<?php

use App\ODifusion;
use App\ODifusionBanners;
use App\ODifusionLinkInteres;

class pageController extends Controller
{
    //private $_inicio;
    private $_pagina;
    private $_dublinModel;
    private $_foroModel;
    private $_recursoModel;
    private $_jsonBusqueda;

    public function __construct($lang, $url)
    {
        parent::__construct($lang, $url);
        $this->_pagina = $this->loadModel('index', 'arquitectura');
    }

    public function index($idPagina = 5)
    {
       
    }
    public function getRaizPadre($arbolRaiz,$padreI = true)
    {
        $padre = "";
        //print_r($arbolRaiz);
        $href = $arbolRaiz[0]['Pag_IdPagina'];
        $Pag_Nombre = $arbolRaiz[0]['Pag_Nombre'];
        if ($padreI)
        {
            $raiz = " <li>/</li><li> <a class='actual'>".$Pag_Nombre." </a> </li> :: ";
            $padre .= $raiz;
        }
        else
        {
            $raiz = " <li>/</li><li> <a href='".BASE_URL."index/index/".$href."'>".$Pag_Nombre." </a> </li> :: ";
            $padre .= $raiz;
        }

        for ($i = 0; $i < count($arbolRaiz); $i++)
        {
            if (!empty($arbolRaiz[$i]["padre"]))
            {
                $raizPadre = $arbolRaiz[$i]["padre"];
                $temph = $this->getRaizPadre($raizPadre,false);
                $padre .= $temph;
            }
        }
        return $padre;
    }

    public function item($idPagina=false)
    {
                   // $this->_acl->autenticado();
            $this->validarUrlIdioma();
            $this->_view->setTemplate(LAYOUT_FRONTEND);
            $this->_view->getLenguaje("page_item");
            $this->_view->setJs(array('item'));
            $condicion1 = '';
            $id = $this->filtrarInt($idPagina);
        // echo Cookie::lenguaje();
            $condicion1 .= " WHERE pa.Pag_Estado = 1 AND pa.Pag_IdPagina = $id ";
            $datos = $this->_pagina->getPaginaTraducida($condicion1, Cookie::lenguaje());

            $datos;        
            //MenuRaiz
            if (!empty($datos))
            {
                $padre = "";
                $arbolRaiz = $this->_pagina->getMenusRaiz($datos['Pag_TipoPagina'],$id);
                if(!empty($arbolRaiz) && count($arbolRaiz)){
                    if (!empty($arbolRaiz[0])) {
                        $padre = $this->getRaizPadre($arbolRaiz);
                    }
                }
         
                $arrayRaiz = array_reverse(explode("::", $padre));
                $arrayRaiz = array_chunk($arrayRaiz, 1);
                $this->_view->assign('menuRaiz', $arrayRaiz);
            }
            $this->_view->addViews('modules'.DS.'difusion'.DS.'views'.DS.'contenido'.DS);

            $this->_view->assign('datos', $datos);
            $this->_view->assign('titulo', $datos['Pag_Nombre']);
            $this->_view->render('item');
        
    }

    public function attachments(){
        $this->_view->getLenguaje("page_attachments");
        $palabra = $this->getSql('palabra'); 
        $this->_view->setJs(array("item"));

        $this->_view->assign('search', $palabra);
        $this->_view->renderizar('ajax/attachments', false, true);
    }
}

?>
