unit uConstant;
//                     ���������������� ���� � ���������
interface

uses System.SysUtils;


const  NullDate: TDateTime = 0; // 30.12.1899


Type
{
tOrders - ������
flag  int   0-
            1 - ���������� ����
            2 - ��� ����
            4 - �������
            8 - ������ ��������� � ���������� ��������� ������
           16 - ������ �����
           32 - ��������� ��� �������
           64 - �������� �����
          128 - ����� �� ������
          256 - ��� ������� �����-����
}

TOrderFlag = (
   ORDER_CHANGE_PRICELOGO           = 256
);


implementation


end.
