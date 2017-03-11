drop trigger inserJogoCategoriaAuditoria;

Delimiter $$
create trigger inserJogoCategoriaAuditoria
after insert on jogocategoria
for each row
begin

insert into jogocategoriaauditoria value (idjogoCategoriaAuditoria,New.idJogo,New.idCategoria,New.last_Update,'I');

end$$ 


drop trigger updateJogoCategoriaAuditoria;

Delimiter $$
create trigger updateJogoCategoriaAuditoria
after update on jogocategoria
for each row
begin

insert into jogocategoriaauditoria value (idjogoCategoriaAuditoria,New.idJogo,New.idCategoria,New.last_Update,'U');

end$$ 


drop trigger removeJogoCategoriaAuditoria;

Delimiter $$
create trigger removeJogoCategoriaAuditoria
after delete on jogocategoria
for each row
begin

insert into jogocategoriaauditoria value (idjogoCategoriaAuditoria,OLD.idJogo,OLD.idCategoria,now(),'R');

end$$ 
