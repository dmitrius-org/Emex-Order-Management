import time
import datetime
import os
import platform

def t(n):
    return time.strftime("%H:%M:%S", time.gmtime(n))

def getSpecialPath(APath):
    if APath[-1] != '\\':
        APath = APath + "\\"

    return APath

def creation_date(path_to_file):
    """
      дата создания файла
    """
    if platform.system() == 'Windows':
        return datetime.datetime.fromtimestamp(os.path.getctime(path_to_file))  
    else:
        stat =  datetime.datetime.fromtimestamp(os.stat(path_to_file))  
        try:
            return stat.st_birthtime
        except AttributeError:
            # Вероятно, мы используем Linux. Здесь нет простого способа получить даты создания,
            # поэтому мы остановимся на том, когда его содержимое было изменено в последний раз.
            return stat.st_mtime