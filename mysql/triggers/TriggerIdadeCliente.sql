use bi;
/* 
O cliente ter de ter no minimo 18 anos para poder criar conta. 
*/

drop trigger anoCliente

delimiter $$
create trigger anoCliente
before insert on cliente
for each row 
begin
declare msg varchar(255);

if((datediff(now(),new.dataNascimento))/365<18) 
Then 
 set msg= 'Não tem idade minima para criar conta';
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 



end if;

end $$

