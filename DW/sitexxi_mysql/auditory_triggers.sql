use sitexxi;

SET SQL_SAFE_UPDATES = 0;

drop trigger if exists insert_cliente_auditory; 

Delimiter $$
create trigger insert_cliente_auditory
after insert on Cliente
for each row
begin

insert into Auditory_Cliente
value (New.id_cliente,New.nome,New.email,New.data_nascimento,New.sexo,New.nr_telemovel,New.data_registo,New.id_cidade,'I',now());

end $$
DELIMITER ;

drop trigger if exists update_cliente_auditory; 

Delimiter $$
create trigger update_cliente_auditory
after update on Cliente
for each row
begin

insert into Auditory_Cliente
value (New.id_cliente,New.nome,New.email,New.data_nascimento,New.sexo,New.nr_telemovel,New.data_registo,New.id_cidade,'U',now());

end $$
DELIMITER ;

drop trigger if exists insert_jogo_auditory; 

Delimiter $$
create trigger insert_jogo_auditory
after insert on Jogo
for each row
begin

insert into Auditory_Jogo
value (New.id_jogo,New.nome,New.data_lancamento,New.idade_minima,New.stock,New.preco,New.desconto,New.id_produtor,'I',now());

end $$ 
DELIMITER ;

drop trigger if exists update_jogo_auditory; 

Delimiter $$
create trigger update_jogo_auditory
after update on Jogo
for each row
begin

insert into Auditory_Jogo
value (New.id_jogo,New.nome,New.data_lancamento,New.idade_minima,New.stock,New.preco,New.desconto,New.id_produtor,'U',now());

end $$
DELIMITER ;

drop trigger if exists insert_compra_auditory; 

Delimiter $$
create trigger insert_compra_auditory
after insert on Compra
for each row
begin

insert into Auditory_Compra
value (New.id_compra,New.id_cliente,New.id_jogo,New.quantidade,New.preco,New.desconto,New.data_compra,'I',now());

end $$
DELIMITER ;
