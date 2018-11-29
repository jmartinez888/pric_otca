<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class examenController extends elearningController {

    protected $certificado;
    protected $service;

    public function __construct($lang,$url)
    {
        parent::__construct($lang,$url);
        $this->getLibrary("ServiceResult");
        $this->service = new ServiceResult();
        $this->examen = $this->loadModel("examen");        
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

    public function examens($idcurso=false, $idLeccion = false){
        // $codigo = $this->getTexto("certificado");
        // $this->_view->setCss(array("verificar"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'),array(BASE_URL . 'modules/elearning/views/gestion/js/framework/lodash.js'),array(BASE_URL . 'modules/elearning/views/gestion/js/core/controller.js'),array(BASE_URL . 'modules/elearning/views/gestion/js/index.js'),array(BASE_URL . 'modules/elearning/views/gestion/js/core/view.js'), "index"));
        $this->_view->getLenguaje("index_inicio");

        $pagina = $this->getInt('pagina');

        //Filtro por Activos/Eliminados
        if ($idLeccion) {

            $Mmodel = $this->loadModel("_gestionModulo");
            $model = $this->loadModel("_gestionLeccion");

            $leccion = $model->getLeccionId($idLeccion);
            $modulo = $Mmodel->getModuloId($leccion["Moc_IdModuloCurso"]);
        
            $filtro = " WHERE e.Lec_IdLeccion = $idLeccion ";

            $Exa_Habilitado = $this->examen->getExamensCondicion(0,CANT_REG_PAG, " WHERE e.Lec_IdLeccion = ".$leccion["Lec_IdLeccion"]." AND e.Exa_Estado = 1 AND e.Row_Estado = 1");
            // print_r($Exa_Habilitado);
            if (count($Exa_Habilitado) > 0) {               
                $this->_view->assign('Exa_Habilitado', 1 );
            } else {                
                $this->_view->assign('Exa_Habilitado', 0 );
            }

            $this->_view->assign("modulo", $modulo);
            $this->_view->assign("leccion", $leccion);
            $this->_view->assign('idLeccion', $idLeccion);

        } else {            
            $filtro = " WHERE e.Cur_IdCurso = $idcurso ";
        }
        
        $condicion = " $filtro  ORDER BY e.Row_Estado DESC ";
        $soloActivos = 0;
        if (!$this->_acl->permiso('ver_eliminados')) {
            $soloActivos = 1;
            // $condicion = "  $filtro and e.Row_Estado = $soloActivos ";
        }

        $Cmodel = $this->loadModel("_gestionCurso");

        $curso = $Cmodel->getCursoXId($idcurso);

        $paginador = new Paginador();
        // echo "$idcurso";
        $arrayRowCount = $this->examen->getExamensRowCount($condicion);
        $this->_view->assign('examens',  $this->examen->getExamensCondicion($pagina,CANT_REG_PAG, $condicion));

        $paginador->paginar( $arrayRowCount['CantidadRegistros'],"listarexamens", "", $pagina, CANT_REG_PAG, true);

        $porcentaje=$this->examen->getExamensPorcentaje($idcurso);
        $titulo = $this->examen->getTituloCurso($idcurso);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionexamens', $paginador->getView('paginacion_ajax_s_filas'));
        // print_r($porcentaje);
        $this->_view->assign('porcentaje', $porcentaje['Porcentaje'] );
        // $this->_view->assign('titulo', 'Administracion de preguntas');
        $this->_view->assign('idcurso', $idcurso);
        // $this->_view->assign('titulo_Curso', $titulo);
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);

        $this->_view->assign("curso", $curso);

        $this->_view->renderizar('examens');
    }

    public function _cambiarEstadoExamen(){
        $this->_acl->acceso('agregar_rol');
        //Para Mensajes
        $resultado = array();
        $mensaje = "error";
        $contenido = "";
        //Para mensajes

        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $Exa_Idpregunta = $this->getInt('_Exa_IdExamen');
        $Exa_Estado = $this->getInt('_Exa_Estado');
        $Lec_IdLeccion = $this->getInt('_Lec_IdLeccion');
        // $idExamen=$this->getInt('idexamen');
        // $idcurso=$this->getInt('idcurso');
        // echo $Per_Estado."//".$Per_Idpregunta; exit;
        if(!$Exa_Idpregunta){
            $contenido = 'Error parametro ID...!!';
            $mensaje = "error";
            array_push($resultado, array(0 => $mensaje, 1 => $contenido));
        } else {
            $rowCountEstado = $this->examen->cambiarEstadoExamen($Exa_Idpregunta, $Exa_Estado);
            if ($rowCountEstado > 0) {
                if ($Exa_Estado == 1) {
                    $contenido = ' Se cambio de estado correctamente a <b>Deshabilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign" title="Deshabilitado" style="background: #FFF; color: #DD4B39; padding: 2px;"/> ...!! ';              
                }
                if ($Exa_Estado == 0) {
                     $contenido = ' Se cambio de estado correctamente a <b>Habilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign" title="Habilitado" style=" background: #FFF;  color: #088A08; padding: 2px;"/> ...!! ';
                }     
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));       
            } else {
                $contenido = 'Error de variable(s) en consulta..!!'; 
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            }        
        }
        $mensaje_json = json_encode($resultado);
        // echo($mensaje_json); exit();
        $this->_view->assign('_mensaje_json', $mensaje_json);
        $this->_buscarexamens();
    }

    public function _buscarexamens(){
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $idcurso = $this->getInt('idcurso');
        $idleccion = $this->getInt('_Lec_IdLeccion');

        $condicion = " ";
        $soloActivos = 0;
        if ($idleccion) {        
            $Mmodel = $this->loadModel("_gestionModulo");
            $model = $this->loadModel("_gestionLeccion");

            $leccion = $model->getLeccionId($idleccion);
            $modulo = $Mmodel->getModuloId($leccion["Moc_IdModuloCurso"]);
        
            $filtro = " e.Lec_IdLeccion = $idleccion ";

            $this->_view->assign("modulo", $modulo);
            $this->_view->assign("leccion", $leccion);
            $this->_view->assign('idLeccion', $idleccion);

            $Exa_Habilitado = $this->examen->getExamensCondicion(0,CANT_REG_PAG, " WHERE e.Lec_IdLeccion = ".$leccion["Lec_IdLeccion"]." AND e.Exa_Estado = 1 AND e.Row_Estado = 1");
            // print_r($Exa_Habilitado);
            if (count($Exa_Habilitado) > 0) {               
                $this->_view->assign('Exa_Habilitado', 1 );
            } else {                
                $this->_view->assign('Exa_Habilitado', 0 );
            }


        } else {            
            $filtro = " Cur_IdCurso = $idcurso ";
        }
        if ($txtBuscar) 
        {
            $condicion = "  WHERE $filtro AND Exa_Titulo liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND e.Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY e.Row_Estado DESC  ";
            }
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = "  WHERE $filtro ORDER BY e.Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = "  WHERE $filtro AND e.Row_Estado = $soloActivos ";
            }
        }         

        $paginador = new Paginador();

        $arrayRowCount = $this->examen->getExamensRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // echo($totalRegistros);
        // print_r($arrayRowCount); echo($condicion);exit;
        $porcentaje = $this->examen->getExamensPorcentaje($idcurso);
        $this->_view->assign('examens', $this->examen->getExamensCondicion($pagina,CANT_REG_PAG, $condicion));
        $this->_view->assign('porcentaje', $porcentaje['Porcentaje'] );

        $paginador->paginar( $totalRegistros ,"listarexamens", "$txtBuscar", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('idcurso', $idcurso);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionexamens', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarexamens', false, true);
    }
    public function _eliminar_examen()
    {
        // $pagina = $this->getInt('pagina');
        // $filas=$this->getInt('filas');
        // $idcurso=$this->getInt('idcurso');
        // $totalRegistros = $this->getInt('total_registros');
        // $idleccion = $this->getInt('idleccion');

        //Para Mensajes
        $resultado = array();
        $mensaje = "error";
        $contenido = "";
        //Para mensajes

        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $Exa_Idpregunta = $this->getInt('_Exa_IdExamen');
        $Exa_Estado = $this->getInt('_Row_Estado');
        $idleccion = $this->getInt('_Lec_IdLeccion');
        // $idExamen=$this->getInt('idexamen');
        $idcurso = $this->getInt('idcurso');
        // echo $Per_Estado."//".$Per_Idpregunta; exit;
        if(!$Exa_Idpregunta){
            $contenido = 'Error parametro ID...!!';
            $mensaje = "error";
            array_push($resultado, array(0 => $mensaje, 1 => $contenido));
        } else {
            $rowCountEstado = $this->examen->eliminarHabilitarexamen($Exa_Idpregunta, $Exa_Estado);
            if ($rowCountEstado > 0) {
                if ($Exa_Estado == 1) {
                    $contenido = ' Se cambio de estado correctamente a <b>Deshabilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign" title="Deshabilitado" style="background: #FFF; color: #DD4B39; padding: 2px;"/> ...!! ';              
                }
                if ($Exa_Estado == 0) {
                     $contenido = ' Se cambio de estado correctamente a <b>Habilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign" title="Habilitado" style=" background: #FFF;  color: #088A08; padding: 2px;"/> ...!! ';
                }     
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));       
            } else {
                $contenido = 'Error de variable(s) en consulta..!!'; 
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            }        
        }
        $mensaje_json = json_encode($resultado);
        // echo($mensaje_json); exit();
        $this->_view->assign('_mensaje_json', $mensaje_json);

        $condicion = " ";
        $soloActivos = 0;
        // $nombre = $this->getSql('palabra');
        if ($idleccion) {        
            $Mmodel = $this->loadModel("_gestionModulo");
            $model = $this->loadModel("_gestionLeccion");

            $leccion = $model->getLeccionId($idleccion);
            $modulo = $Mmodel->getModuloId($leccion["Moc_IdModuloCurso"]);
        
            $filtro = " e.Lec_IdLeccion = $idleccion ";

            $this->_view->assign("modulo", $modulo);
            $this->_view->assign("leccion", $leccion);
            $this->_view->assign('idLeccion', $idleccion);

            $Exa_Habilitado = $this->examen->getExamensCondicion(0,CANT_REG_PAG, " WHERE e.Lec_IdLeccion = ".$leccion["Lec_IdLeccion"]." AND e.Exa_Estado = 1 AND e.Row_Estado = 1");
            // print_r($Exa_Habilitado);
            if (count($Exa_Habilitado) > 0) {               
                $this->_view->assign('Exa_Habilitado', 1 );
            } else {                
                $this->_view->assign('Exa_Habilitado', 0 );
            }


        } else {            
            $filtro = " Cur_IdCurso = $idcurso ";
        }
        if ($txtBuscar) 
        {
            $condicion = "  WHERE $filtro AND Exa_Titulo liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND e.Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY e.Row_Estado DESC  ";
            }
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = "  WHERE $filtro ORDER BY e.Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = "  WHERE $filtro AND e.Row_Estado = $soloActivos ";
            }
        }         

        $paginador = new Paginador();

        $arrayRowCount = $this->examen->getExamensRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // $arrayRowCount = $this->_aclm->getpreguntasRowCount$arrayRowCount = 0,($condicion);
        $porcentaje = $this->examen->getExamensPorcentaje($idcurso);
        $paginador->paginar( $totalRegistros,"listarexamens", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('examens', $this->examen->getExamensCondicion($pagina,$filas, $condicion));
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('porcentaje', $porcentaje['Porcentaje'] );
        $this->_view->assign('idcurso', $idcurso);
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacionexamens', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarexamens', false, true);
    }

    public function _paginacion_listarexamens($txtBuscar = false){
        //$this->validarUrlIdioma();
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $idcurso=$this->getInt('idcurso');
        $totalRegistros = $this->getInt('total_registros');
        $idleccion = $this->getInt('idleccion');

        $condicion = " ";
        $soloActivos = 0;
        // $nombre = $this->getSql('palabra');
        if ($idleccion) {        
            $Mmodel = $this->loadModel("_gestionModulo");
            $model = $this->loadModel("_gestionLeccion");

            $leccion = $model->getLeccionId($idleccion);
            $modulo = $Mmodel->getModuloId($leccion["Moc_IdModuloCurso"]);
        
            $filtro = " e.Lec_IdLeccion = $idleccion ";

            $this->_view->assign("modulo", $modulo);
            $this->_view->assign("leccion", $leccion);
            $this->_view->assign('idLeccion', $idleccion);

            $Exa_Habilitado = $this->examen->getExamensCondicion(0,CANT_REG_PAG, " WHERE e.Lec_IdLeccion = ".$leccion["Lec_IdLeccion"]." AND e.Exa_Estado = 1 AND e.Row_Estado = 1");
            // print_r($Exa_Habilitado);
            if (count($Exa_Habilitado) > 0) {               
                $this->_view->assign('Exa_Habilitado', 1 );
            } else {                
                $this->_view->assign('Exa_Habilitado', 0 );
            }


        } else {            
            $filtro = " Cur_IdCurso = $idcurso ";
        }
        if ($txtBuscar) 
        {
            $condicion = "  WHERE $filtro AND Exa_Titulo liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND e.Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY e.Row_Estado DESC  ";
            }
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = "  WHERE $filtro ORDER BY e.Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = "  WHERE $filtro AND e.Row_Estado = $soloActivos ";
            }
        }         


        $paginador = new Paginador();
        // $arrayRowCount = $this->_aclm->getpreguntasRowCount$arrayRowCount = 0,($condicion);
        $porcentaje = $this->examen->getExamensPorcentaje($idcurso);
        $paginador->paginar( $totalRegistros,"listarexamens", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('examens', $this->examen->getExamensCondicion($pagina,$filas, $condicion));
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('porcentaje', $porcentaje['Porcentaje'] );
        $this->_view->assign('idcurso', $idcurso);
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacionexamens', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarexamens', false, true);
    }

    public function nuevoexamen($id = 0, $idLeccion = false){
        // $this->_view->setCss(array("verificar"));
        // $id = $this->getTexto("id");
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));

        if(strlen($id)==0){ $id = Session::get("learn_param_curso"); }
        if(strlen($id)==0){ exit; }
        Session::set("learn_url_tmp", "examen/nuevoexamen");
        Session::set("learn_param_curso", $id);

        if ($idLeccion) {
            // $filtro = " WHERE e.Lec_IdLeccion = $idLeccion ";
            $titulo = $this->examen->getTituloCurso($id);
            $leccion = $this->examen->getLeccionXId($idLeccion);
            $Exa_Porcentaje = $this->examen->getExamenesPorcentaje($id);
            $Tra_Porcentaje = $this->examen->getTrabajosPorcentaje($id);
            $Porcentaje = 100 - $Exa_Porcentaje['Exa_PorcentajeTotal'] - $Tra_Porcentaje['Tra_PorcentajeTotal'];
            // print_r($leccion);
            $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
            // $this->_view->assign('modulos', $this->examen->getModulos($id));
            $this->_view->assign('idLeccion', $idLeccion);
            $this->_view->assign('porcentaje', $Porcentaje);
            $this->_view->assign('lecciones', $this->examen->getLecciones($leccion["Moc_IdModuloCurso"]));
            $this->_view->assign('leccion', $leccion);

        } else {            
            // $filtro = " WHERE e.Cur_IdCurso = $idcurso ";
        }

        // $lecciones=$this->examen->getLecciones($id);

        $modulos = $this->examen->getModulos($id);

        if ($this->botonPress("guardar")) {

            $examen = $this->examen->insertExamen($id,$this->getSql("selectmodulo"), $this->getSql("titulo"), $this->getSql("porcentaje"), $this->getSql("puntaje"),  $this->getSql("intentos"), $this->getInt("selectleccion"));

            if($examen){
                $this->redireccionar('elearning/examen/preguntas/'.$id.'/'.$examen[0]);
            }
        }

        // echo "string".$id;
        // print_r($this->examen->getTituloCurso($id));
        $titulo = $this->examen->getTituloCurso($id);
        
        // $this->_view->assign('lecciones',$lecciones);
        $this->_view->assign('modulos',$modulos);
        $this->_view->assign('idcurso', $id);
        // $this->_view->assign('titulo_Curso', $titulo);
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->renderizar('nuevoexamen', 'elearning');
    }

    public function editarexamen($id, $idExamen){
        // $this->_view->setCss(array("verificar"));
        // $id = $this->getTexto("id");
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));

        if(strlen($id)==0){ $id = Session::get("learn_param_curso"); }
        if(strlen($id)==0){ exit; }
        Session::set("learn_url_tmp", "examen/editarexamen");
        Session::set("learn_param_curso", $id);
        // $lecciones=$this->examen->getLecciones($id);

        $modulos=$this->examen->getModulos($id);

        if ($this->botonPress("guardarEdit")) {
            $examen = $this->examen->editExamen($id,$this->getSql("selectmodulo"), $this->getSql("titulo"), $this->getSql("porcentaje"), $this->getSql("puntaje"),  $this->getSql("intentos"), $this->getInt("selectleccion"), $idExamen);
            if($examen){
                $this->redireccionar('elearning/examen/preguntas/'.$id.'/'.$idExamen);
            }
        }

        $titulo = $this->examen->getTituloCurso($id);
        $examen = $this->examen->getExamen($idExamen);
        $Exa_Porcentaje = $this->examen->getExamenesPorcentaje($id);
        $Tra_Porcentaje = $this->examen->getTrabajosPorcentaje($id);
        $Porcentaje = 100 - $Exa_Porcentaje['Exa_PorcentajeTotal'] - $Tra_Porcentaje['Tra_PorcentajeTotal'] + $examen['Exa_Porcentaje'];
        // echo $Porcentaje.'//'.$Exa_Porcentaje['Exa_PorcentajeTotal'].'//'.$Tra_Porcentaje['Tra_PorcentajeTotal'].'//'.$examen['Exa_Porcentaje']
        // ; 

        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->assign('modulos', $modulos);
        $this->_view->assign('examen', $examen);
        $this->_view->assign('porcentaje', $Porcentaje);
        $this->_view->assign('lecciones', $this->examen->getLecciones($examen['Moc_IdModulo']));
        $this->_view->assign('idcurso', $id);
        $this->_view->renderizar('editarexamen', 'elearning');
    }
    
    public function actualizarlecciones(){
        $idModulo = $this->getInt('id');
        $idCurso = $this->getInt('idCurso');

        $Exa_Porcentaje = $this->examen->getExamenesPorcentaje($idCurso);
        $Tra_Porcentaje = $this->examen->getTrabajosPorcentaje($idCurso);
        $Porcentaje = 100 - $Exa_Porcentaje['Exa_PorcentajeTotal'] - $Tra_Porcentaje['Tra_PorcentajeTotal'];

        $this->_view->assign('porcentaje',$Porcentaje);

        $this->_view->assign('lecciones', $this->examen->getLecciones($idModulo));

        $this->_view->renderizar('ajax/listarlecciones', false, true);
    }

    public function preguntas($id,$idExamen){
        // $id = $this->getTexto("id");
        // $idLeccion = $this->getTexto("idleccion");
        if(strlen($id)==0){ $id = Session::get("learn_param_curso"); }
        if(strlen($id)==0){ exit; }
        Session::set("learn_url_tmp", "examen/preguntas");
        Session::set("learn_param_curso", $id);
        // $codigo = $this->getTexto("certificado");
        // $this->_view->setCss(array("verificar"));

        // $idExamen = $this->getTexto("id");
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), array(BASE_URL . 'modules/elearning/views/gestion/js/core/controller.js'), array(BASE_URL . 'modules/elearning/views/gestion/js/core/view.js'), "index"));

        // url
        $Examen = $this->examen->getExamenID($idExamen);
        $Mmodel = $this->loadModel("_gestionModulo");
        $model = $this->loadModel("_gestionLeccion");
        $leccion = $model->getLeccionId($Examen["Lec_IdLeccion"]);
        $modulo = $Mmodel->getModuloId($Examen["Moc_IdModulo"]);
        $this->_view->assign("modulo", $modulo);
        $this->_view->assign("leccion", $leccion);
        $this->_view->assign('idLeccion', $Examen["Lec_IdLeccion"]);
            // url

        $this->_view->getLenguaje("index_inicio");
        $pagina = $this->getInt('pagina');

        // if(strlen($idExamen)==0){ $idExamen = Session::get("learn_param_curso"); }
        // if(strlen($idExamen)==0){ exit; }
        // Session::set("learn_url_tmp", "examen/examens");
        // Session::set("learn_param_curso", $idExamen);

        // $idExamen = $this->examen->getIdExamen($idLeccion);
        // $idExamen =$idExamen['Exa_IdExamen'];
        //Filtro por Activos/Eliminados
        $condicion = " WHERE Exa_IdExamen = $idExamen ORDER BY Row_Estado DESC ";
        $soloActivos = 0;
        if (!$this->_acl->permiso('ver_eliminados')) {
            $soloActivos = 1;
            $condicion = " WHERE Exa_IdExamen = $idExamen AND Row_Estado = $soloActivos ";
        }

        $paginador = new Paginador();

        $arrayRowCount = $this->examen->getPreguntasRowCount($condicion);
        $this->_view->assign('preguntas',  $this->examen->getPreguntasCondicion($pagina,CANT_REG_PAG, $condicion));

        $paginador->paginar( $arrayRowCount['CantidadRegistros'],"listarpreguntas", "", $pagina, CANT_REG_PAG, true);

        $peso = $this->examen->getExamenPeso($idExamen);
        $puntos_pregunta = $this->examen->getPuntosPregunta($idExamen);
        $puntos_maximo = $peso['Exa_Peso'] - $puntos_pregunta['puntos_pregunta'];
        // echo $puntos_pregunta['puntos_pregunta']; exit;
        if ($peso['Exa_Estado'] == 0 && $puntos_maximo == 0) {
            $habilitaExamen = $this->examen->updateExamen($idExamen);
        }         

        $titulo =  $this->examen->getTituloCurso($id);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionpreguntas', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->assign('puntos_maximo', $puntos_maximo);
        // $this->_view->assign('titulo', 'Administracion de preguntas');
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->assign('examen', $idExamen);
        $this->_view->assign('idcurso', $id);
        $this->_view->renderizar('preguntas', 'preguntas');
    }

    public function _paginacion_listarpreguntas($txtBuscar = false) 
    {
        //$this->validarUrlIdioma();
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $idExamen=$this->getInt('idexamen');
        $totalRegistros = $this->getInt('total_registros');

        $condicion = " ";
        $soloActivos = 0;
        // $nombre = $this->getSql('palabra');
        if ($txtBuscar) 
        {
            $condicion = " WHERE Exa_IdExamen = $idExamen AND Pre_Descripcion liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY Row_Estado DESC  ";
            }
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " WHERE Exa_IdExamen = $idExamen ORDER BY Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE Exa_IdExamen = $idExamen AND Row_Estado = $soloActivos ";
            }
        }         

        $paginador = new Paginador();
        // $arrayRowCount = $this->_aclm->getpreguntasRowCount$arrayRowCount = 0,($condicion);

        $paginador->paginar( $totalRegistros,"listarpreguntas", "$txtBuscar", $pagina, $filas, true);

        $peso= $this->examen->getExamenPeso($idExamen);
        $puntos_pregunta= $this->examen->getPuntosPregunta($idExamen);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];
        $this->_view->assign('puntos_maximo', $puntos_maximo);

        $this->_view->assign('preguntas', $this->examen->getPreguntasCondicion($pagina,$filas, $condicion));
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacionpreguntas', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarpreguntas', false, true);
    }

    public function _cambiarEstadopreguntas(){
        $this->_acl->acceso('agregar_rol');
        // $this->_view->setJs(array(array(BASE_URL . 'public/js/util.js',true)));

        //Para Mensajes
        $resultado = array();
        $mensaje = "error";
        $contenido = "";
        //Para mensajes

        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $Mod_Idpregunta = $this->getInt('_Mod_Idpregunta');
        $Mod_Estado = $this->getInt('_Mod_Estado');
        $idExamen=$this->getInt('idexamen');
        $idcurso=$this->getInt('idcurso');
        // echo $Per_Estado."//".$Per_Idpregunta; exit;

        if(!$Mod_Idpregunta){            
            $contenido = 'Error parametro ID ..!!'; 
            $mensaje = "error";
            array_push($resultado, array(0 => $mensaje, 1 => $contenido));            
        } else {
            $rowCountEstado = $this->examen->cambiarEstadopreguntas($Mod_Idpregunta, $Mod_Estado);
            if ($rowCountEstado > 0) {
                if ($Mod_Estado == 1) {
                    $contenido = ' Se cambio de estado correctamente a <b>Deshabilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign" title="Deshabilitado" style="background: #FFF; color: #DD4B39; padding: 2px;"/> ...!! ';              
                }
                if ($Mod_Estado == 0) {
                     $contenido = ' Se cambio de estado correctamente a <b>Habilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign" title="Habilitado" style=" background: #FFF;  color: #088A08; padding: 2px;"/> ...!! ';
                }     
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));       
            } else {
                $contenido = 'Error de variable(s) en consulta..!!'; 
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            }        
        }
        $mensaje_json = json_encode($resultado);
        // echo($mensaje_json); exit();
        $this->_view->assign('_mensaje_json', $mensaje_json);

        $condicion = " ";
        $soloActivos = 0;
        if ($txtBuscar) 
        {
            $condicion = " WHERE Exa_IdExamen = $idExamen AND Pre_Descripcion liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY Row_Estado DESC  ";
            }
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " WHERE Exa_IdExamen = $idExamen ORDER BY Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE Exa_IdExamen = $idExamen AND Row_Estado = $soloActivos ";
            }
        }         

        $paginador = new Paginador();

        $arrayRowCount = $this->examen->getPreguntasRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        $this->_view->assign('preguntas', $this->examen->getPreguntasCondicion($pagina,$filas, $condicion));

        $paginador->paginar( $totalRegistros ,"listarpreguntas", "$txtBuscar", $pagina, $filas, true);

        $peso= $this->examen->getExamenPeso($idExamen);
        $puntos_pregunta= $this->examen->getPuntosPregunta($idExamen);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];
        $this->_view->assign('puntos_maximo', $puntos_maximo);
        $this->_view->assign('idcurso', $idcurso);
        $this->_view->assign('examen',$idExamen);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionpreguntas', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarpreguntas', false, true);
    }
   
    public function _buscarpregunta() 
    {
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
         $idExamen=$this->getInt('idexamen');

        $condicion = " ";
        $soloActivos = 0;
        if ($txtBuscar) 
        {
            $condicion = " WHERE Exa_IdExamen = $idExamen AND Pre_Descripcion liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY Row_Estado DESC  ";
            }
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " WHERE Exa_IdExamen = $idExamen ORDER BY Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE Exa_IdExamen = $idExamen AND Row_Estado = $soloActivos ";
            }
        }         

        $paginador = new Paginador();

        $arrayRowCount = $this->examen->getPreguntasRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // echo($totalRegistros);
        // print_r($arrayRowCount); echo($condicion);exit;
        $this->_view->assign('preguntas', $this->examen->getPreguntasCondicion($pagina,CANT_REG_PAG, $condicion));

        $paginador->paginar( $totalRegistros ,"listarpreguntas", "$txtBuscar", $pagina, CANT_REG_PAG, true);
        $peso= $this->examen->getExamenPeso($idExamen);
        $puntos_pregunta= $this->examen->getPuntosPregunta($idExamen);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];
        $this->_view->assign('puntos_maximo', $puntos_maximo);

        $this->_view->assign('examen',$idExamen);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionpreguntas', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarpreguntas', false, true);
    }

    public function _eliminar_pregunta()
    {
        $this->_acl->acceso('agregar_rol');
        //Variables Ajax_Javascript
        $Mod_Idpregunta = $this->getInt('_Mod_Idpregunta');
        $Row_Estado = $this->getInt('_Row_Estado');
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $idExamen=$this->getInt('idexamen');

        //Para Mensajes
        $resultado = array();
        $mensaje = "error";
        $contenido = "";
        //Para mensajes

        if ($Row_Estado == 0) {
            if(!$Mod_Idpregunta)
            {            
                $contenido = 'Error parametro ID ..!!'; 
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));          
            } else {
                $rowCount = $this->examen->eliminarHabilitarpregunta($Mod_Idpregunta,$Row_Estado);
                if($rowCount)
                {
                    $contenido = 'El pregunta fue eliminado correctamente...!!!'; 
                    $mensaje = "ok";
                    array_push($resultado, array(0 => $mensaje, 1 => $contenido));
                } else {
                    $contenido = 'No se pudo eliminar pregunta error en consulta...!!!'; 
                    $mensaje = "error";
                    array_push($resultado, array(0 => $mensaje, 1 => $contenido));
                }                           
            }
        } else {
            $rowCount = $this->examen->eliminarHabilitarpregunta($Mod_Idpregunta,$Row_Estado);
            
            if($rowCount)
            {
                $contenido = 'El pregunta fue activado correctamente...!!!'; 
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            } else {
                $contenido = 'No se pudo activar pregunta, error en variable(s) de consulta...!!!'; 
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            }
        }

        $mensaje_json = json_encode($resultado);
        $this->_view->assign('_mensaje_json', $mensaje_json);

        $condicion = " ";
        $soloActivos = 0;
        if ($txtBuscar) 
        {
            $condicion = " WHERE Exa_IdExamen = $idExamen AND Pre_Descripcion liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY Row_Estado DESC  ";
            }
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " WHERE Exa_IdExamen = $idExamen ORDER BY Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE Exa_IdExamen = $idExamen AND Row_Estado = $soloActivos ";
            }
        }         

        $paginador = new Paginador();

        $arrayRowCount = $this->examen->getPreguntasRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        $this->_view->assign('preguntas', $this->examen->getPreguntasCondicion($pagina,$filas, $condicion));

        $paginador->paginar( $totalRegistros ,"listarpreguntas", "$txtBuscar", $pagina, $filas, true);

        $peso= $this->examen->getExamenPeso($idExamen);
        $puntos_pregunta= $this->examen->getPuntosPregunta($idExamen);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];
        $this->_view->assign('puntos_maximo', $puntos_maximo);

        $this->_view->assign('examen',$idExamen);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionpreguntas', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarpreguntas', false, true);
    }
    
    public function registrarRespuestaUnica($idExamen, $id){
        // $this->_view->setCss(array("verificar"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));

        if(strlen($id)==0){ $id = Session::get("learn_param_curso"); }
        if(strlen($id)==0){ exit; }
        Session::set("learn_url_tmp", "examen/registrarRespuestaUnica");
        Session::set("learn_param_curso", $id);

        $peso= $this->examen->getExamenPeso($idExamen);
        $puntos_pregunta= $this->examen->getPuntosPregunta($idExamen);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];

        if ($this->botonPress("btn_registrar_pregunta")) {
            $pregunta = $this->getSql("in_pregunta");
            $valor = $this->getTexto("valor_preg");
            $contador = $this->getTexto("contador");
            $cont=1;

            for($i=1;$i<=$contador;$i++){
                if($this->getSql("alt".$i)!=null){
                    $cont++;

                    if($i==$valor)
                        break;
                }
            }

            $pregunta =$this->examen->insertPregunta($idExamen, $pregunta, $cont, 1, null,  $this->getInt("puntos"));

            if($pregunta){

                $alternativa=0;
                $j=1;

                for($i=1;$i<=$contador;$i++)

                if($this->getSql("alt".$i)!=null){
                    $alternativa =$this->examen->insertAlternativa($pregunta[0], $j, $this->getSql("alt".$i),0,0);
                    $j++;
                }
                
                if($alternativa)
                    $this->redireccionar("elearning/examen/preguntas/$id/$idExamen");
            }
        }
       
        $titulo =  $this->examen->getTituloCurso($id);
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->assign('puntos_maximo', $puntos_maximo );
        $this->_view->assign('examen', $idExamen );
        $this->_view->assign('idcurso', $id);
        $this->_view->renderizar('respuestaunica', 'respuestaunica');
    }

    public function editarRespuestaUnica($id, $idcurso){
        // $this->_view->setCss(array("verificar"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));

        if(strlen($idcurso)==0){ $idcurso = Session::get("learn_param_curso"); }
        if(strlen($idcurso)==0){ exit; }
        Session::set("learn_url_tmp", "examen/registrarRespuestaUnica");
        Session::set("learn_param_curso", $idcurso);


        $alternativas =$this->examen->getAlternativas($id);

        $preguntaedit =$this->examen->getValorPregunta($id);


        if ($this->botonPress("btn_registrar_pregunta")) {

            $countrpta=$this->examen->deleteAlternativa($id);
            $pregunta = $this->getSql("in_pregunta");
            $valor = $this->getTexto("valor_preg");
            $contador = $this->getTexto("contador");
            $cont=0;

            for($i=1;$i<=$contador;$i++){
                if($this->getSql("alt".$i)!=null){
                    $cont++;

                    if($i==$valor)
                        break;
                }
            }

            $pregunta =$this->examen->updatePregunta($id, $pregunta, $cont, $this->getInt("puntos"));

            if($pregunta){

                $alternativa=0;
                $j=1;

                for($i=1;$i<=$contador;$i++)

                if($this->getSql("alt".$i)!=null){
                    $alternativa =$this->examen->insertAlternativa($id, $j, $this->getSql("alt".$i),0,0);
                    $j++;
                }
                
                if($alternativa)
                    $this->redireccionar("elearning/examen/preguntas/$idcurso/".$preguntaedit['Exa_IdExamen']);
            }
        }

        $peso= $this->examen->getExamenPeso($preguntaedit['Exa_IdExamen']);
        $puntos_pregunta= $this->examen->getPuntosPregunta($preguntaedit['Exa_IdExamen']);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];


        $titulo =  $this->examen->getTituloCurso($idcurso);
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->assign('puntos_maximo', $puntos_maximo );
        $this->_view->assign('examen', $preguntaedit['Exa_IdExamen'] );
        $this->_view->assign('idcurso', $idcurso);

        $this->_view->assign('alternativas', $alternativas);
         $this->_view->assign('nextinput', count($alternativas)+1);
        $this->_view->assign('preguntaedit', $preguntaedit);
        $this->_view->renderizar('editarrespuestaunica');
    }

    public function registrarRespuestaMultiple($idExamen, $id){
        // $this->_view->setCss(array("verificar"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));
        if(strlen($id)==0){ $id = Session::get("learn_param_curso"); }
        if(strlen($id)==0){ exit; }
        Session::set("learn_url_tmp", "examen/registrarRespuestaUnica");
        Session::set("learn_param_curso", $id);

        $peso= $this->examen->getExamenPeso($idExamen);
        $puntos_pregunta= $this->examen->getPuntosPregunta($idExamen);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];

        if ($this->botonPress("btn_registrar_pregunta")) {
            $pregunta = $this->getSql("in_pregunta");
            $contador = $this->getTexto("contador");

            $pregunta =$this->examen->insertPregunta($idExamen, $pregunta, 0, 2, null, $this->getInt("puntos"));

            if($pregunta){

                $alternativa=0;
                $j=1;
                $total=0;

                for($i=1;$i<=$contador;$i++){
                    if($this->getSql("ckb".$i)!=null)
                        $total++;
                }

                for($i=1;$i<=$contador;$i++)

                if($this->getSql("alt".$i)!=null){

                    if($this->getSql("ckb".$i)!=null)
                    $alternativa =$this->examen->insertAlternativa($pregunta[0], $j, $this->getSql("alt".$i),0,1,$this->getInt("puntos")/$total);

                else
                    $alternativa =$this->examen->insertAlternativa($pregunta[0], $j, $this->getSql("alt".$i),0,0,0);
                    $j++;
                }
                
                if($alternativa)
                    $this->redireccionar("elearning/examen/preguntas/$id/$idExamen");
            }
        }
        
        $titulo =  $this->examen->getTituloCurso($id);
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->assign('puntos_maximo', $puntos_maximo );
        $this->_view->assign('examen', $idExamen );
        $this->_view->assign('idcurso', $id);
        $this->_view->renderizar('respuestamultiple', 'elearning');
    }

    public function editarRespuestaMultiple($id, $idcurso){
        // $this->_view->setCss(array("verificar"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));

        $alternativas =$this->examen->getAlternativas($id);

        $preguntaedit =$this->examen->getValorPregunta($id);


        if ($this->botonPress("btn_registrar_pregunta")) {

            $countrpta=$this->examen->deleteAlternativa($id);
            $pregunta = $this->getSql("in_pregunta");
            $contador = $this->getTexto("contador");

            $pregunta =$this->examen->updatePregunta($id, $pregunta, 0,$this->getInt("puntos"));

             if($pregunta){

                $alternativa=0;
                $j=1;

                $total=0;

                for($i=1;$i<=$contador;$i++){
                    if($this->getSql("ckb".$i)!=null)
                        $total++;
                }

                for($i=1;$i<=$contador;$i++)

                if($this->getSql("alt".$i)!=null){

                    if($this->getSql("ckb".$i)!=null)
                    $alternativa =$this->examen->insertAlternativa($id, $j, $this->getSql("alt".$i),0,1,$this->getInt("puntos")/$total);

                else
                    $alternativa =$this->examen->insertAlternativa($id, $j, $this->getSql("alt".$i),0,0,0);
                    $j++;
                }
                
                if($alternativa)
                     $this->redireccionar("elearning/examen/preguntas/$idcurso/".$preguntaedit['Exa_IdExamen']);
            }

        }

        $peso= $this->examen->getExamenPeso($preguntaedit['Exa_IdExamen']);
        $puntos_pregunta= $this->examen->getPuntosPregunta($preguntaedit['Exa_IdExamen']);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];

        $titulo =  $this->examen->getTituloCurso($id);
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->assign('puntos_maximo', $puntos_maximo );
        $this->_view->assign('examen', $preguntaedit['Exa_IdExamen'] );
        $this->_view->assign('idcurso', $idcurso);
        $this->_view->assign('alternativas', $alternativas);
        $this->_view->assign('nextinput', count($alternativas)+1);
        $this->_view->assign('preguntaedit', $preguntaedit);
        $this->_view->renderizar('editarrespuestamultiple');
    }

    public function registrarRespuestaBlanco($idExamen, $id){
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));
        if(strlen($id)==0){ $id = Session::get("learn_param_curso"); }
        if(strlen($id)==0){ exit; }
        Session::set("learn_url_tmp", "examen/registrarRespuestaUnica");
        Session::set("learn_param_curso", $id);

        $peso= $this->examen->getExamenPeso($idExamen);
        $puntos_pregunta= $this->examen->getPuntosPregunta($idExamen);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];

        if ($this->botonPress("btn_registrar_pregunta")) {
            $pregunta = $this->getSql("in_pregunta");
            $pregunta2 =" ". $this->getSql("in_pregunta4");

            $pregunta =$this->examen->insertPregunta($idExamen, $pregunta, 0, 3, $pregunta2, $this->getInt("puntos") );

             if($pregunta){

                $alternativa=0;
                $arrayalt=explode('|', $pregunta2);

                $j=1;

                for ($i=0; $i < count($arrayalt); $i++) { 
                    if($i%2!=0 && $i!=count($arrayalt)-1){
                        $alternativa =$this->examen->insertAlternativa($pregunta[0], $i, $arrayalt[$i] ,0,0, $this->getInt("puntos".$j));
                    }
                }

                if($alternativa)
                    $this->redireccionar("elearning/examen/preguntas/$id/$idExamen");
            }
            
        }
        
        $titulo =  $this->examen->getTituloCurso($id);
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->assign('puntos_maximo', $puntos_maximo );
        $this->_view->assign('examen', $idExamen );
        $this->_view->assign('idcurso', $id);
        $this->_view->renderizar('respuestablanco', 'elearning');
    }

    public function editarRespuestaBlanco($id, $idcurso){
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));

        $alternativas =$this->examen->getAlternativas($id);

        $preguntaedit =$this->examen->getValorPregunta($id);

        if ($this->botonPress("btn_registrar_pregunta")) {
            // dd($_POST);
            $pregunta = $this->getSql("in_pregunta");
            $pregunta2 = " ". $this->getSql("in_pregunta4");

            $countrpta=$this->examen->deleteAlternativa($id);

            $pregunta = $this->examen->updatePregunta2($id, $pregunta,$pregunta2, 0,$this->getInt("puntos"));

            if($pregunta){
                $alternativa=0;
                $arrayalt=explode('|', $pregunta2);
                // $j=1;
                $t = 1;
                for ($i=0; $i < count($arrayalt); $i++) {
                    if($i%2!=0 && $i!=count($arrayalt)-1){
                        //echo($this->getInt("puntos".$t++));
                        $alternativa =$this->examen->insertAlternativa($id, $t, $arrayalt[$i],0,0, $this->getInt("puntos".$t));
                        $t++;
                    }
                }          
                //exit;
                if($alternativa)
                     $this->redireccionar("elearning/examen/preguntas/$idcurso/".$preguntaedit['Exa_IdExamen']);
            }
        }

        $peso= $this->examen->getExamenPeso($preguntaedit['Exa_IdExamen']);
        $puntos_pregunta= $this->examen->getPuntosPregunta($preguntaedit['Exa_IdExamen']);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];
        
        $titulo =  $this->examen->getTituloCurso($idcurso);
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->assign('puntos_maximo', $puntos_maximo );
        $this->_view->assign('examen', $preguntaedit['Exa_IdExamen']);
        $this->_view->assign('idcurso', $idcurso);

        $this->_view->assign('alternativas', $alternativas);
        $this->_view->assign('nextinput', count($alternativas)+1);
        $this->_view->assign('preguntaedit', $preguntaedit);
        $this->_view->renderizar('editarrespuestablanco', 'elearning');
    }

    public function registrarRespuestaRelacionar($idExamen, $id){
        // $this->_view->setCss(array("verificar"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));
        if(strlen($id)==0){ $id = Session::get("learn_param_curso"); }
        if(strlen($id)==0){ exit; }
        Session::set("learn_url_tmp", "examen/registrarRespuestaUnica");
        Session::set("learn_param_curso", $id);
        $peso= $this->examen->getExamenPeso($idExamen);
        $puntos_pregunta= $this->examen->getPuntosPregunta($idExamen);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];

        if ($this->botonPress("btn_registrar_pregunta")) {
            $pregunta = $this->getSql("in_pregunta");
            // $valor = $this->getTexto("valor_preg");
            $contador = $this->getTexto("contador");
          
            $pregunta =$this->examen->insertPregunta($idExamen, $pregunta, 0, 4, null,  $this->getInt("puntos") );

            if($pregunta){

                $alternativa=0;
                $j=1;

                for($i=1;$i<=$contador;$i++)

                if($this->getSql("enu".$i)!=null){

                    $alternativa =$this->examen->insertAlternativa($pregunta[0], $j, $this->getSql("enu".$i),0,1, $this->getInt("puntos")/$contador);
                    $alternativa2 =$this->examen->insertAlternativa($pregunta[0], $j, $this->getSql("rpta".$i),$alternativa[0],1);

                    $this->examen->updateRelacionAlternativa($alternativa[0], $alternativa2[0]);

                    $j++;
                }
                
                if($alternativa)
                    $this->redireccionar("elearning/examen/preguntas/$id/$idExamen");
            }
        }
       
        $titulo =  $this->examen->getTituloCurso($id);
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->assign('puntos_maximo', $puntos_maximo );
        $this->_view->assign('examen', $idExamen );
        $this->_view->assign('idcurso', $id);
        $this->_view->renderizar('respuestarelacionar', 'elearning');
    }

    public function editarRespuestaRelacionar($id, $idcurso){
        // $this->_view->setCss(array("verificar"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));
        $alternativas =$this->examen->getAlternativas($id);
        $preguntaedit =$this->examen->getValorPregunta($id);

        if ($this->botonPress("btn_registrar_pregunta")) {
            $countrpta=$this->examen->deleteAlternativa($id);
            $pregunta = $this->getSql("in_pregunta");
            $contador = $this->getTexto("contador");

            $pregunta =$this->examen->updatePregunta($id, $pregunta, 0,  $this->getInt("puntos"));

            if($pregunta){
                $alternativa=0;
                $j=1;
                for($i=1;$i<=$contador;$i++)
                if($this->getSql("enu".$i)!=null){
                    $alternativa =$this->examen->insertAlternativa($id, $j, $this->getSql("enu".$i),0,1,$this->getInt("puntos")/$contador);
                    $alternativa2 =$this->examen->insertAlternativa($id, $j, $this->getSql("rpta".$i),$alternativa[0],1);

                    $this->examen->updateRelacionAlternativa($alternativa[0], $alternativa2[0]);
                    $j++;
                }
                
                if($alternativa)
                     $this->redireccionar("elearning/examen/preguntas/$idcurso/".$preguntaedit['Exa_IdExamen']);
            }
        }

        $peso= $this->examen->getExamenPeso($preguntaedit['Exa_IdExamen']);
        $puntos_pregunta= $this->examen->getPuntosPregunta($preguntaedit['Exa_IdExamen']);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];
        
        $titulo =  $this->examen->getTituloCurso($idcurso);
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->assign('puntos_maximo', $puntos_maximo );
        $this->_view->assign('examen', $preguntaedit['Exa_IdExamen']);
        $this->_view->assign('idcurso', $idcurso);
        $this->_view->assign('alternativas', $alternativas);
        $this->_view->assign('nextinput', (count($alternativas)/2)+1);
        $this->_view->assign('preguntaedit', $preguntaedit);
        $this->_view->renderizar('editarrespuestarelacionar');
    }

    public function registrarRespuestaAbierta($idExamen, $id){
        // $this->_view->setCss(array("verificar"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));

        if(strlen($id)==0){ $id = Session::get("learn_param_curso"); }
        if(strlen($id)==0){ exit; }
        Session::set("learn_url_tmp", "examen/registrarRespuestaUnica");
        Session::set("learn_param_curso", $id);

        $peso= $this->examen->getExamenPeso($idExamen);
        $puntos_pregunta= $this->examen->getPuntosPregunta($idExamen);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];

        if ($this->botonPress("btn_registrar_pregunta")) {
            $pregunta = $this->getSql("in_pregunta");
            // $valor = $this->getTexto("valor_preg");
            // $contador = $this->getTexto("contador");
          
            $pregunta =$this->examen->insertPregunta($idExamen, $pregunta, 0, 5, null, $this->getInt("puntos"));

            if($pregunta)
                    $this->redireccionar("elearning/examen/preguntas/$id/$idExamen");
            
        }

        $titulo =  $this->examen->getTituloCurso($id);
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->assign('puntos_maximo', $puntos_maximo );
        $this->_view->assign('examen', $idExamen );
        $this->_view->assign('idcurso', $id);
        $this->_view->renderizar('respuestaabierta', 'elearning');
    }

    public function editarRespuestaAbierta($id, $idcurso){
        // $this->_view->setCss(array("verificar"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));

        $preguntaedit =$this->examen->getValorPregunta($id);

        if ($this->botonPress("btn_registrar_pregunta")) {
            $pregunta = $this->getSql("in_pregunta");
          
            $pregunta =$this->examen->updatePregunta($id, $pregunta, 0,  $this->getInt("puntos"));

            if($pregunta)
                $this->redireccionar("elearning/examen/preguntas/$idcurso/".$preguntaedit['Exa_IdExamen']);
            
        }

        $peso= $this->examen->getExamenPeso($preguntaedit['Exa_IdExamen']);
        $puntos_pregunta= $this->examen->getPuntosPregunta($preguntaedit['Exa_IdExamen']);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];

        $titulo =  $this->examen->getTituloCurso($idcurso);
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->assign('idcurso', $idcurso);
        $this->_view->assign('puntos_maximo', $puntos_maximo );
        $this->_view->assign('examen', $preguntaedit['Exa_IdExamen']);
        $this->_view->assign('preguntaedit', $preguntaedit);
        $this->_view->renderizar('editarrespuestaabierta', 'elearning');
    }
    // No por ahora
    public function registrarRespuestaZonasImagen($idExamen, $id){
        // $this->_view->setCss(array("verificar"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));

        if(strlen($id)==0){ $id = Session::get("learn_param_curso"); }
        if(strlen($id)==0){ exit; }
        Session::set("learn_url_tmp", "examen/registrarRespuestaUnica");
        Session::set("learn_param_curso", $id);

        if ($this->botonPress("btn_registrar_pregunta")) {
            $pregunta = $this->getSql("in_pregunta");
            // $valor = $this->getTexto("valor_preg");
            // $contador = $this->getTexto("contador");
          
            $pregunta =$this->examen->insertPregunta($idExamen, $pregunta, 0, 5);

            if($pregunta)
                    $this->redireccionar('elearning/examen/preguntas/'.$idExamen);
            
        }
       
        $this->_view->renderizar('respuestazonasimagen', 'elearning');
    }

    public function registrarRespuestaCombinacionExacta($idExamen, $id){
        // $this->_view->setCss(array("verificar"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));

        if(strlen($id)==0){ $id = Session::get("learn_param_curso"); }
        if(strlen($id)==0){ exit; }
        Session::set("learn_url_tmp", "examen/registrarRespuestaUnica");
        Session::set("learn_param_curso", $id);

        $peso= $this->examen->getExamenPeso($idExamen);
        $puntos_pregunta= $this->examen->getPuntosPregunta($idExamen);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];

        if ($this->botonPress("btn_registrar_pregunta")) {
            $pregunta = $this->getSql("in_pregunta");
            $contador = $this->getTexto("contador");
            $pregunta =$this->examen->insertPregunta($idExamen, $pregunta, 0, 7, null, $this->getInt("puntos"));

            if($pregunta){

                $alternativa=0;
                $j=1;

                for($i=1;$i<=$contador;$i++)

                if($this->getSql("alt".$i)!=null){

                    if($this->getSql("ckb".$i)!=null)
                    $alternativa =$this->examen->insertAlternativa($pregunta[0], $j, $this->getSql("alt".$i),0,1);

                else
                    $alternativa =$this->examen->insertAlternativa($pregunta[0], $j, $this->getSql("alt".$i),0,0);
                    $j++;
                }
                
                if($alternativa)
                    $this->redireccionar("elearning/examen/preguntas/$id/$idExamen");
            }
        }
        $titulo =  $this->examen->getTituloCurso($id);
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->assign('puntos_maximo', $puntos_maximo );
        $this->_view->assign('examen', $idExamen );
        $this->_view->assign('idcurso', $id);
        $this->_view->renderizar('respuestacombinacionexacta', 'elearning');
    }

    public function editarRespuestaCombinacionExacta($id, $idcurso){
        // $this->_view->setCss(array("verificar"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));

        $alternativas =$this->examen->getAlternativas($id);
        $preguntaedit =$this->examen->getValorPregunta($id);

        if ($this->botonPress("btn_registrar_pregunta")) {

            $countrpta=$this->examen->deleteAlternativa($id);
            $pregunta = $this->getSql("in_pregunta");
            $contador = $this->getTexto("contador");

            $pregunta =$this->examen->updatePregunta($id, $pregunta, 0,$this->getInt("puntos"));

            if($pregunta){
                $alternativa=0;
                $j=1;

                for($i=1;$i<=$contador;$i++)

                if($this->getSql("alt".$i)!=null){

                    if($this->getSql("ckb".$i)!=null)
                    $alternativa =$this->examen->insertAlternativa($id, $j, $this->getSql("alt".$i),0,1);
                else
                    $alternativa =$this->examen->insertAlternativa($id, $j, $this->getSql("alt".$i),0,0);
                    $j++;
                }
                
                if($alternativa)
                     $this->redireccionar("elearning/examen/preguntas/$idcurso/".$preguntaedit['Exa_IdExamen']);
            }

        }

        $peso= $this->examen->getExamenPeso($preguntaedit['Exa_IdExamen']);
        $puntos_pregunta= $this->examen->getPuntosPregunta($preguntaedit['Exa_IdExamen']);
        $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];
        
        $titulo =  $this->examen->getTituloCurso($idcurso);
        $this->_view->assign('titulo', $titulo["Cur_Titulo"]);
        $this->_view->assign('puntos_maximo', $puntos_maximo );
        $this->_view->assign('examen', $preguntaedit['Exa_IdExamen']);
        $this->_view->assign('idcurso', $idcurso);
        $this->_view->assign('alternativas', $alternativas);
         $this->_view->assign('nextinput', count($alternativas)+1);
        $this->_view->assign('preguntaedit', $preguntaedit);
        $this->_view->renderizar('editarrespuestacombinacionexacta');
    }

    public function comenzarexamen($idexamen){
        // $this->_view->setCss(array("miscertificados"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));
       
        if ($this->botonPress("comenzar")) {

            // $intento=$this->examen->insertExamenAlumno($idexamen,Session::get("id_usuario"));

            // if($intento){
            //     $this->redireccionar('elearning/examen/examen/'.$idexamen);
            // }

            $this->redireccionar('elearning/examen/examen/'.$idexamen);
        }

        $maxintentos= $this->examen->getMaxIntentos($idexamen);
        $intentos=$this->examen->getIntentos($idexamen,Session::get("id_usuario"));

        $this->_view->assign('maxintentos', $maxintentos['Exa_Intentos']);
        $this->_view->assign('intentos', $intentos['intentos'] );
       
        $this->_view->renderizar('comenzarexamen', 'elearning');
    }

    public function examen($idexamen){
        // $this->_view->setCss(array("miscertificados"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));

        if (Session::get("intento")<1){
        $intento=$this->examen->insertExamenAlumno($idexamen,Session::get("id_usuario"));
        Session::set("intento", 1);
        Session::set("idintento", $intento[0]);
        $preguntas= $this->examen->getPreguntas($idexamen);
        $peso= $this->examen->getExamenPeso($idexamen);
        Session::set("preguntas", $preguntas);
        }
        // echo $intento[0]; exit;
       
        if ($this->botonPress("terminar")) {

            $puntos=0;

            $preguntas=Session::get("preguntas");

            for ($i=0; $i < count($preguntas); $i++) { 

                $tipo=$this->getSql('tipo_preg'.$i);

                if($tipo==1){

                    $alt=$preguntas[$i]['Alt'];
                    $puntosrpta=0;

                    foreach ($alt as $k) {
                       if($k['Alt_Valor']==$preguntas[$i]['Pre_Valor'])
                            if($this->getInt('rpta_alt'.$i)==$k['Alt_IdAlternativa']){
                                $puntosrpta=$preguntas[$i]['Pre_Puntos'];
                                $puntos=$puntos+$puntosrpta;
                            }
                    }

                     $this->examen->insertRespuesta($this->getInt('id_preg'.$i), Session::get("idintento"), $this->getInt('rpta_alt'.$i),null,null,$puntosrpta);                    
                }

                else if($tipo==2){

                    for($j=0; $j < count($preguntas[$i]['Alt']); $j++){
                        if($this->getSql('rpta2_alt'.$i.'_index'.$j)){
                            
                            $alt=$preguntas[$i]['Alt'];
                            $puntosrpta=0;

                            foreach ($alt as $k) {
                                if($k['Alt_Check'])
                                if($this->getInt('rpta2_alt'.$i.'_index'.$j)==$k['Alt_IdAlternativa']){
                                    $puntosrpta=$k['Alt_Puntos'];
                                    $puntos=$puntos+$puntosrpta;
                                }
                            }   

                             $this->examen->insertRespuesta($this->getInt('id_preg'.$i), Session::get("idintento"), $this->getInt('rpta2_alt'.$i.'_index'.$j),null,null,$puntosrpta);                 

                        }
                    }
                }

                else if($tipo==3){

                    $alt=$preguntas[$i]['Alt'];

                    for($j=0; $j < count($alt); $j++){

                    $puntosrpta=0;

                    if($this->getSql('rpta3_'.$i.'_index_'.$j)==$alt[$j]['Alt_Etiqueta']){
                        $puntosrpta=$alt[$j]['Alt_Puntos'];
                        $puntos=$puntos+$puntosrpta; 
                    }

                    $this->examen->insertRespuesta($this->getInt('id_preg'.$i), Session::get("idintento"),null,null, $this->getSql('rpta3_'.$i.'_index_'.$j),$puntosrpta);
                    }
                }

                else if($tipo==4){

                    $alt=$preguntas[$i]['Alt'];

                    for($j=0; $j < count($alt); $j=$j+2){

                        $puntosrpta=0;

                        if($this->getInt('rpta4_'.$i.'_index_'.$j)==$alt[$j]['Alt_IdAlternativa'])
                            if($this->getInt('rpta4_alt'.$i.'_index_'.$j)==$alt[$j]['Alt_Relacion']){
                                $puntosrpta=$alt[$j]['Alt_Puntos'];
                                $puntos=$puntos+$puntosrpta;
                            }

                     $this->examen->insertRespuesta($this->getInt('id_preg'.$i), Session::get("idintento"), $this->getInt('rpta4_'.$i.'_index_'.$j),$this->getInt('rpta4_alt'.$i.'_index_'.$j),null,$puntosrpta);
                    }
                }

                else if($tipo==5){
                    $this->examen->insertRespuesta($this->getInt('id_preg'.$i), Session::get("idintento"), null, null, $this->getSql('rpta_alt'.$i),null);
                }

                else{
                    $cont2=0;
                    for($j=0; $j < count($preguntas[$i]['Alt']); $j++)
                    if($this->getSql('rpta7_alt'.$i.'_index'.$j)){

                     $alt=$preguntas[$i]['Alt'];
                    $cont=0;
                    $puntosrpta=0;
                    
                            foreach ($alt as $k) {
                                if($k['Alt_Check']){
                                    if($this->getInt('rpta7_alt'.$i.'_index'.$j)==$k['Alt_IdAlternativa'])
                                        $cont2++;

                                    $cont++;
                                }
                            } 
                        if($cont==$cont2){
                                $puntosrpta=$preguntas[$i]['Pre_Puntos'];
                                $puntos=$puntos+$puntosrpta;
                            }

                        $this->examen->insertRespuesta($this->getInt('id_preg'.$i), Session::get("idintento"), $this->getInt('rpta7_alt'.$i.'_index'.$j),null,null,$puntosrpta);
                    }
                }
            }

            $this->examen->updateNotaExamen(Session::get("idintento"), $puntos);

            $examen=$this->examen->getExamen($idexamen);

            // if($puntos*100/$peso[0]>50){
            //     $this->examen->insertProgreso(Session::get("id_usuario"), $examen['Lec_IdLeccion']);
            // }

             $this->redireccionar("elearning/cursos/modulo/".$examen['Cur_IdCurso'].'/'.$examen['Moc_IdModulo'].'/'.$examen['Lec_IdLeccion']);
        }

        $this->_view->assign('preguntas', $preguntas);       
        $this->_view->renderizar('examen');
    }

    public function resultado($puntos=0, $peso=0){
        // $this->_view->setCss(array("miscertificados"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));
       
        if ($this->botonPress("comenzar")) {

            // $this->redireccionar('elearning/examen/examen/'.$idexamen);
        }

        // $maxintentos= $this->examen->getMaxIntentos($idexamen);
        // $intentos=$this->examen->getIntentos($idexamen,Session::get("id_usuario"));

        $this->_view->assign('puntos', $puntos);
        $this->_view->assign('peso', $peso);
        $this->_view->renderizar('resultado', 'elearning');
    }

    public function corregirExamenAlumno($id){
        // $this->_view->setCss(array("miscertificados"));
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));

        $respuestas=$this->examen->getRespuestasAbiertas($id);
       
        if ($this->botonPress("corregir")) {
            for ($i=0; $i < count($respuestas); $i++) { 
                $tipo=$this->getSql('tipo_preg'.$i);

                // if($tipo==1){
                //     $this->examen->insertRespuesta($this->getInt('id_preg'.$i), $intento[0][0], $this->getInt('rpta_alt'.$i),null);

                //     $alt=$preguntas[$i]['Alt'];

                //     foreach ($alt as $k) {
                //        if($k['Alt_Valor']==$preguntas[$i]['Pre_Valor'])
                //             if($this->getInt('rpta_alt'.$i)==$k['Alt_IdAlternativa'])
                //                 $puntos=$puntos+$preguntas[$i]['Pre_Puntos'];
                //     }                    
                // }

                // else if($tipo==2){

                //     for($j=0; $j < count($preguntas[$i]['Alt']); $j++){
                //         if($this->getSql('rpta2_alt'.$i.'_index'.$j)){
                //             $this->examen->insertRespuesta($this->getInt('id_preg'.$i), $intento[0][0], $this->getInt('rpta2_alt'.$i.'_index'.$j),null);
                            
                //             $alt=$preguntas[$i]['Alt'];

                //             foreach ($alt as $k) {
                //                 if($k['Alt_Check'])
                //                 if($this->getInt('rpta2_alt'.$i.'_index'.$j)==$k['Alt_IdAlternativa'])
                //                     $puntos=$puntos+$preguntas[$i]['Pre_Puntos'];
                //             }                    

                //         }
                //     }
                // }

                // else if($tipo==3){

                //     $alt=$preguntas[$i]['Alt'];

                //     for($j=0; $j < count($alt); $j++){
                //     $this->examen->insertRespuesta($this->getInt('id_preg'.$i), $intento[0][0],null,null, $this->getSql('rpta3_'.$i.'_index_'.$j));

                //     if($this->getSql('rpta3_'.$i.'_index_'.$j)==$alt[$j]['Alt_Etiqueta'])
                //         $puntos=$puntos+$alt[$j]['Alt_Puntos']; 
                //     }
                // }

                // else if($tipo==4){

                //     $alt=$preguntas[$i]['Alt'];

                //     for($j=0; $j < count($alt); $j=$j+2){
                //     $this->examen->insertRespuesta($this->getInt('id_preg'.$i), $intento[0][0], $this->getInt('rpta4_'.$i.'_index_'.$j),$this->getInt('rpta4_alt'.$i.'_index_'.$j));

                //         if($this->getInt('rpta4_'.$i.'_index_'.$j)==$alt[$j]['Alt_IdAlternativa'])
                //             if($this->getInt('rpta4_alt'.$i.'_index_'.$j)==$alt[$j]['Alt_Relacion'])
                //                 $puntos=$puntos+$alt[$j]['Alt_Puntos'];
                //     }
                // }

                if($tipo==5){

                    $this->examen->updatePuntosRespuestaAbierta($this->getInt('id_preg'.$i), $this->getInt('rpta_puntos'.$i));
                    // $this->examen->insertRespuesta($this->getInt('id_preg'.$i), $intento[0][0], null, null, $this->getInt('rpta_puntos'.$i));
                }

                // else{
                //     $cont2=0;
                //     for($j=0; $j < count($preguntas[$i]['Alt']); $j++)
                //     if($this->getSql('rpta7_alt'.$i.'_index'.$j)){
                //     $this->examen->insertRespuesta($this->getInt('id_preg'.$i), $intento[0][0], $this->getInt('rpta7_alt'.$i.'_index'.$j),null);

                //      $alt=$preguntas[$i]['Alt'];
                //     $cont=0;
                    
                //             foreach ($alt as $k) {
                //                 if($k['Alt_Check']){
                //                     if($this->getInt('rpta7_alt'.$i.'_index'.$j)==$k['Alt_IdAlternativa'])
                //                         $cont2++;

                //                     $cont++;
                //                 }
                //             } 
                //     }
                //      if($cont==$cont2)
                //                 $puntos=$puntos+$preguntas[$i]['Pre_Puntos'];
                // }
            }

             // $this->redireccionar("elearning/examen/resultado/$puntos/".$peso['Exa_Peso']);
        }

        $this->_view->assign('respuestas', $respuestas);
       
        $this->_view->renderizar('correccionexamen', 'elearning');
    }
    // other
    public function detalle($Nombre){
        $this->_view->renderizar("detalle");
    }  
}