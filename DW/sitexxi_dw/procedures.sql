use sitexxi_dw;

drop procedure if exists sp_update_cliente;

DELIMITER $$
create procedure sp_update_cliente(
								      in in_id_cliente int,
                                      in in_nr_telemovel varchar(20),
									  in in_cidade varchar(45),
									  in in_pais varchar(35),
									  in in_last_update timestamp(6)
								  )
begin
	
    declare id_clienteC int;
    declare cidadeC varchar(45);
    declare paisC varchar(35);
    declare last_updateC timestamp(6);
    declare aux int;
    
    declare erro bool default 0;
	declare continue handler for sqlexception set erro=1;
	
    start transaction;
    
    select id_cliente into aux from DIM_Cliente where id_cliente = in_id_cliente and nr_telemovel != in_nr_telemovel;
    
    if aux is not null then
		
		update DIM_Cliente
			set nr_telemovel = in_nr_telemovel,
				last_update = in_last_update
			where id_cliente = in_id_cliente;
    end if;
    
    select cidade into cidadeC from DIM_Cliente where id_cliente = in_id_cliente limit 1;
    select pais into paisC from DIM_Cliente where id_cliente = in_id_cliente limit 1;
    select last_update into last_updateC from DIM_Cliente where id_cliente = in_id_cliente limit 1;
    
    insert into DIM_Cliente_Historia
		(id_cliente,cidade,pais,last_update)
    values
		(in_id_cliente,cidadeC,paisC,last_updateC);
    
    update DIM_Cliente
		set cidade = in_cidade,
			pais = in_pais,
            last_update = in_last_update
        where id_cliente = in_id_cliente;

    if erro 
	then rollback;
	else commit;
	end if;

end $$
DELIMITER ;

drop procedure if exists sp_update_jogo;

DELIMITER $$
create procedure sp_update_jogo(
							      in in_id_jogo int,
								  in in_stock int,
								  in in_preco decimal(7,2),
								  in in_desconto decimal(5,2),
								  in in_last_update timestamp(6)
							   )
begin
    
    update DIM_Jogo
		set stock = in_stock,
			preco = in_preco,
            desconto = in_desconto,
            last_update = in_last_update
		where id_jogo = in_id_jogo;
    
end $$
DELIMITER ;