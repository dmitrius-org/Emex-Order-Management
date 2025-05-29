delete from tRetCode
-- tUsers
exec RetCodeInsert 1,  'Пользователь с заданным логином существует!', 'A user with the specified login already exists!'
exec RetCodeInsert 2,  'Пользователь должен иметь права [sysadmin]!', 'The user must have [sysadmin] privileges!'
exec RetCodeInsert 3,  'Ошибка при добавлении пользователя!', 'Error adding the user!'
exec RetCodeInsert 4,  'Ошибка при удалении пользователя!', 'Error deleting the user!'
exec RetCodeInsert 5,  'Старый и новый пароли не должны совпадать!', 'Old and new passwords must not be the same!'
exec RetCodeInsert 6,  'Удаление запрещено, пользователь используется в таблице заказов!', 'Deletion is not allowed; the user is referenced in the orders table!'
exec RetCodeInsert 7,  'Группа с заданным сокращением существует!', 'A group with the specified abbreviation already exists!'
exec RetCodeInsert 8,  'Удаление запрещено, в группе имеются пользователи!', 'Deletion is not allowed; the group contains users!'
exec RetCodeInsert 9,  'Связь пользователя и группы существет!', 'The user-group association already exists!'
exec RetCodeInsert 10, 'Клиент существует!', 'The client already exists!'
exec RetCodeInsert 11, 'Удаление запрещено, пользователь входит в группу прав!', 'Deletion is not allowed; the user is part of a rights group!'
exec RetCodeInsert 12, 'Не заполнено обязательное поле!', 'A required field is not filled in!'
exec RetCodeInsert 13, 'Email в системе не зарегистрирован!', 'The email is not registered in the system!'
exec RetCodeInsert 14, 'Ошибка сброса пароля!', 'Password reset error!'
exec RetCodeInsert 15, 'Пароль не может быть пустым!', 'Password cannot be empty!'
exec RetCodeInsert 16, 'Пользователь заблокирован из-за неудачных попыток входа, повторите попытку через 30 минут!', 'The user is locked due to failed login attempts. Please try again in 30 minutes!'
exec RetCodeInsert 17, 'Имя пользователя или пароль неверны!', 'Incorrect username or password!'
exec RetCodeInsert 18, 'Доступ отключен!', 'Access is disabled!'


-- tClients
exec RetCodeInsert 100, 'Клиент с заданным наименованием существует!', 'A client with the specified name already exists!'
exec RetCodeInsert 101, 'Удаление запрещено, Клиент используется в таблице заказов!', 'Deletion is not allowed, the client is used in the orders table!'
exec RetCodeInsert 102, 'В системе уже зарегистрирован клиент с заданной почтой!', 'A client with the specified email is already registered in the system!'
exec RetCodeInsert 103, 'Нет данных!', 'No data found!'
exec RetCodeInsert 104, 'Удаление запрещено, пользователь используется в справочнике клиентов!', 'Deletion is not allowed, the user is used in the client directory!'
exec RetCodeInsert 105, 'Необходимо заполнить поле [Наименование профиля]!', 'The [Profile Name] field is required!'
exec RetCodeInsert 106, 'Необходимо заполнить поле [Способ доставки]!', 'The [Delivery Method] field is required!'
exec RetCodeInsert 107, 'Наименование профиля существует!', 'A profile with the same name already exists!'



--tClientType
insert tRetCode (RetCode, Message) select 120, 'Тип клиент с заданным наименованием существует!'
insert tRetCode (RetCode, Message) select 121, 'Удаление запрещено, тип клиента используется в справочнике "Клиенты"!'

-- tSuppliers
insert tRetCode (RetCode, Message) select 200, 'Поставщик с заданным наименованием!'
insert tRetCode (RetCode, Message) select 201, 'Удаление запрещено, поставщик используется в справочнике "Клиенты"!'
insert tRetCode (RetCode, Message) select 202, 'Удаление запрещено, профиль доставки используется в справочнике "Клиенты"!'
insert tRetCode (RetCode, Message) select 203, 'Удаление запрещено, поставщик используется в справочнике "Заказов"!'

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
insert tRetCode (RetCode, Message) select 517, 'Неизвестная ошибка, деталь не добавлена в корзину!'
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
insert tRetCode (RetCode, Message) select 546, 'Запрос существует!'
insert tRetCode (RetCode, Message) select 547, 'Необходимо выбрать другого поставщика, так как выбран тот же поставщик, что и в основном заказе!'

--

-- tPrices - Прайслисты автозапчастей
insert tRetCode (RetCode, Message) select 600, 'Прайслист с заданным наименованием существуют!'


-- tBasket 701 - 800
exec RetCodeInsert 701, 'Имеются позиции по которым необходимо обновить цену!', 'There are items that require a price update!'
exec RetCodeInsert 702, 'Пожалуйста заполните поле "Описание"!', 'Please fill in the "Description" field!'
exec RetCodeInsert 703, 'Пожалуйста заполните поле "Вес"!', 'Please fill in the "Weight" field!'
exec RetCodeInsert 704, 'Пожалуйста заполните поле "Объём"!', 'Please fill in the "Volume" field!'
exec RetCodeInsert 705, 'Деталь не найдена в корзине!', 'The item was not found in the cart!'
exec RetCodeInsert 706, 'Нет позиций для заказа!', 'There are no items to order!'
exec RetCodeInsert 707, 'Корзина пуста!', 'The cart is empty!'
exec RetCodeInsert 708, 'Товар запрещен к перевозке по выбранному способу доставки! Выберите другой способ доставки.', 'The item is prohibited from being shipped by the selected delivery method! Please choose another delivery method.'



-- API
-- order

exec RetCodeInsert 10001, 'Список заказов пуст', 'The order list is empty'
