<?php

use App\ContenidoTraducido;
use App\ForoTematica;
use App\Idioma;
use App\ODifusion;
use App\ODifusionIndicadores;
use App\ODifusionTipo;
use Dompdf\Dompdf;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Support\Carbon;
class contenidoController extends difusionController {
	protected $ruta_iconos = 'iconos';
	protected $ruta_banners = 'banner';

	private function _export ($query, $formato) {
		$lenguaje = $this->_view->getLenguaje('difusion_contenido_index');


		$rows = $query->get();
		switch ($formato) {
			case 'pdf':
				$data = $rows->map(function($item) use ($lenguaje) {
            $item->ODif_Descripcion = str_limit($item->ODif_Descripcion, 100);
            $item->ODif_Estado = +$item->ODif_Estado == 1 ? $lenguaje['str_activo'] : $lenguaje['str_inactivo'];
                return $item;
        });
        $this->_view->assign('difusiones', $data);
        $html = $this->_view->render('pdf/pdf_difusion_contenido', false, true);
        // echo $html;exit;
        $dompdf = new Dompdf();
        $dompdf->loadHtml($html);
        $dompdf->setPaper('A4', 'landscape');
        $dompdf->render();
        $dompdf->stream(APP_NAME.'-OTCA_'.mb_strtoupper($lenguaje['difusion_contenido_index_titulo']).'.pdf');
				break;
			case 'csv':

				$objPHPExcel = new PHPExcel();
	      $data = $rows;
	      $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, '#');
	      $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, $lenguaje['str_nombre']);
	      $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, $lenguaje['str_descripcion']);
	      $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, $lenguaje['str_estado']);
	      $init = 2;
	      foreach ($data as $value) {
	          $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $init, $init - 1);
	          $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $init, $value->ODif_Titulo);
	          $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $init, $value->ODif_Descripcion);
	          $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $init, $value->ODif_Estado);
	          $init++;
	      }
	      $objPHPExcel->getActiveSheet()->setTitle(mb_strtoupper($lenguaje['str_difusion']));
	      $objPHPExcel->setActiveSheetIndex(0);
	      ob_end_clean();
	      ob_start();


        header("Content-type: application/vnd.ms-excel");
        header("Pragma: no-cache"); header("Expires: 0");
        echo "\xEF\xBB\xBF"; //UTF-8 BOM echo $out;
        //
        header('Content-Disposition: attachment;filename="'.APP_NAME.'-OTCA'.mb_strtoupper($lenguaje['difusion_contenido_index_titulo']).'.csv"');
        header('Cache-Control: max-age=0');
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'CSV');
        $objWriter->save('php://output');
				break;
			case 'excel':
				$objPHPExcel = new PHPExcel();
	      $data = $rows;
	      $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, '#');
	      $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, $lenguaje['str_nombre']);
	      $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, $lenguaje['str_descripcion']);
	      $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, $lenguaje['str_estado']);
	      $init = 2;
	      foreach ($data as $value) {
	          $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $init, $init - 1);
	          $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $init, $value->ODif_Titulo);
	          $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $init, $value->ODif_Descripcion);
	          $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $init, $value->ODif_Estado);
	          $init++;
	      }
	      $objPHPExcel->getActiveSheet()->setTitle(mb_strtoupper($lenguaje['str_difusion']));
	      $objPHPExcel->setActiveSheetIndex(0);
	      ob_end_clean();
	      ob_start();
	      header('Content-Type: application/vnd.ms-excel');
	      header('Content-Disposition: attachment;filename="'.APP_NAME.'-OTCA_'.mb_strtoupper($lenguaje['difusion_contenido_index_titulo']).'.xls"');
	      header('Cache-Control: max-age=0');
	      $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
	      $objWriter->save('php://output');
				break;
		}
	}
	public function datatable () {
		$query = ODifusion::select();
		if ($this->has('zone')) {
			if ($this->getInt('zone') == 1)
				$query->where('ODif_Datos', 1);
			if ($this->getInt('zone') == 2)
				$query->where('ODif_Evento', 1);
		}
		$records_total = $query->count();
		$records_total_filter = $records_total;

		if ($this->filledGet('buscar')) {
			$query->where(function($q) {
				$q->orWhere('ODif_Titulo', 'like', '%'.$_GET['buscar'].'%')
					->orWhere('ODif_Descripcion', 'like', '%'.$_GET['buscar'].'%');
			});
			$records_total_filter = $query->count();
		}

		if ($this->filledGet('export')) {
			$this->_export($query, $this->getTexto('export'));
		} else {
			$rows = $query->offset($_GET['start'])->limit($_GET['length'])->get();

			$data = [
				'draw' => +$_GET['draw'],
				'recordsTotal' => $records_total,
        'recordsFiltered' => $records_total_filter,
        'data' => $rows
			];

			$this->_view->responseJson($data);

		}
	}
	private function update ($id) {
		$res = ['success' => false, 'msg' => ''];
		if ($this->has('metodo')) {
			$metodo = $this->getTExto('metodo');
			$lenguaje = $this->_view->LoadLenguaje('difusion_contenido_index');
			switch ($metodo) {
				case 'estado':
					if ($this->has(['estado', 'datos', 'banner', 'evento', 'id'])) {
						$row = ODifusion::find($this->getInt('id'));
						if ($row) {
							DB::transaction(function() use ($row, $lenguaje, &$res) {
								$row->ODif_Estado = $this->getInt('estado');
								$row->ODif_Datos = $this->getInt('datos');
								$row->ODif_Evento = $this->getInt('evento');
								$row->ODif_Banner = $this->getInt('banner');
								$row->save();
								$res['msg'] = $lenguaje['str_success_update'];
								$res['success'] = true;
							});

						}
					}
					break;
			}
		}
		$this->_view->responseJson($res);
	}
	public function store () {
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
			$lenguaje = $this->_view->LoadLenguaje('difusion_contenido_index');
			$res = ['success' => false, 'msg' => ''];
	    $idiomas = Idioma::activos();
	    $self = $this;
	    if ($this->has(['idiomas', 'estado', 'evento', 'datos', 'tipo', 'linea_tematica'])) {
	    	$post = $_POST;
				DB::transaction(function () use ($self, &$res, $post, $idiomas, $lenguaje, $image) {
			      $difusion = new ODifusion();
			      $opcionales = [];



			      foreach ($idiomas as $value) {
			          $idioma_var = "idioma_".$value->Idi_IdIdioma;
			          if (array_key_exists($idioma_var, $post['idiomas'])) {
			              if ($value->Idi_IdIdioma == Cookie::lenguaje()) {
			                  //por defecto agregar en el idioma actual
			                  $difusion->ODif_Titulo = $post['idiomas'][$idioma_var]['titulo'];
			                  $difusion->ODif_Descripcion = $post['idiomas'][$idioma_var]['descripcion'];
			                  $difusion->ODif_Contenido = $post['idiomas'][$idioma_var]['contenido'];
			                  $difusion->ODif_Palabras = $post['idiomas'][$idioma_var]['palabras_clave'];
			                  $difusion->ODit_IdTipoDifusion = $post['tipo'];
			                  $difusion->ODif_Estado = $post['estado'];

			                  $difusion->ODif_Evento = $post['evento'];
			                  $difusion->ODif_Datos = $post['datos'];

			                  $difusion->Lit_IdLineaTematica = $post['linea_tematica'];
			                  $difusion->ODif_FechaPublicacion = Carbon::now();
			                  // $difusion->ODif_BannerUrl = 'http://local.github/pric_otca/views/layout/frontend/img/slider_noticias/noticia1.jpg';
			                  // $difusion->ODif_Image = 'http://local.github/pric_otca/views/layout/frontend/img/img-noti1.jpg';

			                  // $difusion->Usu_IdUsuario =
			                  $difusion->Idi_IdIdioma = Cookie::lenguaje();
			                  $difusion->save();
			              } else {
			                  $opcionales[] = [
			                      'idioma' => $value->Idi_IdIdioma,
			                      'titulo' => $post['idiomas'][$idioma_var]['titulo'],
			                      'descripcion' => $post['idiomas'][$idioma_var]['descripcion'],
			                      'contenido' => $post['idiomas'][$idioma_var]['contenido'],
			                      'palabras_clave' => $post['idiomas'][$idioma_var]['palabras_clave']
			                  ];
			              }
			          }
			      }

			      if ($difusion->ODif_IdDifusion != 0) {
			          foreach ($opcionales as  $value) {
			          	ContenidoTraducido::setRow('ora_difusion', $difusion->ODif_IdDifusion, 'ODif_Titulo', $value['titulo'], $value['idioma']);
			          	ContenidoTraducido::setRow('ora_difusion', $difusion->ODif_IdDifusion, 'ODif_Descripcion', $value['descripcion'], $value['idioma']);
			          	ContenidoTraducido::setRow('ora_difusion', $difusion->ODif_IdDifusion, 'ODif_Contenido', $value['contenido'], $value['idioma']);
			          	ContenidoTraducido::setRow('ora_difusion', $difusion->ODif_IdDifusion, 'ODif_Palabras', $value['palabras_clave'], $value['idioma']);


			          }

			          $res['success'] = true;
			          $res['msg'] = str_replace('%contenido%', $difusion->ODif_Titulo, $lenguaje['difusion_contenido_index_registro_success']);
			      }

			      $path = $self->ruta_images.$difusion->ODif_IdDifusion.DS;
			      if (!file_exists($path))
              mkdir($path);
            $destino_path = $path.rawurlencode($image['name']);

            if (move_uploaded_file($image['tmp_name'], $destino_path)) {
            	$name_thumb = md5($image['name']).'.jpg';
            	Helper::create_thumbnail_image($destino_path, $path.$name_thumb);
            }

            $difusion->ODif_BannerUrl = $image['name'];
            $difusion->ODif_Image = $name_thumb;
            $difusion->save();


			  });
	    } else {

	    }
    }


    $this->_view->responseJson($res);
	}
	public function edit ($id) {
		echo 'edit'.$id;
	}
	public function show ($id) {
		$difusion = ODifusion::find($id);
		if ($this->isAcceptJson()) {
			$res = ['success' => false, 'data' => null];
			if ($difusion)
				$res['data'] = $difusion;
			$this->_view->responseJson($res);
		} else {
			$data['interes_evento'] = ODifusion::eventos_interes()->get();
      $data['interes_datos'] = ODifusion::datos_interes()->get();
      // $data['contenido_relacionado'] = $difusion->getRelacionado();
			$this->_view->setTemplate(LAYOUT_FRONTEND);

			$date = new Carbon($difusion->ODif_FechaPublicacion);
			$date->setLocale('es');
			// dd($date->format('l jS \\of F Y h:i:s A'));
			// dd($difusion->getRelacionado());
			$data['difusion'] = $difusion;
			$this->_view->assign($data);
			$this->_view->render('detalles');
		}
	}
	public function create () {
		// $this->_view->setTemplate(LAYOUT_FRONTEND);
		// $data['idiomas'] = Idioma::activos();
		// $data['tipo_difusion'] = ODifusionTipo::activos()->visibles()->get();
		// $data['tematicas'] = ForoTematica::activos()->visibles()->get();
		// $this->_view->getLenguaje('difusion_contenido_index');

		// //generar variables para los inputs del form en el cliente
		// $vars_idioma = [];
  //   $data['idiomas']->map(function($item) use(&$vars_idioma){
  //       $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
  //           'id' => $item->Idi_IdIdioma,
  //           'titulo' => '',
  //           'descripcion' => '',
  //           'palabras_clave' => '',
  //           'contenido' => ''
  //       ];
  //   });
  //   $data['data_vue'] = [
  //       'idiomas' => $vars_idioma,
  //       'idioma_actual' => Cookie::lenguaje(),
  //       'tipo' => count($data['tipo_difusion']) > 0 ? $data['tipo_difusion'][0]->ODit_IdTipoDifusion : 0,
  //       'linea_tematica' => count($data['tematicas']) > 0 ? $data['tematicas'][0]->Lit_IdLineaTematica : 0,
  //       'imagen' => null
  //   ];

		// // $lenguaje = $this->_view->LoadLenguaje('foro_admin_tematica');
		// // $this->_view->getLenguaje('foro_admin_tematica');
		// $this->_view->assign($data);
		// $this->_view->render('create');
		$this->prepareCreate('create');
	}
	// public function show ()
	public function index ($id = 'index', $accion = 'show') {


		if ($id == 'index') {
			// $this->create();
			$this->_view->setTemplate(LAYOUT_FRONTEND);
			$data['idiomas'] = Idioma::activos();
			$data['tipo_difusion'] = ODifusionTipo::activos()->visibles()->get();
			$data['tematicas'] = ForoTematica::activos()->visibles()->get();
			$lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
			$data['titulo'] = $lenguaje['difusion_contenido_index_titulo'];
			$this->_view->assign($data);
			$this->_view->render('index');
		} else {
		// 	switch ($accion) {
		// 		case 'show':
		// 			$this->show($id);
		// 			break;
		// 		case 'edit':
		// 			$this->show($id);
		// 			break;
		// 		case 'delete':
					$this->show($id);
		// 			break;
		// 		case 'update':
		// 			$this->update($id);
		// 			break;
		// 		default:
		// 			$this->show($id);
		// 			break;
		// 	}
		}
		// echo 'asd'.$id[0];
	}
	public function buscar ($query) {
		$rows = ODifusion::buscarByTitulo($query)->limit(5)->get();
		$datares = [];
		$rows->map(function ($item) use (&$datares){
			$datares[] = [
				'ODif_IdDifusion' => $item->ODif_IdDifusion,
				'ODif_Titulo' => $item->ODif_Titulo
			];
		});
		$this->_view->responseJson($datares);
	}
	public function datos_cifras () {
		$datos = ODifusionIndicadores::with(['difusion', 'indicador'])->get();
		$this->_view->responseJson($datos);
	}
}
?>