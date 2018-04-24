/*
SQLyog Enterprise - MySQL GUI v8.1 
MySQL - 5.5.5-10.1.28-MariaDB : Database - siigef
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `pric_otca`;

/*Table structure for table `estacion_monitoreo` */

DROP TABLE IF EXISTS `estacion_monitoreo`;

CREATE TABLE `estacion_monitoreo` (
  `Esm_IdEstacionMonitoreo` int(11) NOT NULL AUTO_INCREMENT,
  `Esm_Nombre` varchar(1024) DEFAULT NULL,
  `Esm_Latitud` char(18) DEFAULT NULL,
  `Esm_Longitud` char(18) DEFAULT NULL,
  `Esm_Referencia` char(18) DEFAULT NULL,
  `Esm_Altitud` int(11) DEFAULT NULL,
  `Esm_Estado` char(1) DEFAULT NULL,
  `Ric_IdRioCuenca` int(11) DEFAULT NULL,
  `Tie_IdTipoEstacion` int(11) DEFAULT NULL,
  `Mpd_IdMunicipioProvDist` int(11) DEFAULT NULL,
  `Esd_IdEstadoDepartamento` int(11) DEFAULT NULL,
  `Ubi_IdUbigeo` int(11) DEFAULT NULL,
  PRIMARY KEY (`Esm_IdEstacionMonitoreo`),
  KEY `fk_Estacion_Monitoreo_Rio_Cuenca1_idx` (`Ric_IdRioCuenca`),
  KEY `fk_Estacion_Monitoreo_Tipo_Estacion1_idx` (`Tie_IdTipoEstacion`),
  KEY `fk_Estacion_Monitoreo_Municipio_Provincia_Distrito1_idx` (`Mpd_IdMunicipioProvDist`),
  KEY `FK_estacion_monitoreo` (`Esd_IdEstadoDepartamento`),
  KEY `FK_estacion_monitoreo_ubigeo` (`Ubi_IdUbigeo`),
  CONSTRAINT `FK_estacion_monitoreo_esd` FOREIGN KEY (`Esd_IdEstadoDepartamento`) REFERENCES `estado_departamento` (`Esd_IdEstadoDepartamento`),
  CONSTRAINT `FK_estacion_monitoreo_mpd` FOREIGN KEY (`Mpd_IdMunicipioProvDist`) REFERENCES `municipio_provincia_distrito` (`Mpd_IdMunicipioProvDist`),
  CONSTRAINT `FK_estacion_monitoreo_ric` FOREIGN KEY (`Ric_IdRioCuenca`) REFERENCES `rio_cuenca` (`Ric_IdRioCuenca`),
  CONSTRAINT `FK_estacion_monitoreo_ubigeo` FOREIGN KEY (`Ubi_IdUbigeo`) REFERENCES `ubigeo` (`Ubi_IdUbigeo`),
  CONSTRAINT `fk_estacion_monitoreo_tipo_estacion1` FOREIGN KEY (`Tie_IdTipoEstacion`) REFERENCES `tipo_estacion` (`Tie_IdTipoEstacion`)
) ENGINE=InnoDB AUTO_INCREMENT=607 DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
