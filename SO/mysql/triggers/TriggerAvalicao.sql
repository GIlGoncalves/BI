use bi;
/* 
A data de registo ser maior que a data de nascimento 
*/

drop trigger avaliacaoR

delimiter $$
create trigger avaliacaoR
before insert on avaliacao
for each row 
begin
declare msg varchar(255);

if(New.avaliacao>5) 
Then 
 set msg= 'A avaliacao so vai ate 5';
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 



end if;

end $$