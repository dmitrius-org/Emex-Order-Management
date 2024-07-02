   declare           @DestinationLogo	nvarchar(20) = '0001',
			  @DetailNum        nvarchar(40) = '6102B303'




update pFindByNumber set spid = @@spid

declare @Kurs		  float
	   ,@RetVal       int

-- ���� �������
select @Kurs = dbo.GetCurrencyRate('840', null)
      ,@RetVal = 0

if OBJECT_ID('tempdb..#Price') is not null drop table #Price

create table #Price 
(
 ID                  numeric(18,0)  --  
,Brand               varchar(60)    --
,DetailNum	         varchar(30)    -- ����� ������ 
,DetailPrice         float          -- ����
,FinalPrice          float          -- ����
,DetailName	         varchar(255)   -- ��������
,PriceLogo           varchar(30)    -- �������� ������ 
,Quantity            int            -- ����������
,PackQuantity        int            -- ���������� � ��������

,WeightKG            float          -- ��� ���������� �� 
,VolumeKG            float          -- ��� �������� ��  

,TPrice              float          -- ��� ����, ��������: MOSA, MOSC, KIRG
,TDel                float          -- ������� ��������� �� ��������
,TDetPrice           float          -- ������� ���� ������ �� �������
,TCom                float          -- ������� �������� 
,TMarg               float          -- ������� ������� �� �����
,TFinPrice           float
,Term                int            -- ���� ��������
,TFinPriceKurs       money

,DestinationLogo     nvarchar(10)

,Margin		         float
,Kurs		         float
,ExtraKurs           float
,Commission	         float  -- �������� ��������
,Discount	         float  -- ������
,Reliability         float  -- ����������� ��������
,PDWeightKG	         float
,PDVolumeKG          float

 -- ������ � ������� ����������
,ProfilesDeliveryID  numeric(18, 0)
,Delivery            int
,GuaranteedDay       int    -- �������������� ���� �������� � ����������
,FragileSign         bit    -- ������� ������� �� ������
,Fragile             float  -- �������� �������� � ����������� �������� 

,RetVal              int
)

-- ��� ��������� ����� � ������� tPrice
declare @Num as table
       (DetailNum nvarchar(40));

Update p
   set p.WeightGr  = isnull((Select max(pp.WeightGr)  from pFindByNumber pp with (nolock index=ao1) where pp.Spid = @@Spid and pp.make = p.Make and pp.DetailNum = p.DetailNum), 0)  
      ,p.VolumeAdd = isnull((Select max(pp.VolumeAdd) from pFindByNumber pp with (nolock index=ao1) where pp.Spid = @@Spid and pp.make = p.Make and pp.DetailNum = p.DetailNum), 0)  
  from pFindByNumber p with (updlock index=ao1)
 where p.Spid = @@Spid

declare  @Price  table
       ( DetailNum   nvarchar(40)
        ,MakeLogo    nvarchar(40)
        ,WeightKGF   float
		,VolumeKGf   float
        ,FragileSign bit);

insert @Num (DetailNum)
select distinct p.DetailNum
  from pFindByNumber p with (nolock index=ao2)
 where p.Spid = @@spid
   and p.DetailNum = @DetailNum

insert @Price
       (DetailNum, 
		MakeLogo, 
		WeightKGF, 
		VolumeKGf,
        FragileSign)
select top 1 
       pp.DetailNum,
	   pp.MakeLogo,
	   pp.WeightKGF,
	   pp.VolumeKGf,
       isnull(pp.Fragile, 0)
  from @Num p 
 inner join tPrice pp with (nolock index=ao2) 
         on pp.DetailNum = p.DetailNum
order by pp.WeightKGF desc, pp.VolumeKGf desc


-- ������ ����
insert #Price
	  (ID        
      ,Brand        
      ,DetailNum	  
      ,DetailPrice  
      ,DetailName	  
      ,PriceLogo    
      ,Quantity     
      ,PackQuantity 
	  ,Term
	  ,WeightKG 
	  ,VolumeKG 
      ,TPrice  

      ,Margin	
      ,Reliability
      ,Kurs	
      ,ExtraKurs
      ,Commission	
      ,Discount	
      
      ,PDWeightKG	
      ,PDVolumeKG      
      ,DestinationLogo
	  ,ProfilesDeliveryID
	  ,Delivery -- �������������� ���� �������� � ����������
	  ,GuaranteedDay
      ,FragileSign
      ,Fragile
	  )
select p.ID,
       p.MakeName, 
       p.DetailNum, 
	   p.Price,
	   p.DetailNum, 
	   p.PriceLogo,
	   1, 
	   p.Packing, 
	   0,--pt.Term,
       case
         when (p.flag&512)>0 then p.WeightGr -- 512 - ��� ������� ��������
	     else isnull(pp.WeightKGF,p.WeightGr)
       end,

       case
         when (p.flag&512)>0 then p.VolumeAdd-- 512 - ��� ������� ��������
	     else isnull(pp.VolumeKGf,p.VolumeAdd) 
       end	   
           * case --������������ [VolumeKG]
               when isnull(p.VolumeAdd, 0) < 10                 then isnull(pd.VolumeKG_Rate1, 1) -- 1. ����������� �� ������ � ������� [VolumeKG] ������ ������ 10 ��
               when isnull(p.VolumeAdd, 0) between 10 and 19.99 then isnull(pd.VolumeKG_Rate2, 1) -- 2. ����������� �� ������ � ������� [VolumeKG] �� 10 �� ������������, �� ������ ������ 20 ��
               when isnull(p.VolumeAdd, 0) between 20 and 24.99 then isnull(pd.VolumeKG_Rate3, 1) -- 3. ����������� �� ������ � ������� [VolumeKG] �� 20 �� ������������, �� ������ ������ 25 ��
               when isnull(p.VolumeAdd, 0) >= 25                then isnull(pd.VolumeKG_Rate4, 1) -- 4. ����������� �� ������ � ������� [VolumeKG] �� 25 �� ������������
               else 1
             end,
	   p.Price,

       pd.Margin,
       pd.Reliability,
       @Kurs, 
       s.ExtraKurs,
       s.Commission,
       --case 
       --  when p.flag&1>0 then s.Discount
       --  else 0 -- �� ��� ���� �������� � ������ ������
       --end,
       0,
       pd.WeightKG,
       pd.VolumeKG,
       pd.DestinationLogo,
	   pd.ProfilesDeliveryID,
	   pd.Delivery,
	   p.GuaranteedDay,
       pp.FragileSign,
       pd.Fragile
  from pFindByNumber p with (nolock index=ao1)
 inner join tClients c  with (nolock index=ao1)
         on c.ClientID = p.ClientID 
 inner join tSuppliers s  with (nolock index=ao1)
         on S.SuppliersID = c.SuppliersID

 outer apply ( -- ��� �������� ���������� ����� ����, �������� ����� ���� ���������
      select top 1
             pd.DestinationLogo, 
             pd.Name,

             pd.WeightKG,
             pd.VolumeKG,
	         pd.ProfilesDeliveryID,
	         pd.Delivery,

             pc.Margin,
             pc.Reliability,

             pd.VolumeKG_Rate1,
             pd.VolumeKG_Rate2,
             pd.VolumeKG_Rate3,
             pd.VolumeKG_Rate4,
             pd.Fragile

        from tProfilesCustomer pc with (nolock index=ao2)
        left join tSupplierDeliveryProfiles pd with (nolock index=ao1)
               on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
       where pc.ClientID = c.ClientID
         and pd.DestinationLogo    = @DestinationLogo   
     ) as pd

 left join @Price pp
        on pp.DetailNum = p.DetailNum
	   and pp.MakeLogo  = p.Make	
       
 where p.Spid = @@Spid

 select * from @Price
 
 select * from #Price
select * from tSupplierDeliveryProfiles where ProfilesDeliveryID= 3

Update #Price  
   set TDel = case
                -- If "���������� ��� �� ������" >= "�������� ��� �� ������", ��:
                 -- �������� ��� = "���������� ��� �� ������" * "���� �� ��� ��"
                when WeightKG >= VolumeKG 
		          then WeightKG * (PDWeightKG)
			    -- Else "���������� ��� �� ������" < "�������� ��� �� ������", ��:
                   -- �������� ��� = "���������� ��� �� ������" * "���� �� ��� ��" + ("�������� ��� �� ������" - "���������� ��� �� ������") * "���� �� ����� ��"   
                  else WeightKG * (PDWeightKG) + (VolumeKG-WeightKG) * (PDVolumeKG)
              end
    
 --��������� ������� ���� ������ �� �������: TDetPrice = DetailPrice - DetailPrice*Discount
Update #Price set TDetPrice = DetailPrice- DetailPrice * (Discount/100)
 
Update #Price set TCom = TDetPrice * (Commission/100)
    
 -- ��������� ������� ������� �� �����: TMarg = TDetPrice*Margin
Update #Price set TMarg = TDetPrice* (Margin/100)

Update #Price set TFinPrice = (TDetPrice + TDel + TMarg + TCom)

--Update #Price 
--   set TFinPrice  =  TFinPrice  + (TFinPrice * (isnull(Fragile, 0)/100))
-- where isnull(FragileSign, 0) > 0

Update #Price set TFinPriceKurs  = TFinPrice * (Kurs + (Kurs * (isnull(ExtraKurs, 0)/100)))

Update #Price set FinalPrice = TFinPriceKurs
	  
Update f 
   set f.PriceRub        = CEILING(p.FinalPrice)

      ,f.Margin          = p.Margin
      ,f.Discount        = p.Discount
      ,f.Kurs            = p.Kurs
      ,f.ExtraKurs       = p.ExtraKurs
      ,f.Commission      = p.Commission
      ,f.Reliability     = p.Reliability

      ,f.DestinationLogo = p.DestinationLogo
	  ,f.WeightGr	     = p.WeightKG   
	  ,f.VolumeAdd       = p.VolumeKG   
  from #Price p (nolock)
 inner join pFindByNumber f (updlock)
         on f.Spid = @@Spid
        and f.ID   = p.ID

-- ������ ��������� ���� ������
delete pDeliveryDate from pDeliveryDate (rowlock) where spid = @@spid
insert pDeliveryDate 
      (Spid, ID, OrderDate, ProfilesDeliveryID, Delivery)
select @@SPID, 
       ID, 
	   DATEADD(dd, GuaranteedDay, cast(getdate() as date)),
	   ProfilesDeliveryID,
	   isnull(Delivery, 0) -- �������� � ������� ����������
  from #Price (nolock)

exec DeliveryDateCalc  

Update f 
   set f.OurDelivery    = f.GuaranteedDay + DATEDIFF(dd, p.OrderDate, p.DeliveryDate) + p.Delivery
      ,f.OurDeliverySTR = cast(f.GuaranteedDay as nvarchar) + ' + ' + cast(DATEDIFF(dd, p.OrderDate, p.DeliveryDate) as nvarchar) + ' + ' + cast(p.Delivery as nvarchar) + ' = ' + Cast(f.GuaranteedDay + DATEDIFF(dd, p.OrderDate, p.DeliveryDate) + p.Delivery as nvarchar)
  from pDeliveryDate p with (nolock index=ao1)
 inner join pFindByNumber f with (updlock index=ao1)
         on f.Spid = @@Spid
        and f.ID   = p.ID
 where p.Spid = @@Spid
    
exit_: