<?php

class tareaModel extends Model {


	public function insertTarea($trabajo, $usuario, $titulo, $descripcion){ //'14/02/2017 23:38:12'
		$sql = "INSERT INTO tarea_usuario(Tra_IdTrabajo, Usu_IdUsuario, Tar_Titulo,
				Tar_Descripcion, Tar_Estado, Row_Estado)
		        VALUES({$trabajo}, {$usuario}, '{$titulo}', '{$descripcion}', 1, 1)";
		$this->execQuery($sql);

		$sql = "SELECT * FROM tarea_usuario T
				WHERE T.Tra_IdTrabajo = {$trabajo} AND T.Usu_IdUsuario = {$usuario}
				ORDER BY Tar_FechaReg DESC LIMIT 1";
    	$datos = $this->getArray($sql);
    	if($datos != null && count($datos)>0){
    		return $datos[0];
    	}
    	return null;
	}

	public function updateTarea($tarea, $titulo, $descripcion){
		$sql = "UPDATE tarea_usuario SET
					Tar_Titulo = '{$titulo}',
					Tar_Descripcion = '{$descripcion}'
            	WHERE Tar_IdTarea = {$tarea}";
		$this->execQuery($sql);
	}

	public function updateEstadoTarea($tarea, $estado){
		$sql = "UPDATE tarea_usuario SET Tar_Estado = ${estado}
            	WHERE Tar_IdTarea = {$tarea}";
		$this->execQuery($sql);
	}

	public function deleteTarea($tarea){
		$sql = "UPDATE tarea_usuario SET  Row_Estado = 0
            	WHERE Tar_IdTarea = {$tarea}";
		$this->execQuery($sql);
	}

	public function getTareaXTrabajo($trabajo){
		$sql = "SELECT * FROM tarea_usuario T
            WHERE T.Row_Estado = 1 AND T.Tar_Estado = 1 AND T.Tra_IdTrabajo = {$trabajo}";
    	return $this->getArray($sql);
	}

	public function getTareaXTrabajoReporte($trabajo){
		$sql = "SELECT T.*, U.Usu_Nombre, U.Usu_Apellidos FROM tarea_usuario T
						iNNER JOIN usuario U ON U.Usu_IdUsuario = T.Usu_IdUsuario
            WHERE T.Row_Estado = 1 AND T.Tar_Estado = 1 AND T.Tra_IdTrabajo = {$trabajo}";
    	return $this->getArray($sql);
	}

	public function getTareaXTrabajoXUsuario($trabajo, $usuario){
		$sql = "SELECT * FROM tarea_usuario T
            WHERE T.Row_Estado = 1 AND T.Tar_Estado = 1
							AND T.Tra_IdTrabajo = {$trabajo} AND T.Usu_IdUsuario = {$usuario}";
    	return $this->getArray($sql);
	}

	public function getTarea($tarea){
		$sql = "SELECT * FROM tarea_usuario T
            WHERE T.Row_Estado = 1 AND T.Tar_Estado = 1 AND T.Tar_IdTarea = {$tarea}";
    	return $this->getArray($sql);
	}

	public function getTareaUsuario($trabajo){
		$sql = "SELECT * FROM tarea_usuario T WHERE T.Tra_IdTrabajo = {$trabajo}";
    	return $this->getArray($sql);
	}



	public function insertArchivo($tarea, $descripcion, $ruta){
		$sql = "INSERT INTO archivos_tarea(Tar_IdTarea, Arc_Descripcion, Arc_Ruta,
							Arc_Estado, Row_Estado)
		        VALUES({$tarea}, '{$descripcion}', '{$ruta}', 1, 1)";
		$this->execQuery($sql);
	}

	public function deleteArchivo($archivo){
		$sql = "UPDATE archivos_tarea SET Row_Estado = 0 AND Arc_Estado = 0
            	WHERE Arc_IdArchivo = {$archivo}";
		$this->execQuery($sql);
	}

	public function getArchivos($tarea){
		$sql = "SELECT * FROM archivos_tarea T
            WHERE T.Row_Estado = 1 AND T.Arc_Estado = 1 AND T.Tar_IdTarea = {$tarea}";
    	return $this->getArray($sql);
	}
}
