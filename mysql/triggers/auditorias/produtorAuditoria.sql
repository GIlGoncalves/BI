drop trigger inserProdutorAuditoria;

Delimiter $$
create trigger inserProdutorAuditoria
after insert on produtor
for each row
begin

insert into produtorauditoria value (idprodutorAuditoria,New.idProdutor,New.nome,New.last_Update,'I');

end$$ 


drop trigger updateProdutorAuditoria;

Delimiter $$
create trigger updateProdutorAuditoria
after update on produtor
for each row
begin

insert into produtorauditoria value (idprodutorAuditoria,New.idProdutor,New.nome,New.last_Update,'U');

end$$


drop trigger removeProdutorAuditoria;

Delimiter $$
create trigger removeProdutorAuditoria
after delete on produtor
for each row
begin

insert into produtorauditoria value (idprodutorAuditoria,OLD.idProdutor,OLD.nome,now(),'R');

end$$




