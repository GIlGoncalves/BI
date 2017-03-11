drop trigger inserCidadeAuditoria; 

Delimiter $$
create trigger inserCidadeAuditoria
after insert on cidade
for each row
begin

insert into cidadeauditoria value (idCidadeAuditoria,New.idCidade,New.cidade,New.idPais,'I',New.last_Updade);

end$$ 

drop trigger if exists updateCidadeAuditoria;

Delimiter $$
create trigger updateCidadeAuditoria
after update on cidade
for each row

begin

insert into cidadeauditoria value (idCidadeAuditoria,New.idCidade,New.cidade,New.idPais,'U',New.last_Updade);
end$$ 

drop trigger if exists removeCidadeAuditoria;

Delimiter $$
create trigger removeCidadeAuditoria
after delete on cidade
for each row

begin

insert into cidadeauditoria value (idCidadeAuditoria,OLD.idCidade,OLD.cidade,OLD.idPais,'R',now());

end$$ 


