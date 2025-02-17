delete from tRetCode
-- tUsers
insert tRetCode (RetCode, Message) select 1,   'Пользователь с заданным логином существует!'
insert tRetCode (RetCode, Message) select 2,   'Пользователь должен иметь права [sysadmin]!'
insert tRetCode (RetCode, Message) select 3,   'Ошибка при добавлении пользователя!'
insert tRetCode (RetCode, Message) select 4,   'Ошибка при удалении пользователя!'
insert tRetCode (RetCode, Message) select 5,   'Старый и новый пароли не должны совпадать!'
insert tRetCode (RetCode, Message) select 6,   'Удаление запрещено, пользователь используется в таблице заказов!'
insert tRetCode (RetCode, Message) select 7,   'Группа с заданным сокращением существует!'
insert tRetCode (RetCode, Message) select 8,   'Удаление запрещено, в группе имеются пользователи!'
insert tRetCode (RetCode, Message) select 9,   'Связь пользователя и группы существет!'
insert tRetCode (RetCode, Message) select 10,  'Клиент существует!'
insert tRetCode (RetCode, Message) select 11,  'Удаление запрещено, пользователь входит в группу прав!'
insert tRetCode (RetCode, Message) select 12,  'Не заполнено обязательное поле!'
insert tRetCode (RetCode, Message) select 13,  'Email в системе не зарегистрирован!'
insert tRetCode (RetCode, Message) select 14,  'Ошибка сброса пароля!'
insert tRetCode (RetCode, Message) select 15,  'Пароль не может быть пустым!'
insert tRetCode (RetCode, Message) select 16,  'Пользователь заблокирован из-за неудачных попыток входа, повторите попытку через 30 минут!'
insert tRetCode (RetCode, Message) select 17,  'Имя пользователя или пароль неверны!'
insert tRetCode (RetCode, Message) select 18,  'Доступ отключен!'

-- tClients
insert tRetCode (RetCode, Message) select 100, 'Клиент с заданным наименованием существует!'
insert tRetCode (RetCode, Message) select 101, 'Удаление запрещено, Клиент используется в таблице заказов!'
insert tRetCode (RetCode, Message) select 102, 'В системе уже зарегистрирован клиент с заданной почтой!'
insert tRetCode (RetCode, Message) select 103, 'Нет данных!'
insert tRetCode (RetCode, Message) select 104, 'Удаление запрещено, пользователь используется в справочнике клиентов!'

--tClientType
insert tRetCode (RetCode, Message) select 120, 'Тип клиент с заданным наименованием существует!'
insert tRetCode (RetCode, Message) select 121, 'Удаление запрещено, тип клиента используется в справочнике "Клиенты"!'
-- tSuppliers
insert tRetCode (RetCode, Message) select 200, 'Поставщик с заданным наименованием!'
insert tRetCode (RetCode, Message) select 201, 'Удаление запрещено, поставщик используется в справочнике "Клиенты"!'

-- tInstrument
insert tRetCode (RetCode, Message) select 300, 'Состояние с заданным сокращением существует!'
insert tRetCode (RetCode, Message) select 301, 'Группа с заданным сокращением существует!'
insert tRetCode (RetCode, Message) select 302, 'Действие с заданным сокращением существует!'
insert tRetCode (RetCode, Message) select 303, 'Удаление запрещено, под группой имеются связанные настройки!'
insert tRetCode (RetCode, Message) select 304, 'Удаление запрещено, под объектом имеются связанные элементы!'
insert tRetCode (RetCode, Message) select 305, 'Модель состояния с заданным сокращением существует!'
insert tRetCode (RetCode, Message) select 306, 'Удаление запрещено, на состояние имеются переходы!'
insert tRetCode (RetCode, Message) select 307, 'Удаление запрещено, под действием настроены связанные объекты "Процедуры"!'

insert tRetCode (RetCode, Message) select 310, '[LoadOrders] Не определен идентификатор объекта системы для которго настроена модель состояния!'

insert tRetCode (RetCode, Message) select 320, '[LoadOrders] Не определен идентификатор начального состояния!'

insert tRetCode (RetCode, Message) select 331, 'Статус с заданным сокращением используется в таблице заказов!'
insert tRetCode (RetCode, Message) select 332, 'Статус с заданным сокращением используется в модели состояния!'
insert tRetCode (RetCode, Message) select 333, 'Действие с заданным сокращением используется в модели состояния!'

-- tEmployees
insert tRetCode (RetCode, Message) select 450, 'Сотрудник с заданным наименованием существует!'
insert tRetCode (RetCode, Message) select 451, 'Удаление запрещено, сотрудник связан с клиентом!'
insert tRetCode (RetCode, Message) select 452, 'Необходимо заполнить поле менеджер!'
insert tRetCode (RetCode, Message) select 453, 'Параметры существуют!'

-- tOrders 500 - 600
insert tRetCode (RetCode, Message) select 500, 'Отсутствуют объекты для выполнения операции!'
insert tRetCode (RetCode, Message) select 501, 'Не удалось отпределить целевое состояние!'
insert tRetCode (RetCode, Message) select 502, 'Отсутствует настройка [CoeffMaxAgree]. Максимальный коэффициент превышения цены продажи для клиента над ценой!'
insert tRetCode (RetCode, Message) select 503, 'Необходимо проставить значение настройки [CoeffMaxAgree]. Максимальный коэффициент превышения цены продажи для клиента над ценой!'
insert tRetCode (RetCode, Message) select 504, 'Необходимо заполнить обязательные поля "Цена закупки" и "Сумма закупки"!'
insert tRetCode (RetCode, Message) select 505, 'Ошибка удаления товара из корзины, требуется ручная проверка!'
insert tRetCode (RetCode, Message) select 506, 'Ошибка!'
insert tRetCode (RetCode, Message) select 507, 'Клиенту запрещено создавать заказ!'
insert tRetCode (RetCode, Message) select 508, 'Недостаточно средств на балансе клиента!'
insert tRetCode (RetCode, Message) select 509, 'Ошибка с типом отгрузки!'
insert tRetCode (RetCode, Message) select 510, 'Нет позиций для заказа!'
insert tRetCode (RetCode, Message) select 511, 'Неизвестная ошибка!'
insert tRetCode (RetCode, Message) select 512, 'Состояние "В работе" запрещено откатывать!'
insert tRetCode (RetCode, Message) select 513, 'Необходимо заполнить обязательное поле "Reference"!'
insert tRetCode (RetCode, Message) select 514, 'Необходимо заполнить обязательное поле "CustomerSubId"!'
insert tRetCode (RetCode, Message) select 515, 'Состояние "Отказан" запрещено откатывать!'
insert tRetCode (RetCode, Message) select 516, 'Необходимо выделить заказы только одного клиента!'
insert tRetCode (RetCode, Message) select 517, 'Неизвестная ошибка, деталь не добалена в корзину!'
insert tRetCode (RetCode, Message) select 518, 'Необходимо заполнить обязательное поле "DestinationLogo"!'
insert tRetCode (RetCode, Message) select 519, 'Не задан шаблон Excel для экспорта отказов!'
insert tRetCode (RetCode, Message) select 520, 'Не задан каталог для сохранения файлов отказов!'
insert tRetCode (RetCode, Message) select 521, 'Не задан скрипт для выгрузки отказов!'
insert tRetCode (RetCode, Message) select 522, 'Не найден шаблон Excel для экспорта отказов!'
insert tRetCode (RetCode, Message) select 523, 'Не найден каталог для сохранения файлов отказов!'
insert tRetCode (RetCode, Message) select 524, 'Не найден скрипт для выгрузки отказов!'
insert tRetCode (RetCode, Message) select 525, 'Данный файл уже в обработке!'
insert tRetCode (RetCode, Message) select 526, 'Невозможно разместить заказы так как выбраны детали разных клиентов (кабинетов EMEX)!'
insert tRetCode (RetCode, Message) select 527, 'Не выбраны позиции для заказа!'
insert tRetCode (RetCode, Message) select 528, 'Заказ с заданным номером существует!'
insert tRetCode (RetCode, Message) select 530, '[OrderCreateFromBasket] Не определен идентификатор начального состояния!'
insert tRetCode (RetCode, Message) select 533, '[OrderCreateFromBasket] Не определен поставщик, обратитесь к администратору системы!'
insert tRetCode (RetCode, Message) select 534, '[EmexCreateOrderCheck] Деталь уже размещена!'
insert tRetCode (RetCode, Message) select 535, 'Нет позиций для заказа!'
insert tRetCode (RetCode, Message) select 536, 'В корзине emex имеются отказанные детали!'
insert tRetCode (RetCode, Message) select 537, 'Ошибка удаления из корзины emex!'
insert tRetCode (RetCode, Message) select 538, 'Ошибка выполнения действия, по позиции выгружен отказ!'
insert tRetCode (RetCode, Message) select 539, 'Объект уже находится в текущем статусе!'
insert tRetCode (RetCode, Message) select 540, 'Поле наименования пустое!'
insert tRetCode (RetCode, Message) select 541, 'Наименование содержит недопустимые символы!'
insert tRetCode (RetCode, Message) select 542, 'Наименование содержит запрещенные слова!'
insert tRetCode (RetCode, Message) select 543, 'Наименование содержит только пробелы!'
insert tRetCode (RetCode, Message) select 544, 'Вес Физический из прайса = 0, и Вес Физический Факт пустой или равен 0!'
insert tRetCode (RetCode, Message) select 545, 'Заказ в работе!'
--

-- tPrices - Прайслисты автозапчастей
insert tRetCode (RetCode, Message) select 600, 'Прайслист с заданным наименованием существуют!'


-- tBasket 701 - 800
insert tRetCode (RetCode, Message) select 701, 'Имеются позиции по которым необходимо обновить цену!'
insert tRetCode (RetCode, Message) select 702, 'Пожалуйста заполните поле "Описание"!'
insert tRetCode (RetCode, Message) select 703, 'Пожалуйста заполните поле "Вес"!'
insert tRetCode (RetCode, Message) select 704, 'Пожалуйста заполните поле "Объём"!'