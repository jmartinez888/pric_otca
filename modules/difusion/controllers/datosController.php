<?php

use App\ForoTematica;
use App\Idioma;
use App\ODifusionTipo;
class datosController extends difusionController {

	public function create () {
		$this->prepareCreate('create_difusion', 1, 0);

	}

	public function all () {
	    $lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
	    $data['titulo'] = $lenguaje['str_datos_interes'];
	    $data['titulo_base'] = $lenguaje['str_datos_interes'];
	    $this->_view->assign($data);
	    $this->prepareAll('show_all', 1, 0);

	}
	public function index () {
		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$data['idiomas'] = Idioma::activos();
		$data['zone'] = 1;//datos
		$data['ruta'] = 'datos';//datos
		$data['tipo_difusion'] = ODifusionTipo::activos()->visibles()->get();
		$data['tematicas'] = ForoTematica::activos()->visibles()->get();
		$lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
		$data['titulo'] = $lenguaje['difusion_datos_index_titulo'];
		$this->_view->assign($data);
		$this->_view->render('index_difusion');
	}
}
 ?>