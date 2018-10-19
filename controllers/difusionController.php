<?php

use App\ForoTematica;
use App\Idioma;
use App\ODifusionTipo;
class difusionController extends Controller
{
    private $_bdrecursos;
    private $_excel;

    protected $ruta_images = ROOT.'files'.DS.'difusion'.DS.'contenido'.DS;
    protected $ruta_banners = ROOT.'files'.DS.'difusion'.DS.'banner'.DS;
    protected $image_types = ['image/jpeg', 'image/png'];

    public function __construct($lang,$url)
    {
        parent::__construct($lang,$url);
    }
    public function index()
    {
       $this->validarUrlIdioma();
    }
    public function casa($id, $asdasd) {
        echo $id.'-'.$asdasd;
        echo '-asdasd casa';
    }

    public function prepareCreate ($view, $datos = 0, $eventos = 0) {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $data['idiomas'] = Idioma::activos();
        $data['tipo_difusion'] = ODifusionTipo::activos()->visibles()->get();
        $data['tematicas'] = ForoTematica::activos()->visibles()->get();
        $this->_view->getLenguaje('difusion_contenido_index');

        //generar variables para los inputs del form en el cliente
        $vars_idioma = [];
        $data['idiomas']->map(function($item) use(&$vars_idioma){
            $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
                'id' => $item->Idi_IdIdioma,
                'titulo' => '',
                'descripcion' => '',
                'palabras_clave' => '',
                'contenido' => ''
            ];
        });
        $data['data_vue'] = [
            'idiomas' => $vars_idioma,
            'idioma_actual' => Cookie::lenguaje(),
            'tipo' => count($data['tipo_difusion']) > 0 ? $data['tipo_difusion'][0]->ODit_IdTipoDifusion : 0,
            'linea_tematica' => count($data['tematicas']) > 0 ? $data['tematicas'][0]->Lit_IdLineaTematica : 0,
            'imagen' => null,
            'datos_interes' => $datos,
            'eventos_interes' => $eventos
        ];

        // $lenguaje = $this->_view->LoadLenguaje('foro_admin_tematica');
        // $this->_view->getLenguaje('foro_admin_tematica');
        $this->_view->assign($data);
        // $this->_view->render('../contenido/create');
        $this->_view->render($view);
    }
}
?>