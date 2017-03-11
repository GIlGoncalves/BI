drop trigger inserClieteAuditoria; 

Delimiter $$
create trigger inserClienteAuditoria
after insert on cliente
for each row
begin

insert into clienteauditoria value (idclienteAuditoria,New.idCliente,New.nome,New.dataRegisto,New.dataNascimento,New.email,New.nrTelemovel,New.last_Update,New.idCidade,New.sexo,'I');

end$$ 


drop trigger updateClieteAuditoria; 

Delimiter $$
create trigger updateClienteAuditoria
after update on cliente
for each row
begin

insert into clienteauditoria value (idclienteAuditoria,New.idCliente,New.nome,New.dataRegisto,New.dataNascimento,New.email,New.nrTelemovel,New.last_Update,New.idCidade,New.sexo,'U');

end$$ 



drop trigger removeClieteAuditoria; 

Delimiter $$
create trigger removeClienteAuditoria
after delete on cliente
for each row
begin

insert into clienteauditoria value (idclienteAuditoria,OLD.idCliente,OLD.nome,OLD.dataRegisto,OLD.dataNascimento,OLD.email,OLD.nrTelemovel,now(),OLD.idCidade,OLD.sexo,'R');

end$$ 


