<?php

class registrarModel extends Model {

    public function __construct() {
        parent::__construct();
    }

    public function getIdiomas() {
        $post = $this->_db->query(
                "SELECT * FROM idioma");
        return $post->fetchAll();
    }

    public function getFichaLegislacion($Esr_IdEstandarRecurso, $Idi_IdIdioma) {
         try {
        $post = $this->_db->query(
                "SELECT
Fie_IdFichaEstandar,
fn_TraducirContenido('ficha_estandar','Fie_CampoFicha',Fie_IdFichaEstandar,'$Idi_IdIdioma',Fie_CampoFicha) Fie_CampoFicha,
Esr_IdEstandarRecurso,
Fie_NombreTabla,
Fie_ColumnaTabla
FROM ficha_estandar
WHERE Esr_IdEstandarRecurso = $Esr_IdEstandarRecurso");
        return $post->fetchAll();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getFichaLegislacion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getEstandarRecurso($rec_idrecurso) {
         try {
        $post = $this->_db->query(
                "SELECT Esr_IdEstandarRecurso FROM recurso WHERE rec_idrecurso = $rec_idrecurso");
        return $post->fetchAll();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getEstandarRecurso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getAutores() {
        try {
        $post = $this->_db->query(
                "SELECT	* FROM autor ");
        return $post->fetchAll();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getAutores", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getPalabrasClaves($Idi_IdIdioma) {
          try {
        $post = $this->_db->query(
                "SELECT 
DISTINCT(fn_TraducirContenido('dublincore','Dub_PalabraClave',Dub_IdDublinCore,'$Idi_IdIdioma',Dub_PalabraClave)) Dub_PalabraClave
FROM dublincore ");
        return $post->fetchAll();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getPalabrasClaves", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getTiposDublin($Idi_IdIdioma) {
         try {
        $post = $this->_db->query(
                "SELECT Tid_IdTipoDublin,
fn_TraducirContenido('tipo_dublin','Tid_Descripcion',Tid_IdTipoDublin,'$Idi_IdIdioma',Tid_Descripcion) Tid_Descripcion
FROM tipo_dublin ");
        return $post->fetchAll();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getTiposDublin", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getTemasDublin($Idi_IdIdioma) {
        try {
        $post = $this->_db->query(
                "SELECT Ted_IdTemaDublin,
fn_TraducirContenido('tema_dublin','Ted_Descripcion',Ted_IdTemaDublin,'$Idi_IdIdioma',Ted_Descripcion) Ted_Descripcion
FROM tema_dublin ");
        return $post->fetchAll();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getTemasDublin", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getFormatoArchivo() {
         try {
        $post = $this->_db->query(
                "SELECT	* FROM tipo_archivo_fisico");
        return $post->fetchAll();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getFormatoArchivo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getAutor($Aut_Nombre) {
        try {
        $sql = "SELECT	aut.Aut_IdAutor FROM autor aut WHERE aut.Aut_Nombre = '?'";
        $result = $this->_db->prepare($sql);
        $result->bindParam(1, $Aut_Nombre, PDO::PARAM_STR);
        $result->execute();

        return $result->fetch();      
         } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getAutor", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getFormatosArchivos($Taf_IdTipoArchivoFisico) {
        try {
        $post = $this->_db->query(
                "SELECT	* FROM tipo_archivo_fisico where Taf_IdTipoArchivoFisico = '$Taf_IdTipoArchivoFisico' or Taf_Descripcion = '$Taf_IdTipoArchivoFisico'");
        return $post->fetch();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getFormatosArchivos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getTipoDublin($Tid_Descripcion, $Idi_IdIdioma) {
        try {
        $post = $this->_db->query(
                "SELECT tid.Tid_IdTipoDublin
FROM tipo_dublin tid
WHERE fn_TraducirContenido('tipo_dublin','Tid_Descripcion',tid.Tid_IdTipoDublin,'$Idi_IdIdioma',tid.Tid_Descripcion) = '$Tid_Descripcion' ");
        return $post->fetch();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getTipoDublin", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getTemaDublin($Ted_Nombre, $Idi_IdIdioma) {
         try {
        $post = $this->_db->query(
                "SELECT ted.Ted_IdTemaDublin
FROM tema_dublin ted 
WHERE fn_TraducirContenido('tema_dublin','Ted_Descripcion',ted.Ted_IdTemaDublin,'$Idi_IdIdioma',ted.Ted_Descripcion) = '$Ted_Nombre' ");
        return $post->fetch();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getTemaDublin", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getPais($Pai_Nombre) {
         try {
        $post = $this->_db->query(
                "SELECT pai.Pai_IdPais FROM pais pai WHERE pai.Pai_Nombre = '$Pai_Nombre' ");
        return $post->fetch();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getPais", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getArchivoFisico($Arf_PosicionFisica) {
         try {
        $post = $this->_db->query(
                "SELECT	arf.* FROM archivo_fisico arf WHERE arf.Arf_PosicionFisica = '$Arf_PosicionFisica'");
        return $post->fetch();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getArchivoFisico", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
     public function getArchivoFisicoXId($Arf_IdArchivoFisico) {
         try {
        $post = $this->_db->query(
                "SELECT	arf.* FROM archivo_fisico arf WHERE arf.Arf_IdArchivoFisico = $Arf_IdArchivoFisico");
        return $post->fetch();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getArchivoFisicoXId", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getDublinAutor($Dub_IdDublinCore, $Aut_IdAutor) {
         try {
        $post = $this->_db->query(
                "SELECT dua.Dub_IdDublinCore FROM dublincore_autor dua
WHERE dua.Dub_IdDublinCore = '$Dub_IdDublinCore' AND dua.Aut_IdAutor = '$Aut_IdAutor'");
        return $post->fetch();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "getDublinAutor", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function registrarFormatoArchivo($Taf_Descripcion) {
         try {
        $this->_db->prepare(
                        "insert into tipo_archivo_fisico (Taf_Descripcion) values " .
                        "(:Taf_Descripcion)"
                )
                ->execute(array(
                    ':Taf_Descripcion' => $Taf_Descripcion
        ));
        $post = $this->_db->query("SELECT LAST_INSERT_ID()");
        return $post->fetch();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "registrarFormatoArchivo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function registrarArchivoFisico($Arf_Descripcion, $Taf_IdTipoArchivoFisico, $Arf_TypeMime, $Arf_TamanoArchivo, $Arf_PosicionFisica, $Arf_FechaCreacion, $Arf_URL, $Arf_Estado, $Idi_IdIdioma) {
        try {            
            $result=$this->_db->prepare(
                            "insert into archivo_fisico (Arf_Descripcion, Taf_IdTipoArchivoFisico, Arf_TypeMime, Arf_TamanoArchivo, Arf_PosicionFisica, Arf_FechaCreacion, Arf_URL, Arf_Estado, Idi_IdIdioma) values " .
                            "(?,?,?,?,?,?,?,?,?)"
                    );
            $result->bindParam(1, $Arf_Descripcion, PDO::PARAM_STR);
            $result->bindParam(2, $Taf_IdTipoArchivoFisico, PDO::PARAM_INT);
            $result->bindParam(3, $Arf_TypeMime, PDO::PARAM_STR);
            $result->bindParam(4, $Arf_TamanoArchivo, PDO::PARAM_STR);
            $result->bindParam(5, $Arf_PosicionFisica, PDO::PARAM_STR);
            $result->bindParam(6, $Arf_FechaCreacion, PDO::PARAM_STR);
            $result->bindParam(7, $Arf_URL, PDO::PARAM_STR);
            $result->bindParam(8, $Arf_Estado, PDO::PARAM_STR);
            $result->bindParam(9, $Idi_IdIdioma, PDO::PARAM_STR);
           
            $result->execute();
                       
            $post = $this->_db->query("SELECT LAST_INSERT_ID()");           
            return $post->fetch();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "registrarArchivoFisico", "Error Model", $exception);
            return $exception->getTraceAsString();
            
        }
    }

    public function registrarAutor($Aut_Nombre) {
         try {  
        $this->_db->prepare(
                        "insert into autor (Aut_Nombre) values " .
                        "(:Aut_Nombre)"
                )
                ->execute(array(
                    ':Aut_Nombre' => $Aut_Nombre
        ));
        $post = $this->_db->query("SELECT LAST_INSERT_ID()");
        return $post->fetch();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "registrarAutor", "Error Model", $exception);
            return $exception->getTraceAsString();
            
        }
    }

    public function registrarTipoDublin($Tid_Descripcion, $Idi_IdIdioma) {
        try {  
        $this->_db->prepare(
                        "insert into tipo_dublin (Tid_Descripcion,Idi_IdIdioma) values " .
                        "(:Tid_Descripcion,:Idi_IdIdioma)"
                )
                ->execute(array(
                    ':Tid_Descripcion' => $Tid_Descripcion,
                    ':Idi_IdIdioma' => $Idi_IdIdioma
        ));
        $post = $this->_db->query("SELECT LAST_INSERT_ID()");
        return $post->fetch();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "registrarTipoDublin", "Error Model", $exception);
            return $exception->getTraceAsString();
            
        }
    }

    public function registrarTemaDublin($Ted_Nombre, $Idi_IdIdioma) {
        try { 
        $this->_db->prepare(
                        "insert into tema_dublin (Ted_Descripcion,Idi_IdIdioma) values " .
                        "(:Ted_Descripcion,:Idi_IdIdioma)"
                )
                ->execute(array(
                    ':Ted_Descripcion' => $Ted_Nombre,
                    ':Idi_IdIdioma' => $Idi_IdIdioma
        ));
        $post = $this->_db->query("SELECT LAST_INSERT_ID()");
        return $post->fetch();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "registrarTemaDublin", "Error Model", $exception);
            return $exception->getTraceAsString();
            
        }
    }

    public function registrarDublinCore($Dub_Titulo, $Dub_Descripcion, $Dub_Editor, $Dub_Colabrorador, $Dub_FechaDocumento, $Dub_Formato, $Dub_Identificador, $Dub_Fuente, $Dub_Idioma, $Dub_Relacion, $Dub_Cobertura, $Dub_Derechos, $Dub_PalabraClave, $Tid_IdTipoDublin, $Arf_IdArchivoFisico, $Idi_IdIdioma, $Ted_IdTemaDublin, $Rec_IdRecurso) {
        try { 
        $this->_db->prepare(
                        "insert into dublincore (Dub_Titulo, Dub_Descripcion, Dub_Editor, Dub_Colaborador, Dub_FechaDocumento, Dub_Formato, Dub_Identificador, Dub_Fuente, Dub_Idioma, Dub_Relacion, Dub_Cobertura, Dub_Derechos, Dub_PalabraClave, Tid_IdTipoDublin, Arf_IdArchivoFisico, Idi_IdIdioma, Ted_IdTemaDublin, Usu_IdUsuario, Rec_IdRecurso, Dub_Estado ) values " .
                        "(:Dub_Titulo, :Dub_Descripcion, :Dub_Editor, :Dub_Colaborador, :Dub_FechaDocumento, :Dub_Formato, :Dub_Identificador, :Dub_Fuente, :Dub_Idioma, :Dub_Relacion, :Dub_Cobertura, :Dub_Derechos, :Dub_PalabraClave, :Tid_IdTipoDublin, :Arf_IdArchivoFisico, :Idi_IdIdioma, :Ted_IdTemaDublin, :Usu_IdUsuario, :Rec_IdRecurso,1)"
                )
                ->execute(array(
                    ':Dub_Titulo' => $Dub_Titulo,
                    ':Dub_Descripcion' => $Dub_Descripcion,
                    ':Dub_Editor' => $Dub_Editor,
                    ':Dub_Colaborador' => $Dub_Colabrorador,
                    ':Dub_FechaDocumento' => $Dub_FechaDocumento,
                    ':Dub_Formato' => $Dub_Formato,
                    ':Dub_Identificador' => $Dub_Identificador,
                    ':Dub_Fuente' => $Dub_Fuente,
                    ':Dub_Idioma' => $Dub_Idioma,
                    ':Dub_Relacion' => $Dub_Relacion,
                    ':Dub_Cobertura' => $Dub_Cobertura,
                    ':Dub_Derechos' => $Dub_Derechos,
                    ':Dub_PalabraClave' => $Dub_PalabraClave,
                    ':Tid_IdTipoDublin' => $Tid_IdTipoDublin,
                    ':Arf_IdArchivoFisico' => $Arf_IdArchivoFisico,
                    ':Idi_IdIdioma' => $Idi_IdIdioma,
                    ':Ted_IdTemaDublin' => $Ted_IdTemaDublin,
                    ':Usu_IdUsuario' => Session::get('id_usuario'),
                    ':Rec_IdRecurso' => $Rec_IdRecurso
        ));
        $post = $this->_db->query("SELECT LAST_INSERT_ID()");
        return $post->fetch();
        } catch (PDOException $exception) {
            
            $this->registrarBitacora("dublincore(registrarModel)", "registrarDublinCore", "Error Model", $exception);
            return $exception->getTraceAsString();
            
        }
    }

    public function insertarFileForo($iFif_NombreFile, $iFif_TipoFile, $iFif_SizeFile, $iFor_IdForo, $iRec_IdRecurso,$iDub_IdDublinCore, $iFif_Titulo,$iFif_EsOutForo)
    {
        try {

            $sql    = "call s_i_insertar_file_foro(?,?,?,?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iFif_NombreFile, PDO::PARAM_STR);
            $result->bindParam(2, $iFif_TipoFile, PDO::PARAM_STR);
            $result->bindParam(3, $iFif_SizeFile, PDO::PARAM_INT);
            $result->bindParam(4, $iFor_IdForo, PDO::PARAM_INT);
            $result->bindParam(5, $iRec_IdRecurso, PDO::PARAM_INT);
            $result->bindParam(6, $iDub_IdDublinCore, PDO::PARAM_INT);
            $result->bindParam(7, $iFif_Titulo, PDO::PARAM_STR);
            $result->bindParam(8, $iFif_EsOutForo, PDO::PARAM_INT);

            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {

            $this->registrarBitacora("dublincore(registrarModel)", "insertarFileForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function updateFileForo($iFor_IdForo, $iFif_NombreFile, $iFif_TipoFile, $iFif_SizeFile,$iFif_Titulo)
    {
        try {
            $foro = $this->_db->query(
                "UPDATE file_foro SET Fif_NombreFile = '$iFif_NombreFile', Fif_TipoFile = '$iFif_TipoFile', Fif_SizeFile = '$iFif_SizeFile', Fif_Titulo='$iFif_Titulo' where For_IdForo=$iFor_IdForo and Fif_EsOutForo=1"
            );

            return $foro->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("registrar(adminModel)", "updateFileForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function registrarDublinAutor($Dub_IdDublinCore, $Aut_IdAutor) {
         try {
        $this->_db->prepare(
                        "insert into dublincore_autor (Dub_IdDublinCore,Aut_IdAutor) values " .
                        "(:Dub_IdDublinCore,:Aut_IdAutor)"
                )
                ->execute(array(
                    ':Dub_IdDublinCore' => $Dub_IdDublinCore,
                    ':Aut_IdAutor' => $Aut_IdAutor
        ));
        $post = $this->_db->query("SELECT LAST_INSERT_ID()");
        return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("registrar(adminModel)", "registrarDublinAutor", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function registrarDocumentosRelacionados($Dub_IdDublinCore, $Pai_IdPais) {
        try {
        $this->_db->prepare(
                        "insert into documentos_relacionados (Dub_IdDublinCore, Pai_IdPais) values " .
                        "(:Dub_IdDublinCore, :Pai_IdPais)"
                )
                ->execute(array(
                    ':Dub_IdDublinCore' => $Dub_IdDublinCore,
                    ':Pai_IdPais' => $Pai_IdPais
        ));
        $post = $this->_db->query("SELECT LAST_INSERT_ID()");
        return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("registrar(adminModel)", "registrarDocumentosRelacionados", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

}

?>
