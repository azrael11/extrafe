/*==============================================================*/
/* Database name:  zeoslib                                      */
/* Created on:     28.12.2002 20:27:07                          */
/*==============================================================*/

INSERT INTO department VALUES (3,'Delivery agency','UKR','Donetsk Artema st. 113')
INSERT INTO department VALUES (2,'Container agency','USA','Krasnodar Komsomolskaya st. 17') 
INSERT INTO department VALUES (1,'Line agency','RUS','Novorossiysk Lenina st. 2') 
go

INSERT INTO equipment VALUES (1,'Volvo',1,15000.0000,'1998-04-03',NULL)
INSERT INTO equipment VALUES (2,'Laboratoy',10,40000.0000,'2001-07-10',NULL)
INSERT INTO equipment VALUES (3,'Computer',7,900.0000,'1999-03-09',NULL)
INSERT INTO equipment VALUES (4,'Radiostation',19,400.0000,'2000-08-07',NULL)
go

INSERT INTO equipment2 VALUES (1,1)
INSERT INTO equipment2 VALUES (1,2)
INSERT INTO equipment2 VALUES (1,4)
INSERT INTO equipment2 VALUES (2,1)
INSERT INTO equipment2 VALUES (2,3)
go

INSERT INTO people VALUES (1,1,'Vasia Pupkin','30/12/1899 09:00:00','30/12/1899 18:00:00',NULL,NULL,0)
INSERT INTO people VALUES (2,2,'Andy Karto','30/12/1899 08:30:00','30/12/1899 17:30:00',NULL,NULL,0)
INSERT INTO people VALUES (3,1,'Kristen Sato','30/12/1899 09:00:00','30/12/1899 18:00:00',NULL,NULL,0)
INSERT INTO people VALUES (4,2,'Aleksey Petrov','30/12/1899 08:30:00','30/12/1899 17:30:00',NULL,NULL,1)
INSERT INTO people VALUES (5,3,'Yan Pater','30/12/1899 08:00:00','30/12/1899 17:00:00',NULL,NULL,1)
go

INSERT INTO cargo VALUES (1,2,'Grain',1,'20/12/2002 02:00:00','20/12/2002 02:00:00',5000,NULL,NULL,1769.4300,NULL)
INSERT INTO cargo VALUES (2,1,'Paper',2,'19/12/2002 14:00:00','23/12/2002 00:00:00',1000,10,10,986.4700,convert(binary(10),'aaa'))
INSERT INTO cargo VALUES (3,1,'Wool',0,'20/12/2002 18:00:00',NULL,400,7,4,643.1100,NULL)
INSERT INTO cargo VALUES (4,2,'Suagr',1,'21/12/2002 10:20:00','26/12/2002 00:00:00',2034,NULL,NULL,1964.8700,NULL)
go
