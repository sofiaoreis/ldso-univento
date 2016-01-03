INSERT INTO `Category` VALUES ('Desportivo',1);
INSERT INTO `Category` VALUES ('Noturno',2);
INSERT INTO `Category` VALUES ('Formação',3);
INSERT INTO `Category` VALUES ('Literatura',4);
INSERT INTO `Category` VALUES ('Artes',5);
INSERT INTO `Category` VALUES ('Música',6);
INSERT INTO `Category` VALUES ('Ambiente',7);
INSERT INTO `Category` VALUES ('Saúde',8);
INSERT INTO `Category` VALUES ('Empreendorismo',9),('Chill',10),('Ciência',11),('Conferência',12),('Festa',13);
INSERT INTO `Category` VALUES ('Filmes',14),('Gastronómico',15),('Jogos',16),('Palestras',17),('Workshop',18);

INSERT INTO `Tags` VALUES ('Workshop',1),('Palestra',2),('Futebol',3), ('Corrida',4),
('Basquetebol',5), ('Voleibol',6), 
('Festa Académica', 7), ('Discoteca', 8), ('Erasmus', 9), ('Leitura', 10), ('Escrita', 11),
('Pintura', 12), ('Design', 13), ('Pop', 14),
('Rock', 15), ('Eletrónica', 16), ('Indie', 17), ('Clássica', 18), ('Drum & Bass', 19), ('Chill', 20), ('Social', 21), ('Festa', 22);

INSERT INTO `CategoryTags` VALUES (1,3),(2,3),(3,1), (4,1), (5,1), (6,1), (7,2), (8,2), (9,2), (10,4), (11,4), (12,5), (13,5), (14,6), (15,6), (16,6), (17,6), (18,6), (19,6), (20,7), (21,7), (22,7);

INSERT INTO `User` VALUES (FALSE,NULL,NULL,1,'feup@feup.pt','$2a$10$Ey3UWycqy/xngTlHZOZwXu/AQukzNG5wOjB2z/EfPKxKmMNPlN3Tq',NULL,NULL,NULL,1,'2015-11-11 15:43:13','2015-11-11 15:43:13','127.0.0.1','127.0.0.1',NULL,NULL);
INSERT INTO `User` VALUES (FALSE,NULL,NULL,2,'faup@faup.pt','$2a$10$eD9LgxrbUZOHHft7QczMm.gjW9QksIDRkYDCYNDyGtZ1NhJbMeCk6',NULL,NULL,NULL,1,'2015-11-11 15:43:13','2015-11-11 15:43:13','127.0.0.1','127.0.0.1',NULL,NULL);
INSERT INTO `User` VALUES (FALSE,NULL,NULL,3,'fdup@fdup.pt','$2a$10$Ey3UWycqy/xngTlHZOZwXu/AQukzNG5wOjB2z/EfPKxKmMNPlN3Tq',NULL,NULL,NULL,1,'2015-11-11 15:43:13','2015-11-11 15:43:13','127.0.0.1','127.0.0.1',NULL,NULL);
INSERT INTO `User` VALUES (FALSE,NULL,NULL,4,'isep@isep.pt','$2a$10$Ey3UWycqy/xngTlHZOZwXu/AQukzNG5wOjB2z/EfPKxKmMNPlN3Tq',NULL,NULL,NULL,1,'2015-11-11 15:43:13','2015-11-11 15:43:13','127.0.0.1','127.0.0.1',NULL,NULL);
INSERT INTO `User` VALUES (FALSE,NULL,NULL,5,'leonel@mail.com','$2a$10$Ey3UWycqy/xngTlHZOZwXu/AQukzNG5wOjB2z/EfPKxKmMNPlN3Tq',NULL,NULL,NULL,1,'2015-11-11 15:43:13','2015-11-11 15:43:13','127.0.0.1','127.0.0.1',NULL,NULL);
INSERT INTO `User` VALUES (FALSE,NULL,NULL,6,'luis@mail.com','$2a$10$Ey3UWycqy/xngTlHZOZwXu/AQukzNG5wOjB2z/EfPKxKmMNPlN3Tq',NULL,NULL,NULL,1,'2015-11-11 15:43:13','2015-11-11 15:43:13','127.0.0.1','127.0.0.1',NULL,NULL);
INSERT INTO `User` VALUES (FALSE,NULL,NULL,7,'maria@mail.com','$2a$10$Ey3UWycqy/xngTlHZOZwXu/AQukzNG5wOjB2z/EfPKxKmMNPlN3Tq',NULL,NULL,NULL,1,'2015-11-11 15:43:13','2015-11-11 15:43:13','127.0.0.1','127.0.0.1',NULL,NULL);
INSERT INTO `User` VALUES (FALSE,NULL,NULL,8,'miguel@mail.com','$2a$10$Ey3UWycqy/xngTlHZOZwXu/AQukzNG5wOjB2z/EfPKxKmMNPlN3Tq',NULL,NULL,NULL,1,'2015-11-11 15:43:13','2015-11-11 15:43:13','127.0.0.1','127.0.0.1',NULL,NULL);
INSERT INTO `User` VALUES (FALSE,NULL,TRUE,9,'sofia@mail.com','$2a$10$Ey3UWycqy/xngTlHZOZwXu/AQukzNG5wOjB2z/EfPKxKmMNPlN3Tq',NULL,NULL,NULL,1,'2015-11-11 15:43:13','2015-11-11 15:43:13','127.0.0.1','127.0.0.1',NULL,NULL);
INSERT INTO `User` VALUES (FALSE,NULL,NULL,10,'rui@mail.com','$2a$10$Ey3UWycqy/xngTlHZOZwXu/AQukzNG5wOjB2z/EfPKxKmMNPlN3Tq',NULL,NULL,NULL,1,'2015-11-11 15:43:13','2015-11-11 15:43:13','127.0.0.1','127.0.0.1',NULL,NULL);

INSERT INTO `Promoter` VALUES ('aefeup@fe.up.pt','FEUP','AEFEUP','http://aefeup.fe.pt',1);
INSERT INTO `Promoter` VALUES ('aefaup@fa.up.pt','FAUP','AEFAUP','http://aefaup.fa.pt',2);
INSERT INTO `Promoter` VALUES ('aefdup@fd.up.pt','FDUP','AEFDUP','http://aefdup.fd.pt',3);
INSERT INTO `Promoter` VALUES ('aeisep@isep.ipp.pt','ISEP','AEISEP','http://aeisep.isep.pt',4);

INSERT INTO `Normal` VALUES ('2000-01-01','Leonel','Male','Peixoto',5);
INSERT INTO `Normal` VALUES ('2000-01-01','Luis','Male','Reis',6);
INSERT INTO `Normal` VALUES ('2000-01-01','Maria','Female','Marques',7);
INSERT INTO `Normal` VALUES ('2000-01-01','Miguel','Male','Nunes',8);
INSERT INTO `Normal` VALUES ('2000-01-01','Sofia','Female','Reis',9);
INSERT INTO `Normal` VALUES ('2000-01-01','Rui','Male','Andrade',10);

INSERT INTO `Colaborator` VALUES (1,7);
INSERT INTO `Colaborator` VALUES (1,9);

INSERT INTO `Friendship` VALUES (5,8,TRUE);
INSERT INTO `Friendship` VALUES (10,5,TRUE);
INSERT INTO `Friendship` VALUES (8,10,TRUE);
INSERT INTO `Friendship` VALUES (5,6,FALSE);
INSERT INTO `Friendship` VALUES (9,5,FALSE);
INSERT INTO `Friendship` VALUES (7,5,FALSE);

INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 01',FALSE,10,1,'2015-12-01',NULL,1,1,1,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 02',FALSE,10,1,'2015-12-02',NULL,2,2,1,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 03',FALSE,10,1,'2015-12-03',NULL,3,3,1,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 04',FALSE,10,1,'2015-12-04',NULL,4,1,1,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 05',FALSE,10,1,'2015-12-05',NULL,5,2,1,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 06',FALSE,10,1,'2015-12-06',NULL,6,3,2,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 07',FALSE,10,1,'2015-12-07',NULL,7,1,2,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 08',FALSE,10,1,'2015-12-08',NULL,8,2,2,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 09',FALSE,10,1,'2015-12-09',NULL,9,3,2,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 10',FALSE,10,1,'2015-12-10',NULL,10,1,2,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 11',FALSE,10,1,'2015-12-11',NULL,11,2,3,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 12',FALSE,10,1,'2015-12-12',NULL,12,3,3,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 13',FALSE,10,1,'2015-12-13',NULL,13,1,3,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 14',FALSE,10,1,'2015-12-14',NULL,14,2,3,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 15',FALSE,10,1,'2015-12-15',NULL,15,3,3,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 16',FALSE,10,1,'2015-12-16',NULL,16,1,4,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 17',FALSE,10,1,'2015-12-16',NULL,17,2,4,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 18',FALSE,10,1,'2015-12-16',NULL,18,3,4,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 19',FALSE,10,1,'2015-12-16',NULL,19,1,4,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 20',TRUE,10,1,'2015-12-16',NULL,20,2,4,15,NULL);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Evento 21',FALSE,10,1,'2015-12-16',NULL,21,2,4,15,NULL);

INSERT INTO `EventTags` VALUES (1,1),(1,2),(1,3);
INSERT INTO `EventTags` VALUES (2,8),(2,16),(2,19);

INSERT INTO `Image` VALUES ('img1.jpg',1,1),('img2.jpg',2,1);

INSERT INTO `Local` VALUES ('rua lá ao fundo',100,100,1);

INSERT INTO `EventDate` VALUES ('0','2016-01-09',10,'2016-01-10',1,1,1),('0','2016-01-11',15,'2016-01-12',2,1,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-10',10,'2016-01-11',3,2,1),('0','2016-01-11',15,'2016-01-12',4,2,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-11',15,'2016-01-12',5,3,1),('0','2016-01-13',10,'2016-01-14',6,3,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-12',10,'2016-01-13',7,4,1),('0','2016-01-14',15,'2016-01-05',8,4,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-13',10,'2016-01-14',9,5,1),('0','2016-01-15',15,'2016-01-06',10,5,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-14',10,'2016-01-15',11,6,1),('0','2016-01-16',15,'2016-01-17',12,6,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-15',10,'2016-01-16',13,7,1),('0','2016-01-17',15,'2016-01-18',14,7,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-16',10,'2016-01-17',15,8,1),('0','2016-01-18',15,'2016-01-19',16,8,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-17',10,'2016-01-18',17,9,1),('0','2016-01-19',15,'2016-01-20',18,9,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-18',10,'2016-01-19',19,10,1),('0','2016-01-20',15,'2016-01-21',20,10,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-19',10,'2016-01-20',21,11,1),('0','2016-01-21',15,'2016-01-22',22,11,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-20',10,'2016-01-21',23,12,1),('0','2016-01-22',15,'2016-01-23',24,12,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-21',10,'2016-01-22',25,13,1),('0','2016-01-23',15,'2016-01-24',26,13,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-22',10,'2016-01-23',27,14,1),('0','2016-01-23',15,'2016-01-24',28,14,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-23',10,'2016-01-24',29,15,1),('0','2016-01-24',15,'2016-01-25',30,15,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-24',10,'2016-01-25',31,16,1),('0','2016-01-24',15,'2016-01-25',32,16,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-25',10,'2016-01-26',33,17,1),('0','2016-01-24',15,'2016-01-25',34,17,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-26',10,'2016-01-27',35,18,1),('0','2016-01-25',15,'2016-01-26',36,18,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-27',10,'2016-01-28',37,19,1),('0','2016-01-25',15,'2016-01-26',38,19,1);
INSERT INTO `EventDate` VALUES ('1','2016-01-28',10,'2016-01-29',39,20,1),('0','2016-01-25',15,'2016-01-26',40,20,1);
INSERT INTO `EventDate` VALUES ('1','2015-12-28',10,'2015-12-29',41,21,1),('0','2015-12-30',15,'2015-12-31',42,21,1);

INSERT INTO `Spotify` VALUES ('http://spotify.com/playlist/1',1,1),('http://spotify.com/playlist/2',2,1);

INSERT INTO `Youtube` VALUES ('http://youtube.com/link1',1,1),('http://youtube.com/link2',2,1),('http://youtube.com/link3',3,1);

INSERT INTO `Registration` VALUES (21,5);