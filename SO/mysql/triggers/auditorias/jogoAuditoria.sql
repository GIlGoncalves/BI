drop trigger inserJogoAuditoria; 

Delimiter $$
create trigger inserJogoAuditoria
after insert on jogo
for each row
begin

insert into jogoauditoria value (idjogoAuditoria,New.idJogo,New.nome,New.dataLancamento,New.idadeParaJogar,New.quantidade,New.precoBase,New.idProdutor,New.last_Update,New.desconto,'I');

end$$ 



drop trigger updateJogoAuditoria; 

Delimiter $$
create trigger updateJogoAuditoria
after update on jogo
for each row
begin

insert into jogoauditoria value (idjogoAuditoria,New.idJogo,New.nome,New.dataLancamento,New.idadeParaJogar,New.quantidade,New.precoBase,New.idProdutor,New.last_Update,New.desconto,'U');

end$$ 


drop trigger removeJogoAuditoria; 

Delimiter $$
create trigger removeJogoAuditoria
after delete on jogo
for each row
begin

insert into jogoauditoria value (idjogoAuditoria,OLD.idJogo,OLD.nome,OLD.dataLancamento,OLD.idadeParaJogar,OLD.quantidade,OLD.precoBase,OLD.idProdutor,now(),OLD.desconto,'R');

end$$
