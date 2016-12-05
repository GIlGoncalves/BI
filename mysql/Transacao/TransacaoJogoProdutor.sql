use bi;

drop procedure inserJogoP;
DELIMITER $$

create procedure inserJogoP(in nomeJogo varchar(45),in dataLancamento date, in idade int ,in quantidade int,
in precoBase decimal(10,5), in desconto decimal(10,5),in nomeP varchar(45)) 
BEGIN


declare conta int;
declare idProd int ;
declare erro bool default 0;
declare continue handler for sqlexception set erro=1;

start transaction;

select idProdutor into conta
from produtor
where produtor.nome=nomeP;



if conta>=1

 then 
 
          insert into jogo values (idJogo,nomeJogo,dataLancamento,idade,quantidade,precoBase,conta,now(),desconto);


  else 
		
        insert into produtor values(idProdutor,nomeP,now());
	
    select idProdutor into idProd
    from produtor 
    order by idProdutor DESC
    LIMIT 1;
    

	insert into jogo values (idJogo,nomeJogo,dataLancamento,idade,quantidade,precoBase,idProd,now(),desconto);


end if;


if erro 
then rollback;
else commit;
end if;

END $$

delimiter $$

call inserJogoP ('GTAdsds33d','2014-02-12',18,100,60,0.5,'oladdd');

delimiter $$

select *
from jogo;




