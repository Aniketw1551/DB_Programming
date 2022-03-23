------------------------Transactions in SQL-----------------------
use DB_Programming
go
------------Autocommit transaction-------------

create table ProductTransaction(
product_id int primary key,
category varchar(100),
cost_price int,
sale_price int
);

insert into ProductTransaction(product_id,category,cost_price,sale_price) values(1,'Electronics',20000,30000),(2,'Grocery',10000,15000),(3,'Jewelry',50000,65000)

select * from ProductTransaction


insert into ProductTransaction(product_id,category,cost_price,sale_price) values(4,'Household',15000,18000)
update ProductTransaction set sale_price=16000 where product_id=2
delete from ProductTransaction where product_id=3
select @@TRANCOUNT

------------Implicit Transaction--------------

select * from ProductTransaction
go

---------with commit-----------

set implicit_transactions on
--insert
insert into ProductTransaction(product_id,category,cost_price,sale_price) values(5,'School',12000,14000)
--update
update ProductTransaction set sale_price=19000 where product_id=4
--delete
delete from ProductTransaction where product_id=2

select @@TRANCOUNT as openTransactions
commit

select @@TRANCOUNT as openTransactions

---------With rollback----------

set implicit_transactions on
--insert
insert into ProductTransaction(product_id,category,cost_price,sale_price) values(7,'College',15000,21000)
--update
update ProductTransaction set sale_price=19000 where product_id=5
--delete
delete from ProductTransaction where product_id=4

select @@TRANCOUNT as openTransactions
rollback

select @@TRANCOUNT as openTransactions


select * from ProductTransaction

---------------Explicit Transaction---------------

begin transaction
--insert
insert into ProductTransaction(product_id,category,cost_price,sale_price) values(7,'College',15000,21000)
--update
update ProductTransaction set cost_price=16000 where product_id=5
--delete
delete from ProductTransaction where product_id=4

declare @a int;
set @a=1;
if @a=1
begin
	commit
end
else
begin
	rollback
end

select * from ProductTransaction

---------------Savepoint command-------------------

begin transaction
insert into ProductTransaction(product_id,category,cost_price,sale_price) values(9,'Office',32000,41000)
save transaction updatepoint
update ProductTransaction set sale_price=18500 where product_id=5
update ProductTransaction set cost_price=17000 where product_id=7
rollback transaction updatepoint
commit

select * from ProductTransaction
