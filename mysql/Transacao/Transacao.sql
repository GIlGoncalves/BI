use bi ;

DELIMITER
drop procedure inserirCompra

DELIMITER $$

create procedure inserirCompra (in idJogo INT, in idCliente INT,IN dataCompra date, in precoVendido decimal(10,5), 
in quantidade int,in desconto decimal(10,5))

BEGIN
declare erro bool default 0;

declare continue handler for sqlexception set erro=1;


start transaction;


update jogo
set jogo.quantidade=jogo.quantidade - quantidade
where jogo.idJogo = idJogo;

insert into compras value(idCompras,idJogo,idCliente,dataCompra,precoVendido,quantidade,desconto,now());


if erro 
then rollback;
else commit;
end if;


end $$

DELIMITER $$

call inserirCompra (1,1,'2014-05-10',300,1000,0.5);
DELIMITER $$

select *
from compras;

DELIMITER $$
select *
from jogo;



