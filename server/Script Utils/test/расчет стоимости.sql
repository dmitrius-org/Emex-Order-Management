declare
              @ProfileName  varchar(30)='EEZap (BEED-48H)',
			  @DetailNum    varchar(30)= 'HYB168NA',
			  @ErrMessage   varchar(255) = null 

--EmEx (MZYN-EMIN)

--select * 
--  from tProfilesCustomer pc (nolock)


declare @IsDelivery   bit    -- ������� � ������ ��������
	   ,@IsMyDelivery bit    -- ���� ��� ������� "������������ ������ ��� ����"
       ,@Margin		  float
       ,@Kurs		  float
       ,@Commission	  float  -- �������� ��������
       ,@Discount	  float  -- ������
	   ,@Reliability  float  -- ����������� ��������
	   ,@RetVal       int
	   ,@WeightKG	  float
	   ,@VolumeKG     float
	   ,@isIgnore     bit
	   ,@ExtraKurs    float
       ,@Fragile      float

Select @Margin      = pc.Margin     
	  ,@Reliability = pc.Reliability 
	  ,@Discount    = s.Discount   
	  ,@Commission  = s.Commission 
	  ,@IsMyDelivery= isnull(pd.isMyDelivery , 0)
      ,@isIgnore    = isnull(pd.isIgnore, 0)
	  ,@WeightKG	= pd.WeightKG
	  ,@VolumeKG    = pd.VolumeKG                     
	  ,@ExtraKurs   = s.ExtraKurs
      ,@Fragile     = isnull(pd.Fragile, 0)
  from tProfilesCustomer pc (nolock)
  inner join tSupplierDeliveryProfiles pd (nolock)
          on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
  inner join tSuppliers s (nolock)
          on s.SuppliersID = pd.SuppliersID
 where pc.Brief =  @ProfileName


Select Margin      = pc.Margin     
	  ,Reliability = pc.Reliability 
	  ,Discount    = s.Discount   
	  ,Commission  = s.Commission 
	  ,IsMyDelivery= isnull(pd.isMyDelivery , 0)
      ,isIgnore    = isnull(pd.isIgnore, 0)
	  ,WeightKG	= pd.WeightKG
	  ,VolumeKG    = pd.VolumeKG                     
	  ,ExtraKurs   = s.ExtraKurs
      ,Fragile     = pd.Fragile
  from tProfilesCustomer pc (nolock)
  inner join tSupplierDeliveryProfiles pd (nolock)
          on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
  inner join tSuppliers s (nolock)
          on s.SuppliersID = pd.SuppliersID
 where pc.Brief =  @ProfileName

if @@ROWCOUNT = 0
begin
  select @ErrMessage='�� ������ ������� [' + @ProfileName + '] ��� �������� ������'
        ,@RetVal    = 1
  goto exit_
end

-- ���� �������
select @Kurs = dbo.GetCurrencyRate('840', null)

if OBJECT_ID('tempdb..#Price') is not null
    drop table #Price

create table #Price 
(
 PriceID           numeric(18,0)   --  
,Brand             varchar(60)    --
,DetailNum	       varchar(30)    -- ����� ������ 
,DetailPrice       float          -- ����
,FinalPrice        float          -- ����
,DetailName	       varchar(255)   -- ��������
,PriceLogo         varchar(30)    -- �������� ������ 
,Quantity          int            -- ����������
,PackQuantity      int            -- ���������� � ��������
--,Reliability       float          -- ����������� ��������
--,isDelivery        bit            -- � ������ ��������
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
,Fragile           bit
)

insert #Price
	  (
	   PriceID        
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
      ,Fragile -- ������� ���������
	  )
select-- top 200000 
       t.PriceID,
       t.Brand, 
       t.DetailNum, 
	   t.DetailPrice,
	   t.DetailName, 
	   t.PriceLogo,
	   t.Quantity, 
	   t.PackQuantity, 
	   0,--pt.Term,
	   isnull(t.WeightKGF, t.WeightKG),--
	   isnull(t.VolumeKGf, t.VolumeKG)
                    * case --������������ [VolumeKG]
                        when isnull(t.VolumeKGf, t.VolumeKG) < 10                 then isnull(pd.VolumeKG_Rate1, 1) -- 1. ����������� �� ������ � ������� [VolumeKG] ������ ������ 10 ��
                        when isnull(t.VolumeKGf, t.VolumeKG) between 10 and 19.99 then isnull(pd.VolumeKG_Rate2, 1) -- 2. ����������� �� ������ � ������� [VolumeKG] �� 10 �� ������������, �� ������ ������ 20 ��
                        when isnull(t.VolumeKGf, t.VolumeKG) between 20 and 24.99 then isnull(pd.VolumeKG_Rate3, 1) -- 3. ����������� �� ������ � ������� [VolumeKG] �� 20 �� ������������, �� ������ ������ 25 ��
                        when isnull(t.VolumeKGf, t.VolumeKG) >= 25                then isnull(pd.VolumeKG_Rate4, 1) -- 4. ����������� �� ������ � ������� [VolumeKG] �� 25 �� ������������
                        else 1
                      end,
	   t.MOSA,
       t.Fragile
  from tProfilesCustomer pc (nolock)
 inner join tSupplierDeliveryProfiles pd (nolock)
         on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
 inner join tPrice t with (nolock index=ao3)
         on t.PriceLogo = pc.UploadPriceName
		 --and 1=1
             /*���� � ����� ���� ����������� ������� "������������ ������ ��� ����", �� ������� ��� ������,
               � ������� ����� � ���� ������� WeightKG � VolumeKG �������� 0.*/
        and (@isIgnore = 0
         or (@isIgnore = 1 and not (isnull(t.WeightKGF, t.WeightKG) = 0 and isnull(t.VolumeKGf, t.VolumeKG) = 0)))
            --������� ��� ������, � ������� �������� � ������� Reliability ������ ������, ��� reliability �� �����
        and t.Reliability >= @Reliability
		 --and t.Quantity > 0
        and  isnull(t.Restrictions, '') = case --���� ���������� ������� �� ��������� � �������������
	                                        when isnull(pd.Restrictions, 0) = 1 and isnull(t.Restrictions, '') = 'NOAIR' then ''  
			                                else isnull(t.Restrictions, '')
                                          end

 where pc.Brief =  @ProfileName

  and t.DetailNum = @DetailNum

if @IsMyDelivery = 0 /*��������� ��������*/
begin
  /*
  ���� ����������� ������� "������� � ������ ��������":
   - ��������� ������� ��������� �� ��������: TDel = "MOSA" (��� ����� ������ �������, ��������� � ������) - Detail Price
   - ��������� ������� ���� ������ �� �������: TDetPrice = DetailPrice - DetailPrice*Discount
   - ��������� ������� ��������: TCom = (TDetPrice+(MOSA-DetailPrice))*Commission
   - ��������� ������� ������� �� �����: TMarg = TDetPrice*Margin
   - ��������� �������� ����: TFinPrice = (TDetPrice + TDel + TMarg + TCom) * Kurs
   - ��������� �������� ���� ����� �� �����
   - � ������� "FinalPrice" ����� TFinPrice
  */
  Update #Price 
     set TDel      = TPrice - DetailPrice
        ,TDetPrice = DetailPrice - DetailPrice * (@Discount/100)

  Update #Price 
     set TCom      = (TDetPrice+(TPrice-DetailPrice))*@Commission/100
        ,TMarg     = TDetPrice*@Margin/100

  Update #Price 
     set TFinPrice = (TDetPrice + TDel + TMarg + TCom)
end
else /* 1 - ���� ��������*/
begin
   Update #Price  
      set TDel = case
	               -- If "���������� ��� �� ������" >= "�������� ��� �� ������", ��:
                   -- �������� ��� = "���������� ��� �� ������" * "���� �� ��� ��"
	               when WeightKG >= VolumeKG 
				     then WeightKG * (@WeightKG)
					 -- Else "���������� ��� �� ������" < "�������� ��� �� ������", ��:
                     -- �������� ��� = "���������� ��� �� ������" * "���� �� ��� ��" + ("�������� ��� �� ������" - "���������� ��� �� ������") * "���� �� ����� ��"   
	                 else WeightKG * (@WeightKG) + (VolumeKG-WeightKG) * (@VolumeKG)
				 end
      
   --��������� ������� ���� ������ �� �������: TDetPrice = DetailPrice - DetailPrice*Discount
   Update #Price set TDetPrice = DetailPrice- DetailPrice * (@Discount/100)
   
   Update #Price set TCom = TDetPrice * (@Commission/100)
      
   -- ��������� ������� ������� �� �����: TMarg = TDetPrice*Margin
   Update #Price set TMarg = TDetPrice* (@Margin/100)

   Update #Price 
      set TFinPrice = (TDetPrice + TDel + TMarg + TCom)

   /* ��� ��������
   - ��������� ������� ���� ������ �� �������: TDetPrice = DetailPrice - DetailPrice*Discount
   - ��������� ������� ��������: TCom = TDetPrice*Commission
   - ��������� ������� ������� �� �����: TMarg = TDetPrice*Margin
   - ��������� �������� ����: TFinPrice = (TDetPrice + TMarg + TCom) * Kurs
   - ��������� �������� ���� ����� �� �����
   - � ������� "FinalPrice" ����� TFinPrice
  Update #Price 
     set TDetPrice = DetailPrice - DetailPrice * (@Discount/100)

  Update #Price 
     set TCom      = TDetPrice*@Commission
        ,TMarg     = TDetPrice*@Margin

  Update #Price 
     set TFinPrice = ((TDetPrice + TMarg + TCom) * @Kurs)
   */

end

Update #Price 
   set TFinPriceKurs  = TFinPrice * (@Kurs + (@Kurs * (isnull(@ExtraKurs, 0)/100)))

--���� � ������ ���������� ����� Fragile, ������� �� ����� � ���� ��������
--��������, ���� �� ������ ������� �� Fragile, �� � ������������� ������ ����������� 3%
Update #Price 
   set TFinPriceKurs  =  TFinPriceKurs  + (TFinPriceKurs * (@Fragile/100))
 where Fragile > 0

Update #Price 
   set FinalPrice = CEILING(TFinPriceKurs)

	  --MakeLogo, DetailNum, DetailName, Quantity, PackQuantity, FinalPrice
	  
select Brand, 
       DetailNum, 
	   DetailName, 
	   Quantity, 
	   PackQuantity, 
	   cast(FinalPrice as int) as FinalPrice
  from #Price (nolock)
 order by PriceLogo
 --*/


exit_:


select * from tPrice where DetailNum='HYB168NA'