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
exec RetCodeInsert 108, 'Необходимо заполнить поле [Поставщик]!', 'The [Supplier] field must be filled in!'
exec RetCodeInsert 109, 'Профиль доставки не соответствует поставщику!', 'The delivery profile does not match the supplier!'


--tClientType
exec RetCodeInsert 120, 'Тип клиент с заданным наименованием существует!'
exec RetCodeInsert 121, 'Удаление запрещено, тип клиента используется в справочнике "Клиенты"!'

-- tSuppliers
exec RetCodeInsert 200, 'Поставщик с заданным наименованием!'
exec RetCodeInsert 201, 'Удаление запрещено, поставщик используется в справочнике "Клиенты"!'
exec RetCodeInsert 202, 'Удаление запрещено, профиль доставки используется в справочнике "Клиенты"!'
exec RetCodeInsert 203, 'Удаление запрещено, поставщик используется в справочнике "Заказов"!'

-- tInstrument
exec RetCodeInsert 300, 'Состояние с заданным сокращением существует!'
exec RetCodeInsert 301, 'Группа с заданным сокращением существует!'
exec RetCodeInsert 302, 'Действие с заданным сокращением существует!'
exec RetCodeInsert 303, 'Удаление запрещено, под группой имеются связанные настройки!'
exec RetCodeInsert 304, 'Удаление запрещено, под объектом имеются связанные элементы!'
exec RetCodeInsert 305, 'Модель состояния с заданным сокращением существует!'
exec RetCodeInsert 306, 'Удаление запрещено, на состояние имеются переходы!'
exec RetCodeInsert 307, 'Удаление запрещено, под действием настроены связанные объекты "Процедуры"!'

exec RetCodeInsert 310, '[LoadOrders] Не определен идентификатор объекта системы для которго настроена модель состояния!'

exec RetCodeInsert 320, '[LoadOrders] Не определен идентификатор начального состояния!'

exec RetCodeInsert 331, 'Статус с заданным сокращением используется в таблице заказов!'
exec RetCodeInsert 332, 'Статус с заданным сокращением используется в модели состояния!'
exec RetCodeInsert 333, 'Действие с заданным сокращением используется в модели состояния!'

-- tEmployees
exec RetCodeInsert 450, 'Сотрудник с заданным наименованием существует!'
exec RetCodeInsert 451, 'Удаление запрещено, сотрудник связан с клиентом!'
exec RetCodeInsert 452, 'Необходимо заполнить поле менеджер!'
exec RetCodeInsert 453, 'Параметры существуют!'

-- tOrders 500 - 600
exec RetCodeInsert 500, 'Отсутствуют объекты для выполнения операции!'
exec RetCodeInsert 501, 'Не удалось отпределить целевое состояние!'
exec RetCodeInsert 502, 'Отсутствует настройка [CoeffMaxAgree]. Максимальный коэффициент превышения цены продажи для клиента над ценой!'
exec RetCodeInsert 503, 'Необходимо проставить значение настройки [CoeffMaxAgree]. Максимальный коэффициент превышения цены продажи для клиента над ценой!'
exec RetCodeInsert 504, 'Необходимо заполнить обязательные поля "Цена закупки" и "Сумма закупки"!'
exec RetCodeInsert 505, 'Ошибка удаления товара из корзины, требуется ручная проверка!'
exec RetCodeInsert 506, 'Ошибка!'
exec RetCodeInsert 507, 'Клиенту запрещено создавать заказ!'
exec RetCodeInsert 508, 'Недостаточно средств на балансе клиента!'
exec RetCodeInsert 509, 'Ошибка с типом отгрузки!'
exec RetCodeInsert 510, 'Нет позиций для заказа!'
exec RetCodeInsert 511, 'Неизвестная ошибка!'
exec RetCodeInsert 512, 'Состояние "В работе" запрещено откатывать!'
exec RetCodeInsert 513, 'Необходимо заполнить обязательное поле "Reference"!'
exec RetCodeInsert 514, 'Необходимо заполнить обязательное поле "CustomerSubId"!'
exec RetCodeInsert 515, 'Состояние "Отказан" запрещено откатывать!'
exec RetCodeInsert 516, 'Необходимо выделить заказы только одного клиента!'
exec RetCodeInsert 517, 'Неизвестная ошибка, деталь не добавлена в корзину!'
exec RetCodeInsert 518, 'Необходимо заполнить обязательное поле "DestinationLogo"!'
exec RetCodeInsert 519, 'Не задан шаблон Excel для экспорта отказов!'
exec RetCodeInsert 520, 'Не задан каталог для сохранения файлов отказов!'
exec RetCodeInsert 521, 'Не задан скрипт для выгрузки отказов!'
exec RetCodeInsert 522, 'Не найден шаблон Excel для экспорта отказов!'
exec RetCodeInsert 523, 'Не найден каталог для сохранения файлов отказов!'
exec RetCodeInsert 524, 'Не найден скрипт для выгрузки отказов!'
exec RetCodeInsert 525, 'Данный файл уже в обработке!'
exec RetCodeInsert 526, 'Невозможно разместить заказы так как выбраны детали разных клиентов (кабинетов EMEX)!'
exec RetCodeInsert 527, 'Не выбраны позиции для заказа!'
exec RetCodeInsert 528, 'Заказ с заданным номером существует!'
exec RetCodeInsert 530, '[OrderCreateFromBasket] Не определен идентификатор начального состояния!'
exec RetCodeInsert 533, '[OrderCreateFromBasket] Не определен поставщик, обратитесь к администратору системы!'
exec RetCodeInsert 534, '[EmexCreateOrderCheck] Деталь уже размещена!'
exec RetCodeInsert 535, 'Нет позиций для заказа!'
exec RetCodeInsert 536, 'В корзине emex имеются отказанные детали!'
exec RetCodeInsert 537, 'Ошибка удаления из корзины emex!'
exec RetCodeInsert 538, 'Ошибка выполнения действия, по позиции выгружен отказ!'
exec RetCodeInsert 539, 'Объект уже находится в текущем статусе!'
exec RetCodeInsert 540, 'Поле наименования пустое!'
exec RetCodeInsert 541, 'Наименование содержит недопустимые символы!'
exec RetCodeInsert 542, 'Наименование содержит запрещенные слова!'
exec RetCodeInsert 543, 'Наименование содержит только пробелы!'
exec RetCodeInsert 544, 'Вес Физический из прайса = 0, и Вес Физический Факт пустой или равен 0!'
exec RetCodeInsert 545, 'Заказ в работе!'
exec RetCodeInsert 546, 'Запрос существует!'
exec RetCodeInsert 547, 'Необходимо выбрать другого поставщика, так как выбран тот же поставщик, что и в основном заказе!'
exec RetCodeInsert 548, 'Отмена операции запрещена: по заказу уже отправлены ответы (отказы).'

--

-- tPrices - Прайслисты автозапчастей
exec RetCodeInsert 600, 'Прайслист с заданным наименованием существуют!'


-- tBasket 701 - 800
exec RetCodeInsert 701, 'Имеются позиции по которым необходимо обновить цену!', 'There are items that require a price update!'
exec RetCodeInsert 702, 'Пожалуйста заполните поле "Описание"!', 'Please fill in the "Description" field!'
exec RetCodeInsert 703, 'Пожалуйста заполните поле "Вес"!', 'Please fill in the "Weight" field!'
exec RetCodeInsert 704, 'Пожалуйста заполните поле "Объём"!', 'Please fill in the "Volume" field!'
exec RetCodeInsert 705, 'Деталь не найдена в корзине!', 'The item was not found in the cart!'
exec RetCodeInsert 706, 'Нет позиций для заказа!', 'There are no items to order!'
exec RetCodeInsert 707, 'Корзина пуста!', 'The cart is empty!'
exec RetCodeInsert 708, 'Товар запрещен к перевозке по выбранному способу доставки! Выберите другой способ доставки.', 'The item is prohibited from being shipped by the selected delivery method! Please choose another delivery method.'


exec RetCodeInsert 810, 'Товар запрещен к перевозке по выбранному способу доставки! Выберите другой способ доставки.', 'The item is prohibited from being shipped by the selected delivery method! Please choose another delivery method.'



-- API
-- order

exec RetCodeInsert 10001, 'Список заказов пуст', 'The order list is empty'
