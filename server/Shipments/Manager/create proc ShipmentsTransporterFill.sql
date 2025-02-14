drop proc if exists ShipmentsTransporterFill
                     
/*
  ShipmentsTransporterFill - синхронизация сведений по грузу с транспортной компанией

  пример расчета данных
  https://docs.google.com/spreadsheets/d/1sEzljeN4aMwcOkaEC-Kly_TBxMUMY6A2Ld32Zrp7ckQ/edit?gid=1571860292#gid=1571860292
*/
go
create proc ShipmentsTransporterFill
              @IsSave bit = null
as
  set nocount on;

  declare @r        int = 0

  update p 
     set p.Flag = isnull((SELECT COUNT(*) 
                            FROM pShipmentsTransporterData (nolock)
                           where spid = @@spid
                          ), 0)
    from pShipmentsTransporterData p 
   where p.spid = @@spid

  update p
     set p.WeightKG     = t.WeightKG   
        ,p.VolumeKG     = t.VolumeKG        
        ,p.WeightKGF    = t.WeightKGF  
        ,p.VolumeKGF    = t.VolumeKGF  
        ,p.WeightKGAmount = 9--t.WeightKGAmount
        ,p.VolumeKGAmount = 4--t.VolumeKGAmount 
	from pShipmentsTransporterData p (updlock)
   inner join tShipments t (nolock)
           on t.Invoice  = p.Invoice
          and t.TransporterNumber = p.TransporterNumber
   where p.spid = @@spid


  --Инвойс
  update p
     set p.WeightIK     = p.SupplierWeightKG / pd.WeightKGF --Коэффициент разницы для вычисления веса каждого инвойса
        ,p.VolumeIK     = p.SupplierVolumeKG / pd.VolumeKGF --Коэффициент разницы для вычисления веса каждого инвойса
	from pShipmentsTransporterData p (updlock)
    cross apply (select sum(pd.WeightKGF) as WeightKGF
                       ,sum(pd.VolumeKGF) as VolumeKGF
                   from pShipmentsTransporterData pd (nolock)
                  where pd.Spid = @@Spid
                ) as pd
   where p.spid = @@spid

  --Перевозчик
  update p
     set p.WeightSK     = p.TransporterWeightKG / p.SupplierWeightKG 
        ,p.VolumeSK     = p.TransporterVolumeKG / p.SupplierVolumeKG 
	from pShipmentsTransporterData p (updlock)
   where p.spid = @@spid
  
  update p
     set p.WeightI     = p.WeightKGF * p.WeightIK 
        ,p.VolumeI     = p.VolumeKGF * p.VolumeIK 
	from pShipmentsTransporterData p (updlock)
   where p.spid = @@spid

  update p
     set p.Weights     = p.WeightI * p.WeightSK 
        ,p.Volumes     = p.VolumeI * p.VolumeSK 
	from pShipmentsTransporterData p (updlock)
   where p.spid = @@spid

  update p    --Стоимость доставки расчетная
     set p.AmountCalculated     = p.WeightS * (p.WeightKGAmount) + (p.VolumeS - p.WeightS) * p.VolumeKGAmount
	from pShipmentsTransporterData p (updlock)
   where p.spid = @@spid

  update p
     set p.AmountK     = p.TransporterAmount / pd.AmountCalculated --Коэффициент разницы для вычисления веса каждого инвойса
	from pShipmentsTransporterData p (updlock)
    cross apply (select sum(pd.AmountCalculated) as AmountCalculated
                   from pShipmentsTransporterData pd (nolock)
                  where pd.Spid = @@Spid
                ) as pd
   where p.spid = @@spid

  update p
     set p.AmountFinal     = p.AmountK * p.AmountCalculated 
	from pShipmentsTransporterData p (updlock)
   where p.spid = @@spid

  if isnull(@IsSave, 0) = 1
  begin
    Update t
       set           
           t.SupplierWeightKG     = iif(p.flag=1, p.SupplierWeightKG, p.WeightI)
          ,t.SupplierVolumeKG     = iif(p.flag=1, p.SupplierVolumeKG, p.VolumeI)   

          ,t.TransporterWeightKG  = iif(p.flag=1, p.TransporterWeightKG, p.WeightS)  
          ,t.TransporterVolumeKG  = iif(p.flag=1, p.TransporterVolumeKG, p.VolumeS) 
           -- Сумма доставки исходя из данных перевозчика = Стоимость доставки расчетная
          ,t.TransporterAmount    = iif(p.flag=1, p.TransporterAmount, p.AmountCalculated)
          
           --Фактическая стоимость доставки исходя из фактических данных = Стоимость доставки конечная
          ,t.DeliverySumF         = iif(p.flag=1, p.TransporterAmount, p.AmountFinal)
      from pShipmentsTransporterData p with (nolock index=ao1)
     inner join tShipments t with (Updlock index=ao2)
             on t.Invoice = p.Invoice
     where p.Spid = @@SPid
      
    update t
       set t.SupplierDiffVolumeWeigh    = t.SupplierVolumeKG    - t.SupplierWeightKG 
          ,t.TransporterDiffVolumeWeigh = t.TransporterVolumeKG - t.TransporterWeightKG 
      from pShipmentsTransporterData p with (nolock index=ao1)
     inner join tShipments t with (Updlock index=ao2)
             on t.Invoice = p.Invoice
     where p.Spid = @@SPid

    delete pAuditInsert from pAuditInsert (rowlock) where spid=@@spid
    insert pAuditInsert with (rowlock)
          (Spid
          ,ObjectID
          ,ObjectTypeID
          ,ActionID
          ,Comment
          )
    select @@Spid 
          ,t.ShipmentsID       	         
          ,10        
          ,2      
          ,'Изменение информации о грузе'
       from pShipmentsTransporterData p with (nolock index=ao1)
      inner join tShipments t with (nolock index=ao2)
              on t.Invoice = p.Invoice
      where p.Spid = @@SPid
            
    exec MassAuditInsert

  end

 exit_:
 return @r
go
grant exec on ShipmentsTransporterFill to public
go
exec setOV 'ShipmentsTransporterFill', 'P', '20250213', '0'
go
 