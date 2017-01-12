drop trigger inserPaisAuditoria; 

Delimiter $$
create trigger inserPaisAuditoria
after insert on pais
for each row
begin

insert into paisauditoria value (idPaisAuditoria,New.idPais,New.nomePais,'I',New.last_Updade);

end$$ 

drop trigger updatePaisAuditoria;

Delimiter $$
create trigger updatePaisAuditoria
after update on pais
for each row

begin

insert into paisauditoria value (idPaisAuditoria,New.idPais,New.nomePais,'U',New.last_Updade);

end$$ 

drop trigger removePaisAuditoria;

Delimiter $$
create trigger removePaisAuditoria
after delete on pais
for each row

begin

insert into paisauditoria value (idPaisAuditoria,OLD.idPais,OLD.nomePais,'D',now());

end$$ 


