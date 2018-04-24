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

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
