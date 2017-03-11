use sitexxi;

# inserir um novo cliente
insert into Cliente
(`nome`,`email`,`data_nascimento`,`sexo`,`nr_telemovel`,`data_registo`,`id_cidade`)
value
('Teste99','teste@mail.com','1992-09-1','M','123456709','2017-03-2',4);

# update ao novo cliente
update Cliente
	set id_cidade = 5
    where id_cliente = 10;
    
update Cliente
	set id_cidade = 2,
		nr_telemovel = '0987654321'
    where id_cliente = 10;

# inserir um novo jogo
#insert into Jogo
#(`nome`,`data_lancamento`,`idade_minima`,`stock`,`preco`,`desconto`,`id_produtor`)
#values
#('Teste','2014-02-12',18,100,60,5,1);

# update ao novo jogo
#update Jogo
#	set stock = 50
#    where id_jogo = 11;

# inserir uma nova compra em relação ao cliente e ao jogo inserido
insert into Compra
(`id_cliente`,`id_jogo`,`quantidade`,`preco`,`desconto`,`data_compra`)
values
(10,10,1,30,50,'2017-04-10');
