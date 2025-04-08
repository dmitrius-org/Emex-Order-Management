begin tran


declare @OrderID numeric(18, 0)
    exec OrderSplitting
           @OrderID    = 189960
          ,@Quantity   = 1
          ,@NewOrderID = @OrderID  out  


          commit tran