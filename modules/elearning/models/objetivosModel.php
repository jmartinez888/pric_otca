<?php

class objetivosModel extends Model {

    public function __construct() { parent::__construct(); }

    public function getObjs($id, $Idi_IdIdioma = "es"){
        return $this->getArray("SELECT CO_IdObjetivo,
        Cur_IdCurso,
        fn_TraducirContenido('curso_objetivos','CO_Titulo',CO_IdObjetivo,'$Idi_IdIdioma',CO_Titulo) CO_Titulo,
        fn_TraducirContenido('curso_objetivos','CO_Descripcion',CO_IdObjetivo,'$Idi_IdIdioma',CO_Descripcion) CO_Descripcion,
        CO_FechaReg,
        CO_Estado,
        Row_Estado,
        fn_devolverIdioma('curso_objetivos',CO_IdObjetivo,'$Idi_IdIdioma',Idi_IdIdioma) Idi_IdIdioma
        FROM curso_objetivos WHERE Cur_IdCurso = {$id}");
    }
}
