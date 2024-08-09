from openpyxl.utils import FORMULAE


def GetExcelVal(adata, asheet, aval):
    '''
    GetExcelVal-вспомогательная функция для получения значения ячейки с листа excel
    '''
    if aval.isnumeric():
        return adata[aval-1]
    else: 
        if any(ele.lower()  in aval.lower()  for ele in sorted(FORMULAE, key=len, reverse=True)):
            asheet["I1"].formula ="="+aval
            return asheet["I1"].value  
        else:
            return asheet[aval].value  