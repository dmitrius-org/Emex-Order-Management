@echo off
>C:\Logs\load_Shipments_BoxesData.txt 2>&1(

  cd c:\scripts\

  call .\.venv\Scripts\activate

  python load_Shipments_BoxesData.py

) 



