<?php

class trabajoModel extends Model {


	public function insertTrabajo($leccion, $tipo, $titulo, $descripcion,$desde, $hasta){ //'14/02/2017 23:38:12'
		$sql = "INSERT INTO trabajo_leccion(Lec_IdLeccion, Tra_Tipo, Tra_Titulo,
						Tra_Descripcion,  Tra_FechaDesde, Tra_FechaHasta, Tra_Estado, Row_Estado)
		        VALUES({$leccion}, {$tipo}, '{$titulo}', '{$descripcion}',  
		        	STR_TO_DATE('{$desde}', '%d/%m/%Y %T'), STR_TO_DATE('{$hasta}', '%d/%m/%Y %T'), 1, 1)";
		$this->execQuery($sql);

		$sql = "SELECT * FROM trabajo_leccion T WHERE T.Lec_IdLeccion = {$leccion}
				ORDER BY Tra_FechaReg DESC LIMIT 1";
    	$datos = $this->getArray($sql);
    	if($datos != null && count($datos)>0){
    		return $datos[0];
    	}
    	return null;
	}

	public function updateTrabajo($trabajo, $tipo, $titulo, $descripcion, $desde, $hasta){
		$sql = "UPDATE trabajo_leccion SET
					Tra_Tipo = {$tipo},
					Tra_Titulo = '{$titulo}',
					Tra_Descripcion = '{$descripcion}',
					Tra_FechaDesde = STR_TO_DATE('{$desde}', '%d/%m/%Y %T'),
					Tra_FechaHasta = STR_TO_DATE('{$hasta}', '%d/%m/%Y %T')
            	WHERE Tra_IdTrabajo = {$trabajo}";
		$this->execQuery($sql);
	}

	public function updateEstadoTrabajo($trabajo, $estado){
		$sql = "UPDATE trabajo_leccion SET Tra_Estado = {$estado}
            	WHERE Tra_IdTrabajo = {$trabajo}";
		$this->execQuery($sql);
	}

	public function deleteTrabajo($trabajo){
		$sql = "UPDATE trabajo_leccion SET  Row_Estado = 0
            	WHERE Tra_IdTrabajo = {$trabajo}";
		$this->execQuery($sql);
	}

	public function getTrabajoXLeccion($leccion, $Idi_IdIdioma = "es"){
			$sql = "SELECT
						T.Tra_IdTrabajo,
						T.Lec_IdLeccion,
						T.Tra_Tipo,
						fn_TraducirContenido('leccion','Tra_Titulo',T.Tra_IdTrabajo,'$Idi_IdIdioma',T.Tra_Titulo) Tra_Titulo,
                		fn_TraducirContenido('leccion','Tra_Descripcion',T.Tra_IdTrabajo,'$Idi_IdIdioma',T.Tra_Descripcion) Tra_Descripcion,                
						T.Tra_FechaDesde,
						T.Tra_FechaHasta,
						T.Tra_FechaReg,
						T.Tra_Estado,
						T.Row_Estado,
						T.Tra_Porcentaje,
                		fn_devolverIdioma('leccion',T.Tra_IdTrabajo,'$Idi_IdIdioma',T.Idi_IdIdioma) Idi_IdIdioma,
						(CASE WHEN NOW() BETWEEN Tra_FechaDesde AND Tra_FechaHasta THEN 1 ELSE 0 END) as Activo,
						(CASE WHEN NOW() < Tra_FechaDesde THEN 1
						ELSE (CASE WHEN NOW() > Tra_FechaHasta THEN 2 ELSE 0 END) END) as Condicion
					FROM trabajo_leccion T
            WHERE T.Row_Estado = 1 AND T.Tra_Estado = 1 AND T.Lec_IdLeccion = {$leccion}";
			return $this->getArray($sql);
	}

	public function getTrabajoXModulo($modulo){
		$sql = "SELECT * FROM trabajo_leccion T
						INNER JOIN leccion L ON L.Lec_IdLeccion = T.Lec_IdLeccion
            	WHERE T.Row_Estado = 1 AND T.Tra_Estado = 1
								AND L.Row_Estado = 1 AND L.Lec_Estado = 1
								AND L.Moc_IdModuloCurso = {$modulo}
						ORDER BY T.Tra_FechaDesde";
    	return $this->getArray($sql);
	}

	public function getTrabajo($trabajo){
		$sql = "SELECT * FROM trabajo_leccion T
            	WHERE T.Row_Estado = 1 AND T.Tra_Estado = 1 AND T.Tra_IdTrabajo = {$trabajo}";
    	$datos = $this->getArray($sql);
    	if($datos != null && count($datos)>0){
    		return $datos[0];
    	}
    	return null;
	}

	public function getTrabajoUsuario($leccion){
		$sql = "SELECT * FROM trabajo_leccion T WHERE T.Lec_IdLeccion = {$leccion} AND Row_Estado = 1";
    	return $this->getArray($sql);
	}


	public function getConstanteTrabajo(){
		$sql = "SELECT * FROM constante
				WHERE Con_Codigo = 4000
					AND Con_Estado = 1
					AND Row_Estado = 1
					AND Con_Valor <> Con_Codigo";
    	return $this->getArray($sql);
	}



	public function insertArchivo($trabajo, $descripcion, $ruta){
		$sql = "INSERT INTO archivos_trabajo(Tra_IdTrabajo, Arc_Descripcion, Arc_Ruta, Arc_Estado, Row_Estado)
		        VALUES({$trabajo}, '{$descripcion}', '{$ruta}', 1, 1)";
		$this->execQuery($sql);
	}

	public function deleteArchivo($archivo){
		$sql = "UPDATE archivos_trabajo SET Row_Estado = 0 AND Arc_Estado = 0
            	WHERE Arc_IdArchivo = {$archivo}";
		$this->execQuery($sql);
	}

	public function getArchivos($trabajo){
		$sql = "SELECT * FROM archivos_trabajo T
            	WHERE T.Row_Estado = 1 AND T.Arc_Estado = 1 AND T.Tra_IdTrabajo = {$trabajo}";
    	$datos = $this->getArray($sql);
    	if($datos!=null && count($datos)>0){
    		return $datos[0];
    	}
    	return null;
	}
}
