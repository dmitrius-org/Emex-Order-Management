
update pShipmentsTransporterData
   set spid = @@spid
--where spid = 110

exec ShipmentsTransporterData @IsSave=1

select WeightIK * 100,
       WeightSK * 100,
       WeightI,
       WeightS,

       VolumeIK * 100 '������ V',
       VolumeSK * 100 '���������� V',

       VolumeI,
       VolumeS,

       * 
   from pShipmentsTransporterData


select *
  from tShipments
 where TransporterNumber='QBOW196C'


