
<?php

class documentosModel extends Model{
    
    public function __construct() {
        parent::__construct();
    }
        
    public function getDocumentosTraducido($condicion,$Idi_IdIdioma)
    {
        $condicion = $condicion." GROUP BY dub.Dub_IdDublinCore ";
        $paginas = $this->_db->query(
            " SELECT 
            dub.Dub_IdDublinCore, GROUP_CONCAT(pai.Pai_Nombre) AS Pai_Nombre,
            fn_TraducirContenido('dublincore','Dub_Titulo',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_Titulo) Dub_Titulo,
            fn_TraducirContenido('dublincore','Dub_Descripcion',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_Descripcion) Dub_Descripcion,
            fn_TraducirContenido('dublincore','Dub_PalabraClave',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_PalabraClave) Dub_PalabraClave,
            dub.Dub_Editor, dub.Dub_Colaborador, dub.Dub_FechaDocumento, dub.Dub_Formato, dub.Dub_Identificador, dub.Dub_Fuente, dub.Dub_Idioma,
            dub.Dub_Relacion, dub.Dub_Cobertura, dub.Dub_Derechos, dub.Dub_Estado, dub.Tid_IdTipoDublin, dub.Arf_IdArchivoFisico, 
            dub.Ted_IdTemaDublin, dub.Rec_IdRecurso, dub.Usu_IdUsuario,
            aut.Aut_IdAutor, aut.Aut_Nombre, arf.Arf_PosicionFisica, arf.Arf_FechaCreacion, arf.Arf_FechaRegistro, taf.*,
            ted.Ted_Descripcion, tid.Tid_Descripcion, tid.Tid_Estado,
            fn_devolverIdioma('dublincore',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Idi_IdIdioma) Idi_IdIdioma
            FROM dublincore dub     
            INNER JOIN tema_dublin ted ON dub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin 
            INNER JOIN dublincore_autor dua ON dub.Dub_IdDublinCore = dua.Dub_IdDublinCore 
            INNER JOIN autor aut ON dua.Aut_IdAutor = aut.Aut_IdAutor  
            LEFT JOIN archivo_fisico arf ON dub.Arf_IdArchivoFisico = arf.Arf_IdArchivoFisico 
            INNER JOIN tipo_dublin tid ON dub.Tid_IdTipoDublin = tid.Tid_IdTipoDublin
            INNER JOIN documentos_relacionados dor ON dub.Dub_IdDublinCore = dor.Dub_IdDublinCore
            INNER JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais
            LEFT JOIN tipo_archivo_fisico taf ON arf.Taf_IdTipoArchivoFisico = taf.Taf_IdTipoArchivoFisico
              $condicion "
             
        );
        return $paginas->fetchAll();
    }
	
	public function getTotalDocumentos($condicion,$Idi_IdIdioma)
    {
        $paginas = $this->_db->query(
            "SELECT COUNT(d.Dub_IdDublinCore) cantidad 
                FROM 
                (SELECT dor.Dub_IdDublinCore FROM documentos_relacionados dor             
                INNER JOIN dublincore dub ON dor.Dub_IdDublinCore = dub.Dub_IdDublinCore
                LEFT JOIN archivo_fisico arf ON dub.Arf_IdArchivoFisico = arf.Arf_IdArchivoFisico
                INNER JOIN tema_dublin ted ON dub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin
                INNER JOIN dublincore_autor dua ON dub.Dub_IdDublinCore = dua.Dub_IdDublinCore
                INNER JOIN autor aut ON dua.Aut_IdAutor = aut.Aut_IdAutor
                INNER JOIN tipo_dublin tid ON dub.Tid_IdTipoDublin = tid.Tid_IdTipoDublin
                INNER JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais
                RIGHT JOIN tipo_archivo_fisico taf ON arf.Taf_IdTipoArchivoFisico = taf.Taf_IdTipoArchivoFisico
                 $condicion 
                GROUP BY dor.Dub_IdDublinCore
                ) d "        
        );
        return $paginas->fetch();
    }
	/*
	public function getCantidadTemasDocumentos($Idi_IdIdioma = "" )
    {
        $post = $this->_db->query(
            "SELECT ted.Ted_IdTemaDublin, ted.Ted_Descripcion, sub.cantidad FROM tema_dublin ted
LEFT JOIN  ( SELECT COUNT(dub.Dub_IdDublinCore) AS cantidad,
fn_TraducirContenido('tema_dublin','Ted_Descripcion',tedu.Ted_IdTemaDublin,'$Idi_IdIdioma',tedu.Ted_Descripcion) Ted_Descripcion,
tedu.Ted_IdTemaDublin FROM dublincore dub 
RIGHT JOIN tema_dublin tedu ON dub.Ted_IdTemaDublin = tedu.Ted_IdTemaDublin
GROUP BY(dub.Ted_IdTemaDublin) ) AS sub ON sub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin ORDER BY Ted_Descripcion ");        
        return $post->fetchAll();
    }	*/
	
    public function getCantidadFormatosDocumentos($condicion = "", $Idi_IdIdioma = "" )
    {
        $post = $this->_db->query(
            "SELECT COUNT(d.Dub_IdDublinCore) AS cantidad,t.Taf_Descripcion FROM 
            (SELECT dor.Dub_IdDublinCore,taf.Taf_Descripcion, taf.Taf_IdTipoArchivoFisico FROM documentos_relacionados dor 
            INNER JOIN dublincore dub ON dor.Dub_IdDublinCore = dub.Dub_IdDublinCore
            LEFT JOIN archivo_fisico arf ON dub.Arf_IdArchivoFisico = arf.Arf_IdArchivoFisico
            INNER JOIN tema_dublin ted ON dub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin
            INNER JOIN dublincore_autor dua ON dub.Dub_IdDublinCore = dua.Dub_IdDublinCore
            INNER JOIN autor aut ON dua.Aut_IdAutor = aut.Aut_IdAutor
            INNER JOIN tipo_dublin tid ON dub.Tid_IdTipoDublin = tid.Tid_IdTipoDublin
            INNER JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais
            LEFT JOIN tipo_archivo_fisico taf ON arf.Taf_IdTipoArchivoFisico = taf.Taf_IdTipoArchivoFisico                
            $condicion
            GROUP BY dub.Dub_IdDublinCore) d
            LEFT JOIN tipo_archivo_fisico t ON d.Taf_IdTipoArchivoFisico = t.Taf_IdTipoArchivoFisico   GROUP BY (t.Taf_IdTipoArchivoFisico)
            ORDER BY t.Taf_Descripcion ASC  ");        
        return $post->fetchAll();
    }
    public function getCantidadAutoresDocumentos($condicion = "", $Idi_IdIdioma = "" )
    {
        $post = $this->_db->query(
            "SELECT COUNT(d.Dub_IdDublinCore) AS cantidad,a.Aut_Nombre FROM 
            (SELECT dor.Dub_IdDublinCore,aut.Aut_Nombre, aut.Aut_IdAutor FROM documentos_relacionados dor 
            INNER JOIN dublincore dub ON dor.Dub_IdDublinCore = dub.Dub_IdDublinCore
            LEFT JOIN archivo_fisico arf ON dub.Arf_IdArchivoFisico = arf.Arf_IdArchivoFisico
            INNER JOIN tema_dublin ted ON dub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin
            INNER JOIN dublincore_autor dua ON dub.Dub_IdDublinCore = dua.Dub_IdDublinCore
            INNER JOIN autor aut ON dua.Aut_IdAutor = aut.Aut_IdAutor
            INNER JOIN tipo_dublin tid ON dub.Tid_IdTipoDublin = tid.Tid_IdTipoDublin
            INNER JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais
            LEFT JOIN tipo_archivo_fisico taf ON arf.Taf_IdTipoArchivoFisico = taf.Taf_IdTipoArchivoFisico                
            $condicion
            GROUP BY dub.Dub_IdDublinCore) d
            LEFT JOIN autor a ON d.Aut_IdAutor = a.Aut_IdAutor  GROUP BY (a.Aut_IdAutor)
            ORDER BY a.Aut_Nombre ASC  ");        
        return $post->fetchAll();
    }
	public function getCantidadTiposDocumentos($condicion = "", $Idi_IdIdioma = "" )
    {
        $post = $this->_db->query(
            "SELECT COUNT(d.Dub_IdDublinCore) AS cantidad,tidm.Tid_Descripcion FROM 
            (SELECT dor.Dub_IdDublinCore,tid.Tid_Descripcion, tid.Tid_IdTipoDublin FROM documentos_relacionados dor 
            INNER JOIN dublincore dub ON dor.Dub_IdDublinCore = dub.Dub_IdDublinCore
            LEFT JOIN archivo_fisico arf ON dub.Arf_IdArchivoFisico = arf.Arf_IdArchivoFisico
            INNER JOIN tema_dublin ted ON dub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin
            INNER JOIN dublincore_autor dua ON dub.Dub_IdDublinCore = dua.Dub_IdDublinCore
            INNER JOIN autor aut ON dua.Aut_IdAutor = aut.Aut_IdAutor
            INNER JOIN tipo_dublin tid ON dub.Tid_IdTipoDublin = tid.Tid_IdTipoDublin
            INNER JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais
            LEFT JOIN tipo_archivo_fisico taf ON arf.Taf_IdTipoArchivoFisico = taf.Taf_IdTipoArchivoFisico                
            $condicion
            GROUP BY dub.Dub_IdDublinCore) d
            LEFT JOIN tipo_dublin tidm ON d.Tid_IdTipoDublin = tidm.Tid_IdTipoDublin  GROUP BY (tidm.Tid_IdTipoDublin)
            ORDER BY tidm.Tid_Descripcion ASC  ");        
        return $post->fetchAll();
    }
    public function getCantidadTemasDocumentos($condicion = "", $Idi_IdIdioma = "")
    {
        $post = $this->_db->query(
        "SELECT COUNT(d.Dub_IdDublinCore) AS cantidad,tedm.Ted_Descripcion FROM 
            (SELECT dor.Dub_IdDublinCore,ted.Ted_Descripcion, ted.Ted_IdTemaDublin FROM documentos_relacionados dor 
            INNER JOIN dublincore dub ON dor.Dub_IdDublinCore = dub.Dub_IdDublinCore
            LEFT JOIN archivo_fisico arf ON dub.Arf_IdArchivoFisico = arf.Arf_IdArchivoFisico
            INNER JOIN tema_dublin ted ON dub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin
            INNER JOIN dublincore_autor dua ON dub.Dub_IdDublinCore = dua.Dub_IdDublinCore
            INNER JOIN autor aut ON dua.Aut_IdAutor = aut.Aut_IdAutor
            INNER JOIN tipo_dublin tid ON dub.Tid_IdTipoDublin = tid.Tid_IdTipoDublin
            INNER JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais
            INNER JOIN tipo_archivo_fisico taf ON arf.Taf_IdTipoArchivoFisico = taf.Taf_IdTipoArchivoFisico                
            $condicion
            GROUP BY dub.Dub_IdDublinCore) d
            LEFT JOIN tema_dublin tedm ON d.Ted_IdTemaDublin = tedm.Ted_IdTemaDublin  GROUP BY (tedm.Ted_IdTemaDublin)
            ORDER BY tedm.Ted_Descripcion ASC  ");        
        return $post->fetchAll();
    }	
	public function getCantidadDocumentosPaises($condicion = "")
    {
        $post = $this->_db->query(
        "SELECT COUNT(dor.Dor_IdDocumentoRelacionado) AS cantidad, pai.Pai_Nombre  FROM documentos_relacionados dor
        INNER JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais $condicion 
        GROUP BY pai.Pai_Nombre");        
        return $post->fetchAll();
    }
	
	public function getPaises()
    {
        $post = $this->_db->query(
                "SELECT * FROM pais");				
        return $post->fetchAll();
    }
	/*
	public function getCantidadTemaDocumentos($condicion = "")
    {
        $post = $this->_db->query(
        "SELECT COUNT(dub.Dub_IdDublinCore) AS cantidad,ted.Ted_Descripcion FROM dublincore dub 
INNER JOIN tema_dublin ted ON dub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin GROUP BY(dub.Ted_IdTemaDublin)
ORDER BY ted.Ted_Descripcion ASC ");        
        return $post->fetchAll();
    }*/
    
    
    public function getCantidadDocumentosPais($condicion = "")
    {
        $post = $this->_db->query(     
        "SELECT COUNT(dub.Dub_IdDublinCore) AS cantidad, pai.Pai_Nombre FROM dublincore dub "
		. "INNER JOIN documentos_relacionados dor ON dub.Dub_IdDublinCore = dor.Dub_IdDublinCore "
		. "RIGHT JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais $condicion "
		. "GROUP BY(pai.Pai_Nombre)");
        return $post->fetchAll();
    }
	/*
	public function getDocumentosPaises($condicion = "", $Idi_IdIdioma = "")
    {
        $condicion = $condicion." GROUP BY dub.Dub_IdDublinCore ORDER BY dub.Dub_Titulo ASC ";
            
        $post = $this->_db->query(
                "SELECT dub.Dub_IdDublinCore, COUNT(pai.Pai_IdPais) AS Pai_Cantidad, pai.Pai_Nombre,
                fn_TraducirContenido('dublincore','Dub_Titulo',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_Titulo) Dub_Titulo,
                fn_TraducirContenido('dublincore','Dub_Descripcion',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_Descripcion) Dub_Descripcion,
                fn_TraducirContenido('dublincore','Dub_PalabraClave',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_PalabraClave) Dub_PalabraClave,
                dub.Dub_Editor, dub.Dub_Colaborador, dub.Dub_FechaDocumento, dub.Dub_Formato, dub.Dub_Identificador, dub.Dub_Fuente, dub.Dub_Idioma,
                dub.Dub_Relacion, dub.Dub_Cobertura, dub.Dub_Derechos, dub.Dub_Estado, dub.Tid_IdTipoDublin, dub.Arf_IdArchivoFisico, 
                dub.Ted_IdTemaDublin, dub.Rec_IdRecurso, dub.Usu_IdUsuario,
                fn_devolverIdioma('dublincore',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Idi_IdIdioma) Idi_IdIdioma,
                arf.Arf_PosicionFisica,ted.Ted_Descripcion,aut.*,tid.Tid_Descripcion ,taf.* FROM documentos_relacionados dor
                INNER JOIN dublincore dub ON dor.Dub_IdDublinCore = dub.Dub_IdDublinCore
                LEFT JOIN archivo_fisico arf ON dub.Arf_IdArchivoFisico = arf.Arf_IdArchivoFisico
                INNER JOIN tema_dublin ted ON dub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin
                INNER JOIN dublincore_autor dua ON dub.Dub_IdDublinCore = dua.Dub_IdDublinCore
                INNER JOIN autor aut ON dua.Aut_IdAutor = aut.Aut_IdAutor
                INNER JOIN tipo_dublin tid ON dub.Tid_IdTipoDublin = tid.Tid_IdTipoDublin
                INNER JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais
                LEFT JOIN tipo_archivo_fisico taf ON arf.Taf_IdTipoArchivoFisico = taf.Taf_IdTipoArchivoFisico $condicion ");               
        return $post->fetchAll();
    }
	*/
    public function getDocumentosRowCount($condicion = "", $Idi_IdIdioma = "")
    {
        $condicion = $condicion." GROUP BY dub.Dub_IdDublinCore ";
            
        $post = $this->_db->query(
                " SELECT COUNT(c.Dub_IdDublinCore) AS CantidadRegistros FROM (SELECT dor.Dub_IdDublinCore  FROM documentos_relacionados dor
                INNER JOIN dublincore dub ON dor.Dub_IdDublinCore = dub.Dub_IdDublinCore
                LEFT JOIN archivo_fisico arf ON dub.Arf_IdArchivoFisico = arf.Arf_IdArchivoFisico
                INNER JOIN tema_dublin ted ON dub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin
                INNER JOIN dublincore_autor dua ON dub.Dub_IdDublinCore = dua.Dub_IdDublinCore
                INNER JOIN autor aut ON dua.Aut_IdAutor = aut.Aut_IdAutor
                INNER JOIN tipo_dublin tid ON dub.Tid_IdTipoDublin = tid.Tid_IdTipoDublin
                INNER JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais
                LEFT JOIN tipo_archivo_fisico taf ON arf.Taf_IdTipoArchivoFisico = taf.Taf_IdTipoArchivoFisico $condicion ) c ");               
        
        return $post->fetch();
    }

    public function getDocumentosPaises($condicion = "", $Idi_IdIdioma = "", $OrderBy = "")
    {
        $condicion = $condicion." GROUP BY dub.Dub_IdDublinCore $OrderBy ";
            
        $post = $this->_db->query(
                " SELECT dub.Dub_IdDublinCore, GROUP_CONCAT(DISTINCT (aut.Aut_Nombre)) AS 'Autores', COUNT(pai.Pai_IdPais) AS Pai_Cantidad, pai.Pai_Nombre,
                fn_TraducirContenido('dublincore','Dub_Titulo',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_Titulo) Dub_Titulo,
                fn_TraducirContenido('dublincore','Dub_Descripcion',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_Descripcion) Dub_Descripcion,
                fn_TraducirContenido('dublincore','Dub_PalabraClave',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_PalabraClave) Dub_PalabraClave,
                dub.Dub_Editor, dub.Dub_Colaborador, dub.Dub_FechaDocumento, dub.Dub_Formato, dub.Dub_Identificador, dub.Dub_Fuente, dub.Dub_Idioma,
                dub.Dub_Relacion, dub.Dub_Cobertura, dub.Dub_Derechos, dub.Dub_Estado, dub.Tid_IdTipoDublin, dub.Arf_IdArchivoFisico, 
                dub.Ted_IdTemaDublin, dub.Rec_IdRecurso, dub.Usu_IdUsuario,
                dub.Row_Estado,
                fn_devolverIdioma('dublincore',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Idi_IdIdioma) Idi_IdIdioma,
                arf.Arf_PosicionFisica,ted.Ted_Descripcion,aut.*,tid.Tid_Descripcion ,taf.*    
                FROM documentos_relacionados dor
                INNER JOIN dublincore dub ON dor.Dub_IdDublinCore = dub.Dub_IdDublinCore
                LEFT JOIN archivo_fisico arf ON dub.Arf_IdArchivoFisico = arf.Arf_IdArchivoFisico
                INNER JOIN tema_dublin ted ON dub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin
                INNER JOIN dublincore_autor dua ON dub.Dub_IdDublinCore = dua.Dub_IdDublinCore
                INNER JOIN autor aut ON dua.Aut_IdAutor = aut.Aut_IdAutor
                INNER JOIN tipo_dublin tid ON dub.Tid_IdTipoDublin = tid.Tid_IdTipoDublin
                INNER JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais
                LEFT JOIN tipo_archivo_fisico taf ON arf.Taf_IdTipoArchivoFisico = taf.Taf_IdTipoArchivoFisico $condicion ");               
        
        return $post->fetchAll();
    }

    public function getCantDocumentosPaises($condicion = "", $Idi_IdIdioma = "" )
    {
        //$condicion = $condicion." GROUP BY dub.Dub_IdDublinCore ";
        $post = $this->_db->query(
                "SELECT COUNT(d.Dor_IdDocumentoRelacionado) AS cantidad, p.Pai_Nombre, p.Pai_IdPais FROM (
                    SELECT dor.Dor_IdDocumentoRelacionado, pai.Pai_Nombre, pai.Pai_IdPais
                    FROM documentos_relacionados dor
                    INNER JOIN dublincore dub ON dor.Dub_IdDublinCore = dub.Dub_IdDublinCore
                    LEFT JOIN archivo_fisico arf ON dub.Arf_IdArchivoFisico = arf.Arf_IdArchivoFisico
                    INNER JOIN tema_dublin ted ON dub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin
                    INNER JOIN dublincore_autor dua ON dub.Dub_IdDublinCore = dua.Dub_IdDublinCore
                    INNER JOIN autor aut ON dua.Aut_IdAutor = aut.Aut_IdAutor
                    INNER JOIN tipo_dublin tid ON dub.Tid_IdTipoDublin = tid.Tid_IdTipoDublin
                    INNER JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais
                    LEFT JOIN tipo_archivo_fisico taf ON arf.Taf_IdTipoArchivoFisico = taf.Taf_IdTipoArchivoFisico
                    $condicion
                ) d RIGHT JOIN pais p ON d.Pai_IdPais = p.Pai_IdPais GROUP BY p.Pai_Nombre ORDER BY p.Pai_Nombre ASC  ");   
        return $post->fetchAll();
    }
    /*

	public function getCantDocumentosPaises($condicion = "", $Idi_IdIdioma = "" )
    {
        //$condicion = $condicion." GROUP BY dub.Dub_IdDublinCore ";
        $post = $this->_db->query(
                "SELECT COUNT(d.Dor_IdDocumentoRelacionado) AS cantidad, p.Pai_Nombre, p.Pai_IdPais FROM (
                    SELECT dor.Dor_IdDocumentoRelacionado, pai.Pai_Nombre, pai.Pai_IdPais
                    FROM documentos_relacionados dor
                    INNER JOIN dublincore dub ON dor.Dub_IdDublinCore = dub.Dub_IdDublinCore
                    LEFT JOIN archivo_fisico arf ON dub.Arf_IdArchivoFisico = arf.Arf_IdArchivoFisico
                    INNER JOIN tema_dublin ted ON dub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin
                    INNER JOIN dublincore_autor dua ON dub.Dub_IdDublinCore = dua.Dub_IdDublinCore
                    INNER JOIN autor aut ON dua.Aut_IdAutor = aut.Aut_IdAutor
                    INNER JOIN tipo_dublin tid ON dub.Tid_IdTipoDublin = tid.Tid_IdTipoDublin
                    INNER JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais
                    LEFT JOIN tipo_archivo_fisico taf ON arf.Taf_IdTipoArchivoFisico = taf.Taf_IdTipoArchivoFisico
                    $condicion
                ) d RIGHT JOIN pais p ON d.Pai_IdPais = p.Pai_IdPais GROUP BY p.Pai_Nombre ORDER BY p.Pai_Nombre ASC  ");	
        return $post->fetchAll();
    }
	*/
	public function getTemasDocumentosPaises($condicion = "", $Idi_IdIdioma = "")
    {
        $post = $this->_db->query(
                "SELECT COUNT(d.Dub_IdDublinCore) cantidad, d.Ted_Descripcion FROM (SELECT
fn_TraducirContenido('dublincore','Dub_Titulo',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_Titulo) Dub_Titulo,
fn_TraducirContenido('dublincore','Dub_Descripcion',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_Descripcion) Dub_Descripcion,
fn_TraducirContenido('dublincore','Dub_PalabraClave',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_PalabraClave) Dub_PalabraClave,dub.Dub_IdDublinCore,dub.Dub_Editor, dub.Dub_Colaborador, dub.Dub_FechaDocumento, dub.Dub_Formato, dub.Dub_Identificador, dub.Dub_Fuente, dub.Dub_Idioma,
dub.Dub_Relacion, dub.Dub_Cobertura, dub.Dub_Derechos, dub.Dub_Estado, dub.Tid_IdTipoDublin, dub.Arf_IdArchivoFisico, 
dub.Ted_IdTemaDublin, dub.Rec_IdRecurso, dub.Usu_IdUsuario,
fn_devolverIdioma('dublincore',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Idi_IdIdioma) Idi_IdIdioma
,pai.Pai_Nombre,arf.Arf_PosicionFisica,ted.Ted_Descripcion,aut.*,tid.Tid_Descripcion ,taf.* FROM documentos_relacionados dor
INNER JOIN dublincore dub ON dor.Dub_IdDublinCore = dub.Dub_IdDublinCore
LEFT JOIN archivo_fisico arf ON dub.Arf_IdArchivoFisico = arf.Arf_IdArchivoFisico
INNER JOIN tema_dublin ted ON dub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin
INNER JOIN dublincore_autor dua ON dub.Dub_IdDublinCore = dua.Dub_IdDublinCore
INNER JOIN autor aut ON dua.Aut_IdAutor = aut.Aut_IdAutor
INNER JOIN tipo_dublin tid ON dub.Tid_IdTipoDublin = tid.Tid_IdTipoDublin
INNER JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais
RIGHT JOIN tipo_archivo_fisico taf ON arf.Taf_IdTipoArchivoFisico = taf.Taf_IdTipoArchivoFisico) d $condicion
GROUP BY d.Ted_Descripcion ");				
        return $post->fetchAll();
    }
	
	public function getPalabrasClavesPaises($condicion = "", $Idi_IdIdioma = "")
    {
        $post = $this->_db->query(
                "SELECT COUNT(d.Dub_IdDublinCore) cantidad, d.Dub_PalabraClave FROM (SELECT
fn_TraducirContenido('dublincore','Dub_Titulo',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_Titulo) Dub_Titulo,
fn_TraducirContenido('dublincore','Dub_Descripcion',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_Descripcion) Dub_Descripcion,
fn_TraducirContenido('dublincore','Dub_PalabraClave',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Dub_PalabraClave) Dub_PalabraClave,dub.Dub_IdDublinCore,dub.Dub_Editor, dub.Dub_Colaborador, dub.Dub_FechaDocumento, dub.Dub_Formato, dub.Dub_Identificador, dub.Dub_Fuente, dub.Dub_Idioma,
dub.Dub_Relacion, dub.Dub_Cobertura, dub.Dub_Derechos, dub.Dub_Estado, dub.Tid_IdTipoDublin, dub.Arf_IdArchivoFisico, 
dub.Ted_IdTemaDublin, dub.Rec_IdRecurso, dub.Usu_IdUsuario,
fn_devolverIdioma('dublincore',dub.Dub_IdDublinCore,'$Idi_IdIdioma',dub.Idi_IdIdioma) Idi_IdIdioma
,pai.Pai_Nombre,arf.Arf_PosicionFisica,ted.Ted_Descripcion,aut.*,tid.Tid_Descripcion ,taf.* FROM documentos_relacionados dor
INNER JOIN dublincore dub ON dor.Dub_IdDublinCore = dub.Dub_IdDublinCore
LEFT JOIN archivo_fisico arf ON dub.Arf_IdArchivoFisico = arf.Arf_IdArchivoFisico
INNER JOIN tema_dublin ted ON dub.Ted_IdTemaDublin = ted.Ted_IdTemaDublin
INNER JOIN dublincore_autor dua ON dub.Dub_IdDublinCore = dua.Dub_IdDublinCore
INNER JOIN autor aut ON dua.Aut_IdAutor = aut.Aut_IdAutor
INNER JOIN tipo_dublin tid ON dub.Tid_IdTipoDublin = tid.Tid_IdTipoDublin
INNER JOIN pais pai ON dor.Pai_IdPais = pai.Pai_IdPais
RIGHT JOIN tipo_archivo_fisico taf ON arf.Taf_IdTipoArchivoFisico = taf.Taf_IdTipoArchivoFisico) d $condicion
GROUP BY d.Dub_PalabraClave ");				
        return $post->fetchAll();
    }
	
	
	public function actualizarDublinCore($Dub_Titulo,$Dub_Descripcion,$Dub_FechaDocumento,$Dub_PalabraClave,$Dub_IdDublinCore)
    {
        $post = $this->_db->query(
                "UPDATE dublincore SET Dub_Titulo = '$Dub_Titulo' , Dub_Descripcion = '$Dub_Descripcion' , Dub_FechaDocumento = '$Dub_FechaDocumento' , Dub_PalabraClave = '$Dub_PalabraClave' WHERE Dub_IdDublinCore = $Dub_IdDublinCore ");
    }
    
    public function registrarDescarga($Esp_Ip="",$Arf_IdArchivoFisico=0,$Esd_CantidadDescarga=1,$Esd_TipoAcceso='')
	{
      // echo "$Esp_Ip";exit;
        try {                     
            $sql = "call s_i_estadistica_descarga(?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $Esp_Ip, PDO::PARAM_STR);
            $result->bindParam(2, $Arf_IdArchivoFisico, PDO::PARAM_INT);
            $result->bindParam(3, $Esd_CantidadDescarga, PDO::PARAM_INT);
            $result->bindParam(4, $Esd_TipoAcceso, PDO::PARAM_STR);
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("documentosModel", "registrarDescarga", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
	
    //Para modal Adjuntar archivo
    public function getEstandar()
    {
        try
        {
            $post = $this->_db->query("SELECT est.* FROM estandar_recurso est 
                                WHERE EXISTS (SELECT Table_Name FROM information_schema.TABLES 
                                WHERE Table_Name=est.Esr_NombreTabla AND TABLE_SCHEMA='siigef')");

            return $post->fetchAll();
        } 
        catch (PDOException $exception) 
        {
            $this->registrarBitacora("dublincore(documentosModel)", "getEstandar", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

	public function getIdiomas($fg ="") 
    {
        try
        {
            $idiomas = $this->_db->query("
            SELECT *, fn_TraducirContenido('idioma','Idi_Idioma',idioma.Idi_CharCode,'".self::getCurrentLang()."',idioma.Idi_Idioma) Idi_Idioma
            FROM idioma WHERE Idi_Estado = 1"
            );
            return $idiomas->fetchAll(PDO::FETCH_ASSOC);
        } 
        catch (PDOException $exception) 
        {
            $this->registrarBitacora("dublincore(documentosModel)", "getIdiomas", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
    
		
}
