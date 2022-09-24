-- criação do banco de dados 

create database ecommerce;
use ecommerce;

-- criar tabela 

create table client(
	idclient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique (CPF)
);

create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10),
    classification_kids bool,
    category enum('Eletronicos', 'Vestimenta1', 'Brinquedos', 'Alimentos', 'Moveis')not null,
    avaliação float default 0,
    size varchar(10),
    constraint unique_cpf_client unique (CPF)
);

create table payment(
	idclient int primary key,
    id_payment int, 
    typePayment enum('Boleto', 'Cartão', 'Dois cartões'),
    limitAvailable float,
    primary key(idClient, id_payment),
	constraint fk_client foreign key(idClient) references clients(idClient)

);


create table orders(
	idOrders int auto_increment primary key,
    idOrdersClient int,
	orderStatus enum('Cancelado', 'Confrimado', 'Em processo') not null,
    ordenDescription varchar(255),
    sendValue float default 10,
    idpayment bool default false,
    constraint fk_ordes_client foreign key(idOrderClient) references clients(idClient),
	constraint fk_orders_payment foreign key(idpayment) references payment(idpayment)

);
create table productStorage(
	idProdStorage int auto_increment primary key,
    storagelocation varchar(255),
    quantity int default 0
   
);

create table supplier(
	idSuplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
   
);

create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(15),
    Location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
   constraint unique_cpf_seller unique (CNPJ)
);

create table productSeller(
 idPseller int,
 idPproduct int,
 prodQuantity int default 1,
 primary key (idPseller, idPproduct),
 constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
 constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

create table productOrder(
 idPOproduct int,
 idPOorder int,
 poQuantity int default 1,
 poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
 primary key (idPOproduct, idPOorder),
 constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
 constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storegeLocation(
 idLproduct int,
 idLstorage int,
 location varchar(255) not null,
 primary key (idPOproduct, idPOorder),
 constraint fk_product_seller foreign key (idPOproduct) references product(idProduct),
 constraint fk_product_product foreign key (idPOorder) references productStorage(idProdStorage)
);

create table productSupplier(
 idPsSupplier int,
 idPsProduct int,
 quality int not null,
 primary key (idPsSupplier, idPsProduct ),
 constraint fk_product_seller foreign key (idPsSupplier) references product(idSupplier),
 constraint fk_product_product foreign key (idPsProduct) references productStorage(idProduct)
);

show tables;

show databases;
use information_schema;
show tables;
desc referential_constrainsts;

select * from referential_constrainsts where constraint_schema = 'ecommerce';

select fName from client;
select fname from client where category = 'Eletronicos';
select * from product order by size;

select 
A.Fname Client,
A.CPF Client,
B.Pname product
from
 client A inner join product B
 on A.idProduct = B.idProduct