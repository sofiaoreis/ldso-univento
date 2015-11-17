INSERT INTO `Category` VALUES ('categoria de teste',1);
INSERT INTO `Tags` VALUES ('tag1_teste',1),('tag2_teste',2),('tag3_teste',3);
INSERT INTO `CategoryTags` VALUES (1,1),(2,1),(3,1);
INSERT INTO `User` VALUES (NULL,NULL,1,'feup@feup.pt','$2a$10$Ey3UWycqy/xngTlHZOZwXu/AQukzNG5wOjB2z/EfPKxKmMNPlN3Tq',NULL,NULL,NULL,1,'2015-11-11 15:43:13','2015-11-11 15:43:13','127.0.0.1','127.0.0.1',NULL,NULL);
INSERT INTO `Promoter` VALUES ('afeup@fe.up.pt','FEUP','AEFEUP','aefeup.fe.pt',1);
INSERT INTO `Event` VALUES ('descricao do evento de teste','Nome do evento blabla',NULL,10,1,1,NULL,1,1,1);

INSERT INTO `EventTags` VALUES (1,1),(1,2),(1,3);
INSERT INTO `Image` VALUES ('img1.jpg',1,1),('img2.jpg',2,1);
INSERT INTO `Local` VALUES ('rua lá ao fundo',100,100,1);
INSERT INTO `EventDate` VALUES ('2015-11-12',10,'2015-11-13',1,1,1),('2015-11-15',15,'2015-11-17',2,1,1);
INSERT INTO `Spotify` VALUES ('http:playlist/1',1,1),('http:playlist/2',2,1);
INSERT INTO `Youtube` VALUES ('http://youtube.com/link1',1,1),('http://youtube.com/link2',2,1),('http://youtube.com/link3',3,1);

