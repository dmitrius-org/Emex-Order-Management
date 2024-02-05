@echo off
>C:\Logs\currency_import_cmd.txt 2>&1(
 cd D:\Development\AutoPartsApps\scripts
 call .\.venv\Scripts\python.exe load_currency_rate.py
) 



