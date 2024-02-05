 declare  @UserID numeric(18, 0);   
    select @UserID = dbo.GetUserID(); 
  
   exec GrantSelect        
         @UserID = @UserID;


   Select *             
     from vGrant           
    where UserID = @UserID 
      and value = 1        
    order by N             