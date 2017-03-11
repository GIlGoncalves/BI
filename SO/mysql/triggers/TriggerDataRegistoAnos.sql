use bi;
/* 
A data de registo ser maior que a data de nascimento 
*/

drop trigger dataRegisto

delimiter $$
create trigger dataRegisto
before insert on cliente
for each row FOLLOWS anoCliente
begin
declare msg varchar(255);

if((datediff(new.DataRegisto,new.dataNascimento))<0) 
Then 
 set msg= 'A data de registo esta errada';
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 



end if;

end $$