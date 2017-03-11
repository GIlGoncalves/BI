USE sitexxi;

set foreign_key_checks=0;

INSERT INTO `sitexxi`.`Pais`
(`nome`)
VALUES
('Portugal'),
('Franca'),
('Inglaterra'),
('Espanha'),
('Suica'),
('Andorra');

INSERT INTO `sitexxi`.`Cidade`
(`nome`,`id_pais`)
VALUES
('Braga',1),
('Lisboa',1),
('Porto',1),
('Fafe',1),
('Paris',2),
('Barcelona',4),
('Madrid',4),
('Lousada',1);

INSERT INTO `sitexxi`.`Cliente`
(`nome`,`email`,`data_nascimento`,`sexo`,`nr_telemovel`,`data_registo`,`id_cidade`)
VALUES
('Gil Goncalves','gidl@mail.com','1992-09-1','M','123456709','2011-04-2',4),
('Jose Pedro','jose@mail.com','1993-03-12','M','234567890','2012-01-2',4),
('Bruno Ribeiro','bruno@mail.com','1991-01-14','M','345678901','2012-05-2',1),
('Luis Pedro','luis@mail.com','1990-04-15','M','456789012','2009-04-15',1),
('Celia Figueiredo','celia@mail.com','1993-12-24','F','567890123','2012-01-2',2),
('Marcia Costa','marcia@mail.com','1992-02-12','F',NULL,'2011-12-2',3),
('Daniel Rodrigues','daniel@mail.com','1990-09-1','M',NULL,'2010-04-2',4),
('Ricardo Lopes','ricardo@mail.com','1990-09-1','M','678901234','2009-04-2',5),
('Carlos Faria','carlos@mail.com','1993-12-1','M',NULL,'2012-11-2',6);

INSERT INTO `sitexxi`.`Produtor`
(`nome`)
VALUES
('Capcom'),
('Square Enix'),
('Konami'),
('Ubisoft'),
('SEGA'),
('Activision Blizzard'),
('Nintendo'),
('Sony'),
('Microsoft'),
('Electronic Arts');

INSERT INTO `sitexxi`.`Categoria`
(`nome`)
VALUES
('Acao'),
('Aventura'),
('Estrategia'),
('RPG'),
('Desporto'),
('Corrida'),
('Quebra-Cabeca'),
('Simulacao');

INSERT INTO `sitexxi`.`Jogo`
(`nome`,`data_lancamento`,`idade_minima`,`stock`,`preco`,`desconto`,`id_produtor`)
VALUES
('GTA','2014-02-12',18,100,60,5,4),
('Max Payne ','2014-01-12',18,100,65,0,10),
('Hitman','2013-02-12',18,100,50,80,1),
('Gears of War','2014-02-12',18,10,30,10,10),
('Monkey Island','2010-02-12',12,50,20,20,2),
('Tomb Raider','2015-02-12',18,30,30,60,3),
('NASCAR','2014-02-12',18,100,15.3,54,4),
('GTR','2015-10-12',18,10,13,0,5),
('Need For Speed','2013-12-12',18,60,30,28,6),
('Alone in The Dark','2014-02-12',18,100,30,39,7);

INSERT INTO `sitexxi`.`JogoCategoria`
(`id_jogo`,`id_categoria`)
VALUES
(1,1),
(1,2),
(2,3),
(2,2),
(3,4),
(3,1),
(4,4),
(4,1),
(5,2),
(5,1),
(6,3),
(6,4),
(10,1);

INSERT INTO `sitexxi`.`Compra`
(`id_cliente`,`id_jogo`,`quantidade`,`preco`,`desconto`,`data_compra`)
VALUES
(1,1,1,30,50,'2014-05-10'),
(2,1,3,39,40,'2014-06-12'),
(2,2,1,65,0,'2014-01-12'),
(3,2,1,25,50,'2013-05-12'),
(1,3,1,60,0,'2014-02-12'),
(4,3,1,15,50,'2014-06-01'),
(4,4,3,30,0,'2014-02-13'),
(1,4,1,58,20,'2014-03-01'),
(1,5,1,12,8,'2015-03-12'),
(5,5,1,10,50,'2013-05-12'),
(6,6,3,30,0,'2015-02-12'),
(2,6,4,19.5,0,'2014-06-17'),
(7,7,1,15.3,0,'2014-02-12'),
(7,5,1,4,0,'2014-03-12'),
(8,8,2,13,0,'2015-10-12'),
(8,10,3,30,0,'2014-02-12'),
(9,9,1,15,0,'2013-12-25');

INSERT INTO `sitexxi`.`Avaliacao`
(`id_cliente`,`id_jogo`,`avaliacao`,`descricao`,`data_avaliacao`)
VALUES
(1,1,3,'Gostei muito','2015-05-10'),
(1,2,5,'Melhor jogo de sempre','2015-04-11'),
(2,3,1,'Adorei','2015-01-15'),
(8,8,5,NULL,'2015-07-25'),
(9,9,3,NULL,'2015-09-18'),
(8,10,1,NULL,'2015-10-19'),
(3,4,5,NULL,'2015-05-23'),
(4,1,1,'Recomendo','2015-05-28');

set foreign_key_checks=1;
