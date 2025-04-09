@REM @echo off
>C:\Logs\processing_orders_cancel.txt 2>&1(
    
 cd c:\scripts

 call .\.venv\Scripts\python.exe processing_orders_cancel_automatic.py

@REM  call .\.venv\Scripts\python.exe processing_orders_cancel_scripts.py

) 

