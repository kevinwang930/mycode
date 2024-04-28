SET PASSWORD FOR 'root'@localhost = PASSWORD("123456");
select password('123456');
create user kevin@% identified by password '123456';
grant all privileges on *.* to kevin@% 