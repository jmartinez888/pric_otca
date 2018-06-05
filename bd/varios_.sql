/*
SQLyog Enterprise - MySQL GUI v8.1 
MySQL - 5.5.5-10.1.28-MariaDB : Database - siigef
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`siigef` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `siigef`;

/*Table structure for table `estado_departamento` */

DROP TABLE IF EXISTS `estado_departamento`;

CREATE TABLE `estado_departamento` (
  `Esd_IdEstadoDepartamento` int(11) NOT NULL AUTO_INCREMENT,
  `Esd_Nombre` varchar(50) DEFAULT NULL,
  `Esd_Siglas` varchar(10) DEFAULT NULL,
  `Pai_IdPais` int(11) DEFAULT NULL,
  `Esd_Estado` char(1) DEFAULT NULL,
  `Esd_Denominacion` varchar(25) DEFAULT NULL,
  `Idi_IdIdioma` int(11) DEFAULT NULL,
  PRIMARY KEY (`Esd_IdEstadoDepartamento`),
  KEY `R_1` (`Pai_IdPais`),
  KEY `FK_estado_departamento_idi` (`Idi_IdIdioma`),
  CONSTRAINT `estado_detarpamento_ibfk_1` FOREIGN KEY (`Pai_IdPais`) REFERENCES `pais` (`Pai_IdPais`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `estado_departamento` */

/*Table structure for table `hidrologia` */

DROP TABLE IF EXISTS `hidrologia`;

CREATE TABLE `hidrologia` (
  `Hid_IdHidrologia` int(11) NOT NULL AUTO_INCREMENT,
  `Hid_Pais` varchar(20) DEFAULT NULL,
  `Hid_Rio` varchar(100) DEFAULT NULL,
  `Hid_Variable` varchar(50) DEFAULT NULL,
  `Hid_Valor` double(16,8) DEFAULT NULL,
  `Hid_UnidadMedida` varchar(10) DEFAULT NULL,
  `Hid_Fecha` varchar(10) DEFAULT NULL,
  `Hid_Latitud` varchar(100) DEFAULT NULL,
  `Hid_Longitud` varchar(100) DEFAULT NULL,
  `Rec_IdRecurso` int(11) DEFAULT NULL,
  `Idi_IdIdioma` char(11) DEFAULT NULL,
  `Hid_Estado` tinyint(5) DEFAULT NULL,
  PRIMARY KEY (`Hid_IdHidrologia`)
) ENGINE=InnoDB AUTO_INCREMENT=25969 DEFAULT CHARSET=latin1;

/*Data for the table `hidrologia` */


/*Table structure for table `historial_calidad_agua` */

DROP TABLE IF EXISTS `historial_calidad_agua`;

CREATE TABLE `historial_calidad_agua` (
  `Hca_IdHistorialCalAgu` int(11) NOT NULL AUTO_INCREMENT,
  `Esm_IdEstacionMonitoreo` int(11) DEFAULT NULL,
  `Ica_IdIndiceCalidadAgua` int(11) DEFAULT NULL,
  `Hca_Fecha` datetime DEFAULT NULL,
  `Hca_Valor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Hca_IdHistorialCalAgu`),
  KEY `fk_Historial_Calidad_Agua_Calidad_Agua1_idx` (`Ica_IdIndiceCalidadAgua`),
  KEY `fk_Historial_Calidad_Agua_Rio_Cuenca1_idx` (`Esm_IdEstacionMonitoreo`),
  CONSTRAINT `FK_historial_calidad_agua` FOREIGN KEY (`Esm_IdEstacionMonitoreo`) REFERENCES `estacion_monitoreo` (`Esm_IdEstacionMonitoreo`),
  CONSTRAINT `FK_historial_calidad_agua_ica` FOREIGN KEY (`Ica_IdIndiceCalidadAgua`) REFERENCES `indice_calidad_agua` (`Ica_IdIndiceCalidadAgua`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `historial_calidad_agua` */

/*Table structure for table `rio` */

DROP TABLE IF EXISTS `rio`;

CREATE TABLE `rio` (
  `Rio_IdRio` int(11) NOT NULL AUTO_INCREMENT,
  `Rio_Nombre` varchar(225) DEFAULT NULL,
  `Rio_Estado` char(1) DEFAULT NULL,
  `Pai_IdPais` int(11) DEFAULT NULL,
  `Tia_IdTipoAgua` int(11) DEFAULT NULL,
  PRIMARY KEY (`Rio_IdRio`),
  KEY `fk_Rio_Pais1_idx` (`Pai_IdPais`),
  KEY `fk_Rio_Tipo_Agua1_idx` (`Tia_IdTipoAgua`),
  CONSTRAINT `fk_Rio_Pais1` FOREIGN KEY (`Pai_IdPais`) REFERENCES `pais` (`Pai_IdPais`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rio_Tipo_Agua1` FOREIGN KEY (`Tia_IdTipoAgua`) REFERENCES `tipo_agua` (`Tia_IdTipoAgua`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=latin1;

/*Data for the table `rio` */

insert  into `rio`(Rio_IdRio,Rio_Nombre,Rio_Estado,Pai_IdPais,Tia_IdTipoAgua) values (1,'RIO SOLIMÕES/AMAZONAS','0',2,NULL),(2,'RIO JAVARI',NULL,2,NULL),(3,'RIO PUTUMAYO/IÇÁ',NULL,2,NULL),(4,'RIO JURUÁ',NULL,2,NULL),(5,'RIO GREGÓRIO',NULL,2,NULL),(6,'RIO ENVIRA',NULL,2,NULL),(7,'RIO PURUS',NULL,2,NULL),(8,'RIO ACRE',NULL,2,NULL),(9,'RIO TAPAUA',NULL,2,NULL),(10,'RIO NEGRO',NULL,2,NULL),(11,'RIO IÇANA',NULL,2,NULL),(12,'RIO VAUPÉS/UAUPÉS',NULL,2,NULL),(13,'RIO TIQUIÉ',NULL,2,NULL),(14,'RIO CURICURIARI',NULL,2,NULL),(15,'Río MATURACÁ',NULL,2,NULL),(16,'RIO PADAUARI',NULL,2,NULL),(17,'RIO DEMENI',NULL,2,NULL),(18,'RIO BRANCO',NULL,2,NULL),(19,'RIO AUARI',NULL,2,NULL),(20,'RIO URARICOERA',NULL,2,NULL),(21,'RIO TACUTU',NULL,2,NULL),(22,'RIO MAÚ OU IRENG',NULL,2,NULL),(23,'RIO SURUMU',NULL,2,NULL),(24,'RIO COTINGO',NULL,2,NULL),(25,'RIO MUCAJAÍ',NULL,2,NULL),(26,'RIO ANAUA',NULL,2,NULL),(27,'RIO CATRIMANI',NULL,2,NULL),(28,'RIO JAUAPERI',NULL,2,NULL),(29,'RIO ALALAÚ',NULL,2,NULL),(30,'RIO PRETO DA EVA',NULL,2,NULL),(31,'RIO MADEIRA',NULL,2,NULL),(32,'RIO MAMORÉ',NULL,2,NULL),(33,'RIO GUAPORÉ',NULL,2,NULL),(34,'RIO CABIXI ou BRANCO',NULL,2,NULL),(35,'RIO CORUMBIARA ANTIGO',NULL,2,NULL),(37,'RIO SÃO MIGUEL',NULL,2,NULL),(38,'RIO OURO PRETO',NULL,2,NULL),(39,'RIO ABUNÃ',NULL,2,NULL),(41,'RIO JAMARI',NULL,2,NULL),(42,'RIO MASSANGANA',NULL,2,NULL),(43,'RIO PRETO DO CRESPO',NULL,2,NULL),(44,'RIO CANDEIAS',NULL,2,NULL),(45,'RIO JIPARANÁ (ou MACHADO)',NULL,2,NULL),(46,'RIO APEDIA  ou PIMENTA BUENO',NULL,2,NULL),(47,'RIO PALMEIRAS',NULL,2,NULL),(48,'RIO COMEMORAÇÃO',NULL,2,NULL),(49,'RIO URUPA',NULL,2,NULL),(50,'Río IGARAPÉ BOA VISTA',NULL,2,NULL),(51,'RIO JARU',NULL,2,NULL),(52,'RIO MACHADINHO',NULL,2,NULL),(53,'RIO JACUNDÁ',NULL,2,NULL),(54,'RIO ARIPUANÃ',NULL,2,NULL),(55,'RIO URUBU',NULL,2,NULL),(56,'RIO UATUMA',NULL,2,NULL),(57,'RIO TROMBETAS',NULL,2,NULL),(58,'RIO CACHORRO',NULL,2,NULL),(59,'RIO MAPUERA OU URUCURINA',NULL,2,NULL),(60,'RIO CUMINA / EREPECURU / P.D\'OESTE',NULL,2,NULL),(61,'RIO NHAMUNDÁ',NULL,2,NULL),(62,'RIO CURUÁ',NULL,2,NULL),(63,'RIO TAPAJÓS',NULL,2,NULL),(64,'RIO JURUENA',NULL,2,NULL),(65,'RIO JUINA',NULL,2,NULL),(66,'RIO FORMIGA',NULL,2,NULL),(67,'RIO PAPAGAIO',NULL,2,NULL),(68,'RIO SACRE',NULL,2,NULL),(69,'RIO BURITI',NULL,2,NULL),(70,'RIO DO SANGUE',NULL,2,NULL),(71,'RIO ARINOS',NULL,2,NULL),(72,'RIO DOS PEIXES',NULL,2,NULL),(73,'RIO TELES PIRES (OU SÃO MANUEL)',NULL,2,NULL),(74,'RIO TENENTE LIRA',NULL,2,NULL),(75,'RIO CELESTE',NULL,2,NULL),(76,'RIO VERDE',NULL,2,NULL),(77,'RIO PEIXOTO DE AZEVEDO',NULL,2,NULL),(78,'RIO BRACO SUL',NULL,2,NULL),(79,'RIO CREPORI',NULL,2,NULL),(80,'RIO JAMANXIM',NULL,2,NULL),(81,'RIO MAICURU',NULL,2,NULL),(82,'RIO URUARÁ',NULL,2,NULL),(83,'RIO PARU',NULL,2,NULL),(84,'RIO PARU DE ESTE',NULL,2,NULL),(85,'RIO XINGÚ',NULL,2,NULL),(86,'RIO CULUENE',NULL,2,NULL),(87,'RIBEIRÃO TANGURO',NULL,2,NULL),(88,'RIO RONURO',NULL,2,NULL),(89,'RIO ATELCHU OU VAN DEN STEINEN',NULL,2,NULL),(90,'RIO TURVO',NULL,2,NULL),(91,'RIBEIRÃO BONITO',NULL,2,NULL),(92,'CÓRREGO TRINTA',NULL,2,NULL),(93,'RIBEIRÃO TANGURINHO',NULL,2,NULL),(94,'RIO SUIA-MIÇU',NULL,2,NULL),(95,'RIO DARRO',NULL,2,NULL),(96,'RIO MANISSAUA - MIÇU',NULL,2,NULL),(97,'RIO COMANDANTE FONTOURA',NULL,2,NULL),(98,'RIO FRESCO',NULL,2,NULL),(99,'RIO IRIRI',NULL,2,NULL),(100,'RIO CURUÁ',NULL,2,NULL),(101,'RIO BACAJÁ',NULL,2,NULL),(102,'RIO JARI',NULL,2,NULL),(103,'RIO IRATAPURU',NULL,2,NULL),(104,'RIO CAJARI',NULL,2,NULL),(105,'RIO PACAJÁS',NULL,2,NULL),(106,'Canal D',NULL,3,NULL),(107,'Quebrada Curillo',NULL,3,NULL),(108,'Quebrada el Achiote',NULL,3,NULL),(109,'Quebrada el Doncello',NULL,3,NULL),(110,'Quebrada el Sabalo',NULL,3,NULL),(111,'Quebrada el Yarumo',NULL,3,NULL),(112,'Quebrada Fraguachorroso',NULL,3,NULL),(113,'Quebrada la Dorada',NULL,3,NULL),(114,'Quebrada la Hidraulica ',NULL,3,NULL),(115,'Quebrada la Hormiga',NULL,3,NULL),(116,'Quebrada la Montañita',NULL,3,NULL),(117,'Quebrada la Paujila',NULL,3,NULL),(118,'Quebrada la Sardina',NULL,3,NULL),(119,'Quebrada Naboyaco',NULL,3,NULL),(120,'Quebrada San Antonio',NULL,3,NULL),(121,'Quebrada San Francisco',NULL,3,NULL),(122,'Quebrada San Nicolas',NULL,3,NULL),(123,'Quebrada Singuiya',NULL,3,NULL),(124,'Rio Amazonas',NULL,3,NULL),(125,'Rio Bodoquero',NULL,3,NULL),(126,'Rio Caguán',NULL,3,NULL),(127,'Rio Caquetá',NULL,3,NULL),(128,'Río Fraguachorroso',NULL,3,NULL),(129,'Rio Hacha',NULL,3,NULL),(130,'Rio Inírida',NULL,3,NULL),(131,'Rio Loretoyacu',NULL,3,NULL),(132,'Rio Mocoa',NULL,3,NULL),(133,'Rio Mulato',NULL,3,NULL),(134,'Rio Orteguaza',NULL,3,NULL),(135,'Rio Pescado',NULL,3,NULL),(136,'Rio Putumayo',NULL,3,NULL),(137,'Rio Sangoyaco',NULL,3,NULL),(138,'Rio Tamauca',NULL,3,NULL),(139,'Rio Vaúpes',NULL,3,NULL),(140,'Quebrada Cambana',NULL,4,NULL),(141,'Quebrada Campanilla',NULL,4,NULL),(142,'Quebrada Charapa',NULL,4,NULL),(143,'Quebrada Chinapintza Chico',NULL,4,NULL),(144,'Quebrada Chinapinza  Grande',NULL,4,NULL),(145,'Quebrada Conwime',NULL,4,NULL),(146,'Quebrada el Hierro',NULL,4,NULL),(147,'Quebrada Guasimy',NULL,4,NULL),(148,'Quebrada La sultana',NULL,4,NULL),(149,'Quebrada Paushiyacu',NULL,4,NULL),(150,'Quebrada sin Nombre',NULL,4,NULL),(151,'Quebrada Wawayme',NULL,4,NULL),(152,'Rio Aguarico',NULL,4,NULL),(153,'Rio Aguas Blancas',NULL,4,NULL),(154,'Rio Aguas Negras',NULL,4,NULL),(155,'Rio Ambato',NULL,4,NULL),(156,'Rio Anzu',NULL,4,NULL),(157,'Rio Añangu',NULL,4,NULL),(158,'Rio Arajuno',NULL,4,NULL),(159,'Rio Bellavista',NULL,4,NULL),(160,'Rio Blanco',NULL,4,NULL),(161,'Rio Brisas de Yoya',NULL,4,NULL),(162,'Rio Cariyuturi',NULL,4,NULL),(163,'Rio Cascales',NULL,4,NULL),(164,'Rio Cebadas',NULL,4,NULL),(165,'Rio Chambo',NULL,4,NULL),(166,'Rio Chigual',NULL,4,NULL),(167,'Rio Coca',NULL,4,NULL),(168,'Rio Cristal',NULL,4,NULL),(169,'Rio Culapachan',NULL,4,NULL),(170,'Rio Cuyabeno',NULL,4,NULL),(171,'Rio da Chupenda',NULL,4,NULL),(172,'Rio Daldal',NULL,4,NULL),(173,'Rio Dashino',NULL,4,NULL),(174,'Rio de Libertad',NULL,4,NULL),(175,'Rio Due',NULL,4,NULL),(176,'Rio Dureno',NULL,4,NULL),(177,'Rio el Manto',NULL,4,NULL),(178,'Rio el Topo',NULL,4,NULL),(179,'Rio Guamote',NULL,4,NULL),(180,'Rio Guano',NULL,4,NULL),(181,'Rio Guisuya',NULL,4,NULL),(182,'Rio Hollin',NULL,4,NULL),(183,'Rio Huambuno',NULL,4,NULL),(184,'Rio Huashito Grande',NULL,4,NULL),(185,'Rio Huaymayacu',NULL,4,NULL),(186,'Rio Indillana',NULL,4,NULL),(187,'Rio Itaya',NULL,4,NULL),(188,'Rio Jatunyacu',NULL,4,NULL),(189,'Rio Jivino',NULL,4,NULL),(190,'Rio Lagrimas de Conejio',NULL,4,NULL),(191,'Rio Las Juntas',NULL,4,NULL),(192,'Rio Lumbaqui',NULL,4,NULL),(193,'Rio Machinaza',NULL,4,NULL),(194,'Rio Malacatos',NULL,4,NULL),(195,'Rio Manzalla',NULL,4,NULL),(196,'Rio Margajita',NULL,4,NULL),(197,'Rio Misahualli',NULL,4,NULL),(198,'Rio Mocha',NULL,4,NULL),(199,'Rio Nambija',NULL,4,NULL),(200,'Rio Nangaritza',NULL,4,NULL),(201,'Rio Napo',NULL,4,NULL),(202,'RIO NEGRO',NULL,4,NULL),(203,'Rio Oyacachi',NULL,4,NULL),(204,'Rio Pacayacu',NULL,4,NULL),(205,'Rio Palora',NULL,4,NULL),(206,'Rio Pandoyacu',NULL,4,NULL),(207,'Rio Pano',NULL,4,NULL),(208,'Rio Papallacta',NULL,4,NULL),(209,'Rio Papaya Chico',NULL,4,NULL),(210,'Rio Pastaza',NULL,4,NULL),(211,'Rio Patate',NULL,4,NULL),(212,'Rio Paushiyacu',NULL,4,NULL),(213,'Rio Pavayacu',NULL,4,NULL),(214,'Rio Payamino',NULL,4,NULL),(215,'Rio Piedra Bola',NULL,4,NULL),(216,'Rio Pindoyacu',NULL,4,NULL),(217,'Rio Punino',NULL,4,NULL),(218,'Rio Punino',NULL,4,NULL),(219,'Rio Puñuña',NULL,4,NULL),(220,'Rio Pusuno',NULL,4,NULL),(221,'Rio Putumayo',NULL,4,NULL),(222,'Rio Quijos',NULL,4,NULL),(223,'Rio Quillupacay',NULL,4,NULL),(224,'Rio Quimi',NULL,4,NULL),(225,'Rio Recodo',NULL,4,NULL),(226,'Rio Salado',NULL,4,NULL),(227,'Rio San Miguel de Putumayo',NULL,4,NULL),(228,'Rio Sana Elena',NULL,4,NULL),(229,'Rio Sanzaguar',NULL,4,NULL),(230,'Rio Sardinas',NULL,4,NULL),(231,'Rio Shingue',NULL,4,NULL),(232,'Rio Silvayacu',NULL,4,NULL),(233,'Rio Sumino',NULL,4,NULL),(234,'Rio Suno',NULL,4,NULL),(235,'Rio Tace',NULL,4,NULL),(236,'Rio Tiputini',NULL,4,NULL),(237,'Rio Tteye',NULL,4,NULL),(238,'Rio Ulba',NULL,4,NULL),(239,'Rio Verde',NULL,4,NULL),(240,'Rio Yacuambi',NULL,4,NULL),(241,'Rio Yasuni',NULL,4,NULL),(242,'Rio Yucara',NULL,4,NULL),(243,'Rio Zamora',NULL,4,NULL),(244,'Rio Zarza',NULL,4,NULL),(245,'Rio Payaminu',NULL,4,NULL),(246,'Rio Yanayacu',NULL,4,NULL),(248,'RIO APURIMAC',NULL,6,NULL),(249,'Rio Caychihue',NULL,6,NULL),(250,'Rio Chambira',NULL,6,NULL),(251,'Rio Dos de Mayo',NULL,6,NULL),(252,'RIO HUALLAGA',NULL,6,NULL),(253,'Rio Huapetuhe',NULL,6,NULL),(254,'Rio Inambari',NULL,6,NULL),(255,'Rio Jayave',NULL,6,NULL),(256,'rio Madre de Dios',NULL,6,NULL),(257,'Rio Malinowski',NULL,6,NULL),(258,'RIO MARAÑON',NULL,6,NULL),(259,'RIO MAYO',NULL,6,NULL),(260,'Rio Momóm',NULL,6,NULL),(261,'Rio Nanay',NULL,6,NULL),(262,'RIO PALCA',NULL,6,NULL),(263,'RIO PASTAZA',NULL,6,NULL),(264,'RIO PERENÉ',NULL,6,NULL),(265,'Rio Pintuyacu',NULL,6,NULL),(266,'Rio Pukiri',NULL,6,NULL),(267,'Rio Tambopata',NULL,6,NULL),(268,'RIO VILCANOTA',NULL,6,NULL),(269,'RIO PASTAZA','1',2,NULL),(270,'Rio Pintuyacu','1',2,NULL),(271,'Itaya','1',6,NULL);

/*Table structure for table `rio_cuenca` */

DROP TABLE IF EXISTS `rio_cuenca`;

CREATE TABLE `rio_cuenca` (
  `Ric_IdRioCuenca` int(11) NOT NULL AUTO_INCREMENT,
  `Ric_Nombre` varchar(255) DEFAULT NULL,
  `Ric_Estado` char(1) DEFAULT NULL,
  `Suc_IdSubcuenca` int(11) DEFAULT NULL,
  `Cue_IdCuenca` int(11) DEFAULT NULL,
  `Rio_IdRio` int(11) DEFAULT NULL,
  PRIMARY KEY (`Ric_IdRioCuenca`),
  KEY `fk_Rio_Cuenca_Sub_Cuenca1_idx` (`Suc_IdSubcuenca`),
  KEY `fk_Rio_Cuenca_Cuenca1_idx` (`Cue_IdCuenca`),
  KEY `fk_Rio_Cuenca_Rio1_idx` (`Rio_IdRio`),
  CONSTRAINT `FK_rio_cuenca_cue` FOREIGN KEY (`Cue_IdCuenca`) REFERENCES `cuenca` (`Cue_IdCuenca`),
  CONSTRAINT `FK_rio_cuenca_ric` FOREIGN KEY (`Rio_IdRio`) REFERENCES `rio` (`Rio_IdRio`),
  CONSTRAINT `FK_rio_cuenca_suc` FOREIGN KEY (`Suc_IdSubcuenca`) REFERENCES `sub_cuenca` (`Suc_IdSubcuenca`)
) ENGINE=InnoDB AUTO_INCREMENT=284 DEFAULT CHARSET=latin1;

/*Data for the table `rio_cuenca` */

insert  into `rio_cuenca`(Ric_IdRioCuenca,Ric_Nombre,Ric_Estado,Suc_IdSubcuenca,Cue_IdCuenca,Rio_IdRio) values (1,NULL,NULL,10,1,1),(2,NULL,NULL,10,1,2),(3,NULL,NULL,11,1,3),(4,NULL,NULL,12,1,4),(5,NULL,NULL,12,1,5),(6,NULL,NULL,12,1,6),(7,NULL,NULL,13,1,7),(8,NULL,NULL,13,1,8),(9,NULL,NULL,13,1,9),(10,NULL,NULL,14,1,10),(11,NULL,NULL,14,1,11),(12,NULL,NULL,14,1,12),(13,NULL,NULL,14,1,13),(14,NULL,NULL,14,1,14),(15,NULL,NULL,14,1,15),(16,NULL,NULL,14,1,16),(17,NULL,NULL,14,1,17),(18,NULL,NULL,14,1,18),(19,NULL,NULL,14,1,19),(20,NULL,NULL,14,1,20),(21,NULL,NULL,14,1,21),(22,NULL,NULL,14,1,22),(23,NULL,NULL,14,1,23),(24,NULL,NULL,14,1,24),(25,NULL,NULL,14,1,25),(26,NULL,NULL,14,1,26),(27,NULL,NULL,14,1,27),(28,NULL,NULL,14,1,28),(29,NULL,NULL,14,1,29),(30,NULL,NULL,15,1,30),(31,NULL,NULL,15,1,31),(32,NULL,NULL,15,1,32),(33,NULL,NULL,15,1,33),(34,NULL,NULL,15,1,34),(35,NULL,NULL,15,1,35),(36,NULL,NULL,15,1,36),(37,NULL,NULL,15,1,37),(38,NULL,NULL,15,1,38),(39,NULL,NULL,15,1,39),(40,NULL,NULL,15,1,40),(41,NULL,NULL,15,1,41),(42,NULL,NULL,15,1,42),(43,NULL,NULL,15,1,43),(44,NULL,NULL,15,1,44),(45,NULL,NULL,15,1,45),(46,NULL,NULL,15,1,46),(47,NULL,NULL,15,1,47),(48,NULL,NULL,15,1,48),(49,NULL,NULL,15,1,49),(50,NULL,NULL,15,1,50),(51,NULL,NULL,15,1,51),(52,NULL,NULL,15,1,52),(53,NULL,NULL,15,1,53),(54,NULL,NULL,15,1,54),(55,NULL,NULL,16,1,55),(56,NULL,NULL,16,1,56),(57,NULL,NULL,16,1,57),(58,NULL,NULL,16,1,58),(59,NULL,NULL,16,1,59),(60,NULL,NULL,16,1,60),(61,NULL,NULL,16,1,61),(62,NULL,NULL,17,1,62),(63,NULL,NULL,17,1,63),(64,NULL,NULL,17,1,64),(65,NULL,NULL,17,1,65),(66,NULL,NULL,17,1,66),(67,NULL,NULL,17,1,67),(68,NULL,NULL,17,1,68),(69,NULL,NULL,17,1,69),(70,NULL,NULL,17,1,70),(71,NULL,NULL,17,1,71),(72,NULL,NULL,17,1,72),(73,NULL,NULL,17,1,73),(74,NULL,NULL,17,1,74),(75,NULL,NULL,17,1,75),(76,NULL,NULL,17,1,76),(77,NULL,NULL,17,1,77),(78,NULL,NULL,17,1,78),(79,NULL,NULL,17,1,79),(80,NULL,NULL,17,1,80),(81,NULL,NULL,18,1,81),(82,NULL,NULL,18,1,82),(83,NULL,NULL,18,1,83),(84,NULL,NULL,18,1,84),(85,NULL,NULL,18,1,85),(86,NULL,NULL,18,1,86),(87,NULL,NULL,18,1,87),(88,NULL,NULL,18,1,88),(89,NULL,NULL,18,1,89),(90,NULL,NULL,18,1,90),(91,NULL,NULL,18,1,91),(92,NULL,NULL,18,1,92),(93,NULL,NULL,18,1,93),(94,NULL,NULL,18,1,94),(95,NULL,NULL,18,1,95),(96,NULL,NULL,18,1,96),(97,NULL,NULL,18,1,97),(98,NULL,NULL,18,1,98),(99,NULL,NULL,18,1,99),(100,NULL,NULL,18,1,100),(101,NULL,NULL,18,1,101),(102,NULL,NULL,19,1,102),(103,NULL,NULL,19,1,103),(104,NULL,NULL,19,1,104),(105,NULL,NULL,19,1,105),(106,NULL,NULL,0,1,124),(107,NULL,NULL,0,1,131),(108,NULL,NULL,0,2,126),(109,NULL,NULL,0,3,119),(110,NULL,NULL,0,3,114),(111,NULL,NULL,0,3,136),(112,NULL,NULL,0,3,121),(113,NULL,NULL,0,3,138),(114,NULL,NULL,0,3,106),(115,NULL,NULL,0,3,122),(116,NULL,NULL,0,3,123),(117,NULL,NULL,0,3,108),(118,NULL,NULL,0,3,115),(119,NULL,NULL,0,3,113),(120,NULL,NULL,11,3,132),(121,NULL,NULL,11,3,133),(122,NULL,NULL,11,3,137),(123,NULL,NULL,11,3,120),(124,NULL,NULL,12,3,110),(125,NULL,NULL,12,3,111),(126,NULL,NULL,0,3,133),(127,NULL,NULL,0,3,137),(128,NULL,NULL,0,3,110),(129,NULL,NULL,0,4,132),(130,NULL,NULL,0,4,127),(131,NULL,NULL,0,4,107),(132,NULL,NULL,0,4,128),(133,NULL,NULL,0,4,135),(134,NULL,NULL,0,4,126),(135,NULL,NULL,0,5,112),(136,NULL,NULL,0,6,134),(137,NULL,NULL,0,6,116),(138,NULL,NULL,0,6,118),(139,NULL,NULL,0,6,129),(140,NULL,NULL,0,6,125),(141,NULL,NULL,0,7,109),(142,NULL,NULL,0,7,117),(143,NULL,NULL,0,8,130),(144,NULL,NULL,0,9,139),(145,NULL,NULL,0,11,207),(146,NULL,NULL,0,11,149),(147,NULL,NULL,0,11,197),(148,NULL,NULL,0,11,156),(149,NULL,NULL,0,11,188),(150,NULL,NULL,0,11,182),(151,NULL,NULL,0,11,220),(152,NULL,NULL,0,11,158),(153,NULL,NULL,0,11,183),(154,NULL,NULL,0,11,233),(155,NULL,NULL,0,11,234),(156,NULL,NULL,0,11,214),(157,NULL,NULL,0,11,201),(158,NULL,NULL,0,11,167),(159,NULL,NULL,0,11,216),(160,NULL,NULL,0,11,246),(161,NULL,NULL,0,11,185),(162,NULL,NULL,0,11,189),(163,NULL,NULL,0,11,160),(164,NULL,NULL,0,11,187),(165,NULL,NULL,0,11,186),(166,NULL,NULL,0,11,150),(167,NULL,NULL,0,11,162),(168,NULL,NULL,0,11,157),(169,NULL,NULL,0,11,213),(170,NULL,NULL,0,11,236),(171,NULL,NULL,0,11,241),(172,NULL,NULL,0,14,181),(173,NULL,NULL,0,14,161),(174,NULL,NULL,0,14,228),(175,NULL,NULL,0,14,242),(176,NULL,NULL,0,14,219),(177,NULL,NULL,0,14,153),(178,NULL,NULL,0,14,209),(179,NULL,NULL,0,14,221),(180,NULL,NULL,0,14,195),(181,NULL,NULL,0,14,232),(182,NULL,NULL,0,14,235),(183,NULL,NULL,0,14,229),(184,NULL,NULL,0,14,231),(185,NULL,NULL,0,14,227),(186,NULL,NULL,0,14,142),(187,NULL,NULL,0,14,171),(188,NULL,NULL,13,11,208),(189,NULL,NULL,13,11,167),(190,NULL,NULL,13,11,222),(191,NULL,NULL,13,11,203),(192,NULL,NULL,13,11,226),(193,NULL,NULL,14,11,166),(194,NULL,NULL,14,11,225),(195,NULL,NULL,14,11,175),(196,NULL,NULL,14,11,152),(197,NULL,NULL,14,11,163),(198,NULL,NULL,14,11,237),(199,NULL,NULL,14,11,176),(200,NULL,NULL,14,11,159),(201,NULL,NULL,14,11,204),(202,NULL,NULL,14,11,190),(203,NULL,NULL,14,11,154),(204,NULL,NULL,14,11,170),(205,NULL,NULL,15,11,214),(206,NULL,NULL,15,11,184),(207,NULL,NULL,15,11,223),(208,NULL,NULL,15,11,150),(209,NULL,NULL,15,11,217),(210,NULL,NULL,15,11,212),(211,NULL,NULL,15,11,245),(212,NULL,NULL,0,12,202),(213,NULL,NULL,0,13,169),(214,NULL,NULL,0,13,155),(215,NULL,NULL,0,13,198),(216,NULL,NULL,0,13,211),(217,NULL,NULL,0,13,164),(218,NULL,NULL,0,13,179),(219,NULL,NULL,0,13,165),(220,NULL,NULL,0,13,172),(221,NULL,NULL,0,13,180),(222,NULL,NULL,0,13,210),(223,NULL,NULL,0,13,238),(224,NULL,NULL,0,13,239),(225,NULL,NULL,0,13,196),(226,NULL,NULL,0,13,178),(227,NULL,NULL,0,13,205),(228,NULL,NULL,16,15,243),(229,NULL,NULL,16,15,194),(230,NULL,NULL,16,15,191),(231,NULL,NULL,16,15,146),(232,NULL,NULL,16,15,199),(233,NULL,NULL,16,15,148),(234,NULL,NULL,16,15,141),(235,NULL,NULL,16,15,140),(236,NULL,NULL,16,15,240),(237,NULL,NULL,16,15,200),(238,NULL,NULL,16,15,147),(239,NULL,NULL,16,15,144),(240,NULL,NULL,16,15,145),(241,NULL,NULL,16,15,193),(242,NULL,NULL,16,15,244),(243,NULL,NULL,16,15,151),(244,NULL,NULL,16,15,224),(245,NULL,NULL,16,15,150),(246,NULL,NULL,16,15,143),(247,NULL,NULL,0,10,192),(248,NULL,NULL,0,10,215),(249,NULL,NULL,0,10,160),(250,NULL,NULL,0,10,173),(251,NULL,NULL,0,10,206),(252,NULL,NULL,0,10,230),(253,NULL,NULL,0,10,168),(254,NULL,NULL,0,10,174),(255,NULL,NULL,0,10,177),(256,NULL,NULL,0,18,256),(257,NULL,NULL,0,18,267),(258,NULL,NULL,0,18,257),(259,NULL,NULL,0,18,255),(260,NULL,NULL,0,18,266),(261,NULL,NULL,0,18,253),(262,NULL,NULL,0,18,249),(263,NULL,NULL,0,18,254),(264,NULL,NULL,0,18,251),(266,NULL,NULL,0,19,257),(267,NULL,NULL,0,25,267),(268,NULL,NULL,0,22,261),(269,NULL,NULL,0,22,265),(270,NULL,NULL,0,22,250),(271,NULL,NULL,0,21,259),(272,NULL,NULL,0,24,264),(273,NULL,NULL,0,16,248),(274,NULL,NULL,0,26,268),(275,NULL,NULL,0,17,252),(276,NULL,NULL,0,23,262),(277,NULL,NULL,0,22,260),(278,NULL,NULL,0,20,258),(279,NULL,NULL,0,13,263),(280,NULL,NULL,17,4,269),(281,NULL,NULL,18,2,270),(282,NULL,NULL,19,4,3),(283,NULL,NULL,20,27,271);

/*Table structure for table `tipo_estacion` */

DROP TABLE IF EXISTS `tipo_estacion`;

CREATE TABLE `tipo_estacion` (
  `Tie_IdTipoEstacion` int(11) NOT NULL AUTO_INCREMENT,
  `Tie_Nombre` varchar(100) DEFAULT NULL,
  `Tie_Estado` char(1) DEFAULT NULL,
  `Idi_IdIdioma` int(11) DEFAULT NULL,
  PRIMARY KEY (`Tie_IdTipoEstacion`),
  KEY `FK_tipo_estacion_idi` (`Idi_IdIdioma`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `tipo_estacion` */

insert  into `tipo_estacion`(Tie_IdTipoEstacion,Tie_Nombre,Tie_Estado,Idi_IdIdioma) values (1,'Meterológica-Hidrológica','1',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;