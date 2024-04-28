USE test;
create table transactions (
    transaction_id int,
    user_id int,
    transaction_date date,
    store_id int,
 	payment_method varchar(10),
    amount float
);

insert into transactions
(transaction_id, user_id, transaction_date, store_id, payment_method, amount)
values
    (1, 1234, `2019–03–02`, 1, 'cash', 5.25),
    (1, 1234, `2019–03–01`, 1, 'credit', 10.75),
    (1, 1234, `2019–03–02`, 2, 'cash', 25.50),
    (1, 1234, `2019–03–03`, 2, 'credit', 17.00),
    (1, 4321, `2019–03–01`, 2, 'cash', 20.00),
    (1, 4321, `2019–03–02`, 2, 'debit', 30.00),
    (1, 4321, `2019–03–03`, 1, 'cash', 3.00)
;