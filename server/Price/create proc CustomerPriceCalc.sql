if OBJECT_ID('ClientPriceCalc', 'P') is not null
    drop proc ClientPriceCalc
go
if OBJECT_ID('CustomerPriceCalc', 'P') is not null
    drop proc CustomerPriceCalc	 
go
/* --------------------------------------------------------
  CustomerPriceCalc - ������ ���� 

-------------------------------------------------------- */
create proc CustomerPriceCalc
              @DestinationLogo	nvarchar(20)
as
set nocount on;

declare @Kurs		  float
	   ,@RetVal       int

-- ���� �������
select @Kurs = dbo.GetCurrencyRate('840', null)

if OBJECT_ID('tempdb..#Price') is not null drop table #Price

create table #Price 
(
 PriceID           numeric(18,0)  --  
,Brand             varchar(60)    --
,DetailNum	       varchar(30)    -- ����� ������ 
,DetailPrice       float          -- ����
,FinalPrice        float          -- ����
,DetailName	       varchar(255)   -- ��������
,PriceLogo         varchar(30)    -- �������� ������ 
,Quantity          int            -- ����������
,PackQuantity      int            -- ���������� � ��������

,WeightKG          float          -- ��� ���������� �� 
,VolumeKG          float          -- ��� �������� ��  

,TPrice            float          -- ��� ����, ��������: MOSA, MOSC, KIRG
,TDel              float          -- ������� ��������� �� ��������
,TDetPrice         float          -- ������� ���� ������ �� �������
,TCom              float          -- ������� �������� 
,TMarg             float          -- ������� ������� �� �����
,TFinPrice         float
,Term              int            -- ���� ��������
,TFinPriceKurs     money

,DestinationLogo   nvarchar(10)

,Margin		       float
,Kurs		       float
,ExtraKurs         float
,Commission	       float  -- �������� ��������
,Discount	       float  -- ������
,Reliability       float  -- ����������� ��������
,PDWeightKG	       float
,PDVolumeKG        float

,RetVal            int
)

insert #Price
	  (PriceID        
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
      ,Kurs	
      ,ExtraKurs
      ,Commission	
      ,Discount	
      ,Reliability
      ,PDWeightKG	
      ,PDVolumeKG      
      ,DestinationLogo)
select p.ID,
       p.MakeName, 
       p.DetailNum, 
	   p.Price,
	   p.DetailNum, 
	   p.PriceLogo,
	   1, 
	   p.Packing, 
	   0,--pt.Term,
	   p.WeightGr/1000,--
	   p.VolumeAdd 
                    * case --������������ [VolumeKG]
                        when isnull(p.VolumeAdd, 0) < 10                 then isnull(pd.VolumeKG_Rate1, 1) -- 1. ����������� �� ������ � ������� [VolumeKG] ������ ������ 10 ��
                        when isnull(p.VolumeAdd, 0) between 10 and 19.99 then isnull(pd.VolumeKG_Rate2, 1) -- 2. ����������� �� ������ � ������� [VolumeKG] �� 10 �� ������������, �� ������ ������ 20 ��
                        when isnull(p.VolumeAdd, 0) between 20 and 24.99 then isnull(pd.VolumeKG_Rate3, 1) -- 3. ����������� �� ������ � ������� [VolumeKG] �� 20 �� ������������, �� ������ ������ 25 ��
                        when isnull(p.VolumeAdd, 0) >= 25                then isnull(pd.VolumeKG_Rate4, 1) -- 4. ����������� �� ������ � ������� [VolumeKG] �� 25 �� ������������
                        else 1
                      end,
	   p.Price,
       pc.Margin,		
       @Kurs, 	
       pc.ExtraKurs,
       pc.Commission,
       pc.Discount,	
       pc.Reliability,
       pd.WeightKG,
       pd.VolumeKG,
       pd.DestinationLogo
  from pFindByNumber p (rowlock)
 --inner join tClients c (nolock)
 --        on c.ClientID = p.ClientID
 inner join tProfilesCustomer pc (nolock)
         on pc.ClientID = p.ClientID

 inner join tSupplierDeliveryProfiles pd (nolock)
         on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
        and pd.DestinationLogo    = @DestinationLogo
 where p.Spid = @@Spid

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

Update #Price set TFinPriceKurs  = TFinPrice * (Kurs + (Kurs * (isnull(ExtraKurs, 0)/100)))

Update #Price set FinalPrice = TFinPriceKurs --CEILING(TFinPriceKurs)
	  
Update f 
   set f.PriceRub        = p.FinalPrice
      ,f.Margin          = p.Margin
      ,f.Discount        = p.Discount
      ,f.DestinationLogo = p.DestinationLogo
  from #Price p (rowlock)
 inner join pFindByNumber f (updlock)
         on f.Spid = @@Spid
        and f.id   = p.PriceID
 --*/


exit_:
return @RetVal    
go
grant all on CustomerPriceCalc to public
go
exec setOV 'CustomerPriceCalc', 'P', '20240101', '1.0.0.0'
go
