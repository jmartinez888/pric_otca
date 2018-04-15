<?php

class institucionesController extends ofertaController
{	
	private $_inst;
	public function __construct($lang, $url) {
        parent::__construct($lang, $url);
        $this->_inst=$this->loadModel('instituciones');
    }

    public function index() {
    	$this->validarUrlIdioma();
    	$this->_view->getLenguaje("oferta_index");
    	$this->_view->setJs(array('index'));

		$nombre = $this->getSql('nombre');
        $pagina = $this->getInt('pagina');
        $paginador = new Paginador();

        $arrayRowCount = $this->_inst->getInstitucionesRowCount();
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        $this->_view->assign('paises', $this->_inst->getPaises());
        $this->_view->assign('numeracion', 0);
        $this->_view->assign('totalRegistros', 0);
        
    	$lista=$this->_inst->getInstituciones(0,CANT_REG_PAG);
    	$paginador->paginar( $totalRegistros,"listarInstituciones", "", $pagina, CANT_REG_PAG, true);
    	
    	$this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        


    	$this->_view->assign('listaIns', $lista);
    	$this->_view->assign('titulo', 'Instituciones');
    	$this->_view->setTemplate(LAYOUT_FRONTEND);
    	$this->_view->renderizar('index','instituciones');

    }

    public function _paginacion_listarInstituciones($txtBuscar = false) 
    {
        
        if($txtBuscar=="all"){$txtBuscar="";}
        //Variables de Ajax_JavaScript
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $totalRegistros = $this->getInt('total_registros');
        $paginador = new Paginador();
        if($pagina==0){
        $numeracion=0;
    }else{
        $numeracion=($pagina-1)*10;    
    }
        $this->_view->setJs(array('index'));
        $paginador->paginar( $totalRegistros,"listarInstituciones", "$txtBuscar", $pagina, $filas, true);
        $this->_view->assign('numeracion', $numeracion);
        $this->_view->assign('listaIns', $this->_inst->getInstituciones($pagina,$filas));
        $this->_view->assign('totalRegistros', 0);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
$this->_view->assign('titulo', 'Instituciones');
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarInstituciones', false, true);
    }
    public function _paginacion_listarResultados($txtBuscar = false,$pais=false) 
    {
        if($pais=="all"){$pais="";}
        if($txtBuscar=="all"){$txtBuscar="";}
        //Variables de Ajax_JavaScript
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $totalRegistros = $this->getInt('total_registros');
        $paginador = new Paginador();
        if($pagina==0){
        $numeracion=0;
    }else{
        $numeracion=($pagina-1)*10;    
    }
    $this->_view->assign('titulo', 'Instituciones');
        $this->_view->setJs(array('index'));
        $paginador->paginar( $totalRegistros,"listarInstituciones", "$txtBuscar", $pagina, $filas, true);
        $this->_view->assign('numeracion', $numeracion);
        $this->_view->assign('listaIns', $this->_inst->getInstituciones($pagina,$filas));
        $this->_view->assign('totalRegistros', 0);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());

        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarInstituciones', false, true);
    }
    public function buscarporpalabras($dato = '',$pais='')
    {
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("oferta_index");
        if($dato=="all"){$dato="";}
        if($pais=="all"){$pais="";}
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $arrayRowCount = $this->_inst->getInstitucionesBusquedaRowCount($dato,$pais);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];  
        $this->_view->setJs(array('index'));
        $paginador = new Paginador();
        if($pagina==0){
        $numeracion=0;
    }else{
        $numeracion=($pagina-1)*10;    
    }
        $this->_view->assign('titulo', 'Instituciones');
        $paginador->paginar( $totalRegistros,"listarInstituciones", "$dato", $pagina, CANT_REG_PAG, true);
        $this->_view->assign('paises', $this->_inst->getPaises());
        $this->_view->assign('listaIns', $this->_inst->getInstitucionesBusqueda($pagina,CANT_REG_PAG,$dato,$pais));
        $this->_view->assign('numeracion', $numeracion);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('index', 'instituciones');
    }
    public function ficha($id=false,$oferta=false,$id_oferta=false) {
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("oferta_index");
        $idioma = Cookie::lenguaje();

        if($oferta!==false && $id_oferta!==false){
            $this->validarUrlIdioma();
                
        $this->_view->setJs(array('index'));

        $lista=$this->_inst->getInstitucionPorId($id,$idioma);
        
        if(Session::get('id_usuario')){
            $id_usuario = Session::get('id_usuario');   
            $inst_usuario=$this->_inst->getInstitucionUsuario($id,$id_usuario);
            if($inst_usuario){
                
                $this->_view->assign('inst_usuario', 'si');        
            }
        }
        if($oferta=='Especializacion'){
            $oferta="Especialización";
        }
        if($oferta=='Maestria'){
            $oferta="Maestría";
        }
        if($oferta=='Investigacion'){
            $oferta="Investigación";
        }

        $listaOfe=$this->_inst->getOfertaPorId($id_oferta);
        $this->_view->assign('oferta', $oferta);
        $this->_view->assign('listaIns', $lista);
        $this->_view->assign('listaOfe', $listaOfe);
        $this->_view->assign('titulo', 'Ficha Oferta');
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->renderizar('ficha_oferta','instituciones');
        exit;
        }

        $this->validarUrlIdioma();
                
        $this->_view->setJs(array('index'));

        $lista=$this->_inst->getInstitucionPorId($id,$idioma);
        
        if(Session::get('id_usuario')){
            $id_usuario = Session::get('id_usuario');   
            $inst_usuario=$this->_inst->getInstitucionUsuario($id,$id_usuario);
            
            if($inst_usuario){
                
                $this->_view->assign('inst_usuario', 'si');        
            }
        }
        $tiene_traduccion = $this->_inst->tiene_traduccion($id);
        if(count($tiene_traduccion)){
        $this->_view->assign('tiene_traduccion', 'si');    
        }
        
        $this->_view->assign('listaIns', $lista);
        $this->_view->assign('titulo', 'Ficha Institucion');
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->renderizar('ficha','instituciones');

    }
}
?>  