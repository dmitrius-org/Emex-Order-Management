@echo off
>C:\Logs\load_part_description.txt 2>&1(

  cd c:\scripts\

  call .\.venv\Scripts\activate

  python load_part_description.py

) 



