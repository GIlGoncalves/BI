use bi;

drop procedure inserCompras;

delimiter $$
create procedure inserCompras(in idJogo int, in idCliente int, in precoVendido decimal(10,5), in quantidade int)
begin
declare desco decimal(10,5);
declare preco decimal(10,5);

declare msg varchar(255);

if precoVendido >=0  

then
if quantidade >0

then 
   select precoBase into preco
   from jogo
   where jogo.idJogo=idJogo;
 
  set desco = (precoVendido - preco)/(-preco);

   insert into compras value (idCompras,idJogo,idCliente, date(now()), precoVendido,quantidade, desco,now());
   

else 

set msg= 'O quantidade introduzido e menor ou igual a zero';
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
end if;          

else 
set msg= 'O preco introduzido e negativo';
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 

end if;
end $$ 

delimiter $$ 

call inserCompras(1,1,0,90);
delimiter $$ 

select * 
from jogo;


delimiter $$
select *
from compras;