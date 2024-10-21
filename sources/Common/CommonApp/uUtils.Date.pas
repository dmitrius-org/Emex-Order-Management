unit uUtils.Date;

interface

uses System.SysUtils;

function daterangepicker(AControl, AEventControl: string): string;

implementation

function daterangepicker(AControl, AEventControl: string): string;
begin
result:=
StringReplace( StringReplace(
'''

    $(function() {

    $('input[name="AControl"]').daterangepicker({
      minYear: 2020,
      maxYear: 2050,
      alwaysShowCalendars: true,
      showWeekNumbers: true,
      showISOWeekNumbers: true,
      linkedCalendars: true,
      autoUpdateInput: true,
      showCustomRangeLabel: false,
      showDropdowns: true,
      opens: "center",
      drops: "auto",
      //ranges: {
      //'Сегодня': [moment(), moment()],
      //'Вчера': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
      //'Последние 7 дней': [moment().subtract(6, 'days'), moment()],
      //'Последние 30 дней': [moment().subtract(29, 'days'), moment()],
      //'Этот месяц': [moment().startOf('month'), moment().endOf('month')],
      //'Прошлый месяц': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
      //},
      locale: {
          'format': 'DD/MM/YYYY',
          'separator': ' - ',
          'applyLabel': 'Применить',
          'cancelLabel': 'Очистить',
          'fromLabel': 'From',
          'toLabel': 'To',
          'customRangeLabel': 'Custom',
          'weekLabel': 'Н',
          'daysOfWeek': ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],
          'monthNames': ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
          firstDay: 1
      }
    }, function(start, end, label) {
        //console.log('Выбран период: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));

        ajaxRequest(AEventControl, "OrderDate", [ "BeginDate=" + start.format('DDMMYYYY'), "EndDate=" + end.format('DDMMYYYY') ]);

    });

    $('input[name="AControl"]').on('apply.daterangepicker', function(ev, picker) {
        $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));

        //console.log('Выбран период: ' + picker.startDate.format('YYYY-MM-DD') + ' to ' + picker.endDate.format('YYYY-MM-DD'));

        ajaxRequest(AEventControl, "OrderDate", [ "BeginDate=" + picker.startDate.format('DDMMYYYY'), "EndDate=" + picker.endDate.format('DDMMYYYY') ]);
    });

    $('input[name="AControl"]').on('cancel.daterangepicker', function(ev, picker) {
        console.log('Очистить');
        $(this).val('');

        //console.log('Выбран период: ' + picker.startDate.format('YYYY-MM-DD') + ' to ' + picker.endDate.format('YYYY-MM-DD'));

        ajaxRequest(AEventControl, "OrderDate", [ "BeginDate=", "EndDate="]);
    });


    });

'''
,'AControl', AControl, [rfReplaceAll]),'AEventControl', AEventControl, [rfReplaceAll]);

end;

end.
