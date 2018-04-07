<?php

class objetivosModel extends Model {

    public function __construct() { parent::__construct(); }

    public function getObjs($id){
        return $this->getArray("SELECT * FROM curso_objetivos WHERE Cur_IdCurso = {$id}");
    }
}
