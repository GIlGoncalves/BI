use bi;

INSERT INTO `bi`.`pais`
(`idPais`,
`nomePais`,
`last_Updade`)
VALUES
(idPais,'Portugal',now()),
(idPais,'Franca',now()),
(idPais,'Inglaterra',now()),
(idPais,'Espanha',now()),
(idPais,'Suica',now()),
(idPais,'Andorra',now());


INSERT INTO `bi`.`cidade`
(`idCidade`,
`cidade`,
`idPais`,
`last_Updade`)
VALUES
(idCidade,'Braga',1,now()),
(idCidade,'Lisboa',1,now()),
(idCidade,'Porto',1,now()),
(idCidade,'Fafe',1,now()),
(idCidade,'Paris',2,now()),
(idCidade,'Barcelona',4,now()),
(idCidade,'Madrid',4,now()),
(idCidade,'Reino Unido',3,now()),
(idCidade,'Lousada',1,now());




INSERT INTO `bi`.`cliente`
(`idCliente`,
`nome`,
`dataRegisto`,
`dataNascimento`,
`email`,
`nrTelemovel`,
`last_Update`,
`idCidade`)
VALUES
(idCliente,'Gil Goncalves','2011-04-2','1992-09-1','gidl@mail.com',123456709,now(),4),
(idCliente,'Jose Pedro','2012-01-2','1993-03-12','jose@mail.com',234567890,now(),9),
(idCliente,'Bruno Ribeiro','2012-05-2','1991-01-14','bruno@mail.com',345678901,now(),1),
(idCliente,'Luis Pedro','2009-04-15','1990-04-15','luis@mail.com',456789012,now(),1),
(idCliente,'Celia Figueiredo','2012-01-2','1993-12-24','celia@mail.com',567890123,now(),2),
(idCliente,'Marcia Costa','2011-12-2','1992-02-12','marcia@mail.com',NULL,now(),3),
(idCliente,'Daniel Rodrigues','2010-04-2','1990-09-1','daniel@mail.com',678901234,now(),4),
(idCliente,'Ricardo Lopes','2009-04-2','1990-09-1','ricardo@mail.com',NULL,now(),5),
(idCliente,'Carlos Faria','2012-11-2','1993-12-1','carlos@mail.com',NULL,now(),6);

INSERT INTO `bi`.`produtor`
(`idProdutor`,
`nome`,
`last_Update`)
VALUES
(idProdutor,'Capcom',now()),
(idProdutor,'Square Enix',now()),
(idProdutor,'Konami',now()),
(idProdutor,'Ubisoft',now()),
(idProdutor,'SEGA',now()),
(idProdutor,'Activision Blizzard',now()),
(idProdutor,'Nintendo',now()),
(idProdutor,'Sony',now()),
(idProdutor,'Microsoft',now()),
(idProdutor,'Electronic Arts',now());


INSERT INTO `bi`.`categoria`
(`idCategoria`,
`categoria`,
`last_Update`)
VALUES
(idCategoria,'Acao',now()),
(idCategoria,'Aventura',now()),
(idCategoria,'Estrategia',now()),
(idCategoria,'RPG',now()),
(idCategoria,'Desporto',now()),
(idCategoria,'Corrida',now()),
(idCategoria,'Quebra-Cabeca',now()),
(idCategoria,'Simulacao',now());




INSERT INTO `bi`.`jogo`
(`idJogo`,
`nome`,
`dataLancamento`,
`idadeParaJogar`,
`quantidade`,
`precoBase`,
`idProdutor`,
`last_Update`,
`desconto`)
VALUES
(idJogo,'GTA','2014-02-12',18,100,60,4,now(),0.5),
(idJogo,'Max Payne ','2014-01-12',18,100,65,10,now(),0),
(idJogo,'Hitman,','2013-02-12',18,100,50,1,now(),0.8),
(idJogo,'Gears of War','2014-02-12',18,10,30,10,now(),0.1),
(idJogo,'Monkey Island','2010-02-12',12,50,20,2,now(),0.2),
(idJogo,'Tomb Raider','2015-02-12',18,30,30,3,now(),0.6),
(idJogo,'NASCAR,','2014-02-12',18,100,15.3,4,now(),0.54),
(idJogo,'GTR','2015-10-12',18,10,13,5,now(),0),
(idJogo,'Need For Speed','2013-12-12',18,60,30,6,now(),0.28),
(idJogo,'Alone in The Dark,','2014-02-12',18,100,30,7,now(),0.39);



INSERT INTO `bi`.`jogocategoria`
(`idJogo`,
`idCategoria`,
`last_Update`)
VALUES
(1,1,now()),
(1,2,now()),
(2,3,now()),
(2,2,now()),
(3,4,now()),
(3,1,now()),
(4,4,now()),
(4,1,now()),
(5,2,now()),
(5,1,now()),
(6,3,now()),
(6,4,now()),
(10,1,now());


INSERT INTO `bi`.`compras`
(`idCompras`,
`idJogo`,
`idCliente`,
`dataCompra`,
`precoVendido`,
`quantidade`,
`desconto`,
`last_Update`)
VALUES
(idCompras,1,1,'2014-05-10',30,1,0.5,now()),
(idCompras,2,1,'2014-06-12',39,3,0.4,now()),
(idCompras,2,2,'2014-01-12',65,1,0,now()),
(idCompras,3,2,'2013-05-12',25,1,0.5,now()),
(idCompras,1,3,'2014-02-12',60,1,0,now()),
(idCompras,4,3,'2014-06-01',15,1,0.5,now()),
(idCompras,4,4,'2014-02-13',30,3,0,now()),
(idCompras,1,4,'2014-03-01',58,1,0.2,now()),
(idCompras,1,5,'2015-03-12',12,1,0.8,now()),
(idCompras,5,5,'2013-05-12',10,1,0.5,now()),
(idCompras,6,6,'2015-02-12',30,3,0,now()),
(idCompras,2,6,'2014-06-17',19.5,4,0.7,now()),
(idCompras,7,7,'2014-02-12',15.3,1,0,now()),
(idCompras,5,7,'2014-03-12',4,1,0.8,now()),
(idCompras,8,8,'2015-10-12',13,2,0,now()),
(idCompras,10,8,'2014-02-12',30,3,0,now()),
(idCompras,9,9,'2013-12-25',15,1,0.5,now());


INSERT INTO `bi`.`avaliacao`
(`idAvaliacao`,
`idJogo`,
`idCliente`,
`avaliacao`,
`last_Update`,
`descricao`)
VALUES
(idAvaliacao,1,1,3,now(),'Gostei muito'),
(idAvaliacao,2,1,5,now(),'Melhor jogo de sempre'),
(idAvaliacao,3,2,0,now(),'Adorei'),
(idAvaliacao,8,8,5,now(),NULL),
(idAvaliacao,9,9,3,now(),NULL),
(idAvaliacao,10,8,1,now(),NULL),
(idAvaliacao,4,3,5,now(),NULL),
(idAvaliacao,1,4,3,now(),NULL),
(idAvaliacao,1,4,10,now(),'Recomendo');
