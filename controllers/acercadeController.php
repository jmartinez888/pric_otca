<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class acercadeController extends Controller{
    public function __construct($lang, $url) {
        parent::__construct($lang, $url);
    }
	public function index($pagina = false) {
        //Para idioma
        $this->validarUrlIdioma();
        $this->_view->setTemplate(LAYOUT_FRONTEND); 
        $this->_view->getLenguaje("index_inicio");      
        $this->_view->renderizar('index');
    }
    public function otca()
    {
    	
        $this->validarUrlIdioma();
        $this->_view->setTemplate(LAYOUT_FRONTEND); 
        $this->_view->getLenguaje("index_inicio");      
        $this->_view->renderizar('otca');
    }
    public function ora()
    {    	
        $this->validarUrlIdioma();
        $this->_view->setTemplate(LAYOUT_FRONTEND); 
        $this->_view->getLenguaje("index_inicio");      
        $this->_view->renderizar('ora');
    }
}
?>
