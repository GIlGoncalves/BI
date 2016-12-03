
/*
Vista dos clientes sobre os clientes
*/
create view verPerfilCliente as 
select Nome as 'Nome do Cliente',
	   Email as 'Email do Cliente',
       sexo   as 'Sexo do Cliente'
 from cliente       
       delimiter 
/*
Viste dos clientes sobre os jogos
*/       
drop view verJogo;
delimiter 
create view verJogo as 
select J.nome as 'Nome do Jogo',
	   P.nome as 'Nome do produtor do jogo',
       J.precoBase as 'Preco do jogo',
       J.desconto as 'Desconto do jogo',
       J.dataLancamento as 'Data de Lancamento',
       J.idadeParaJogar as 'Idade permitida para jogar',
       J.quantidade as 'Quantidade disponivel do jogo',
       AVG(A.avaliacao) as 'Avaliacao do Jogo'
       from jogo as J inner join produtor as P on J.idProdutor=P.idProdutor
           inner join avaliacao as A on A.idJogo=J.idJogo
        group by A.idJogo
        order by AVG(A.avaliacao) desc;
 delimiter        
select *
from verJogo;

        
/*
Vista do gestor sobre as vendas de cada jogo
*/       
drop view verCompras; 
delimiter 

create view verCompras as 
select J.Nome as 'Nome do Jogo',
	   sum(C.PrecoVendido*C.quantidade) as 'Dinheiro Feito com o Jogo'
       from jogo as J inner join compras as C on J.idJogo= C.idJogo
       group by j.idJogo
       order by sum(C.PrecoVendido*C.quantidade) desc ;
 

delimiter            
select * 
from verCompras;           
 
 
 
 /*
 Informacao do cliente
 */
 delimiter  
 drop view infoCliente;
 
delimiter  
create view infoCliente as 
select Nome as 'Nome do Cliente',
	   FLOOR(datediff(date(now()),dataNascimento)/365) as 'Idade do cliente',
	  email as 'Email do cliente',
      nrTelemovel as 'Numero de telemovel',
      dataRegisto as 'Data de registo do cliente',
      cidade as 'Nome da cidade',
      nomePais AS 'Nome do pais' 
      from cliente as C inner join cidade as Ci on C.idCidade=Ci.idCidade 
			inner join pais as P on P.idPais=Ci.idPais;
            
 delimiter       
 select *
 from infoCliente