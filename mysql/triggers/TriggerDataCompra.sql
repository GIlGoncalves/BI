use bi;
drop trigger verificaDataCompra;

delimiter $$
create trigger verificaDataCompra
before insert on compras
for each row
begin
declare msg varchar(255);
declare dataR date;
declare dataL date;
declare quant int;
declare quanF int;

select dataRegisto into dataR
from cliente
where New.idCliente=idCliente;

select dataLancamento into dataL 
from jogo
where New.idJogo = idJogo;

if((datediff(New.dataCompra ,dataR))/365<0) 
Then 
 set msg= 'O utilizador nao tinha conta criada quando comprou este artigo';
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
          
else
	  if((datediff(New.dataCompra ,dataL))/365<0) 
        then 
		  set msg= 'O utilizador nao pode ter comprar este jogo nesta data porque ele ainda nao tinha saido';
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
         
        else   
               select quantidade into quant
               from jogo
               where idJogo=New.idJogo;
               set quanF=quant-New.quantidade;
               
               if(quanF<0) 
               
               then set msg= 'O utilizador nao pode comprar a quantidade desejada';
						SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
               
               else update jogo
					set quantidade=quantidade-New.quantidade
                    where idJogo=New.idJogo;
               end if;
      end if;

end if;
end $$


