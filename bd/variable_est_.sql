﻿/*
SQLyog Enterprise - MySQL GUI v8.1 
MySQL - 5.5.5-10.1.28-MariaDB : Database - siigef
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `pric_otca`;

/*Table structure for table `variables_estudio` */

DROP TABLE IF EXISTS `variables_estudio`;

CREATE TABLE `variables_estudio` (
  `Var_IdVariable` int(11) NOT NULL AUTO_INCREMENT,
  `Var_Nombre` varchar(50) DEFAULT NULL,
  `Var_Abreviatura` varchar(10) DEFAULT NULL,
  `Var_Medida` varchar(50) DEFAULT NULL,
  `Var_Estado` char(1) DEFAULT NULL,
  `Tiv_IdTipoVariable` int(11) DEFAULT NULL,
  `Var_Columna` char(10) DEFAULT NULL,
  `Var_DescripcionMedida` varbinary(500) DEFAULT NULL,
  `Idi_IdIdioma` char(5) DEFAULT NULL,
  PRIMARY KEY (`Var_IdVariable`),
  KEY `fk_variables_estudio_Tipo_variable_estudio1_idx` (`Tiv_IdTipoVariable`),
  CONSTRAINT `FK_variables_estudio_tiv` FOREIGN KEY (`Tiv_IdTipoVariable`) REFERENCES `tipo_variable` (`Tiv_IdTipoVariable`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=latin1;

/*Data for the table `variables_estudio` */

insert  into `variables_estudio`(Var_IdVariable,Var_Nombre,Var_Abreviatura,Var_Medida,Var_Estado,Tiv_IdTipoVariable,Var_Columna,Var_DescripcionMedida,Idi_IdIdioma) values (1,'Aceites y Grasas','MEH','(mg/L)','',3,'','mg/l miligramos por litro',NULL),(2,'Acenafteno','C12H10','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(3,'Acenaftileno','C12H8','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(4,'Acidez ','H-','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(5,'Alcalinidad','OH-','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(6,'Alcalinidad Total','TA-','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(7,'Aluminio','Al','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(8,'Amoniaco','NH','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(9,'Amonio','NH4','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(10,'Antimonio','Sb','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(11,'Antraceno','C14H10','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(12,'Arsenico','As','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(13,'Azufre','S','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(14,'Bacterias Heterotroficas','','(NMP/100mL) o (UFC/100mL)','',1,'','UFC (Unidades Formadoras de Colonias) indica el grado de contaminación microbiológica de un ambiente',NULL),(15,'Bario','Ba','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(16,'Benceno','C6H6','','',4,'','mg/l miligramos por litro',NULL),(17,'Benzo (A) Antraceno','C18H12','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(18,'Benzo (A) Pireno','C20H12','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(19,'Benzo (B) Fluoranteno','T3DB','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(20,'Benzo (G, H, I) Pirileno','C22H12','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(21,'Benzo (K) Fluoranteno','T3DB','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(22,'Berilio','Be','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(23,'Bicarbonato','HCO3-','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(24,'Bismuto','Bi','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(25,'Bismuto Total','Bi Total','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(26,'Boro','B','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(27,'Cadmio','Cd','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(28,'Calcio','Ca','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(29,'Calcio Total','Ca Total','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(30,'Carbonato','CO3(2)-','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(31,'Carbono Organico Total','COT','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(32,'Cianuro','CN-','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(33,'Clordano','C10H6Cl8','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(34,'Cloro','CI','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(35,'Cloro Total','CI- Total','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(36,'Cloruros','','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(37,'Cobalto','Co','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(38,'Cobre','Cu','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(39,'Coliformes Fecales','CF','(NMP/100mL) o (UFC/100mL)','',1,'','UFC (Unidades Formadoras de Colonias) indica el grado de contaminación microbiológica de un ambiente',NULL),(40,'Compuestos Organoclorados','DDT','','',1,'','',NULL),(41,'Conductividad Electrica','CE','(µS/cm)','',3,'','µS/cm unidad de medida de conductividad',NULL),(42,'Contagem de bacterias em placa','','','',1,'','',NULL),(43,'Cor','Cor','HAZEN','',3,'','La escala de HAZEN se utiliza como medida del color que le confieren al agua los materiales contamines',NULL),(44,'Criseno','','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(45,'Cromo','Cr','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(46,'Cromo Hexavalente','Cr6+','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(47,'Cromo Total','Cr total','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(48,'Demanda Bioquimica de Oxigeno','DBO','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(49,'Demanda Quimica de Oxigeno','DQO','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(50,'Descarga Liquida','','','',3,'','',NULL),(51,'Dibenzo (A) Antraceno','DBA','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(52,'Dureza','','(mg/L)','',3,'','mg/l miligramos por litro',NULL),(53,'Dureza Calcica','','(mg/L)','',3,'','mg/l miligramos por litro',NULL),(54,'Dureza Total','','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(55,'Estaño','Sn','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(56,'Estroncio','Sr','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(57,'Fenantreno','C9H22O4P2S','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(58,'Fenoles','Fenoles','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(59,'Fitoplancton Total','FT','Unidad','',1,'','Unidad',NULL),(60,'Flujo','','(m/seg)','',4,'','m/seg metros por segundos',NULL),(61,'Fluor','F','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(62,'Fluoranteno','C16H10','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(63,'Fluoreno','C13H10','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(64,'Fluoruros','F-','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(65,'Fosfatos','PO43-','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(66,'Fosforo','P','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(67,'Fosforo Total','P Total','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(68,'HAPS','HAPS','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(69,'Hidrocarburos totales de petroleo','TPH','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(70,'Hierro','Fe','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(71,'Hierro Total','Fe Total','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(72,'Indeno (1,2,3-C,D) Pireno','C22H12','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(73,'Indice de  Coliformes Termotolerantes','ICTL','(NMP/100mL) o (UFC/100mL)','',1,'','UFC (Unidades Formadoras de Colonias) indica el grado de contaminación microbiológica de un ambiente',NULL),(74,'Indice de Coliformes Totales','ICT','(NMP/100mL) o (UFC/100mL)','',1,'','UFC (Unidades Formadoras de Colonias) indica el grado de contaminación microbiológica de un ambiente',NULL),(75,'Indice de Fenoles','','','',4,'','',NULL),(76,'Lindano ','C6H6Cl6','(µg/L)','',4,'','µg/l microgramos por litro',NULL),(77,'Litio','Li','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(78,'Lluvia','','','',2,'','',NULL),(79,'Magnesio','Mg','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(80,'Magnesio Total','Mg Total','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(81,'Manganeso','Mn','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(82,'Mercurio','Hg','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(83,'Molibdeno','Mo','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(84,'Naftaleno','C10H8','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(85,'Niquel','Ni','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(86,'Nitratos','N-NO3','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(87,'Nitritos','NO2-','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(88,'Nitritos + Nitratos','N-NO3 + NO','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(89,'Nitrogeno Amoniacal','N-NH3','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(90,'Nitrogeno Total','N Total','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(91,'Numero de Medicion','','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(92,'Ortofosfato Total','','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(93,'Oxigeno consumido en acido','','','',4,'','',NULL),(94,'Oxigeno Disuelto',' (OD)','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(95,'Pireno','','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(96,'Plata','Ag','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(97,'Plomo','Pb','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(98,'Plomo Total','Pb Total','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(99,'Posicion horizontal de colecta','','','',3,'','',NULL),(100,'Posicion vertical de colecta','','','',3,'','',NULL),(101,'Potasio','K','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(102,'Potasio Total','K Total','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(103,'Potencial de hidrogeno','pH','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(104,'Profundidad','PP','(mts)','',3,'','mts Metros',NULL),(105,'Salinidad','','(mg/L)','',3,'','mg/l miligramos por litro',NULL),(106,'Selenio','Se','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(107,'Silicato','','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(108,'Silicato Disuelto','','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(109,'Sodio','Na','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(110,'Sodio Total','Na Total','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(111,'Solidos disueltos','','','',3,'','',NULL),(112,'Solidos disueltos fijos','','','',3,'','',NULL),(113,'Solidos en suspension fijos','','','',3,'','',NULL),(114,'Solidos fijos','SF','(mg/L)','',3,'','mg/l miligramos por litro',NULL),(115,'Solidos sedimentarios','SSD','(mg/L)','',3,'','mg/l miligramos por litro',NULL),(116,'Solidos suspendidos','SS','(mg/L)','',3,'','mg/l miligramos por litro',NULL),(117,'Solidos Suspendidos Totales','STS','(mg/L)','',3,'','mg/l miligramos por litro',NULL),(118,'Solidos Totales','ST','(mg/L)','',3,'','mg/l miligramos por litro',NULL),(119,'Solidos Totales disueltos','STD','(mg/L)','',3,'','mg/l miligramos por litro',NULL),(120,'Sulfatos','SO42-','(mg/L)','',3,'','mg/l miligramos por litro',NULL),(121,'Suma de aniones','','(meq/l)','',4,'','meq/l miliequivalentes/litos',NULL),(122,'Suma de cationes','','(meq/l)','',4,'','meq/l miliequivalentes/litos',NULL),(123,'Temperatura','T°','(°C)','',3,'','°C grados centigrados',NULL),(124,'Temperatura de la muestra','T°','(°C)','',3,'','°C grados centigrados',NULL),(125,'Temperatura del Agua','T° H2O','(°C)','',3,'','°C grados centigrados',NULL),(126,'Temperatura del Aire','','(°C)','',3,'','°C grados centigrados',NULL),(127,'Temperatura del Ambiente','T° AMB','(°C)','',3,'','°C grados centigrados',NULL),(128,'Turbidez','','(NTU,campo)','',3,'','NTU (Unidad Nefelométrica de Turdidez) mide la turbidez en el agua',NULL),(129,'Uranio','U','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(130,'Vanadio','V','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(131,'Zinc','Zn','(mg/L)','',4,'','mg/l miligramos por litro',NULL),(132,'Temperatura Minima del Aire','T°','C°',NULL,NULL,NULL,NULL,'es'),(133,'Temperatura Maxima del Aire','T°','C°',NULL,NULL,NULL,NULL,'es'),(134,' humedad Relativa del Aire','Hu','%',NULL,NULL,NULL,NULL,'es'),(135,' Humedad Relativa Minima del Aire','Hu','%',NULL,NULL,NULL,NULL,'es'),(136,' Humedad Relativa Maxima del Aire','Hu','%',NULL,NULL,NULL,NULL,'es');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;