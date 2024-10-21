Insert tInstrument ( PID, Brief, Name, InstrumentTypeID) Select  0, 'State',    'Модель состояния',  1
Insert tInstrument ( PID, Brief, Name, InstrumentTypeID) Select  0, 'Settings', 'Настройки системы', 2

Insert tInstrument ( PID, Brief, Name, InstrumentTypeID) Select  2, 'emexdwc', 'Настройки интеграции с emexdwc', 4--, 'TSettingsT'
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select 3, 'CoeffMaxAgree', 'Максимальный коэффициент превышения цены продажи для клиента над ценой', 'Максимальный коэффициент превышения цены продажи для клиента над ценой, показанной на сайте (по умолчанию 1.1)', '1.1', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select 3, 'AutomaticRejectionPartsByCreatOrder', 'Автоматический отказ деталей с ошибками при создании заказа', '', '1', 0

Insert tInstrument ( PID, Brief, Name, InstrumentTypeID, ObjectTypeID) Select  1, 'Заказы',    'Заказы',  5, 3
Insert tInstrument ( PID, Brief, Name, InstrumentTypeID) Select  2, 'Orders', 'Заказы', 4--, 'TSettingsT'


go
declare @ID numeric(18, 0)
select @ID = InstrumentID from tInstrument where brief = 'Orders'

insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'OrdersGridRowCount', 'Количество строк на странице таблицы заказов', '', '500', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'TemplateOrderRefusals', 'Шаблон Excel для экспорта отказов', '', '', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'UploadingRefusalsCatalog', 'Папка для сохранения файлов отказов', '', '', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'UploadingEmexRefusalsScript', 'Скрипт для выгрузки отказов для EMEX', '', '', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'EmexdwcClient', 'Клиент для интеграции', '', '3', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'OrderAutoSetStatus', 'Автоматический перевод в Проверено при загрузке заказа', '', '1', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'GoogleProgrammableSearchEngineKey', 'Ключ для программируемой поисковой системы', '', '42f36a3f7fa7d4e09', 0



-- Настройки для клиентского приложения
go
declare @PID numeric(18, 0)
Insert tInstrument ( PID, Brief, Name, InstrumentTypeID) Select  0, 'SettingsClientApp', 'Настройки для клиентского приложения', 2
select @PID = InstrumentID from tInstrument where brief = 'SettingsClientApp'
Insert tInstrument ( PID, Brief, Name, InstrumentTypeID) Select  @PID, 'ClientAppCommon', 'Общие настройки', 4--, 'TSettingsT'


go
declare @ID numeric(18, 0)
select @ID = InstrumentID from tInstrument where brief = 'ClientAppCommon'
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'TemplateClientsShipments', 'Шаблон Excel для выгрузки информации по отгрузке', '', '', 0

insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'DefaultSuppliers', 'Поставщик по умолчанию', 'Значение данного параметра проставляется в карточку клиента при регистрации на сайте', '', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'SearchSuppliers',  'Поставщик для поиска деталей', 'Используется для определения личного кабинета через который выполняется поиск деталей. Если значение не проставлено, то поставщика определяем через клиента', '', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'PercentSupped',    'Фильтр по вероятности поставки для отображения результата поиска', '', '', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'ShowSubsts',       'Показывать аналоги в поиске', '', '', 0

insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'SearchColumnInfoWeight',       'Справка для столбца: Вес',                  'Текст справки столбца таблицы поиска деталей', 'Вес', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'SearchColumnInfoVolume',       'Справка для столбца: Объем',                'Текст справки столбца таблицы поиска деталей', 'Объем', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'SearchColumnInfoDeliveryType', 'Справка для столбца: Доставка',             'Текст справки столбца таблицы поиска деталей', 'Доставка', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'SearchColumnInfoDelivery',     'Справка для столбца: Срок доставки',        'Текст справки столбца таблицы поиска деталей', 'Срок доставки', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'SearchColumnInfoRating',       'Справка для столбца: Вероятность поставки', 'Текст справки столбца таблицы поиска деталей', 'Вероятность поставки', 0

insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'DeliveryInfoExpress',         'Справка для способа доставки Express <i class="fa fa-plane"></i>',  '', 'Экспресс доставка: Прямая авиадоставка: быстро и дорого. Этим способом выгодно заказывать небольшие детали без объемного веса. К доставке не принимается опасный груз. Внизу поставить перечеркнутые логотипчики как в брошуре самолета, что нельзя возить взрывоопасные и легковоспламеняющиеся товары ( масла, подушки безопасности и т.д.)', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'DeliveryInfoCharter',         'Справка для способа доставки Charter <i class="fa fa-car"></i>',    '', 'Стандартная доставка: Непрямая авиадоставка с пересадкой и перегрузкой в грузовой транспорт. Этим способом выгодно доставлять 90% деталей, но для доставки деталей с большим объемным весом лучше выбрать Контейнерную доставку.', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'DeliveryInfoContainer',       'Справка для способа доставки Container <i class="fa fa-ship"></i>', '', 'Контейнерная доставка: Самый дешевый способ доставки грузов, он же и самый долгий. Этот способ подходит для доставки тяжелых или крупных деталей с большим объемом. Также можно доставлять любой опасный груз: масла, подушки безопасности с пиропатронами и так далее', 0

insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'RedirectOnExit','Адрес для редиректа при выходе из приложения', '', 'www.booster.ae', 0
--
go
declare @PID numeric(18, 0)
select @PID = InstrumentID from tInstrument where brief = 'SettingsClientApp'
Insert tInstrument ( PID, Brief, Name, InstrumentTypeID) Select  @PID, 'SMTP', 'Почтовый сервер для регистрации', 4--, 'TSettingsT'


go
declare @ID numeric(18, 0)
select @ID = InstrumentID from tInstrument where brief = 'SMTP'
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'SMTP_Host', 'Host', '', 'smtp.yandex.ru', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'SMTP_Port', 'Port', '', '465', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'SMTP_AuthType', 'AuthType', '', '1', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'SMTP_Username', 'Username', '', '', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'SMTP_Password', 'Password', '', '', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'SMTP_RegistrationLink', 'Registration link', 'Заголовок адреса для валидации регистрации', '', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'SMTP_FromName', 'Имя отправителя', 'Имя отправителя', 'Boster.ae', 0
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'SMTP_FromAlias','Почта отправителя', 'Почта отправителя', 'noreply@booster.ae', 0
go
Insert tInstrument ( PID, Brief, Name, InstrumentTypeID) Select  2, 'AppProfiles', 'Профили программы', 4--, 'TSettingsT'
declare @ID numeric(18, 0)
select @ID = InstrumentID from tInstrument where brief = 'AppProfiles'
insert tSettings (GroupID, Brief, Name, Comment, Val, SettingType) select @ID, 'AppProfilesName', 'Наименование программы', '', 'Booster LLC', 0
/*
delete
  from tSettings 
 where brief in ('SMTP_FromName')
*/


select *
  from tInstrument (nolock)
select *
  from tSettings (nolock)
  where brief = 'SeaachSuppliers'
