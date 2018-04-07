<?php

class constanteModel extends Model {

    public function __construct() { parent::__construct(); }

    public function getConstante($cod, $valor=""){
        $sql = "SELECT * FROM constante WHERE Con_Codigo = {$cod}";
        if ($valor!="" ){ $sql .= " AND Con_Valor = {$valor} "; }
        $sql .= " AND Con_Estado = 1 AND Row_Estado = 1";
        return $this->getArray($sql);
    }
}
