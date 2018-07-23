<?php



class indexController extends noticiasController
{
    private $_not;
    
    public function __construct($lang,$url) 
    {
        parent::__construct($lang,$url);
        $this->_not = $this->loadModel('index');        
    }
    
    public function index($id_noticia=0)
    {       
        // $this->_acl->autenticado();
        $this->validarUrlIdioma();
        // $this->_view->getLenguaje("index_inicio");
        $this->_view->assign('titulo', 'Noticias');
        $this->_view->setCss(array('base'));
        // echo "546546546";exit;

        
        $this->_view->assign('id_noticia', $id_noticia);
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->renderizar('index');
    }

    
    
}
?>