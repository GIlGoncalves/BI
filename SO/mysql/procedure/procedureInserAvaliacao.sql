use bi;
/*
o cliente só pode avaliar um jogo que comprou, e a avaliacao esta compreendida de 0 a 5 valores 

*/

drop procedure inserAvaliacao

DELIMITER $$
create procedure inserAvaliacao(in idJogo INT, in idCliente INT, in avaliacao INT,in descricao TEXT) 
BEGIN
declare conta int;
declare contador int;
dECLARE msg varchar(255);


if avaliacao >=0 and avaliacao <=5
then
select count(*) into contador
from compras as C
where c.idJogo=idJogo and c.idCliente=idCliente; 

if contador >0 
then

select count(*) into conta
from avaliacao as A
where A.idJogo = idJogo and A.idCliente=idCliente;

if conta >0 
then 
	  update avaliacao as A
	  set A.avaliacao = avaliacao,
		  A.last_Update = now()
	  where A.idJogo = idJogo and A.idCliente=idCliente;


else 

insert into avaliacao values(idJogo,idCliente,avaliacao,now(),descricao);

end  if;




else 
set msg= 'O utilizador precisa de comprar o jogo para o poder avaliar';
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 

end if;

else 
set msg= 'A avaliacao tem de ser maior ou igual a zero e menor ou igual a 5';
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 

end if;

END $$ 

delimiter $$

  
