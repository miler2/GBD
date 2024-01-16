DROP DATABASE IF EXISTS `liga`;

CREATE DATABASE `liga`;
USE `liga`;

DROP TABLE IF EXISTS `equipos`;

CREATE TABLE `equipos` (
  `id_equipo` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `ciudad` varchar(45) NOT NULL,
  `web` varchar(250) DEFAULT 'sin web oficial',
  `puntos` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_equipo`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `jugadores`;

CREATE TABLE `jugadores` (
  `id_jugador` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `puesto` varchar(45) DEFAULT NULL,
  `id_capitan` int(11) DEFAULT NULL,
  `fecha_alta` datetime DEFAULT NULL,
  `salario` int(11) DEFAULT NULL,
  `equipo` int(11) DEFAULT NULL,
  `altura` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`id_jugador`),
  KEY `fequipo` (`equipo`),
  CONSTRAINT `fequipo` FOREIGN KEY (`equipo`) REFERENCES `equipos` (`id_equipo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `partidos`;

CREATE TABLE `partidos` (
  `id_partido` int(11) NOT NULL AUTO_INCREMENT,
  `elocal` int(11) NOT NULL,
  `evisitante` int(11) NOT NULL,
  `resultado` varchar(45) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `arbitro` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_partido`),
  KEY `flocal` (`elocal`),
  KEY `fvisitante` (`evisitante`),
  CONSTRAINT `flocal` FOREIGN KEY (`elocal`) REFERENCES `equipos` (`id_equipo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fvisitante` FOREIGN KEY (`evisitante`) REFERENCES `equipos` (`id_equipo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

INSERT INTO `equipos` VALUES (1,'Regal Barcelona','Barcelona','http://www.fcbarcelona.com/web/index_idiomes.html',10),(2,'RealMadrid','Madrid','http://www.realmadrid.com/cs/Satellite/es/1193040472450/SubhomeEquipo/Baloncesto.htm',9),(3,'P.E. Valencia','Valencia','http://www.valenciabasket.com/',11),(4,'Caja Laboral','Vitoria','http://www.baskonia.com/prehomes/prehomes.asp?id_prehome=69',22),(5,'Gran Canaria','Las Palmas','http://www.acb.com/club.php?id=CLA',14),(6,'CAI Zaragoza','Zaragoza','http://basketzaragoza.net/',23);
INSERT INTO `jugadores` VALUES (1,'Juan Carlos','Navarro','escolta',1,'2010-01-10 00:00:00',130000,1,'1.96'),(2,'Felipe','Reyes','Pivot',2,'2009-02-20 00:00:00',132000,2,'2.04'),(3,'Victor','Claver','Alero',3,'2009-03-08 00:00:00',99000,3,'2.08'),(4,'Rafa ','Martinez','ala-pivot',4,'2010-11-11 00:00:00',51000,3,'1.91'),(5,'Fernando','San Emeterio','Alero',6,'2008-09-22 00:00:00',60000,4,'1.99'),(6,'Mirza','Teletovic','Pivot',6,'2010-05-13 00:00:00',77000,4,'2.06'),(7,'Sergio ','Llull','Escolta',2,'2011-10-29 00:00:00',100000,2,'1.90'),(8,'Victor ','Sada','Base',1,'2012-01-01 00:00:00',80000,1,'1.92'),(9,'Carlos','Suarez','Alero',2,'2011-02-19 00:00:00',66000,2,'2.03'),(10,'Xavi ','Rey','Pivot',14,'2008-10-12 00:00:00',104500,5,'2.09'),(11,'Carlos ','Cabezas','Base',13,'2012-01-21 00:00:00',105000,6,'1.86'),(12,'Pablo ','Aguilar','Alero',13,'2011-06-14 00:00:00',51700,6,'2.03'),(13,'Rafa','Hettsheimeir','Pivot',13,'2008-04-15 00:00:00',58300,6,'2.08'),(14,'Sitapha','Savané','Pivot',14,'2011-07-27 00:00:00',66000,5,'2.01');