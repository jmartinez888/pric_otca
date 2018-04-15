<?php

class ofertasacademicasController extends ofertaController
{	
	private $_inst;
	public function __construct($lang, $url) {
        parent::__construct($lang, $url);
        $this->_inst=$this->loadModel('ofertasacademicas');
    }

    public function index() {
    	$this->validarUrlIdioma();
    	
    	$this->_view->setJs(array('index'));

		$nombre = $this->getSql('nombre');
        $pagina = $this->getInt('pagina');
        $paginador = new Paginador();

        $arrayRowCount = $this->_inst->getOfertasRowCount();
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        $this->_view->assign('paises', $this->_inst->getPaises());
        $this->_view->assign('numeracion', 0);
        $this->_view->assign('totalRegistros', 0);
    	$lista=$this->_inst->getOfertas(0,CANT_REG_PAG);
    	$paginador->paginar( $totalRegistros,"listarOfertas", "", $pagina, CANT_REG_PAG, true);
    	
    	$this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        


    	$this->_view->assign('listaIns', $lista);
    	$this->_view->assign('titulo', 'Ofertas Académicas');
    	$this->_view->setTemplate(LAYOUT_FRONTEND);
    	$this->_view->renderizar('index','OfertasAcademicas');

    }

    public function _paginacion_listarOfertas($txtBuscar = false) 
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
        $paginador->paginar( $totalRegistros,"listarOfertas", "$txtBuscar", $pagina, $filas, true);
        $this->_view->assign('numeracion', $numeracion);
        $this->_view->assign('listaIns', $this->_inst->getOfertas($pagina,$filas));
        $this->_view->assign('totalRegistros', 0);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('titulo', 'Ofertas Academicas');
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarOfertas', false, true);
    }
public function buscarporpalabras($dato = '')
    {
        if($dato=="all"){$dato="";}
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $arrayRowCount = $this->_inst->getOfertasBusquedaRowCount($dato);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];  
        $this->_view->setJs(array('index'));
        $paginador = new Paginador();
        if($pagina==0){
        $numeracion=0;
    }else{
        $numeracion=($pagina-1)*10;    
    }
        $this->_view->assign('titulo', 'Ofertas Académicas');
        $paginador->paginar( $totalRegistros,"listarOfertas", "$dato", $pagina, CANT_REG_PAG, true);
        $this->_view->assign('listaIns', $this->_inst->getOfertasBusqueda($pagina,CANT_REG_PAG,$dato));
        $this->_view->assign('numeracion', $numeracion);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('index', 'ofertasacademicas');
    }
    public function ficha($id=false) {
        $this->validarUrlIdioma();
        
        $this->_view->setJs(array('index'));

        $lista=$this->_inst->getOfertaPorId($id);
        
        $this->_view->assign('listaIns', $lista);
        $this->_view->assign('titulo', 'Ficha de Oferta');
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->renderizar('ficha','ofertasacademicas');

    }
}
?>