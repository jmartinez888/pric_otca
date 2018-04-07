<?php

class indexController extends ofertaController
{
	
	public function __construct($lang, $url) {
        parent::__construct($lang, $url);
    }

    public function index() {
    	$this->validarUrlIdioma();
    	$this->_view->assign('titulo', 'Oferta Académica');
    	$this->_view->setTemplate(LAYOUT_FRONTEND);
    	$this->_view->renderizar('index');
    }
}
?>