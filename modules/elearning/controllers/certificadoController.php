<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class certificadoController extends elearningController {

    protected $certificado;
    protected $service;

    public function __construct($lang,$url)
    {
        parent::__construct($lang,$url);
        $this->getLibrary("ServiceResult");
        $this->service = new ServiceResult();
        $this->certificado = $this->loadModel("certificado");
    }

    public function index(){  }

    public function registrar(){

        $usuario = Session::get("id_usuario");
        $curso = $this->getTexto("curso");
        
        $tmpUser = "0000" . $usuario;
        $tmpCurso = "0000" . $curso;

        $codigo = substr($tmpCurso, strlen($tmpCurso)-5, strlen($tmpCurso));
        $codigo .= substr($tmpUser, strlen($tmpUser)-5, strlen($tmpUser));
        $codigo = date('Ymd'). $codigo;

        $this->certificado->insertCertificado($codigo, $usuario, $curso);

        $this->service->Success("Se registró la calificación");
        $this->service->Send();
    }

    public function get(){
        $curso = $this->getTexto("curso");
        $calif = $this->calificar->getCalificacion($curso);

        $this->service->Populate($calif);
        $this->service->Success("Se registró la calificación");
        $this->service->Send();        
    }

    public function miscertificados(){
        // $codigo = $this->getTexto("certificado");
        $this->_view->setCss(array("verificar"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        // $this->_view->assign("certificado", $codigo);
        // $this->_view->assign("resultados", $this->certificado->getCertificado($codigo));
        // $this->_view->renderizar("menu");
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));


        // $this->_view->setJs(array('index'));

        $pagina = $this->getInt('pagina');
        $usuario = Session::get("id_usuario");

        //Filtro por Activos/Eliminados
        // $condicion = " ORDER BY Row_Estado DESC ";
        // $soloActivos = 0;
        // if (!$this->_acl->permiso('ver_eliminados')) {
        //     $soloActivos = 1;
        //     $condicion = " WHERE Row_Estado = $soloActivos ";
        // }
        //Filtro por Activos/Eliminados

        $paginador = new Paginador();

        
        $arrayRowCount = $this->certificado->getCertificadoRowCount("WHERE v.Usu_IdUsuario = $usuario");

        $this->_view->assign('certificados', $this->certificado->getCertificadosCondicion($pagina,CANT_REG_PAG,"WHERE v.Usu_IdUsuario = $usuario"));



        $paginador->paginar( $arrayRowCount[0]['CantidadRegistros'],"listarcertificados", "", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacioncertificados', $paginador->getView('paginacion_ajax_s_filas'));
        
        $this->_view->assign('titulo', 'Mis Certficados');
        $this->_view->renderizar('miscertificados');
    }


     public function _paginacion_listarcertificados($txtBuscar = false) 
    {
        //$this->validarUrlIdioma();
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $totalRegistros = $this->getInt('total_registros');
        $usuario = Session::get("id_usuario");

        $condicion = " ";
        $soloActivos = 1;
        // $nombre = $this->getSql('palabra');
        if ($txtBuscar) 
        {
            $condicion = " WHERE c.Cur_Titulo liKe '%$txtBuscar%' and v.Usu_IdUsuario = $usuario ";
            //Filtro por Activos/Eliminados
            // if (!$this->_acl->permiso('ver_eliminados')) {
            //     $soloActivos = 1;
            //     $condicion .= " AND Row_Estado = $soloActivos ";
            // } else {
            //     $condicion .= " ORDER BY Row_Estado DESC  ";
            // }
        } else {
            //Filtro por Activos/Eliminados     
            // $condicion = " ORDER BY Row_Estado DESC ";   
            // if (!$this->_acl->permiso('ver_eliminados')) {
            //     $soloActivos = 1;
                 $condicion = " WHERE v.Usu_IdUsuario = $usuario  ";
            // }
        }         


        $paginador = new Paginador();
        // $arrayRowCount = $this->_aclm->getcertificadosRowCount$arrayRowCount = 0,($condicion);

        $paginador->paginar( $totalRegistros,"listarcertificados", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('certificados', $this->certificado->getCertificadosCondicion($pagina,$filas, $condicion));
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacioncertificados', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarcertificados', false, true);
    }
    //Modificado por Jhon Martinez
    public function _buscarcertificado() 
    {
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $condicion = "";
         $usuario = Session::get("id_usuario");

        $soloActivos = 1;
        // $nombre = $this->getSql('palabra');
        if ($txtBuscar) 
        {
            $condicion = " WHERE c.Cur_Titulo liKe '%$txtBuscar%' and v.Usu_IdUsuario = $usuario ";
            // if (!$this->_acl->permiso('ver_eliminados')) {
            //     $soloActivos = 1;
            //     $condicion .= " AND Row_Estado = $soloActivos ";
            // }
            // $condicion .= " ORDER BY Row_Estado DESC  ";
        } else {
            //Filtro por Activos/Eliminados     
            // $condicion = " ORDER BY Row_Estado DESC ";   
            // if (!$this->_acl->permiso('ver_eliminados')) {
            //     $soloActivos = 1;
                $condicion = "  WHERE v.Usu_IdUsuario = $usuario  ";
            // }

            //Filtro por Activos/Eliminados
        }        


        $paginador = new Paginador();


        $arrayRowCount = $this->certificado->getCertificadoRowCount($condicion);
        $totalRegistros = $arrayRowCount[0]['CantidadRegistros'];
        // echo($totalRegistros);
        // print_r($arrayRowCount); echo($condicion);exit;
        $this->_view->assign('certificados', $this->certificado->getCertificadosCondicion($pagina,CANT_REG_PAG, $condicion));

        $paginador->paginar( $totalRegistros ,"listarcertificados", "$txtBuscar", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacioncertificados', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarcertificados', false, true);
    }



    #metodo Otros reeditador por @vicercavi, ahora se llama verificar
    public function verificar($codigo = false) {

        $this->_view->setTemplate(LAYOUT_FRONTEND);
        
        $this->_view->setJs(array("verificar"));
        $this->_view->setCss(array("verificar"));

        if ($codigo) {
            $certificado = $this->certificado->getCertificadoCodigo($codigo);
            $this->_view->assign('certicado', $certificado);
            $this->_view->assign('codigo', $codigo);
        }

        $this->_view->assign('titulo', 'Verificacion de Certificados');
        $this->_view->renderizar('verificar');
    }

    public function _paginacion_listarcertificadosotros($txtBuscar = false) 
    {
        //$this->validarUrlIdioma();
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $totalRegistros = $this->getInt('total_registros');
        $usuario = Session::get("id_usuario");

        $condicion = " ";
        $soloActivos = 1;
        // $nombre = $this->getSql('palabra');
        if ($txtBuscar) 
        {
            $condicion = " WHERE v.Cer_Codigo liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            // if (!$this->_acl->permiso('ver_eliminados')) {
            //     $soloActivos = 1;
            //     $condicion .= " AND Row_Estado = $soloActivos ";
            // } else {
            //     $condicion .= " ORDER BY Row_Estado DESC  ";
            // }
        } else {
            //Filtro por Activos/Eliminados     
            // $condicion = " ORDER BY Row_Estado DESC ";   
            // if (!$this->_acl->permiso('ver_eliminados')) {
            //     $soloActivos = 1;
                 $condicion = " ";
            // }
        }         


        $paginador = new Paginador();
        // $arrayRowCount = $this->_aclm->getcertificadosRowCount$arrayRowCount = 0,($condicion);

        $paginador->paginar( $totalRegistros,"listarcertificadosotros", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('certificados', $this->certificado->getCertificadosCondicion($pagina,$filas, $condicion));
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacioncertificados', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarcertificadosotros', false, true);
    }

    public function plantilla_opcion($idCurso){
        // $codigo = $this->getTexto("certificado");
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));
        $this->_view->setCss(array("plantilla"));
        $this->_view->getLenguaje("index_inicio");

        $model = $this->loadModel("curso");
        $curso = $model->getCursoID($idCurso);
        $this->_view->assign("curso", $curso[0]);
        
        $plantillas=$this->certificado->getAllPlantillaCertificado($idCurso);
        $this->_view->assign('plantillas', $plantillas);
        $this->_view->assign('idCurso', $idCurso);
        $this->_view->renderizar('plantilla_opcion');
    }



    public function plantilla_certificado($idCurso){
        // $codigo = $this->getTexto("certificado");
        
        $this->_view->setTemplate(LAYOUT_FRONTEND);
       
        $this->_view->getLenguaje("index_inicio");
        // $plantillas=$this->certificado->getAllPlantillaCertificado($idCurso);

        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));
        $this->_view->setCss(array("plantilla"));

         if ($this->botonPress("bt_editarPlantilla")) {
            
            $tipo_doc=$_FILES['img']['type'];
            if($tipo_doc!=="image/jpg" && $tipo_doc!=="image/jpeg" && $tipo_doc!=="image/png"){
                echo ("<script type='text/javascript'>");
                echo ("parent.alert('Formato de Archivo Incorrecto. Solo se admiten png, jpg o jgep. Vuelva a Intentarlo' );");
                echo ("parent.location.href='agregar_silabos4.php';");
                echo ("</script>");
            }else{
                $carpeta = "modules/elearning/views/certificado/img/";
                opendir($carpeta);
                $destino = $carpeta.$_FILES["img"]["name"];
                copy($_FILES["img"]["tmp_name"],$destino);

                $plantillas=$this->certificado->getAllPlantillaCertificado($idCurso);

                foreach ($plantillas as $k) {
                    $this->certificado->cambiarSelectedPlantilla($k['Plc_IdPlantillaCertificado'],1);
                }

                $estiloAlumno="display:none;";
                $estiloCurso="display:none;";
                $estiloHoras="display:none;";
                $estiloFecha="display:none;";


                if(null !==$this->getSql('ckbNombre'))
                    $estiloAlumno=$this->getSql('estiloAlumno');

                if(null !==$this->getSql('ckbCurso'))
                    $estiloCurso=$this->getSql('estiloCurso');

                if(null !==$this->getSql('ckbDuracion'))
                    $estiloHoras=$this->getSql('estiloHoras');

                if(null !==$this->getSql('ckbFecha'))
                    $estiloFecha=$this->getSql('estiloFecha');

                $id=$this->certificado->registrarPlantillaCertificado($destino,$estiloAlumno,$estiloCurso,$estiloHoras,$estiloFecha,$idCurso);

                if($id)
                $this->redireccionar("elearning/certificado/plantilla_certificado_editar/".$id[0]);
            }
        }

        if ($this->botonPress("bt_cancelareditarPlantilla")) {   
            $this->redireccionar("elearning/certificado/plantilla_opcion/".$idCurso);
        }

        // $this->_view->assign('plantillas', $plantillas);
        $this->_view->renderizar('plantilla_certificado');
    }


    public function plantilla_certificado_editar($id){
        // $codigo = $this->getTexto("certificado");
        
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array("index"));
        $this->_view->setCss(array("plantilla"));
        $this->_view->getLenguaje("index_inicio");
        $plantilla=$this->certificado->getPlantillaCertificadoxId($id);

         if ($this->botonPress("bt_editarPlantilla")) {

                $estiloAlumno="display:none;";
                $estiloCurso="display:none;";
                $estiloHoras="display:none;";
                $estiloFecha="display:none;";


                if(null !==$this->getSql('ckbNombre'))
                    $estiloAlumno=$this->getSql('estiloAlumno');

                if(null !==$this->getSql('ckbCurso'))
                    $estiloCurso=$this->getSql('estiloCurso');

                if(null !==$this->getSql('ckbDuracion'))
                    $estiloHoras=$this->getSql('estiloHoras');

                if(null !==$this->getSql('ckbFecha'))
                    $estiloFecha=$this->getSql('estiloFecha');
            
            $tipo_doc=$_FILES['img']['type'];
            if($tipo_doc!=="image/jpg" && $tipo_doc!=="image/jpeg" && $tipo_doc!=="image/png"){
                $this->certificado->editarPlantilla($plantilla['Plc_UrlImg'],$estiloAlumno, $estiloCurso,$estiloHoras,$estiloFecha,$id);

                $this->redireccionar("elearning/certificado/plantilla_certificado_editar/".$id);

            }else{
                $carpeta = "modules/elearning/views/certificado/img/";
                opendir($carpeta);
                $destino = $carpeta.$_FILES["img"]["name"];
                copy($_FILES["img"]["tmp_name"],$destino);

                $this->certificado->editarPlantilla($destino,$estiloAlumno, $estiloCurso,$estiloHoras,$estiloFecha,$id);

                $this->redireccionar("elearning/certificado/plantilla_certificado_editar/".$id);
            }
        }

         if ($this->botonPress("bt_SeleccionarPlantilla")) {   

            $plantillas=$this->certificado->getAllPlantillaCertificado($plantilla['Cur_IdCurso']);

            foreach ($plantillas as $k) {
                $this->certificado->cambiarSelectedPlantilla($k['Plc_IdPlantillaCertificado'],1);
            }
             
            $this->certificado->cambiarSelectedPlantilla($id,0);

        }


        if ($this->botonPress("bt_EliminarPlantilla")) {   
             
            $this->certificado->eliminarPlantilla($id);
            $this->redireccionar("elearning/certificado/plantilla_opcion/".$plantilla['Cur_IdCurso']);
        }

        if ($this->botonPress("bt_cancelareditarPlantilla")) {   
            $this->redireccionar("elearning/certificado/plantilla_opcion/".$plantilla['Cur_IdCurso']);
        }

        $this->_view->assign('plantilla', $plantilla);
        $this->_view->renderizar('plantilla_certificado_editar');
    }
   
}