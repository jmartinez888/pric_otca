<?php

use App\ForoTematica;
use App\Idioma;
use App\ODifusionTipo;

class eventoController extends difusionController {
    public function edit ($id) {
        $lenguaje = $this->_view->LoadLenguaje('difusion_contenido_index');
        $this->prepareEdit($id, 'create_difusion', $lenguaje['difusion_evento_index_titulo'].' - '.$lenguaje['str_editar'], 0, 1);
    }
    public function create () {
        $lenguaje = $this->_view->LoadLenguaje('difusion_contenido_index');
    	$this->prepareCreate('create_difusion', $lenguaje['str_eventos_interes'] , 0, 1);
    }
    public function all () {
        $lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
        $data['titulo'] = $lenguaje['str_eventos_interes'];
        $data['titulo_base'] = $lenguaje['str_eventos_interes'];
        $this->_view->assign($data);
        $this->prepareAll('show_all', 0, 1);

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