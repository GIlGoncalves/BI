use sitexxi_etl;

drop procedure if exists sp_insert_cliente;
DELIMITER $$
create procedure sp_insert_cliente(
										in in_id_cliente int,
										in in_nome varchar(100),
										in in_email varchar(50),
										in in_data_nascimento date,
										in in_sexo char(1),
										in in_nr_telemovel varchar(20),
										in in_data_registo datetime,
										in in_cidade varchar(45),
										in in_pais varchar(45),
										in operation char(1),
										in operation_timestamp timestamp(6),
										in in_source int
									  )
begin
	SET @id = ( SELECT id_DIM_Cliente FROM AR_SK_Cliente WHERE source = in_source and id_source = in_id_cliente);
	if @id is not null then
		INSERT INTO AR_QUAR_Cliente
			(id_cliente,nome,email,data_nascimento,sexo,nr_telemovel,data_registo,cidade,pais,operation,operation_timestamp,descricao,source)
		values
			(in_id_cliente,in_nome,in_email,in_data_nascimento,in_sexo,in_nr_telemovel,in_data_registo,in_cidade,in_pais,operation,operation_timestamp,"Chave repetida",in_source);
	else
		set @id = (SELECT id_DIM_Cliente FROM AR_SK_Cliente WHERE email = in_email limit 1);
        if @id is not null then
			START TRANSACTION;
            INSERT INTO AR_SK_Cliente
            	(id_DIM_Cliente,source,id_source,email)
            values
				(@id,in_source,in_id_cliente,in_email);
			INSERT INTO AR_QUAR_Cliente
				(id_cliente,nome,email,data_nascimento,sexo,nr_telemovel,data_registo,cidade,pais,operation,operation_timestamp,descricao,source)
			values
				(in_id_cliente,in_nome,in_email,in_data_nascimento,in_sexo,in_nr_telemovel,in_data_registo,in_cidade,in_pais,operation,operation_timestamp,"Cliente repetido",in_source);
			COMMIT;
        ELSE 
			START TRANSACTION;
			INSERT INTO AR_SK_Cliente
            	(source,id_source,email)
            values
				(in_source,in_id_cliente,in_email);
			set @id = ( SELECT id_DIM_Cliente FROM AR_SK_Cliente WHERE source = in_source and id_source = in_id_cliente);
			INSERT INTO AR_DIM_Cliente
				(id_cliente,nome,email,data_nascimento,sexo,nr_telemovel,data_registo,cidade,pais,last_update)
			values
				(@id,in_nome,in_email,in_data_nascimento,in_sexo,in_nr_telemovel,in_data_registo,in_cidade,in_pais,operation_timestamp);
			COMMIT;
		END IF;
    END IF;
END $$
DELIMITER ;

drop procedure if exists sp_insert_jogo;
DELIMITER $$
create procedure sp_insert_jogo(
									in in_id_jogo int,
                                    in in_nome varchar(50), 
									in in_data_lancamento datetime,
                                    in in_idade_minima int,
                                    in in_stock int,
                                    in in_preco decimal(7,2),
                                    in in_desconto decimal(5,2),
                                    in in_produtor varchar(45),
                                    in operation char(1),
									in operation_timestamp timestamp(6),
									in in_source int
								)
BEGIN
	
    declare idJogo int;
    declare stockJ int;
    declare precoJ decimal(7,2);
    declare descontoJ decimal(5,2);
    
	declare erro bool default 0;
	declare continue handler for sqlexception set erro=1;
	
    start transaction;
    
	select id_DIM_Jogo into idJogo from AR_SK_Jogo where source = in_source and id_source = in_id_jogo;
    
	if idJogo is not null then
		insert into AR_QUAR_Jogo
			(id_jogo,nome,data_lancamento,idade_minima,stock,preco,desconto,produtor,operation,operation_timestamp,descricao,source)
		values
			(in_id_jogo,in_nome,in_data_lancamento,in_idade_minima,in_stock,in_preco,in_desconto,in_produtor,operation,operation_timestamp,"Chave repetida",in_source);
	else
		select id_DIM_Jogo into idJogo from AR_SK_Jogo where nome = in_nome limit 1;
        if idJogo is not null then
            insert into AR_SK_Jogo
            	(id_DIM_Jogo,source,id_source,nome,stock,preco,desconto)
            values
				(idJogo,in_source,in_id_jogo,in_nome,in_stock,in_preco,in_desconto);
			
            select stock into stockJ from AR_SK_Jogo where nome = in_nome limit 1;
            select preco into precoJ from AR_SK_Jogo where nome = in_nome limit 1;
            select desconto into descontoJ from AR_SK_Jogo where nome = in_nome limit 1;
			
            update AR_DIM_Jogo
				set stock = floor((in_stock+stockJ)/2.0),
                     preco = (in_preco+precoJ)/2.0,
                     desconto = (in_desconto+descontoJ)/2.0
                where id_jogo = idJogo;
		else 
            insert into AR_SK_Jogo
            	(source,id_source,nome,stock,preco,desconto)
            values
				(in_source,in_id_jogo,in_nome,in_stock,in_preco,in_desconto);
			
            select id_DIM_Jogo into idJogo from AR_SK_Jogo where source = in_source and id_source = in_id_jogo;
			
            insert into AR_DIM_Jogo
				(id_jogo,nome,data_lancamento,idade_minima,stock,preco,desconto,produtor,last_update)
			values
				(idJogo,in_nome,in_data_lancamento,in_idade_minima,in_stock,in_preco,in_desconto,in_produtor,operation_timestamp);
		end if;
	end if;
    
    if erro 
	then rollback;
	else commit;
	end if;

END $$
DELIMITER ;

drop procedure if exists sp_insert_venda;
DELIMITER $$
create procedure sp_insert_venda(
									in in_id_venda int,
									in in_id_cliente int,
                                    in in_id_jogo int,
									in in_quantidade int,
                                    in in_preco decimal(7,2),
                                    in in_desconto decimal(5,2),
                                    in in_data_compra datetime,
                                    in operation char(1),
									in operation_timestamp timestamp(6),
									in in_source int
								)
BEGIN
    declare data_nascimento date;
    declare id_data int;
    declare id_cliente int;
    declare id_jogo int ;
    
	select AR_SK_Data.id_data into id_data from AR_SK_Data where data = date(in_data_compra) limit 1;
    
	select id_DIM_Cliente into id_cliente from AR_SK_Cliente where source = in_source and id_source = in_id_cliente limit 1;
    
    select id_DIM_Jogo into id_jogo from AR_SK_Jogo where source = in_source and id_source = in_id_jogo limit 1;
	
    select AR_Conformity_Cliente1.data_nascimento into data_nascimento from AR_Conformity_Cliente1 where AR_Conformity_Cliente1.id_cliente = in_id_cliente and AR_Conformity_Cliente1.source = in_source limit 1;
	
    if data_nascimento is not null then
		insert into AR_TF_Venda
			(id_data,id_cliente,id_jogo,quantidade,preco_unidade,preco_total,desconto,idade_cliente)
		values
			(id_data,id_cliente,id_jogo,in_quantidade,in_preco,in_preco*in_quantidade,in_desconto,Floor((DATEDIFF(date(in_data_compra),data_nascimento)/365.25)));
    else
		select AR_Conformity_Cliente2.data_nascimento into data_nascimento from AR_Conformity_Cliente2 where AR_Conformity_Cliente2.id_cliente = in_id_cliente and AR_Conformity_Cliente2.source = in_source limit 1;
    
		if data_nascimento is not null then
			insert into AR_TF_Venda
				(id_data,id_cliente,id_jogo,quantidade,preco_unidade,preco_total,desconto,idade_cliente)
			values
				(id_data,id_cliente,id_jogo,in_quantidade,in_preco,in_preco*in_quantidade,in_desconto,Floor((DATEDIFF(date(in_data_compra),data_nascimento)/365.25)));
		end if;
	end if;

END $$
DELIMITER ;

drop procedure if exists sp_filter_mongo;

DELIMITER $$
create procedure sp_filter_mongo(
									in mongodb_last_extract timestamp(6)
								)
BEGIN
    
    delete from AR_Extract_Cliente2
		where operation_timestamp >= mongodb_last_extract;
        
	delete from AR_Extract_Jogo2
		where operation_timestamp >= mongodb_last_extract;
        
	delete from AR_Extract_Venda2
		where operation_timestamp >= mongodb_last_extract;

END $$
DELIMITER ;

drop procedure if exists sp_update_cliente;

DELIMITER $$
create procedure sp_update_cliente(
									  in in_id_cliente int,
									  in in_nome varchar(100),
									  in in_email varchar(50),
									  in in_data_nascimento date,
									  in in_sexo char(1),
									  in in_nr_telemovel varchar(20),
									  in in_data_registo datetime,
									  in in_cidade varchar(45),
									  in in_pais varchar(45),
									  in operation char(1),
									  in operation_timestamp timestamp(6),
									  in in_source int
								  )
begin
	set @id = ( select id_DIM_Cliente FROM AR_SK_Cliente WHERE source = in_source and id_source = in_id_cliente);
	
    if @id is not null then
		insert into AR_Update_Cliente
			(id_cliente,nr_telemovel,cidade,pais,last_update)
        values
			(@id,in_nr_telemovel,in_cidade,in_pais,operation_timestamp);
	else 
		insert into AR_QUAR_Cliente
			(id_cliente,nome,email,data_nascimento,sexo,nr_telemovel,data_registo,cidade,pais,operation,operation_timestamp,descricao,source)
		values
			(in_id_cliente,in_nome,in_email,in_data_nascimento,in_sexo,in_nr_telemovel,in_data_registo,in_cidade,in_pais,operation,operation_timestamp,"Cliente Não Existe",in_source);
    end if;
end $$
DELIMITER ;

drop procedure if exists sp_update_jogo;

DELIMITER $$
create procedure sp_update_jogo(
							       in in_id_jogo int,
                                   in in_nome varchar(50), 
								   in in_data_lancamento datetime,
                                   in in_idade_minima int,
                                   in in_stock int,
                                   in in_preco decimal(7,2),
								   in in_desconto decimal(5,2),
								   in in_produtor varchar(45),
								   in operation char(1),
								   in operation_timestamp timestamp(6),
							       in in_source int
							   )
BEGIN
	declare id_jogo int;
    declare stockJ int;
    declare precoJ decimal(7,2);
    declare descontoJ decimal(5,2);
    declare aux int;
    
    declare erro bool default 0;
	declare continue handler for sqlexception set erro=1;
	
    start transaction;
    
	select id_DIM_Jogo into id_jogo from AR_SK_Jogo where source = in_source and id_source = in_id_jogo;
	
    if id_jogo is not null then
		
        select id_DIM_jogo into aux from AR_SK_Jogo where nome = in_nome and source != in_source limit 1;
        
        if aux is not null then
        
			select stock into stockJ from AR_SK_Jogo where nome = in_nome and source != in_source limit 1;
			select preco into precoJ from AR_SK_Jogo where nome = in_nome and source != in_source limit 1;
			select desconto into descontoJ from AR_SK_Jogo where nome = in_nome and source != in_source limit 1;
			
			insert into AR_Update_Jogo
				(id_jogo,stock,preco,desconto,last_update)
			values
				(id_jogo,floor((in_stock+stockJ)/2.0),(in_preco+precoJ)/2.0,(in_desconto+descontoJ)/2.0,operation_timestamp);
			
			update AR_SK_Jogo
					set stock = in_stock,
						 preco = in_preco,
						 desconto = in_desconto
					where source = in_source and id_source = in_id_jogo;

        else
        
            insert into AR_Update_Jogo
				(id_jogo,stock,preco,desconto,last_update)
			values
				(id_jogo,in_stock,in_preco,in_desconto,operation_timestamp);
            
            update AR_SK_Jogo
					set stock = in_stock,
						 preco = in_preco,
						 desconto = in_desconto
					where source = in_source and id_source = in_id_jogo;
            
        end if;
        
	else 
		insert into AR_QUAR_Jogo
			(id_jogo,nome,data_lancamento,idade_minima,stock,preco,desconto,produtor,operation,operation_timestamp,descricao,source)
		values
			(in_id_jogo,in_nome,in_data_lancamento,in_idade_minima,in_stock,in_preco,in_desconto,in_produtor,operation,operation_timestamp,"Jogo Não Existe",in_source);
    end if;
    
    if erro 
	then rollback;
	else commit;
	end if;
    
end $$
DELIMITER ;
