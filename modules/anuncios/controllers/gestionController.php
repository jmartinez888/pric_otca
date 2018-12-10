<?php

/**
 * Description of loginContanuncioler
 * @author anuncioORO
 */
class gestionController extends anunciosController {

  protected $_link;
  protected $service;
  private $_gestionm;

  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
    $this->_view->assign('_url', BASE_URL . "modules/" . $this->_request->getModulo() . "/views/");
    $this->getLibrary("ServiceResult");
    $this->service = new ServiceResult();
     $this->_gestionm= $this->loadModel('_gestion');     
  }

    public function enviarEmailAnuncios($id = false, $from = false)
    {
        $this->_acl->acceso('editar_rol');
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("index_inicio");
        $this->_view->setJs(array('anuncios'));

        $pagina = $this->getInt('pagina');
        //$registros = $this->getInt('registros');
        $nombre = $this->getSql('nombre');
        $_model = $this->loadModel("_gestion");

        $anuncio=array();
        $usuarios=array();

        if($from=='elearning'){
            $anuncio = $_model->getAnuncio($this->filtrarInt($id));
            $usuarios = $_model->getEmailMatriculadosCurso($anuncio['Cur_IdCurso']);
            $curso = $_model->getCursoXid($anuncio['Cur_IdCurso']);
        }

        if ($this->botonPress("bt_cancelarEditarAnuncio")) {

            if($from='elearning')
            $this->redireccionar('elearning/gestion/anuncios/'.$anuncio['Cur_IdCurso']);
        }

        if ($this->botonPress("enviar")) 
        {          

            for($i=1; $i<=count($usuarios);$i++){
                // $variable='usu'.$i;
                $Usu_IdUsuario = $this->getInt('usu'.$i);
                $contenido = "";
                if (null !== $this->getInt('usu'.$i) && $usuarios[$i]["Usu_IdUsuario"] == $Usu_IdUsuario){
                    $contenido = str_replace("|nombre|",$usuarios[$i]["Usu_Nombre"],$anuncio['Anc_Descripcion']);

                    $contenido = str_replace("|apellido|",$usuarios[$i]["Usu_Apellido"],$anuncio['Anc_Descripcion']);

                    $contenido = str_replace("|usuario|",$usuarios[$i]["Usu_Usuario"],$anuncio['Anc_Descripcion']);

                    $contenido = str_replace("|titulo_curso|",$curso["Cur_Titulo"],$anuncio['Anc_Descripcion']);
                    
                    
                    $this->sendEmail($usuarios[$i]["Usu_Email"],$anuncio['Anc_Titulo'],$contenido);
                    
                    $this->_view->assign('_mensaje', 'Anuncio Enviado');

                } else {
                    # code...
                }
                
                
            }
        }        
        // $this->_view->assign('idiomas',$this->_aclm->getIdiomas());        
        $this->_view->assign('usuarios',$usuarios);
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->assign('numeropagina', 1);
        $this->_view->assign('datos',$anuncio);
        $this->_view->assign('from', $from);
        $this->_view->renderizar('enviarEmailAnuncio','enviarEmailAnuncio');
    }

     public function sendEmail($Email,$Subject,$contenido)
    {
        $fromName = 'PRIC - Anuncio de Curso';
        // Parametro ($forEmail, $forName, $Subject, $contenido, $fromName = "Proyecto PRIC")
        $Correo = new Correo();
        $SendCorreo = $Correo->enviar($Email, "NAME", $Subject, $contenido, $fromName);
    }
}
