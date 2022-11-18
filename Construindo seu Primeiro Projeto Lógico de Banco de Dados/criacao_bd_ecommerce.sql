-- Criação do banco de dados para o cenário de E-commerce

-- criação / uso do database
create database ecommerce;
use ecommerce;

-- criação das tabelas
-- cliente
create table clients (
	idclient int auto_increment primary key,
    fname varchar(10) not null,
    mname varchar(3),
    lname varchar(20) not null,
    cpf char(11) not null,
    address varchar(30) not null,
    constraint unique_cpf_client unique (cpf)
);
alter table clients auto_increment=1;
desc clients;

-- produto
-- size = dimensão do produto
create table produto (
    idProduto int auto_increment primary key,
    pname varchar(10) not null,
    classification_kids BOOL DEFAULT FALSE,
    category enum('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    avaliation float default 0,
    size varchar(10),
    saleprice float not null
);
alter table product auto_increment=1;
desc product;

-- pagamentos
create table payments (
	idpayment int auto_increment,
    idclient int,
    typepayment enum('Boleto','Cartão','Dois Cartões'),
    limitavailable float,
    primary key(idclient, idpayment)
);
alter table payments auto_increment=1;
desc payments;

-- tabela pedido
create table orders (
	 idorder int auto_increment primary key,
     idorderclient int ,
     orderstatus enum("Cancelado", "Confirmado", "Em andamento", "Processando", "Enviado", "Entregue") default "Processando",
     orderdescition varchar(255),
     sendvalue float default 10.00,
     typepayment enum('Boleto','Cartão','Dois Cartões') not null,
     idorderpayment int,
     constraint fk_orders_client foreign key (idorderclient) references clients (idClient),
     constraint fk_orders_payment foreign key (idorderpayment) references payments (idpayment)
		on update cascade
        on delete set null
);
alter table orders auto_increment=1;
desc orders; 

-- estoque
create table productstorage (
	 idprodstorage int auto_increment primary key,
	 location varchar(50),
     quantaty int default 0
);
alter table productstorage auto_increment=1;
desc productstorage;

-- fornecedor
create table supplier (
	 idsupplier int auto_increment primary key,
	 cnpj char(15) not null, 
	 socialname varchar(50) not null,
     addresssupplier varchar(30) not null,
     contactsupplier char(11),
     constraint unique_cnpj_supplier unique (cnpj)
);
alter table supplier auto_increment=1;
desc supplier;

-- terceiro - vendedor
create table seller (
	 idseller int auto_increment primary key,
	 cnpj char(15) , 
     cpf char(11),
	 socialname varchar(50) not null, 
     addresssupplier varchar(30) not null,
     contactsupplier char(11),
     constraint unique_cnpj_seller unique (cnpj),
     constraint unique_cpf_seller unique (cpf)
);
alter table seller auto_increment=1;
desc seller;

-- relacionamento produto/vendedor
create table productseller(
	idpproduct int ,
    idpseller int, 
    prodquantaty int default 1,
    primary key (idpproduct, idpseller),
	constraint fk_product_seller foreign key (idpseller) references seller (idseller),
    constraint fk_product_product foreign key (idpproduct) references product (idproduct)
);
desc productseller;

-- relacionamento produto/pedido
create table productorder(
	idpoproduct int ,
    idpoorder int, 
    poquantaty int default 1,
    postatus enum('Disponível','Sem estoque') default 'Disponível',
    primary key (idpoproduct, idpoorder),
	constraint fk_product_order foreign key (idpoorder) references orders (idorder),
    constraint fk_productor_orderproduct foreign key (idpoproduct) references product (idproduct)
);
desc productorder;

-- relacionamento produto/estoque
create table storagelocation(
	idlproduct int ,
    idlstorage int, 
    location varchar(255) not null,
    primary key (idlproduct, idlstorage),
	constraint fk_product_storage foreign key (idlstorage) references productstorage (idprodstorage),
    constraint fk_product_storageproduct foreign key (idlproduct) references product (idproduct)
);
desc storagelocation;

-- relacionamento produto/fornecedor
create table productsupplier(
	idpsproduct int ,
    idpssupplier int, 
    quantaty int not null default 0,
    primary key (idpsproduct, idpssupplier),
	constraint fk_product_supplier foreign key (idpssupplier) references supplier (idsupplier),
    constraint fk_product_supplierproduct foreign key (idlproduct) references product (idproduct)
);
desc productsupplier;

show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';