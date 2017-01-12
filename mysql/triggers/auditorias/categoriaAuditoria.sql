drop trigger inserCategoriaAuditoria;

Delimiter $$
create trigger inserCategoriaAuditoria
after insert on categoria
for each row
begin

insert into categoriaauditoria value (idcategoriaAuditoria,New.idCategoria,New.categoria,New.last_Update,'I');

end$$ 


drop trigger updateCategoriaAuditoria;

Delimiter $$
create trigger updateCategoriaAuditoria
after update on categoria
for each row
begin

insert into categoriaauditoria value (idcategoriaAuditoria,New.idCategoria,New.categoria,New.last_Update,'U');

end$$


Delimiter $$
create trigger removeCategoriaAuditoria
after delete on categoria
for each row
begin

insert into categoriaauditoria value (idcategoriaAuditoria,OLD.idCategoria,OLD.categoria,now(),'R');

end$$