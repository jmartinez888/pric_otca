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

        exit();

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

    public function menu(){
        // $codigo = $this->getTexto("certificado");
        
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
        
        $this->_view->assign('titulo', 'Certficados del Curso');
        $this->_view->renderizar('menu');
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



    public function otros(){
        // $codigo = $this->getTexto("certificado");
        
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        // $this->_view->assign("certificado", $codigo);
        // $this->_view->assign("resultados", $this->certificado->getCertificado($codigo));
        // $this->_view->renderizar("menu");
        $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));


        // $this->_view->setJs(array('index'));

        $pagina = $this->getInt('pagina');

        //Filtro por Activos/Eliminados
        // $condicion = " ORDER BY Row_Estado DESC ";
        // $soloActivos = 0;
        // if (!$this->_acl->permiso('ver_eliminados')) {
        //     $soloActivos = 1;
        //     $condicion = " WHERE Row_Estado = $soloActivos ";
        // }
        //Filtro por Activos/Eliminados

        $paginador = new Paginador();

        
        $arrayRowCount = $this->certificado->getCertificadoRowCount(" ");

        $this->_view->assign('certificados', $this->certificado->getCertificadosCondicion($pagina,CANT_REG_PAG," "));



        $paginador->paginar( $arrayRowCount[0]['CantidadRegistros'],"listarcertificadosotros", "", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacioncertificados', $paginador->getView('paginacion_ajax_s_filas'));
        
        $this->_view->assign('titulo', 'Certficados del Curso');
        $this->_view->renderizar('otros');
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
    //Modificado por Jhon Martinez
    public function _buscarcertificadootros() 
    {
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $condicion = "";
         $usuario = Session::get("id_usuario");

        $soloActivos = 1;
        // $nombre = $this->getSql('palabra');
        if ($txtBuscar) 
        {
            $condicion = " WHERE v.Cer_Codigo liKe '%$txtBuscar%' ";
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
                $condicion = " ";
            // }

            //Filtro por Activos/Eliminados
        }        


        $paginador = new Paginador();


        $arrayRowCount = $this->certificado->getCertificadoRowCount($condicion);
        $totalRegistros = $arrayRowCount[0]['CantidadRegistros'];
        // echo($totalRegistros);
        // print_r($arrayRowCount); echo($condicion);exit;
        $this->_view->assign('certificados', $this->certificado->getCertificadosCondicion($pagina,CANT_REG_PAG, $condicion));

        $paginador->paginar( $totalRegistros ,"listarcertificadosotros", "$txtBuscar", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacioncertificados', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarcertificadosotros', false, true);
    }
}