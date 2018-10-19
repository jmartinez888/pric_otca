<?php

use App\ContenidoTraducido;
use App\Idioma;
use App\ODifusionBanners;
use Illuminate\Database\Capsule\Manager as DB;
class bannerController extends difusionController {
	public function show ($id) {
		echo 'show';
	}

	public function delete ($id) {
		$this->setDelete();
		$lenguaje = $this->_view->LoadLenguaje('difusion_contenido_index');
		$res = ['success' => false, 'msg' => ''];
		if (is_numeric($id)) {
			$row = ODifusionBanners::find($id);
			if ($row) {

				$name = $row->ODib_Titulo;
				$row->delete();
				if (!$row->exists) {
					$res['success'] = true;
					$res['msg'] = str_replace('%banner%', $name, $lenguaje['difusion_banner_eliminar_success']);
				}
			} else {
				$res['msg'] = str_replace('%banner%', $name, $lenguaje['str_elemento_no_encontrado']);
			}
			$this->_view->responseJson($res);
		}
	}
	public function json ($modo) {
		$res = ['success' => false, 'msg'  => ''];
		switch ($modo) {
			case 'index':
				$rows = ODifusionBanners::all()->map(function ($item) {
					return [
						'id' => $item->ODib_IdDifBanner,
						'titulo' => $item->ODib_Titulo,
						'descripcion' => $item->ODib_Descripcion,
						'image' => BASE_URL.'files/difusion/banner/'.$item->ODib_IdDifBanner.'/'.$item->ODib_Banner
					];
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
		$lenguaje = $this->_view->LoadLenguaje(['difusion_contenido_index', 'request']);
		$res = ['success' => false, 'msg' => ''];

		if (!empty($_FILES["imagen"]) && in_array($_FILES['imagen']['type'], $this->image_types)) {
			$image = $_FILES['imagen'];

	    $idiomas = Idioma::activos();
	    $self = $this;

	    if ($this->has(['idiomas', 'estado'])) {
	    	$post = $_POST;
				DB::transaction(function () use ($self, &$res, $post, $idiomas, $lenguaje, $image) {
			      $new = new ODifusionBanners();
			      $opcionales = [];
			      foreach ($idiomas as $value) {
			          $idioma_var = "idioma_".$value->Idi_IdIdioma;
			          if (array_key_exists($idioma_var, $post['idiomas'])) {
			              if ($value->Idi_IdIdioma == Cookie::lenguaje()) {
			                  //por defecto agregar en el idioma actual
			                  $new->ODib_Titulo = $post['idiomas'][$idioma_var]['titulo'];
			                  $new->ODib_Descripcion = $post['idiomas'][$idioma_var]['descripcion'];
			                  $new->ODif_IdDifusion = $post['difusion'];
			                  $new->ODib_Estado = $post['estado'];
			                  $new->Idi_IdIdioma = Cookie::lenguaje();
			                  $new->save();
			              } else {
			                  $opcionales[] = [
			                      'idioma' => $value->Idi_IdIdioma,
			                      'titulo' => $post['idiomas'][$idioma_var]['titulo'],
			                      'descripcion' => $post['idiomas'][$idioma_var]['descripcion']
			                  ];
			              }
			          }
			      }

			      if ($new->ODib_IdDifBanner != 0) {
			          foreach ($opcionales as  $value) {
			          	ContenidoTraducido::setRow('ora_difusion_banner', $new->ODib_IdDifBanner, 'ODib_Titulo', $value['titulo'], $value['idioma']);
			          	ContenidoTraducido::setRow('ora_difusion_banner', $new->ODib_IdDifBanner, 'ODib_Descripcion', $value['descripcion'], $value['idioma']);
			          }

			          $res['success'] = true;
			          $res['msg'] = str_replace('%contenido%', $new->ODib_Titulo, $lenguaje['difusion_contenido_index_registro_success']);
			      }
			      $path = $self->ruta_banners.$new->ODib_IdDifBanner.DS;
			      if (!file_exists($path))
              mkdir($path);
            $ext = explode('/', $image['type']);
            // $ext = end($ext);
            $name = md5($image['name'].$new->ODib_IdDifBanner).'.'.end($ext);
            $destino_path = $path.$name;

            if (move_uploaded_file($image['tmp_name'], $destino_path)) {
            	// $name_thumb = md5($image['name']).'.jpg';
            	// Helper::create_thumbnail_image($destino_path, $path.$name_thumb);
	            $new->ODib_Banner = $name;
	            // $new->ODif_Image = $name_thumb;
	            $new->save();
            }


			  });
	    } else
	    	$res['msg'] = $lenguaje['str_parametro_falta'];
		} else
			$res['msg'] = $lenguaje['str_verificar_imagen_error'];
		$this->_view->responseJson($res);
	}
	public function index() {
		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
		$data['titulo'] = $lenguaje['difusion_banner_index_titulo'];
		$this->_view->assign($data);
		$this->_view->render('banner');
	}
	public function create () {
		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$d = $this->_view->getLenguaje('difusion_contenido_index');
		$data['idiomas'] = Idioma::activos();

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
        'imagen' => null
    ];
		$this->_view->assign($data);
		$this->_view->render('create');
	}
}

 ?>