<?php

class pizarraModel extends Model {

    public function __construct() { parent::__construct(); }

    public function insertPizarra($leccion, $tipo, $titulo, $descripcion, $url, $width, $height, $x, $y){
      $sql = "INSERT INTO Pizarra_Leccion(Lec_IdLeccion, Piz_Tipo, Piz_Titulo, Piz_Descripcion, Piz_ImgFondo,
              Piz_ImgWidth, Piz_ImgHeight, Piz_ImgX, Piz_ImgY, Piz_FechaReg, Piz_Estado)
              VALUES({$leccion}, {$tipo}, '{$titulo}', '{$descripcion}', '{$url}', '{$width}', '{$height}',
              '{$x}', '{$y}', NOW(), 1)";
      return $this->execQuery($sql);
    }

    public function updatePizarra($pizarra, $titulo, $descripcion, $url, $width, $height, $x, $y){
      $sql = "UPDATE Pizarra_Leccion SET
                Piz_Titulo = '{$titulo}',
                Piz_Descripcion = '{$descripcion}',
                Piz_ImgFondo = '{$url}',
                Piz_ImgWidth = {$width},
                Piz_ImgHeight = {$height},
                Piz_ImgX = {$x},
                Piz_ImgY = {$y},
                Piz_FechaReg = NOW()
              WHERE Piz_IdPizarra = {$pizarra}";
      return $this->execQuery($sql);
    }

    public function updateEstadoPizarra($pizarra, $estado){
      $sql = "UPDATE Pizarra_Leccion SET
                Piz_Estado = '{$estado}'
              WHERE Piz_IdPizarra = {$pizarra}";
      return $this->execQuery($sql);
    }

    public function deletePizarra($pizarra){
      $sql = "UPDATE Pizarra_Leccion SET Row_Estado = 0
              WHERE Piz_IdPizarra = {$pizarra}";
      return $this->execQuery($sql);
    }

    public function getPizarrasLeccion($leccion){
      $sql = "SELECT * FROM Pizarra_Leccion WHERE Lec_IdLeccion = {$leccion}
              AND Row_Estado = 1";
      return $this->getArray($sql);
    }

    public function getPizarras($leccion){
      $sql = "SELECT * FROM Pizarra_Leccion WHERE Lec_IdLeccion = {$leccion}
              AND Piz_Estado = 1 AND Row_Estado = 1";
      return $this->getArray($sql);
    }

    public function getPizarraId($pizarra, $condicion){
      $sql = "SELECT * FROM Pizarra_Leccion WHERE Piz_IdPizarra = {$pizarra}
              AND Piz_Estado = {$condicion} AND Row_Estado = 1";
      return $this->getArray($sql);
    }
}
