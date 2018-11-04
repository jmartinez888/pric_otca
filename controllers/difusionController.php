<?php

use App\ContenidoTraducido;
use App\ForoTematica;
use App\Idioma;
use App\ODifusion;
use App\ODifusionTipo;
use Carbon\Carbon;
use voku\helper\Paginator;
use Jenssegers\Date\Date;
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
    public function prepareAll ($view, $datos = 0, $eventos = 0, $id = 0) {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->addViews('modules'.DS.'difusion'.DS.'views'.DS.'contenido'.DS);
        // $lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
        $rows = [];
        $length = 9;
        $start = 0;
        $total = 0;
        $rows = collect();
        $data['no_existe'] = true;
        if ($this->has('page')) {
            $start = ($this->getInt('page') - 1)*$length;
        }
        if ($id == 0) {

            $build  = ODifusion::select();
            if ($datos == 1) {
                $build = $build->datos_interes();
            }
            if ($eventos == 1) {
                $build = $build->eventos_interes();
            }
            $total = $build->count();
            $rows = $build->offset($start)->limit($length)->get();
            $data['no_existe'] = false;
        } else {
            $row = ODifusion::find($id);
            if ($row != null) {
                $data['no_existe'] = false;
                $pre = $row->getRelacionado($length, $start);
                $rows = $pre['data'];
                $total = $pre['count'];
                $data['palabras'] = $pre['palabras'];
            }
        }
        Date::setLocale(Cookie::lenguaje());
        $data['rows'] = $rows->map(function ($item) {

            $rr = new Date($item->ODif_FechaPublicacion);
            $item->ODif_FechaPublicacion = $rr;
            $item->ODif_Titulo = str_limit($item->ODif_Titulo, 80);
            return $item;
        });

        $pages = new Paginator($length,'page');
        $pages->set_total($total);
        $data['pages'] = $pages->page_links();
        $this->_view->assign($data);
        $this->_view->render($view);


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
        $refs_difu = [];
        $data['idiomas']->map(function($item) use(&$vars_idioma, &$refs_difu){
            $refs_difu['idioma_'.$item->Idi_IdIdioma] = [
                'id' => $item->Idi_IdIdioma,
                'text' => ''
            ];
            $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
                'id' => $item->Idi_IdIdioma,
                'titulo' => '',
                'descripcion' => '',
                'palabras_clave' => '',
                'contenido' => ''
            ];
        });
        $refs = [
            ['url' => '', 'idiomas' => $refs_difu]
            // ['url' => '', 'idiomas' => $idiomas_refs]
        ];
        $data['referencias'] = [];
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
            'image' => '',
            'referencias' => $refs,
            'ref_clean' => $refs[0],

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
                $refs_difu = [];
                $data['idiomas']->map(function($item) use(&$vars_idioma, $row, &$refs_difu){
                    $refs_difu = $row->referencias()->withoutGlobalScope('translate')->get();

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
                $refs = [];
                $ref_clean = [];
                // dd($refs_difu);
                if (count($refs_difu) > 0) {
                    $ref_for_clean = [];
                    foreach ($refs_difu as  $row_ref) {
                        $vars_idioma_ref = [];
                        $data['idiomas']->map(function($item) use(&$vars_idioma_ref, $row_ref, &$ref_for_clean) {
                            $ref_for_clean['idioma_'.$item->Idi_IdIdioma] = [
                                'id' => $item->Idi_IdIdioma,
                                'text' => ''
                            ];
                            if ($row_ref->Idi_IdIdioma == $item->Idi_IdIdioma) {
                                $vars_idioma_ref['idioma_'.$item->Idi_IdIdioma] = [
                                    'id' => $item->Idi_IdIdioma,
                                    'text' => $row_ref->ODir_Titulo,
                                    'default' => 1
                                ];
                            } else {
                                $traducido = ContenidoTraducido::getRow(
                                    'ora_difusion_referencias',
                                    $row_ref->ODir_IdRefDif,
                                    $item->Idi_IdIdioma
                                );
                                $vars_idioma_ref['idioma_'.$item->Idi_IdIdioma] = [
                                    'id' => $item->Idi_IdIdioma,
                                    'text' => '',
                                    'default' => 0
                                ];
                                if ($traducido->count() > 0) {
                                    $vars_idioma_ref['idioma_'.$item->Idi_IdIdioma]['text'] = $traducido->where(
                                        'Cot_Columna',
                                        'ODir_Titulo')->first()->Cot_Traduccion;
                                }
                            }

                        });
                        $refs[] = ['elemento_id' => $row_ref->ODir_IdRefDif, 'url' => $row_ref->ODir_Url, 'idiomas' => $vars_idioma_ref];
                    }
                    $ref_clean = ['elemento_id' => 0, 'url' => '', 'idiomas' => $ref_for_clean];
                } else {
                    $vars_idioma_ref = [];
                    $refs_difu = [];
                    $data['idiomas']->map(function($item) use(&$vars_idioma_ref, &$refs_difu){
                        $refs_difu['idioma_'.$item->Idi_IdIdioma] = [
                            'id' => $item->Idi_IdIdioma,
                            'text' => ''
                        ];
                    });
                    $refs = [
                        ['elemento_id' => 0, 'url' => '', 'idiomas' => $refs_difu]
                        // ['url' => '', 'idiomas' => $idiomas_refs]
                    ];
                    $ref_clean = $refs[0];
                }

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
                    'image' => BASE_URL.'files/difusion/contenido/'.$row->ODif_IdDifusion.'/'.$row->ODif_BannerUrl,
                    'referencias' => $refs,
                    'ref_clean' => $ref_clean
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