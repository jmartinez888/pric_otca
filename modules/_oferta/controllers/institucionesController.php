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
    	
    	$this->_view->setJs(array('index'));

		$nombre = $this->getSql('nombre');
        $pagina = $this->getInt('pagina');
        $paginador = new Paginador();

        $arrayRowCount = $this->_inst->getInstitucionesRowCount();
        $totalRegistros = $arrayRowCount['CantidadRegistros'];


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
        
        //Variables de Ajax_JavaScript
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $totalRegistros = $this->getInt('total_registros');
        $paginador = new Paginador();


        $paginador->paginar( $totalRegistros,"listarInstituciones", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('listaIns', $this->_inst->getInstituciones($pagina,$filas));

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());

        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarInstituciones', false, true);
    }
    public function buscarporpalabras($dato = '')
    {
        
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $totalRegistros = $this->getInt('total_registros');   
        
        $paginador = new Paginador();

        $paginador->paginar( $totalRegistros,"listarInstituciones", "$dato", $pagina, CANT_REG_PAG, true);
        print_r($this->_inst->getInstitucionesBusqueda($pagina,CANT_REG_PAG,$dato)); exit;
        $this->_view->assign('listaIns', $this->_inst->getInstitucionesBusqueda($pagina,CANT_REG_PAG,$dato));

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('index', 'instituciones');
    }

}
?>