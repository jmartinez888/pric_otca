<?php

use App\ForoTematica;
use App\Idioma;
use App\ODifusionTipo;

class eventoController extends difusionController {

public function create () {
	$this->prepareCreate('create_difusion', 0, 1);
}
  public function index () {
    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $data['idiomas'] = Idioma::activos();
    $data['zone'] = 2;//evento
    $data['ruta'] = 'evento';//evento
    $data['tipo_difusion'] = ODifusionTipo::activos()->visibles()->get();
    $data['tematicas'] = ForoTematica::activos()->visibles()->get();
    $lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
    $data['titulo'] = $lenguaje['difusion_evento_index_titulo'];
    $this->_view->assign($data);
    $this->_view->render('index_difusion');
  }
}
 ?>