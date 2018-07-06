<?php

/**
 * Description of loginContanuncioler
 * @author anuncioORO
 */
class gestionController extends elearningController {

  protected $_link;
  protected $service;
  private $_gestionm;

  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
    $this->_view->assign('_url', BASE_URL . "modules/" . $this->_request->getModulo() . "/views/");
    $this->getLibrary("ServiceResult");
    $this->service = new ServiceResult();
     $this->_gestionm= $this->loadModel('_gestionCurso');     
  }

  public function index()
  {
      if (!Session::get('autenticado')){ $this->redireccionar(); }

      $this->_view->setJs(array('framework/lodash', 'core/util','core/controller', 'core/view', 'index'));
      $this->_view->setCss(array('principal'));

      if( Session::get("learn_url_tmp") ){
        $this->_view->assign('learn_url_tmp', Session::get("learn_url_tmp"));
      } else {
        $this->_view->assign('learn_url_tmp', "");
      }

      $this->_view->setTemplate(LAYOUT_FRONTEND);
      $this->_view->getLenguaje("index_inicio");

      $this->_view->setJs(array(//array(BASE_URL . 'public/ckeditor/ckeditor.js'), 
        array(BASE_URL . 'public/ckeditor/adapters/jquery.js')));
      $this->_view->assign('learn_usuario', Session::get("login_usuario"));
      $this->_view->assign('learn_lenguaje', $this->_lenguaje ? $this->_lenguaje : "es");
      $this->_view->assign('learn_url', BASE_URL . $this->_request->getLenguaje() . "/" . $this->_request->getModulo() . "/");
      $this->_view->renderizar('index');
  }

  public function _inicio()
  {
    Session::set("learn_url_tmp", "gcurso/_view_mis_cursos");
    $this->redireccionar("elearning/gestion/");
  }

  public function matriculados($id =""){
    if(!Session::get("autenticado")){ $this->redireccionar("elearning/"); }
    if($id == "" || !is_numeric($id) ){ $this->redireccionar("elearning/"); }
    $model = $this->loadModel("curso");
    $_model = $this->loadModel("_gestionCurso");
    if(!$_model->validarDocenteCurso($id, Session::get("id_usuario"))){ $this->redireccionar("elearning/"); }

    $curso = $model->getCursoID($id);
    $matriculados = $_model->getMatriculados($id);

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->assign("curso", $curso[0]);
    $this->_view->assign("matriculados", $matriculados);
    $this->_view->renderizar("matricula");
  }

  public function anuncios($id =""){
    if(!Session::get("autenticado")){ $this->redireccionar("elearning/"); }
    if($id == "" || !is_numeric($id) ){ $this->redireccionar("elearning/"); }
    $model = $this->loadModel("curso");
    $_model = $this->loadModel("_gestionCurso");
    if(!$_model->validarDocenteCurso($id, Session::get("id_usuario"))){ $this->redireccionar("elearning/"); }
    $this->_view->getLenguaje("index_inicio");
    $this->_view->setJs(array('anuncios'));

    $pagina = $this->getInt('pagina');
        //$registros = $this->getInt('registros');
        $nombre = $this->getSql('nombre');

    $condicion = " ";
        // echo $condicion; exit;
        $arrayRowCount = $_model->getAnunciosRowCount($condicion);
        // print_r($arrayRowCount);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];

        $paginador = new Paginador();

        // $this->_view->assign('usuarios', $this->_usuarios->getUsuariosPaginado($condicion));

        $paginador->paginar( $totalRegistros,"listaranuncios", "", $pagina, CANT_REG_PAG, true);

    $curso = $model->getCursoID($id);
    $anuncios = $_model->getAnuncios($id);

    if ($this->botonPress("bt_guardar")) {
            $this->registrarAnuncio($id);                
    }

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->assign("curso", $curso[0]);
    $this->_view->assign("anuncios", $anuncios);
    $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
    $this->_view->assign('paginacionanuncios', $paginador->getView('paginacion_ajax_s_filas'));
    $this->_view->renderizar("anuncios");
  }

  public function registrarAnuncio($id)
    {     
            $_model = $this->loadModel("_gestionCurso");
            $idUsuario = $_model->registrarAnuncio(
                $this->getSql('titulo'),
                $this->getSql('descripcion'),
                $id
            );
        
        if (is_array($idUsuario)) {
            if ($idUsuario[0] > 0) {
                $this->_view->assign('_mensaje', 'Anuncio registrado');
            } else {
                $this->_view->assign('_error', 'Error al registrar el Anuncio');
            }
        } else {

                $this->_view->assign('_error', 'Ocurrio un error al Registrar los datos');        
        }                
    }

   public function _paginacion_listaranuncios($txtBuscar = false) 
    {
        //Variables de Ajax_JavaScript
        $_model = $this->loadModel("_gestionCurso");
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $totalRegistros = $this->getInt('total_registros');

        $soloActivos = 0;
        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Anc_Titulo liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY Row_Estado DESC ";
            }
            
        } else {
            $condicion = " ORDER BY Row_Estado DESC ";
            //Filtro por Activos/Eliminados  
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE Row_Estado = $soloActivos  ";
            }
        }  

        $paginador = new Paginador();

        // $this->_view->assign('anuncioes', $paginador->paginar($this->_aclm->getanuncioes($condicion), "listaranuncioes", "$nombre", $pagina, 25));

        $paginador->paginar( $totalRegistros,"listaranuncios", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('anuncios', $_model->getAnunciosCondicion($pagina,$filas, $condicion));

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacionanuncios', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listaranuncios', false, true);
    }


    public function editarAnuncios($Anc_IdAnuncioCurso = false)
    {
        $this->_acl->acceso('editar_rol');
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("index_inicio");
        $this->_view->setJs(array('anuncios'));
        $_model = $this->loadModel("_gestionCurso");
        $anuncio = $_model->getAnuncio($this->filtrarInt($Anc_IdAnuncioCurso));

        if ($this->botonPress("bt_cancelarEditarAnuncio")) {
            $this->redireccionar('elearning/gestion/anuncios/'.$anuncio['Cur_IdCurso']);
        }

        if ($this->botonPress("bt_editarAnuncio")) 
        {            
                $id = $_model->editarAnuncio($this->filtrarInt($Anc_IdAnuncioCurso), $this->getSql('titulo'),$this->getSql('descripcion'));
                if($id)
                {
                    $this->_view->assign('_mensaje', 'Anuncio editado Correctamente');
                    $anuncio = $_model->getAnuncio($this->filtrarInt($Anc_IdAnuncioCurso));
                }  
                else 
                {
                    $this->_view->assign('_error', 'Error al editar anuncio');
                }
        }        
        // $this->_view->assign('idiomas',$this->_aclm->getIdiomas());        
        $this->_view->assign('datos',$anuncio);
        $this->_view->renderizar('ajax/editarAnuncio','editarAnuncio');
    }

    public function _buscarAnuncio() 
    {

        //Variables de Ajax_JavaScript
        $_model = $this->loadModel("_gestionCurso");
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $totalRegistros = $this->getInt('total_registros');

        $soloActivos = 0;
        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Anc_Titulo liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY Row_Estado DESC ";
            }
            
        } else {
            $condicion = " ORDER BY Row_Estado DESC ";
            //Filtro por Activos/Eliminados  
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE Row_Estado = $soloActivos  ";
            }
        }  

        $paginador = new Paginador();

        $arrayRowCount = $_model->getAnunciosRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];

        $paginador->paginar( $totalRegistros,"listaranuncios", "$txtBuscar", $pagina,CANT_REG_PAG, true);

        $this->_view->assign('anuncios', $_model->getAnunciosCondicion($pagina,CANT_REG_PAG, $condicion));
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacionanuncios', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listaranuncios', false, true);
    }


 public function _cambiarEstadoAnuncio()
    {
        $this->_acl->acceso('editar_rol');
        //Para Mensajes
        $resultado = array();
        $mensaje = "error";
        $contenido = "";
        //Variables de Ajax_JavaScript
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $Anc_IdAnuncioCurso = $this->getInt('_Anc_IdAnuncio');
        $Anc_Estado = $this->getInt('_Anc_Estado');
        
        if(!$Anc_IdAnuncioCurso){            
            $this->_view->assign('_error', 'Error parametro ID ..!!');  
            $this->_view->renderizar('anuncios');
            exit;          
        } else {
            //Actualizacion de estado en la BD
            $rowCountEstado = $this->_gestionm->cambiarEstadoAnuncio($Anc_IdAnuncioCurso, $Anc_Estado);
            //Mensaje de Actualizacion
            if ($rowCountEstado > 0) {
                if ($Anc_Estado == 1) {
                    $contenido = ' Se cambio de estado correctamente a <b>Deshabilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign" title="Deshabilitado" style="background: #FFF; color: #DD4B39; padding: 2px;"/> ...!! ';              
                }
                if ($Anc_Estado == 0) {
                     $contenido = ' Se cambio de estado correctamente a <b>Habilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign" title="Habilitado" style=" background: #FFF;  color: #088A08; padding: 2px;"/> ...!! ';
                }     
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));       
            } else {
                $this->_view->assign('_error', 'Error de variable(s) en consulta..!!');
            }        
        }
        //Mensaje JSON
        $mensaje_json = json_encode($resultado);
        // echo($mensaje_json); exit();
        $this->_view->assign('_mensaje_json', $mensaje_json);

        $soloActivos = 0;
        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Anc_Titulo liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND Row_Estado = $soloActivos ";
            }
            
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE Row_Estado = $soloActivos  ";
            }
        }  

        $paginador = new Paginador();

        $arrayRowCount = $this->_gestionm->getAnunciosRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // echo($totalRegistros);
        // print_r($arrayRowCount); echo($condicion);exit;
        $this->_view->assign('anuncios', $this->_gestionm->getAnunciosCondicion($pagina,$filas, $condicion));

        $paginador->paginar( $totalRegistros ,"listaranuncios", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionanuncios', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listaranuncios', false, true);
    }



     public function _eliminarAnuncio()
    {
        $this->_acl->acceso('editar_rol');
                
        //Variables Ajax_Javascript
        $Anc_IdAnuncioCurso = $this->getInt('_Anc_IdAnuncio');
        $Row_Estado = $this->getInt('_Row_Estado');
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');       
        // echo $Per_IdPermiso."//".$Row_Estado;
        //Para Mensajes
        $resultado = array();
        $mensaje = "error";
        $contenido = "";
        //Para mensajes

        if ($Row_Estado == 0) {
            if(!$Anc_IdAnuncioCurso)
            {            
                $contenido = 'Error parametro ID ..!!'; 
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));          
            } else {
                // $usu = $this->_gestionm->getAnuncio($Anc_IdAnuncioCurso);
                // // print_r($role);
                // if ($usu <= 0)
                // {                   
                    $rowCount = $this->_gestionm->eliminarHabilitarAnuncio($Anc_IdAnuncioCurso,$Row_Estado);
                    // echo $rowCount3;//exit;
                    if($rowCount && $rowCount > 0)
                    {
                        $contenido = 'El anuncio fue elimnado correctamente...!!!'; 
                        $mensaje = "ok";
                        array_push($resultado, array(0 => $mensaje, 1 => $contenido));  
                    } else {
                        $contenido = 'No se pudo eliminar anuncio, error de consulta...!!!'; 
                        $mensaje = "error";
                        array_push($resultado, array(0 => $mensaje, 1 => $contenido)); 
                    }
                    
                } 
                    // else {
                //     $contenido = 'No se pudo eliminar anuncio asignado a usuario...!!!'; 
                //     $mensaje = "error";
                //     array_push($resultado, array(0 => $mensaje, 1 => $contenido)); 
                // }  
                // echo $error;exit;        
            // }
        } else {
            $rowCount = $this->_gestionm->eliminarHabilitarAnuncio($Anc_IdAnuncioCurso,$Row_Estado);            
            if($rowCount)
            {
                $contenido = 'El anuncio fue activado correctamente...!!!'; 
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            } else {
                $contenido = 'No se pudo activar anuncio error en consulta...!!!'; 
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            }
        }

        $mensaje_json = json_encode($resultado);
        // echo($mensaje_json); exit();
        $this->_view->assign('_mensaje_json', $mensaje_json);

        $soloActivos = 0;
        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Anc_Titulo liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY Row_Estado DESC ";
            }
            
        } else {
            $condicion = " ORDER BY Row_Estado DESC ";
            //Filtro por Activos/Eliminados  
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE Row_Estado = $soloActivos  ";
            }
        }  

        $paginador = new Paginador();

        $arrayRowCount = $this->_gestionm->getAnunciosRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];

        $paginador->paginar( $totalRegistros,"listaranuncios", "$txtBuscar", $pagina,$filas, true);

        $this->_view->assign('anuncios', $this->_gestionm->getAnunciosCondicion($pagina, $filas, $condicion));

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacionanuncios', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listaranuncios', false, true);
    }

  public function matricular($curso = "", $alumno = "", $estado = ""){
    if($curso=="" || $alumno=="" || $estado == ""){ $this->redireccionar("elearning/"); }

    $estado = ($estado=="Si" ? 1 : 0);
    $_model = $this->loadModel("_gestionCurso");
    $_model->updateMatricula($curso, $alumno, $estado);
    $this->redireccionar("elearning/gestion/matriculados/" . $curso);
  }
}
