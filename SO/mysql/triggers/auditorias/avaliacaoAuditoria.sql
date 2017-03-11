drop trigger inserAvaliacaoAuditoria; 

Delimiter $$
create trigger inserAvaliacaoAuditoria
after insert on avaliacao
for each row
begin

insert into avaliacaoauditoria value (idavaliacaoAuditoria,New.idJogo,New.idCliente,New.avaliacao,New.last_Update,New.descricao,'I');

end$$ 


drop trigger updateAvaliacaoAuditoria; 

Delimiter $$
create trigger updateAvaliacaoAuditoria
after update on avaliacao
for each row
begin

insert into avaliacaoauditoria value (idavaliacaoAuditoria,New.idJogo,New.idCliente,New.avaliacao,New.last_Update,New.descricao,'U');

end$$ 



drop trigger removeAvaliacaoAuditoria; 

Delimiter $$
create trigger removeAvaliacaoAuditoria
after delete on avaliacao
for each row
begin

insert into avaliacaoauditoria value (idavaliacaoAuditoria,OLD.idJogo,OLD.idCliente,OLD.avaliacao,now(),OLD.descricao,'R');

end$$ 
