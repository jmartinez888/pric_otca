<?php

use App\ContenidoTraducido;
use App\Idioma;
use App\OIndicadores;
use Illuminate\Database\Capsule\Manager as DB;
class indicadoresController extends difusionController {
	public function json ($modo) {
		$res = ['success' => false, 'msg'  => ''];
		switch ($modo) {
			case 'index':
				$build = OIndicadores::orderParaGestor()->visibles();
				if ($this->has(['l', 's'])) {
					$query = $this->getSql('q');
					if ($query && $query != '') {
						$build->where('OInd_Titulo', 'like', '%'.$query.'%');
					}
					$build->offset($this->getInt('s'))->limit($this->getInt('l'));
				}
				$rows =  $build->get()->map(function ($item) {
					$temp = $item->formatToArray();
					$temp['image'] = BASE_URL.'files/difusion/indicador/'.$item->OInd_IdIndicadores.'/'.$item->OInd_IconoPath;
					return $temp;
				});
				$this->_view->responseJson($rows);
				break;
			default:
				$this->_view->responseJson($res);
				exit;
				break;
		}
	}

	public function store () {
		// dd($_POST);
		// dd($_FILES);
		// $this->setStore();
		// $post = file_get_contents('php://input');


    if (!empty($_FILES["imagen"])) {
    	$image = $_FILES['imagen'];
        // $image['file_name'] = time().'_'.$_FILES['file']['name'];
        // $valid_extensions = array("jpeg", "jpg", "png");
        // $temporary = explode(".", $_FILES["file"]["name"]);
        // $file_extension = end($temporary);
        // if((($_FILES["hard_file"]["type"] == "image/png") || ($_FILES["file"]["type"] == "image/jpg") || ($_FILES["file"]["type"] == "image/jpeg")) && in_array($file_extension, $valid_extensions)){
        //     $sourcePath = $_FILES['file']['tmp_name'];
        //     $targetPath = "uploads/".$fileName;
        //     if(move_uploaded_file($sourcePath,$targetPath)){
        //         $uploadedFile = $fileName;
        //     }
        // }
			$lenguaje = $this->_view->LoadLenguaje(['difusion_contenido_index', 'request']);
			$res = ['success' => false, 'msg' => ''];
	    $idiomas = Idioma::activos();
	    $self = $this;
	    if ($this->has(['idiomas', 'estado','id'])) {
	    	$post = $_POST;
				DB::transaction(function () use ($self, &$res, $post, $idiomas, $lenguaje, $image) {
			      $row = new OIndicadores();
			      $opcionales = [];



			      foreach ($idiomas as $value) {
			          $idioma_var = "idioma_".$value->Idi_IdIdioma;
			          if (array_key_exists($idioma_var, $post['idiomas'])) {
			              if ($value->Idi_IdIdioma == Cookie::lenguaje()) {
			                  //por defecto agregar en el idioma actual
			                  $row->OInd_Titulo = $post['idiomas'][$idioma_var]['titulo'];
			                  $row->OInd_Descripcion = $post['idiomas'][$idioma_var]['descripcion'];
			                  $row->OInd_Estado = $post['estado'];
			                  $row->OInd_Color = '#af3';
			                  $row->Idi_IdIdioma = Cookie::lenguaje();
			                  $row->save();
			              } else {
			                  $opcionales[] = [
			                      'idioma' => $value->Idi_IdIdioma,
			                      'titulo' => $post['idiomas'][$idioma_var]['titulo'],
			                      'descripcion' => $post['idiomas'][$idioma_var]['descripcion']
			                  ];
			              }
			          }
			      }

			      if ($row->OInd_IdIndicadores != 0) {
			          foreach ($opcionales as  $value) {
			          	ContenidoTraducido::setRow('ora_indicadores', $row->OInd_IdIndicadores, 'OInd_Titulo', $value['titulo'], $value['idioma']);
			          	ContenidoTraducido::setRow('ora_indicadores', $row->OInd_IdIndicadores, 'OInd_Descripcion', $value['descripcion'], $value['idioma']);

			          }
			          $res['success'] = true;
			          $res['msg'] = str_replace('%contenido%', $row->OInd_Titulo, $lenguaje['difusion_contenido_index_registro_success']);
			      }


			      $path = $self->ruta_indicadores.$row->OInd_IdIndicadores.DS;
			      if (!file_exists($path))
              mkdir($path);
            $ext = explode('/', $image['type']);
            $namefinal = md5($image['name'].$row->OInd_IdIndicadores).'.'.end($ext);
            $destino_path = $path.$namefinal;
            // $destino_path = $path.rawurlencode($image['name']);

            if (move_uploaded_file($image['tmp_name'], $destino_path)) {
            	// $name_thumb = md5($image['name']).'.jpg';
            	// Helper::create_thumbnail_image($destino_path, $path.$name_thumb);
            }
            $ext = explode('/', $image['type']);
            $row->OInd_IconoPath = md5($image['name'].$row->OInd_IdIndicadores).'.'.end($ext);
            $row->save();


			  });
	    } else {
	    	$res['msg'] = $lenguaje['str_parametro_falta'];
	    }
    }


    $this->_view->responseJson($res);
	}
	public function create () {
		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$d = $this->_view->getLenguaje('difusion_contenido_index');
		$data['idiomas'] = Idioma::activos();
		$data['edit'] = false;
		$data['titulo'] = $d['str_indicadores'].' - '.$d['str_crear'];
		$data['idiomas']->map(function($item) use(&$vars_idioma){
        $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
            'id' => $item->Idi_IdIdioma,
            'titulo' => '',
            'descripcion' => ''
        ];
    });
    $data['data_vue'] = [
        'idiomas' => $vars_idioma,
        'idioma_actual' => Cookie::lenguaje(),
        'imagen' => null,
        'edit' => false,
        'image' => '',
        'image_banner' => '',
        'elemento_id' => 0,
    ];
		$this->_view->assign($data);
		$this->_view->render('create');
	}

	public function index() {
		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
		$data['titulo'] = $lenguaje['str_indicadores'];
		$this->_view->assign($data);
		$this->_view->render('index');
	}
}
 ?>