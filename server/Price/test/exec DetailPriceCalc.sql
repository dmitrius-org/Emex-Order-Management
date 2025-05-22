declare @ProfileName  varchar(30),
	    @ErrMessage   varchar(255) 

/*
select p.Brief, p.UploadFolder, p.UploadFileName, isnull(d.Brief, ';') as UploadDelimiter
           from tProfilesCustomer p (nolock) 
           left join tDelimiter d (nolock)
                  on d.DelimiterID = p.UploadDelimiterID
          where 1=1--p.UploadPriceName    = ? 
            and isnull(p.Brief, '') <> ''
            and p.isActive = 1
*/
exec DetailPriceCalc
              @ProfileName  = 'EEZap (OPT2-48H)',
			  @ErrMessage   = @ErrMessage
select @ErrMessage



