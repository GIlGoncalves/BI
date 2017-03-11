drop trigger inserComprasAuditoria; 


Delimiter $$
create trigger inserComprasAuditoria
after insert on compras
for each row
begin

insert into comprasauditoria value (idcomprasAuditoria,New.idCompras,New.idJogo,New.idCliente,New.dataCompra,New.precoVendido,New.quantidade,New.desconto,New.last_Update,'I');

end$$ 


drop trigger updateComprasAuditoria; 


Delimiter $$
create trigger updateComprasAuditoria
after update on compras
for each row
begin

insert into comprasauditoria value (idcomprasAuditoria,New.idCompras,New.idJogo,New.idCliente,New.dataCompra,New.precoVendido,New.quantidade,New.desconto,New.last_Update,'U');

end$$ 


drop trigger removeComprasAuditoria; 


Delimiter $$
create trigger removeComprasAuditoria
after delete on compras
for each row
begin

insert into comprasauditoria value (idcomprasAuditoria,OLD.idCompras,OLD.idJogo,OLD.idCliente,OLD.dataCompra,OLD.precoVendido,OLD.quantidade,OLD.desconto,now(),'R');

end$$ 


