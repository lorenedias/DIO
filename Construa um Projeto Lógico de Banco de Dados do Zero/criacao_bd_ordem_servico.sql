-- Criação do banco de dados para o cenário de E-commerce

-- criação / uso do database
create database ordem_servico;
use ordem_servico;

-- criação das tabelas
-- cliente
create table cliente (
	id_cliente int auto_increment primary key,
    identificador int,
    nome_completo varchar(55) not null,
    cpf char(9),
    cnpj char(15), 
    endereco varchar(30) not null,
    contato char(11),
    constraint unique_cpf_cliente unique (cpf),
	constraint unique_cnpj_cliente unique (cnpj)
);
alter table cliente auto_increment=1;
desc cliente;

-- veiculo
create table veiculo (
    id_veiculo int auto_increment primary key,
    modelo varchar(20) not null,
    marca varchar(20) not null,
    ano_fabricacao date not null,
    placa varchar(10) not null
);
alter table veiculo auto_increment=1;
desc veiculo;

-- mecanico
create table mecanico (
	id_mecanico int auto_increment primary key,
    codigo int,
    nome_mecanico varchar(50),
    endereço varchar(50),
    especialidade enum('Motor','Eletrica','Lataria')
   );
alter table mecanico auto_increment=1;
desc mecanico;

-- produto
create table produto (
	 id_produto int auto_increment primary key,
	 descricao_produto varchar(50) not null,
     quantaty int not null default 0,
     valor_venda float not null default 0
);
alter table produto auto_increment=1;
desc produto;

-- serviço
create table servico (
	 id_servico int auto_increment primary key,
	 descricao_servico varchar(50) not null,
     valor_servico float not null default 0
);
alter table servico auto_increment=1;
desc servico;

-- ordem
create table ordem (
	 id_ordem int auto_increment primary key,
     status_ordem enum("Cancelado", "Confirmado", "Em andamento", "Finalizada") default "Em andamento",
     descricao_ordem varchar(255),
     data_emissao date not null,
     data_entrega date,
     autorizacao_cliente bool not null default false,
     valor_ordem float default 0, 
     id_produto int primary key,
     id_servico int primary key,
	 id_cliente int ,
     constraint fk_ordem_produto foreign key (id_produto) references produto (id_produto),
     constraint fk_ordem_servico foreign key (id_servico) references servico (id_servico),
     constraint fk_ordem_cliente foreign key (id_cliente) references cliente (id_cliente)
		on update cascade
        on delete set null
);
alter table ordem auto_increment=1;
desc ordem; 

-- relacionamento Veiculo / Cliente
create table propriedade(
	id_veiculo int ,
    id_cliente int, 
    primary key (id_veiculo, id_cliente),
	constraint fk_propriedade_veiculo foreign key (id_veiculo) references veiculo (id_veiculo),
    constraint fk_propriedade_cliente foreign key (id_cliente) references cliente (id_cliente)
);
desc propriedade;

-- relacionamento Orderm de Serviço / Veiculos / Cliente
create table ordem_cliente(
	id_ordem int ,
    id_veiculo int, 
	id_client int, 
    primary key (id_ordem, id_veiculo, id_client),
	constraint fk_ordem_cliente_ordem foreign key (id_ordem) references orders (id_ordem),
    constraint fk_ordem_cliente_veiculo foreign key (id_veiculo) references id_veiculo (id_veiculo),
    constraint fk_ordem_cliente_cliente foreign key (id_client) references product (id_client)
);
desc productorder;

-- relacionamento Mecânicos / Orderm de Serviço
create table mecanicos_orderm(
	id_mecanico int ,
    id_ordem int, 
    primary key (idlproduct, idlstorage),
	constraint fk_mecanicos_orderm_mecanico foreign key (id_mecanico) references mecanico (id_mecanico),
    constraint fk_mecanicos_orderm_ordem foreign key (id_ordem) references ordem (id_ordem)
);
desc mecanicos_orderm;

show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ordem_servico';