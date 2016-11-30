use bi;

drop procedure inserJogo;
DELIMITER $$

create procedure inserJogo(in nomeJogo varchar(45),in dataLancamento date, in idade int ,in quantidade int,
in precoBase decimal(10,5), in idProdutor int, in desconto decimal(10,5), in categoria int) 
BEGIN
declare idJo int;
declare erro bool default 0;
declare continue handler for sqlexception set erro=1;

start transaction;



insert into jogo values (idJogo,nomeJogo,dataLancamento,idade,quantidade,precoBase,idProdutor,now(),desconto);

select idJogo into idJo
from jogo
order by idJogo DESC
limit 1;

insert into jogocategoria values(idJo,categoria,now());

if erro 
then rollback;
else commit;
end if;

END $$

call inserJogo('GTA V31',date(now()),18,100,60,1,0.5,1)

delimiter 
select *
from jogo;