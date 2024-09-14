@echo off
::Upload Orders

CD C:\scripts\
call .venv\Scripts\activate
python load_shipments.py