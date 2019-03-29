<?php

class indexModel extends Model
{
    public function __construct()
    {
        parent::__construct();
    }

    //-----------------------------*Noticias*-----------------------------------------
    // Jhon Martinez
    public function getIdiomas() {
        try {
            $result = $this->_db->query("
            SELECT *, fn_TraducirContenido('idioma','Idi_Idioma',idioma.Idi_CharCode,'".self::getCurrentLang()."',idioma.Idi_Idioma) Idi_Idioma FROM idioma");
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("noticias(indexModel)", "getIdiomas", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    // Jhon Martinez
    public function getTiposNoticias() {
        try {
            $result = $this->_db->query("SELECT * FROM tipo_noticia");
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("noticias(indexModel)", "getTiposNoticias", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
}

?>
