use bi;

drop procedure inserCliente;
DELIMITER $$

create procedure inserCliente(in nomeCliente varchar(45),in dataRegisto date, in dataNascimento date ,in email varchar(45),
in numeroTel int,in nomeC varchar(45), in nomePais varchar (45), in sexo varchar(1)) 
BEGIN

declare contaCidade int;
declare idP int;
declare idC int;
declare contaPais int ;
declare erro bool default 0;
declare continue handler for sqlexception set erro=1;


start transaction;

	
    select idCidade into contaCidade 
    from cidade
    where cidade = nomeC;

  if contaCidade>=1
	
    then 
         insert into cliente values (idCliente,nomeCliente,dataRegisto,dataNascimento,email,numeroTel,now(),contaCidade,sexo);

  else 
    
     select idPais into contaPais
	from pais
    where pais.nomePais = nomePais;
	 
      if contaPais != NULL
       
       then 
		
			insert into cidade values (idCidade,nomeC,contaPais,now());
            
		    select idCidade into idC
			from cidade
			order by idCidade DESC
			LIMIT 1;
            
            
            insert into cliente values (idCliente,nomeCliente,dataRegisto,dataNascimento,email,numeroTel,now(),idC,sexo);

  
   
       else     
          
            insert into pais values (idPais,nomePais,now());
            
            
            select idPais into idP
			from pais
			order by idPais DESC
			LIMIT 1;
            
             insert into cidade values (idCidade,nomeC,idP,now());
            
            
            
            select idCidade into idC
			from cidade
			order by idCidade DESC
			LIMIT 1;
          
            
            insert into cliente values (idCliente,nomeCliente,dataRegisto,dataNascimento,email,numeroTel,now(),idC,sexo);
           
            
    end if;
  
  end if;

if erro 
then rollback;
else commit;
end if;


END $$



call inserCliente('Gil Goncalves','2011-04-2','1992-09-1','gfo@mafil.com',133,'Lfg','Portugalffd','M');

DELIMITER $$

select *
from pais;
