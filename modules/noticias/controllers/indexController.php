<?php



class indexController extends noticiasController
{
    private $_not;
    
    public function __construct($lang,$url) 
    {
        parent::__construct($lang,$url);
        $this->_not = $this->loadModel('index');        
    }
    
    public function index($id_noticia=1)
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

    public function admin(){
        // $this->_acl->autenticado();
        $this->validarUrlIdioma();
        // $this->_view->getLenguaje("index_inicio");
        $this->_view->assign('titulo', 'Noticias');
        $this->_view->setCss(array('base'));
        // echo "546546546";exit;

        $paginador = new Paginador();
        // $this->_view->assign('id_noticia', $id_noticia);
        // $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->assign('tipos_noticia',$this->_not->getTiposNoticias());
        $this->_view->assign('idiomas',$this->_not->getIdiomas());
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax'));
        $this->_view->renderizar('admin');
    }

    
    
}
?>