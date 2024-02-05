
insert tUser (Brief,Name, Login) select 'admin','јдминистратор системы', 'admin'

-- добавление логина
CREATE LOGIN admin WITH PASSWORD = '123456'
-- добавление пользовател€
CREATE USER admin FOR LOGIN admin
-- добавление роли к логину
EXEC master..sp_addsrvrolemember @loginame = N'admin', @rolename = N'sysadmin'

delete tGrant 
insert tGrant
      (UserID     
      ,MenuID)
select u.UserID 
      ,m.MenuID
  from tUser u (nolock)
 inner join tMenu m (nolock)
         on 1=1
 where u.Brief='admin'


select * from tUser  (nolock)
select * from tmenu  (nolock)
select * from tGrant (nolock)


