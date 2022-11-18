-- inserção de dados e queries
use ordem_servico;
show tables;

-- id_cliente, identificador, nome_completo, cpf, cnpj, endereco, contato
insert into Cliente (identificador, nome_completo, cpf, cnpj, endereco, contato ) values
			 (1,'Maria Silva', 12346789, null,'rua silva de prata 29, Carangola - Cidade das flores', null),
		     (2,'Matheus Pimentel', 987654321,null,'rua alemeda 289, Centro - Cidade das flores', null),
			 (3,'Ricardo Silva', 45678913,null, 'avenida alemeda vinha 1009, Centro - Cidade das flores', null);
select * from cliente;

-- id_veiculo, modelo, marca, category, ano_fabricacao, placa
insert into veiculo (modelo, marca, ano_fabricacao, placa) values
							  ('Palio','Fiat','2010', 'ASD-1010'),
                              ('Gol','VW','2015', 'JSD-1519'),
                              ('City','Honda','2015', 'PVZ-1519');
select * from veiculo;

-- id_mecanico, codigo, nome_mecanico, endereço, especialidade
insert into  mecanico (codigo, nome_mecanico, endereço, especialidade) values 
							 (1, 'João Silva',null,'Motor'),
                             (2, 'José Souza',null,50,'Eletrica'),
                             (3, 'Antônio Avelar',null,'Lataria');
select * from mecanico;

-- id_produto, descricao_produto, quantaty, valor_venda
insert into produto (descricao_produto, quantaty, valor_venda) values
						 ('Parafuso', 10, 10.00),
                         ('Protetor', 3, 100.00),
                         ('Pneu', 4, 1110.00);
select * from produto;

-- id_servico, descricao_servico, valor_servico
insert into servico (descricao_servico, valor_servico) values
						 ('lanternagem', 1500.00),
                         ('manutenção', 1100.00),
                         ('eletrica', 500.00);
select * from servico;

-- id_ordem , status_ordem, descricao_ordem, data_emissao, data_entrega, autorizacao_cliente, valor_ordem, id_produto, id_servico, id_cliente
insert into ordem (status_ordem, descricao_ordem, data_emissao, data_entrega, autorizacao_cliente, valor_ordem, id_produto, id_servico, id_cliente) values 
							('Em andamento', 'revisão programada', '2022-11-01', null, true, 1000.00, 3, 2, 1),
                            ('Finalizada', 'revisão', '2022-11-01', '2022-11-10', false, 100.00, 2, 2, 2),
                            ('Em andamento', 'eletrica', '2022-11-01', null, true, 5000.00, 1, 3, 3);                          
select * from ordem;

-- id_veiculo, id_cliente
insert into propriedade (id_veiculo, id_cliente) values
						 (1,2),
                         (2,1),
                         (1,3);
select * from propriedade;

-- id_ordem,  id_veiculo, id_client
insert into ordem_cliente (id_ordem,  id_veiculo, id_client) values 
						 (1,2),
                         (2,1),
                         (3,3);                          
select * from ordem_cliente;

create table mecanicos_orderm(
	id_mecanico int ,
    id_ordem int, 
    primary key (idlproduct, idlstorage),
	constraint fk_mecanicos_orderm_mecanico foreign key (id_mecanico) references mecanico (id_mecanico),
    constraint fk_mecanicos_orderm_ordem foreign key (id_ordem) references ordem (id_ordem)
);
desc mecanicos_orderm;

-- consultas diversas

select count(*) 
from cliente;

select * 
from cliente c, ordem o
where c.idClient = o.id_ordem;

select 
	nome_completo
    descricao_ordem, 
    status_ordem
from cliente c, ordem o 
where c.id_cliente = o.id_ordem;
  
select count(*) 
from cliente c, ordem o 
where c.id_cliente = o.id_ordem;

select count(*) 
from cliente c
	left outer join ordem o  on c.id_cliente = o.id_ordem;

select * from ordem;
      
select 
	c.id_cliente, 
    nome_completo, 
    count(*) as num_ordem
from clients c 
	left outer join ordem o  on c.id_cliente = o.id_ordem
group by c.id_cliente;



