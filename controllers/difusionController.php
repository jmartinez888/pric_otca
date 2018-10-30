<?php

use App\ContenidoTraducido;
use App\ForoTematica;
use App\Idioma;
use App\ODifusion;
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
        if (!file_exists(ROOT.'files'.DS)) {
            mkdir(ROOT.'files'.DS);

        }
        if (!file_exists(ROOT.'files'.DS.'difusion'))
            mkdir(ROOT.'files'.DS.'difusion');

            if (!file_exists(ROOT.'files'.DS.'difusion'.DS.'contenido'.DS))
                mkdir(ROOT.'files'.DS.'difusion'.DS.'contenido'.DS);

            if (!file_exists(ROOT.'files'.DS.'difusion'.DS.'banner'.DS))
                mkdir(ROOT.'files'.DS.'difusion'.DS.'banner'.DS);

        else {
            if (!file_exists(ROOT.'files'.DS.'difusion'.DS.'contenido'.DS))
                mkdir(ROOT.'files'.DS.'difusion'.DS.'contenido'.DS);

            if (!file_exists(ROOT.'files'.DS.'difusion'.DS.'banner'.DS))
                mkdir(ROOT.'files'.DS.'difusion'.DS.'banner'.DS);
        }
    }
    public function index()
    {
       $this->validarUrlIdioma();
    }

    public function prepareCreate ($view, $titulo, $datos = 0, $eventos = 0) {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $data['idiomas'] = Idioma::activos();
        $data['tipo_difusion'] = ODifusionTipo::activos()->visibles()->get();
        $data['tematicas'] = ForoTematica::activos()->visibles()->get();
        $data['edit'] = false;
        $data['titulo'] = $titulo;
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
            'edit' => false,
            'datos_interes' => $datos,
            'elemento_id' => 0,
            'eventos_interes' => $eventos,
            'image' => ''
        ];

        // $lenguaje = $this->_view->LoadLenguaje('foro_admin_tematica');
        // $this->_view->getLenguaje('foro_admin_tematica');
        $this->_view->assign($data);
        // $this->_view->render('../contenido/create');
        $this->_view->render($view);
    }

    public function prepareEdit ($id, $view, $titulo, $datos = 0, $eventos = 0) {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $data['idiomas'] = Idioma::activos();
        $data['tipo_difusion'] = ODifusionTipo::activos()->visibles()->get();
        $data['tematicas'] = ForoTematica::activos()->visibles()->get();
        $data['edit'] = true;
        $data['titulo'] = $titulo;
        $lenguaje = $this->_view->getLenguaje('difusion_contenido_index');

        //generar variables para los inputs del form en el cliente
        if (is_numeric($id)) {
            // $row = ODifusion::where('ODif_IdDifusion', $id)->first();
            $row = ODifusion::withoutGlobalScope('translate')->find($id);
            if ($row) {
                $data['row'] = true;
                $vars_idioma = [];
                $data['idiomas']->map(function($item) use(&$vars_idioma, $row){
                    if ($row->Idi_IdIdioma == $item->Idi_IdIdioma) {
                        $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
                            'id' => $item->Idi_IdIdioma,
                            'titulo' => $row->ODif_Titulo,
                            'descripcion' => $row->ODif_Descripcion,
                            'palabras_clave' => $row->ODif_Palabras,
                            'contenido' => $row->ODif_Contenido,
                            'default' => 1
                        ];
                    } else {
                        $traducido = ContenidoTraducido::getRow(
                            'ora_difusion',
                            $row->ODif_IdDifusion,
                            $item->Idi_IdIdioma
                        );

                        $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
                            'id' => $item->Idi_IdIdioma,
                            'titulo' => '',
                            'descripcion' => '',
                            'contenido' => '',
                            'palabras_clave' => '',
                            'default' => 0
                        ];

                        if ($traducido->count() > 0) {
                            $vars_idioma['idioma_'.$item->Idi_IdIdioma]['titulo'] = $traducido->where(
                                'Cot_Columna',
                                'ODif_Titulo')->first()->Cot_Traduccion;

                            $vars_idioma['idioma_'.$item->Idi_IdIdioma]['descripcion'] = $traducido->where(
                                'Cot_Columna',
                                'ODif_Descripcion')->first()->Cot_Traduccion;

                            $vars_idioma['idioma_'.$item->Idi_IdIdioma]['contenido'] = $traducido->where(
                                'Cot_Columna',
                                'ODif_Contenido')->first()->Cot_Traduccion;

                            $vars_idioma['idioma_'.$item->Idi_IdIdioma]['palabras_clave'] = $traducido->where(
                                'Cot_Columna',
                                'ODif_Palabras')->first()->Cot_Traduccion;
                        }
                    }
                });
                $data['data_vue'] = [
                    'idiomas' => $vars_idioma,
                    'idioma_actual' => Cookie::lenguaje(),
                    // 'tipo' => count($data['tipo_difusion']) > 0 ? $data['tipo_difusion'][0]->ODit_IdTipoDifusion : 0,
                    'tipo' => $row->ODit_IdTipoDifusion,
                    // 'linea_tematica' => count($data['tematicas']) > 0 ? $data['tematicas'][0]->Lit_IdLineaTematica : 0,
                    'linea_tematica' => $row->Lit_IdLineaTematica,
                    'imagen' => null,
                    'edit' => true,
                    'datos_interes' => $row->ODif_Datos,
                    'eventos_interes' => $row->ODif_Evento,
                    'elemento_id' => $row->ODif_IdDifusion,
                    'image' => BASE_URL.'files/difusion/contenido/'.$row->ODif_IdDifusion.'/'.$row->ODif_BannerUrl
                ];
            }
        }

        // $lenguaje = $this->_view->LoadLenguaje('foro_admin_tematica');
        // $this->_view->getLenguaje('foro_admin_tematica');
        $this->_view->assign($data);

        // $this->_view->render('../contenido/create');
        $this->_view->render($view);
    }
}
?>