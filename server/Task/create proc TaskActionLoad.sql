drop proc if exists TaskActionLoad
/*
  TaskActionLoad - 
  @TaskID    - Ид объекта
  @Direction - 0 - с постоянной во временную
               1 - с временной в постоянную
*/
go
create proc TaskActionLoad
               @TaskID           numeric(18, 0)       --
              ,@Direction        int                -- 
as
  set nocount on;
  declare @r int

  select @R         = 0
        ,@Direction = isnull(@Direction, 0)

  if @Direction = 0
  begin
	  delete pTaskActions from pTaskActions (rowlock) where spid = @@spid
	  insert pTaskActions  
			 (               
             Spid                    
            ,TaskActionsID 
            ,TaskID        
            ,Number        
            ,Comment       
            ,TaskType      
            ,IsActive      
            ,LinkID        
            ,Field         
            ,Flag          
            ,inDatetime    
            ,updDatetime           
			)
	  select @@Spid                                                                       
            ,TaskActionsID 
            ,TaskID        
            ,Number        
            ,Comment       
            ,TaskType      
            ,IsActive      
            ,LinkID        
            ,Field         
            ,Flag          
            ,inDatetime    
            ,updDatetime   
	   from tTaskActions (nolock)
	  where TaskID = @TaskID
  end
  else
  begin
    delete tTaskActions
	  from tTaskActions t  (rowlock)
	 where t.TaskID   = @TaskID
	   and not exists ( select 1
	                      from pTaskActions p (nolock)
						 where p.Spid          = @@spid
						   and p.TaskActionsID = t.TaskActionsID
						   and isnull(p.TaskID, 0) <> 0  
					   )

	  insert tTaskActions  
			(              
             TaskID        
            ,Number        
            ,Comment       
            ,TaskType      
            ,IsActive         
            ,Field         
            ,Flag  
			,LinkID
			)
	  select isnull(nullif(TaskID, 0), @TaskID)
            ,Number  
			,Comment
			,TaskType
			,IsActive
			,Field
			,Flag
			,LinkID
	   from pTaskActions (nolock)
	  where Spid     = @@Spid 
	    and isnull(TaskID, 0) = 0

     Update t
        set t.Number      = p.Number      
           ,t.Comment     = p.Comment   
		   ,t.TaskType    = p.TaskType  
		   ,t.IsActive    = p.IsActive  
		   ,t.Field       = p.Field  
		   ,t.Flag        = p.Flag 
		   ,t.LinkID      = p.LinkID
		   ,t.updDatetime = getDate()
       from pTaskActions p (nolock)
      inner join tTaskActions t (updlock)
              on t.TaskActionsID = p.TaskActionsID
      where p.Spid = @@Spid 

  end

  

 exit_:
 return @r
go
grant exec on TaskActionLoad to public
go
exec setOV 'TaskActionLoad', 'P', '20240307', '1'
go

