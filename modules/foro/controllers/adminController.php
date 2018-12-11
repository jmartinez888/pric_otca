<?php

use App\ContenidoTraducido;
use App\ForoTematica;
use App\Idioma;
use Dompdf\Dompdf;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Support\Collection as TTT;
// use Recursos\App\DataTables as DataTables;
// use Illuminate\Support\DB as DB;
// use Illuminate\Support\VarDumper;
class adminController extends foroController
{

    private $_model;

    public function __construct($lang, $url)
    {
        parent::__construct($lang, $url);
        $this->_model = $this->loadModel('admin');
    }

    public function index()
    {
       
        $this->_acl->acceso("foro_list_admin");
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("foro_admin_index");
        $lenguaje = Session::get("fileLenguaje");
        $this->_view->assign('titulo', $lenguaje["foro_admin_titulo"]);
        $this->_view->setJs(array('index'));

        $paginador      = new Paginador();
        $lista_foros    = $this->_model->getForos();
        $tipo_foros     = $this->_model->getForosTipos();
        $totalRegistros = $this->_model->getRowForos();

        $paginador->paginar($totalRegistros["For_NRow"], "listarForo", "", $pagina = 1, CANT_REG_PAG, true);

        if ($this->botonPress("export_data_excel")) {
            $this->_exportarDatos("excel");
        }

        if ($this->botonPress("export_data_pdf")) {
            $this->_exportarDatos("pdf");
        }

        if ($this->botonPress("export_data_csv")) {
            $this->_exportarDatos("csv");
        }

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->assign('lista_foros', $lista_foros);
        $this->_view->assign('tipo_foros', $tipo_foros);
        $this->_view->renderizar('index');
    }

    public function _paginacion_listarForo($filtro = false)
    {
        //Variables de Ajax_JavaScript
        $pagina         = $this->getInt('pagina');
        $filas          = $this->getInt('filas');
        $totalRegistros = $this->getInt('total_registros');
        $filtro2 = $this->getTexto('filtro2');

        $paginador = new Paginador();

        $paginador->paginar($totalRegistros, "listarForo", "$filtro", $pagina, $filas, true);

        $lista_foros    = $this->_model->getForos($filtro, $filtro2, $pagina, $filas);

        $this->_view->assign('lista_foros', $lista_foros);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarForo', false, true);
    }

    public function _buscarForo()
    {
        $filtro  = $this->getTexto('filtro');
        $filtro2 = $this->getTexto('filtro2');

        $paginador = new Paginador();

        $lista_foros    = $this->_model->getForos($filtro, $filtro2);
        $totalRegistros = $this->_model->getRowForos($filtro, $filtro2);

        $paginador->paginar($totalRegistros["For_NRow"], "listarForo", $filtro, $pagina = 0, CANT_REG_PAG, true);

        $this->_view->assign('lista_foros', $lista_foros);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarForo', false, true);
    }

     public function _exportarDatos($formatoP)
    {
        $filtro  = $this->getSql('text_busqueda');
        $filtro2 = $this->getSql('select_busqueda');
        $formato  = $formatoP;

        if (empty($filtro)) {
            $filtro  = "";
        }
        if(empty($filtro2)){
            $filtro2="";
        }
        $lista_foros = $this->_model->getForos($filtro, $filtro2, 1, CANT_REG_PAG);

        if ($formato == "csv") {
            if (!empty($lista_foros)) {
                error_reporting(0);
                $objPHPExcel = new PHPExcel();

                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, 'For_Titulo');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, 'For_NParticipantes');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, 'For_NComentarios');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, 'Usu_Usuario');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, 1, 'For_FechaCreacion');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(5, 1, 'For_FechaCierre');

                for ($i = 2; $i <= (count($lista_foros) + 1); $i++) {
                    // $fila11 = $lista_foros[$i - 2]['For_Titulo'];
                    // $fila11 = mb_convert_encoding($fila11, 'UTF-16LE', 'UTF-8');
                    // chr(255) . chr(254);
                    // echo $fila11; exit;
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $i, $lista_foros[$i - 2]['For_Titulo']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $lista_foros[$i - 2]['For_NParticipantes']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $i, $lista_foros[$i - 2]['For_NComentarios']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $i, $lista_foros[$i - 2]['Usu_Usuario']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, $i, $lista_foros[$i - 2]['For_FechaCreacion']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(5, $i, $lista_foros[$i - 2]['For_FechaCierre']);
                    // $fila11="";
                }
                $objPHPExcel->getActiveSheet()->setTitle('ListaDeDescargas');
                $objPHPExcel->setActiveSheetIndex(0);
                ob_end_clean();
                ob_start();
                //
                header("Content-type: application/vnd.ms-excel");
                header("Content-Disposition: attachment; filename='".$file_name."'");
                header("Pragma: no-cache"); header("Expires: 0");
                echo "\xEF\xBB\xBF"; //UTF-8 BOM echo $out;
                //
                header('Content-Disposition: attachment;filename="'.APP_NAME.'-OTCA_Descargas.csv"');
                $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'CSV');
                $objWriter -> setDelimiter ( ',' ) ;
                $objWriter->save('php://output');
            }
            exit;
        }
        if ($formato == "excel") {
            if (!empty($lista_foros)) {
                // echo "."; exit;
                error_reporting(0);
                $objPHPExcel = new PHPExcel();

                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, 'Foro');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, 'Participantes');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, 'Comentarios');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, 'Creador');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, 1, 'Fecha Creacion');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(5, 1, 'Fecha Cierre');

                for ($i = 2; $i <= (count($lista_foros) + 1); $i++) {
                    // for ($j = 0; $j < count($lista_foros[0]); $j++) {
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $i, $lista_foros[$i - 2]['For_Titulo']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $lista_foros[$i - 2]['For_NParticipantes']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $i, $lista_foros[$i - 2]['For_NComentarios']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $i, $lista_foros[$i - 2]['Usu_Usuario']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, $i, $lista_foros[$i - 2]['For_FechaCreacion']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(5, $i, $lista_foros[$i - 2]['For_FechaCierre']);

                }

                $objPHPExcel->getActiveSheet()->setTitle('ListaDeDescargas');
                $objPHPExcel->setActiveSheetIndex(0);
                ob_end_clean();
                ob_start();
                //Session::destroy('encabezado');
                // Session::destroy('Descargar');
                header('Content-Type: application/vnd.ms-excel');
                header('Content-Disposition: attachment;filename="'.APP_NAME.'-OTCA_Descargas.xls"');
                header('Cache-Control: max-age=0');
                $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
                $objWriter->save('php://output');
            }
            else{
                echo "lista vacia";exit;
            }
        }
        if ($formato == "pdf") {
            ob_start();
            header("Content-Type: text/html;charset=utf-8");

            $a = "
            <head>
                <link href='views/layout/frontend/css/bootstrap.min.css' rel='stylesheet' type='text/css'>
            </head>
            <body>
            <div class='table-responsive'>
            <h3 style='text-align: center; color:black; font-family: inherit;'>FOROS</h3>
                    <table class='table'>
                        <thead>
                            <tr>
                                <th></th>
                                <th>Foro</th>
                                <th>Participantes</th>
                                <th>Comentarios</th>
                                <th>Creador</th>
                                <th>Fecha Creacion</th>
                                <th>Fecha Cierre</th>
                            </tr>
                        </thead>
                        <tbody>";
        $b = "";
        $i=1;
            foreach ($lista_foros as $foro){
                $b .= "<tr>
                    <th scope='row'>".$i++."</th>
                    <td>" . utf8_decode($foro['For_Titulo']) . "</td>
                    <td>" . utf8_decode($foro['For_NParticipantes']) . "</td>
                    <td>" . utf8_decode($foro['For_NComentarios']) . "</td>
                    <td>" . utf8_decode($foro['Usu_Usuario']) . "</td>
                    <td>" . utf8_decode($foro['For_FechaCreacion']) . "</td>
                    <td>" . utf8_decode($foro['For_FechaCierre']) . "</td>
                </tr>";
            };
        $c =
                     "</tbody>
                </table>
            </div>
            <script type='text/javascript' src='views/layout/frontend/js/bootstrap.min.js' ></script>
        </body>";

            echo $a.$b.$c;
            require_once("libs/_dompdf/dompdf_config.inc.php");
            $dompdf = new DOMPDF();
            $dompdf->set_paper('letter', 'landscape'); //esta es una forma de ponerlo horizontal
            $dompdf->load_html(ob_get_clean());
            $dompdf->render();
            $pdf      = $dompdf->output();
            $filename = "'".APP_NAME.'-OTCA_Descargas.pdf';
            $dompdf->stream($filename, array("atachment" => 0));
        }
    }

    public function _cambiarEstadoForo()
    {
        $id_foro     = $this->getInt('id_foro');
        $estado_foro = $this->getInt('estado_foro');
        // echo $id_foro . $estado_foro; exit;

        $this->_model->cambiarEstadoForo($id_foro, $estado_foro);

        $this->_paginacion_listarForo();
    }

    public function _habilitarForo()
    {
        $id_foro= $this->getInt('id_foro');

        $this->_model->habilitarForo($id_foro);

        $this->_paginacion_listarForo();
    }

    public function _eliminarForo()
    {
        $id_foro = $this->getInt('id_foro');
        $estado = $this->getInt('estado');
        $this->_model->updestadoRowForo($id_foro, $estado);

        $this->_paginacion_listarForo();
    }
    public function _cerrarForo()
    {
        $id_foro = $this->getInt('id_foro');
        $estado_foro = $this->getInt('estado_foro');

        $this->_model->cerrarForo($id_foro, $estado_foro);

        $this->_paginacion_listarForo();
    }

    public function form($tipo = "", $funcion = "forum", $id_foro = 0)
    {
        $this->validarUrlIdioma();
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->getLenguaje("foro_admin_index");
        $id_foro=$this->filtrarInt($id_foro);
       //Verificar errores en el URl
        if ($tipo != "new" && $tipo != "edit") {
            if($this->_acl->permiso("foro_list_admin"))
                $this->redireccionar("foro/admin");
            else
                $this->redireccionar("foro");
        }
        if ($funcion != "forum" && $funcion != "webinar" && $funcion != "workshop" && $funcion != "query") {
            if($this->_acl->permiso("foro_list_admin"))
                $this->redireccionar("foro/admin");
            else
                $this->redireccionar("foro");
        }

        //Cuando preciona el boton guardar
        if ($this->botonPress("bt_guardar")) {
            $datatemp['post'] = $_POST;
            $datatemp['files'] = $_FILES;
            // dd($datatemp);
            $iFor_Titulo          = $this->getTexto('text_titulo');
            $iFor_Descripcion     = $this->getTexto('text_descripcion');
            $iLit_IdLineaTematica = $this->getInt('s_lista_tematica');

            $iFor_Funcion = $funcion;

            if ($funcion == "query") {
                $iFor_Resumen       = "";
                $iFor_Palabras      = "";
                $iFor_FechaCreacion = "";
                $iFor_FechaCierre   = "";
                $iFor_Tipo          = 1;
                $iFor_Estado        = 1;
                $iEnt_IdEntidad     = 0;
                $iUsu_IdUsuario     = Session::get('id_usuario');

                $Rol_ckey = "participante_foro";
            } else {
                $iFor_Resumen       = $this->getTexto('text_resumen');
                $iFor_Palabras      = $this->getTexto('text_palabras_claves');
                $iFor_FechaCreacion = $this->getTexto('start_time');
                $iFor_FechaCierre   = $this->getTexto('end_time');
                $iFor_Tipo          = $this->getInt('s_lista_tipo');
                $iFor_Estado        = $this->getInt('s_lista_estado');
                $iEnt_IdEntidad     = $this->getInt('s_lista_entidad');
                $iUsu_IdUsuario     = Session::get('id_usuario');

                $Rol_ckey = "lider_foro";

            }

            $iFor_IdPadre  = $this->getInt('hd_id_padre');
            $iFile_foro    = html_entity_decode($this->getTexto('hd_file_form'));
            $aFile_foro    = json_decode($iFile_foro, true);
           

            // echo "/iFor_Titulo".$iFor_Titulo. "/iFor_Objetivo".$iFor_Objetivo."/iFor_ResultadosEsperados".$iFor_ResultadosEsperados."/iFor_Palabras".$iFor_Palabras."/iFor_FechaCierre".$iFor_FechaCierre.
            // "/iFor_Tipo".$iFor_Tipo."/iFor_Estado".$iFor_Estado."/iLit_IdLineaTematica".$iLit_IdLineaTematica."/iEnt_IdEntidad".$iEnt_IdEntidad."/iUsu_IdUsuario".$iUsu_IdUsuario."/iIdi_IdIdioma".$iIdi_IdIdioma; exit;
             $i=0;
            $model_recurso = $this->loadModel('indexbd', 'bdrecursos');
            if ($tipo == "new") {

               
                $error = "";
                $iIdi_IdIdioma = $this->getSql('idiomaRadio');

                if($this->_model->verificarNombreForo($id_foro, $iFor_Titulo,$iIdi_IdIdioma)){
                    $error = ' El Nombre <b style="font-size: 1.15em;">'. $iFor_Titulo .'</b> de Foro ya Existe.';
                    $i=1;
                }
                if($i==0){
                
                $result_rec  = $model_recurso->insertarRecurso("Base de datos de documentos del foro " . $iFor_Titulo, "Proyecto PRIC/OTCA", 1, 1, 3, "Proyecto PRIC/OTCA", "", $iIdi_IdIdioma);
                $id_recurso  = $result_rec[0];
                $result_foro = $this->_model->insertarForo($iFor_Titulo, $iFor_Resumen, $iFor_Descripcion, $iFor_Palabras, $iFor_FechaCreacion, $iFor_FechaCierre, $iFor_Funcion, $iFor_Tipo, $iFor_Estado, $iFor_IdPadre, $iLit_IdLineaTematica, $iUsu_IdUsuario, $iEnt_IdEntidad, $id_recurso, $iIdi_IdIdioma);               

                $Rol_IdRol  = $this->_acl->getIdRol_x_ckey($Rol_ckey);              

                $model_index    = $this->loadModel('index');

                $result_inscrip = $model_index->inscribir_participante_foro($result_foro[0], $iUsu_IdUsuario, $Rol_IdRol["Rol_IdRol"], 1);  

                $id_foro=$result_foro[0];
                $this->_view->assign('_mensaje', 'Registro Completado..!!');


                }else{
                    $this->_view->assign('_error', $error);
                }            
                

            } else {
                $foro = $this->_model->getForosComplit_x_Id($id_foro);
                $IdiomaOriginal = $foro['Idi_IdIdioma'];        

                $id_recurso = $this->getInt('hd_id_recurso');
                $this->_model->deleteFileForo($id_foro);
                $Idi_IdIdiomaselect =  $this->getSql('Idiomaseleccionado'); //idioma seleccionado en el nav

               
                $error = "";

                if($this->_model->verificarNombreForo($id_foro, $iFor_Titulo,$Idi_IdIdiomaselect)){
                    $error = ' El Nombre <b style="font-size: 1.15em;">'. $iFor_Titulo .'</b> de Foro ya Existe.';
                    $i=1;
                }
                if($i==0){                   
                    
                    if($this->_model->verificarIdioma($id_foro, $Idi_IdIdiomaselect))
                    {
                        
                        $this->_model->actualizarForo($id_foro, $iFor_Titulo, $iFor_Resumen, $iFor_Descripcion, $iFor_Palabras, $iFor_FechaCreacion, $iFor_FechaCierre, $iFor_Funcion, $iFor_Tipo, $iFor_Estado, $iFor_IdPadre, $iLit_IdLineaTematica, $iUsu_IdUsuario, $iEnt_IdEntidad, $id_recurso, $IdiomaOriginal);

                        $this->_view->assign('_mensaje', 'Edición Completada..!!');
                       
                       
                    }
                    else {
                  
                        $this->_model->editarTraduccion($iFor_Titulo, $iFor_Resumen,$iFor_Descripcion, $iFor_Palabras, $id_foro, $Idi_IdIdiomaselect);
                    
                        $this->_view->assign('_mensaje', 'Edición Traducción Completado..!!');

                    }
                }
                else{
                    $this->_view->assign('_error', $error);
                }
            }

            if (count($aFile_foro)) {
                foreach ($aFile_foro as $key => $value) {
                    if (trim($value["name"]) != "") {
                        if($value["out"]==0){
                        $result_e = $this->_model->insertarFileForo($value["name"], $value["type"], $value["size"], $id_foro, $id_recurso,$iDub_IdDublinCore=0,$iFif_Titulo="",$iFif_EsOutForo=0);
                        }
                    }

                }
            }

            if($i==0)
                $this->redireccionar("foro/index/ficha/" . $id_foro);
        }
        
         //Cuando va editar un foro
        if ($tipo == "edit") {
            $foro = $this->_model->getForosComplit_x_Id($id_foro);
            $IdiomaOriginal = $foro['Idi_IdIdioma'];        

            // exit;
            
            $this->_view->assign('titulo', "Foro: Editar Foro");
            $this->_view->assign('idForo', $id_foro);
            // echo $foro['Idi_IdIdioma']; exit;

            if (!empty($foro)) {
                $_model_index     = $this->loadModel('index');
                $foro["Archivos"] = $_model_index->getArchivos_x_idforo($id_foro);

                $this->_view->assign('IdiomaOriginal', $IdiomaOriginal);
                $this->_view->assign('Idiomaseleccionado', $IdiomaOriginal);
                $this->_view->assign('foro', $foro);
                $this->_view->assign('start_date', date('d-m-Y H:m', strtotime($foro["For_FechaCreacion"])));
                if (!empty($foro["For_FechaCierre"])) {
                    $this->_view->assign('end_date', date('d-m-Y H:m', strtotime($foro["For_FechaCierre"])));
                } else {
                    $this->_view->assign('end_date', date('d-m-Y H:m', strtotime($foro["For_FechaCreacion"] . '+1 day')));
                }

            } else {
                
                if($this->_acl->permiso("foro_list_admin"))
                    $this->redireccionar("foro/admin");
                else
                   return $this->redireccionar("foro/index/".$funcion);
                 
            }

        } else {
            // dd('asd');            
            $this->_view->assign('start_date', date('d-m-Y H:m'));
            $this->_view->assign('end_date', date('d-m-Y H:m', strtotime('+1 day')));
        }

        // $linea_tematica = $this->_model->getLineaTematicas();
        // $this->_view->assign('linea_tematica', $linea_tematica);
        $this->_view->assign('linea_tematica', ForoTematica::activos()->visibles()->get());
        $model_entidad= $this->loadModel('entidad','hidrogeo');

        $this->_view->assign('list_entidad',$model_entidad->getEntidades("where Ent_Estado =1"));
        $this->_view->assign('tipo', $tipo);
        $this->_view->assign('Form_Funcion', $funcion);
        $this->_view->setJs(array('form', array(BASE_URL . 'public/ckeditor/ckeditor.js'), array(BASE_URL . 'public/ckeditor/adapters/jquery.js'), array(BASE_URL . 'public/js/jquery-ui.min.js'), array(BASE_URL . 'public/js/jquery-ui-timepicker-addon.js')));
        $this->_view->setCss(array('form', array(BASE_URL . "public/css/jquery-ui-timepicker-addon.css"), array(BASE_URL . "public/css/jquery-ui.min.css")));

        if ($tipo == "new" && $id_foro != 0) {
            $model_index= $this->loadModel('index');
            $foro = $this->_model->getForosComplit_x_Id($id_foro);
            $Nombre_propietario_foro = $model_index->getPropietario_foro($foro["Usu_IdUsuario"]);
            $foro["Usu_Usuario"] = $Nombre_propietario_foro["Usu_Usuario"];
            $foro["tiempo"] = $this->timediff($foro["For_FechaCreacion"],Cookie::lenguaje());
            $Nvaloraciones_foro = $model_index->getNvaloraciones($foro["For_IdForo"],'forum');
            $foro["votos"] = $Nvaloraciones_foro["Nvaloraciones"];
            $Numero_participantes_subforo = $model_index->getNumero_participantes_x_idForo($foro["For_IdForo"]);
            $foro["For_TParticipantes"] = $Numero_participantes_subforo["numero_participantes"];
            $Numero_comentarios_x_idForo = $model_index->getNumero_comentarios_x_idForo($foro["For_IdForo"]);
            $foro["For_TComentarios"] = $Numero_comentarios_x_idForo["Numero_comentarios"];
            if (empty($foro)) {
                if($this->_acl->permiso("foro_list_admin"))
                    $this->redireccionar("foro/admin");
                else
                   return $this->redireccionar("foro/index/".$funcion);
            }
            $this->_view->assign('foro_padre', $foro);
            $this->_view->assign('iFor_IdPadre', $id_foro);
        }
        $this->_view->assign('titulo', "Formulario Foro");
        $this->_view->assign('idiomas',$this->_model->getIdiomas());
        $Idi_IdIdioma = Cookie::lenguaje();
        $this->_view->assign('idiomaUrl',$Idi_IdIdioma);
        $this->_view->renderizar('form');
    }

    private function _tematica_export ($query, $formato) {
        $lenguaje = $this->_view->getLenguaje('difusion_contenido_index');

        $tematicas = $query->get();
        // dd($tematicas);
        switch ($formato) {
            case 'pdf':
                $data = $tematicas->map(function($item) {
                    $item->Lit_Descripcion = str_limit($item->Lit_Descripcion, 100);
                        return $item;
                });
                // ob_start();

                $this->_view->assign('tematicas', $data->toArray());
                // $html = $this->_view->fetch(ROOT.'modules/foro/views/admin/pdf/pdf_tematicas.tpl');
                $html = $this->_view->render('pdf/pdf_tematicas', false, true);
                $dompdf = new Dompdf();
                $dompdf->loadHtml($html);
                $dompdf->setPaper('A4', 'landscape');
                $dompdf->render();
                $dompdf->stream();
                break;
            case 'csv':
                $objPHPExcel = new PHPExcel();

                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, 'Usu_Usuario');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, 'Roles');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, 'Usu_Estado');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, 'Row_Estado');
                $init = 2;
                foreach ($tematicas as $key => $value) {
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $init, $init - 1);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $init, $value->Lit_Nombre);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $init, $value->Lit_Estado);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $init, $value->Lit_Descripcion);
                    $init++;
                }
                // for ($i = 2; $i <= (count($lista_datos) + 1); $i++) {
                //     $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $i, $lista_datos[$i - 2]['Usu_Usuario']);
                //     foreach ($lista_datos[$i - 2]['Roles'] as $Roles) {
                //         // echo count($Roles) . 'hola'; exit;
                //         $roles .= $Roles['Rol_Nombre'] . ', ';
                //     }
                //     $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $roles);
                //     // $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $lista_datos[$i - 2]['Roles']);
                //     $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $i, $lista_datos[$i - 2]['Usu_Estado']);
                //     $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $i, $lista_datos[$i - 2]['Row_Estado']);
                // }
                $objPHPExcel->getActiveSheet()->setTitle('ListaDeDescargas');
                $objPHPExcel->setActiveSheetIndex(0);
                ob_end_clean();
                ob_start();
                //
                header("Content-type: application/vnd.ms-excel");
                header("Pragma: no-cache"); header("Expires: 0");
                echo "\xEF\xBB\xBF"; //UTF-8 BOM echo $out;
                //
                header('Content-Disposition: attachment;filename="'.APP_NAME.'-OTCA_Descargas.csv"');
                header('Cache-Control: max-age=0');
                $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'CSV');
                $objWriter->save('php://output');
                break;
            case 'excel':
                $objPHPExcel = new PHPExcel();
                $data = $tematicas;
                $lenguaje = $this->_view->LoadLenguaje('foro_admin_tematica');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, '#');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, $lenguaje['str_nombre']);
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, $lenguaje['str_estado']);
                // $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, $lenguaje['str_idioma']);
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, $lenguaje['str_descripcion']);
                // dd($data->next());
                $init = 2;
                foreach ($data as $value) {
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $init, $init - 1);
                    // foreach ($lista_datos[$i - 2]['Roles'] as $Roles) {
                    //     // echo count($Roles) . 'hola'; exit;
                    //     $roles .= $Roles['Rol_Nombre'] . ', ';
                    // }
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $init, $value->Lit_Nombre);
                    // $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $lista_datos[$i - 2]['Roles']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $init, $value->Lit_Estado);
                    // $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $init, $value->Lit_Idio);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $init, $value->Lit_Descripcion);
                    $init++;
                }


                $objPHPExcel->getActiveSheet()->setTitle($lenguaje['str_tematica']);
                $objPHPExcel->setActiveSheetIndex(0);
                ob_end_clean();
                ob_start();
                //Session::destroy('encabezado');
                // Session::destroy('Descargar');
                header('Content-Type: application/vnd.ms-excel');
                header('Content-Disposition: attachment;filename="'.APP_NAME.'-OTCA_'.$lenguaje['str_descargas'].'.xls"');
                header('Cache-Control: max-age=0');
                $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
                $objWriter->save('php://output');
                break;
        }
    }
    public function tematica ($method = 'index', $action = 'default') {
        // $this->_acl->acceso('gestion_foro_tematica');
        $this->_view->getLenguaje('foro_admin_tematica');
        //  new DataTables();
        // exit();
        if ($method != 0 && is_numeric($method)) {
            switch ($action) {
                case 'edit':
                    $tematica = ForoTematica::find($method);
                    $data['mostrar_contenido'] = false;
                    // dd($tematica);
                    if ($tematica && +$tematica->Lit_IdLineaTematica != 0) {
                        $data['mostrar_contenido'] = true;
                        $this->_view->setJs(
                            array(
                                array(BASE_URL . 'public/js/axios/dist/axios.min.js'),
                                array(BASE_URL . 'public/js/vuejs/vue.min.js'),
                                'tematica_edit'
                            ));
                        $idiomas = Idioma::activos();

                        $vars_idioma = [];
                        $idiomas->map(function($item) use(&$vars_idioma, $tematica){
                            if ($tematica->Idi_IdIdioma == $item->Idi_IdIdioma) {
                                $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
                                    'id' => $item->Idi_IdIdioma,
                                    'tematica' => $tematica->Lit_Nombre,
                                    'tematica_id' => $tematica->Lit_IdLineaTematica,
                                    'default' => true,
                                    'descripcion' => $tematica->Lit_Descripcion,
                                ];
                            } else {
                                // DB::enableQueryLog();

                                $traducido = ContenidoTraducido::getRow('linea_tematica', $tematica->Lit_IdLineaTematica, $item->Idi_IdIdioma);
                                // var_dump($traducido);
                                // dd(DB::getQueryLog());
                                $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
                                        'id' => $item->Idi_IdIdioma,
                                        'tematica' => '',
                                        'default' => false,
                                        'descripcion' => ''
                                    ];
                                if ($traducido->count() > 0) {
                                    $vars_idioma['idioma_'.$item->Idi_IdIdioma]['tematica'] = $traducido->where('Cot_Columna', 'Lit_Nombre')->first()->Cot_Traduccion;

                                    $vars_idioma['idioma_'.$item->Idi_IdIdioma]['descripcion'] = $traducido->where('Cot_Columna', 'Lit_Descripcion')->first()->Cot_Traduccion;
                                }
                            }
                        });
                        // exit;
                        // dd($vars_idioma);
                        $data_vue = [
                            'idiomas' => $vars_idioma,
                            'tematica_id' => $tematica->Lit_IdLineaTematica,
                            'estado' => $tematica->Lit_Estado == 1 ? true : false,
                            'idioma_actual' => Cookie::lenguaje()
                        ];

                        $this->_view->assign('data_vue', json_encode($data_vue));
                        $this->_view->assign('idiomas', $idiomas);
                    }
                    $this->_view->assign($data);
                    $this->_view->render('tematica_edit');
                    break;
                case 'update':
                    $res = ['success' => false, 'msg' => ''];
                    $lenguaje = $this->_view->LoadLenguaje('foro_admin_tematica');
                    $tematica = ForoTematica::find($method);
                    // dd($tematica);
                    if ($tematica && $tematica->Lit_IdLineaTematica != 0) {
                        //si los updates están sugetos a aaciones
                        if ($this->filledPost('accion')) {

                            if ($this->getTexto('accion') == 'estado') {
                                $estado = $this->getInt('estado');
                                if ($estado == 1)
                                    $mensaje = str_replace('%tematica%', $tematica->Lit_Nombre ,$lenguaje['foro_admin_tematica_update_estado_1']);
                                else
                                    $mensaje = str_replace('%tematica%', $tematica->Lit_Nombre ,$lenguaje['foro_admin_tematica_update_estado_0']);

                                DB::transaction(function () use(&$tematica, &$res, $estado, $mensaje){
                                    $tematica->Lit_Estado = $estado;
                                    $tematica->save();
                                    $res['success'] = true;
                                    $res['msg'] = $mensaje;
                                });
                            }
                        } else {
                            //update de idiomas
                            $post = file_get_contents('php://input');
                            $post = json_decode($post);
                            $this->setPut();
                            // $tematica = ForoTematica::find($method);
                            // dd($tematica);
                            if ($tematica) {
                                $idiomas = Idioma::activos();
                                $self = $this;
                                DB::transaction(function () use ($self, &$res, $post, $idiomas, $tematica, $lenguaje) {
                                    // $tematica = new ForoTematica();
                                    $opcionales = [];
                                    foreach ($idiomas as $value) {
                                        $idioma_var = "idioma_".$value->Idi_IdIdioma;
                                        if (array_key_exists($idioma_var, $post->idiomas)) {
                                            if ($post->idiomas->$idioma_var->default) {
                                                //update en 'temtatica'
                                                $tematica->Lit_Nombre = $post->idiomas->$idioma_var->tematica;
                                                $tematica->Lit_Descripcion = $post->idiomas->$idioma_var->descripcion;
                                                $tematica->Lit_Estado = $post->estado;
                                                $tematica->save();

                                            } else {
                                                ContenidoTraducido::updateRow('linea_tematica', $tematica->Lit_IdLineaTematica, $value->Idi_IdIdioma, [
                                                    'Lit_Nombre' => $post->idiomas->$idioma_var->tematica,
                                                    'Lit_Descripcion' => $post->idiomas->$idioma_var->descripcion,
                                                ], true);


                                            }

                                        }
                                    }

                                    $res['success'] = true;
                                    $res['msg'] = str_replace('%tematica%', $tematica->Lit_Nombre, $lenguaje['foro_admin_tematica_update_success']);

                                });
                            }
                        }
                    }
                    // $this->setPut();
                    // dd($_POST);
                    $this->_view->responseJson($res);
                    break;
                case 'delete':
                    $res = ['success' => false, 'msg' => ''];
                    if ($this->filledPost('id')) {
                        $tematica = ForoTematica::find($this->getInt('id'));
                        $lenguaje = $this->_view->LoadLenguaje('foro_admin_tematica');
                        if ($tematica && $tematica->Lit_IdLineaTematica != 0) {
                            DB::transaction(function () use(&$tematica, &$res, $lenguaje) {
                                $tematica->Row_Estado = 0;
                                $tematica->save();
                                $res['success'] = true;
                                $res['msg'] = str_replace('%tematica%', $tematica->Lit_Nombre, $lenguaje['foro_admin_tematica_delete_eliminado']);
                            });
                        }
                    }
                    $this->_view->responseJson($res);
                    break;
            }
        } else {

            switch ($method) {
                case 'datatable':
                    // dd(Cookie::lenguaje());

                    DB::enableQueryLog();
                    $tematicas = ForoTematica::visibles();
                    $records_total = $tematicas->count();
                    $records_total_filter = $records_total;
                    if ($this->filledGet('buscar')) {
                        $tematicas->where('Lit_Nombre', 'like', '%'.$_GET['buscar'].'%');
                        $records_total_filter = $tematicas->count();
                    }
                    if ($this->filledGet('export')) {
                        $this->_tematica_export($tematicas, $_GET['export']);
                    } else {
                        $datas = $tematicas->offset($_GET['start'])->limit($_GET['length'])->get();

                        $data = [
                            'draw' => +$_GET['draw'],
                            'recordsTotal' => $records_total,
                            'recordsFiltered' => $records_total_filter,
                            'data' => $datas,
                            'query' => $cosa = DB::getQueryLog()

                        ];
                        $this->_view->responseJson($data);
                    }
                    break;
                case 'index':
                    // $foro = ForoTematica::find(1);
                    // dd($foro->foros->count());
                    // dd($this->_view->LoadLenguaje('foro_admin_tematica'));
                    $this->_view->setJs(
                        array(
                            array(BASE_URL . 'public/js/mustache/mustache.min.js'),
                            array(BASE_URL . 'public/js/axios/dist/axios.min.js'),
                            array(BASE_URL . 'public/js/vuejs/vue.min.js'),
                            array(BASE_URL .  Cookie::lenguaje(). '/assets/js/datatables_lang.js'),
                            array(BASE_URL . 'public/js/datatable/datatables.min.js'),
                            'tematica'
                        ));

                    $idiomas = Idioma::activos();

                    $vars_idioma = [];
                    $idiomas->map(function($item) use(&$vars_idioma){
                        $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
                            'id' => $item->Idi_IdIdioma,
                            'tematica' => '',
                            'descripcion' => '',
                        ];
                    });
                    $data_vue = [
                        'idiomas' => $vars_idioma,
                        'idioma_actual' => Cookie::lenguaje()
                    ];

                    $this->_view->assign('data_vue', json_encode($data_vue));
                    $this->_view->assign('idiomas', $idiomas);
                    $this->_view->render('tematica');
                    break;
                case 'store':
                    $post = file_get_contents('php://input');
                    $post = json_decode($post);
                    // var_dump($post);
                    $this->setStore();
                    $lenguaje = $this->_view->LoadLenguaje('foro_admin_tematica');
                    if ($this->isAjax()) {
                        $res = ['success' => false, 'msg' => ''];
                        $idiomas = Idioma::activos();
                        $self = $this;
                        DB::transaction(function () use ($self, &$res, $post, $idiomas, $lenguaje) {
                            $tematica = new ForoTematica();
                            $opcionales = [];
                            foreach ($idiomas as $value) {
                                $idioma_var = "idioma_".$value->Idi_IdIdioma;
                                if (array_key_exists($idioma_var, $post->idiomas)) {
                                    if ($value->Idi_IdIdioma == Cookie::lenguaje()) {
                                        //por defecto agregar en el idioma actual
                                        $tematica->Lit_Nombre = $post->idiomas->$idioma_var->tematica;
                                        $tematica->Lit_Descripcion = $post->idiomas->$idioma_var->descripcion;
                                        $tematica->row_estado = $post->estado;
                                        $tematica->Idi_IdIdioma = Cookie::lenguaje();
                                        $tematica->save();
                                    } else {
                                        $opcionales[] = [
                                            'idioma' => $value->Idi_IdIdioma,
                                            'tematica' => $post->idiomas->$idioma_var->tematica,
                                            'descripcion' => $post->idiomas->$idioma_var->descripcion
                                        ];
                                    }
                                }
                            }

                            if ($tematica->Lit_IdLineaTematica != 0) {
                                foreach ($opcionales as  $value) {
                                    $traducido = new ContenidoTraducido();
                                    $traducido->Cot_Tabla ='linea_tematica';
                                    $traducido->Cot_IdRegistro = $tematica->Lit_IdLineaTematica;
                                    $traducido->Cot_Columna ='Lit_Nombre';
                                    $traducido->Cot_Traduccion = $value['tematica'];
                                    $traducido->Idi_IdIdioma = $value['idioma'];
                                    $traducido->save();

                                    $traducido = new ContenidoTraducido();
                                    $traducido->Cot_Tabla ='linea_tematica';
                                    $traducido->Cot_IdRegistro = $tematica->Lit_IdLineaTematica;
                                    $traducido->Cot_Columna ='Lit_Descripcion';
                                    $traducido->Cot_Traduccion = $value['descripcion'];
                                    $traducido->Idi_IdIdioma = $value['idioma'];
                                    $traducido->save();

                                }

                                $res['success'] = true;
                                $res['msg'] = str_replace('%tematica%', $tematica->Lit_Nombre, $lenguaje['foro_admin_tematica_registro_success']);
                            }


                        });
                    }
                    // print_r($_POST);
                    $this->_view->responseJson($res);
                    break;
                default:
                    http_response_code(404);
                    throw new Exception('Error de modelo - ');
                    break;
            }
        }

        // if ($this->isAjax()) {
        //     $res = ['success' => false, 'msg' => ''];
        //     // if ($this->filledPost(['nombre', 'estado'])) {
        //     //     $self = $this;
        //     //     DB::transaction(function () use ($self, &$res) {

        //     //         $tematica = new ForoTematica();
        //     //         $tematica->Lit_Nombre = $self->getTexto('nombre');
        //     //         $tematica->row_estado = $self->getInt('estado');
        //     //         $tematica->save();
        //     //         if ($tematica->Lit_IdLineaTematica != 0)
        //     //             $res['success'] = true;
        //     //     });
        //     // } else {
        //     //     $res['msg'] = 'Faltan variables';
        //     // }
        //     $this->_view->responseJson($_POST);

        // } else {

        // }

    }
    public function gestion_idiomas() {
        //
        // exit;
        $this->_view->getLenguaje('template_backend');
        $condicion1 ='';
        $Idi_IdIdioma =  $this->getPostParam('idIdioma'); //idioma seleccionado en el nav
        $IdiomaOriginal = $this->getTexto('idIdiomaOriginal'); //idioma original en input
        // echo $Idi_IdIdioma; exit;
        $Form_Funcion = $this->getPostParam('Form_Funcion');
        // echo $Form_Funcion; exit;
        $id = $this->getPostParam('idforo');
        // echo $id; exit;
        $condicion1 .= " WHERE fo.For_IdForo = $id ";
        $foro = $this->_model->getPaginaTraducida($condicion1, $Idi_IdIdioma);
        // echo count($foro); exit;
        if ($foro["Idi_IdIdioma"]==$Idi_IdIdioma) {
            $this->_view->assign('foro',$foro);
            // $this->_view->assign('contenido',$datos);
        }else{
            $foro["For_Titulo"]="";
            $foro["For_Resumen"]="";
            $foro["For_Descripcion"]="";
            $foro["For_PalabrasClaves"]="";
            $foro["Idi_IdIdioma"]=$Idi_IdIdioma;
            $this->_view->assign('foro',$foro);
        }

       
        $this->_view->assign('foro', $foro);
        $this->_view->assign('idiomas',$this->_model->getIdiomas());
        $this->_view->assign('idForo', $id);
        $this->_view->assign('Idiomaseleccionado', $Idi_IdIdioma);
        $this->_view->assign('IdiomaOriginal', $IdiomaOriginal);
        $this->_view->assign('Form_Funcion', $Form_Funcion);
        $this->_view->renderizar('ajax/gestion_idiomas', false, true);
    }

    public function members($id_foro = 0)
    {
        $this->_acl->acceso("listar_miembros");
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $model_index = $this->loadModel('index');
        if ($id_foro != 0) {
            $foro = $this->_model->getForos_x_Id($id_foro);

            $idUsuario = Session::get('id_usuario');
            if(!empty($idUsuario)){
                $Rol_Ckey = $model_index->getRolForo(Session::get('id_usuario'), $id_foro);
                if(empty($Rol_Ckey)){
                    $Rol_Ckey = $model_index->getRol_Ckey(Session::get('id_usuario'));
                }
                $this->_view->assign('Rol_Ckey', $Rol_Ckey["Rol_Ckey"]);
                // echo $Rol_Ckey["Rol_Ckey"]; exit;
            }else{
                $Rol_Ckey["Rol_Ckey"]="";
                $this->_view->assign('Rol_Ckey', "sin permiso");
            }

            if (!empty($foro)) {
                $this->_view->getLenguaje("foro_admin_members");
                $lenguaje = Session::get("fileLenguaje");
                $this->_view->assign('titulo', $lenguaje["foro_admin_members_titulo"]);
                $this->_view->setJs(array('members', array(BASE_URL . 'public/ckeditor/ckeditor.js'), array(BASE_URL . 'public/ckeditor/adapters/jquery.js')));
                $this->_view->setCss(array('form'));
                $paginador = new Paginador();

                if($Rol_Ckey["Rol_Ckey"]=="lider_foro" || $Rol_Ckey["Rol_Ckey"] =="administrador" || $Rol_Ckey["Rol_Ckey"] =="administrador_foro"){
                    $filtro_rol="lider_foro";
                }else if($Rol_Ckey["Rol_Ckey"]=="moderador_foro") {
                    $filtro_rol="facilitador_foro";
                }else {
                    $filtro_rol="participante_foro";
                }

                $lista_members  = $this->_model->getMembers_x_Foro($id_foro,$filtro_rol);
                $totalRegistros = $this->_model->getRowMembers_x_Foro($id_foro,$filtro_rol);

                $paginador->paginar($totalRegistros["Usf_RowMembers"], "listaMembers", "", $pagina = 1, CANT_REG_PAG, true);

                $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
                $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
                $this->_view->assign('lista_members', $lista_members);
                $this->_view->assign('foro', $foro);
                $this->_view->assign('lista_rol_foro', $this->_model->getRolForo());
                $this->_view->assign('text_busqueda_miembro', '');
                $this->_view->renderizar('members');
            } else {
                if($this->_acl->permiso("foro_list_admin"))
                    $this->redireccionar("foro/admin");
                else
                   return $this->redireccionar("foro");
            }
        } else {
            if($this->_acl->permiso("foro_list_admin"))
                    $this->redireccionar("foro/admin");
                else
                   return $this->redireccionar("foro");
        }
    }

    public function actividad($id_foro = 0)
    {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        if ($id_foro == 0) {
            if($this->_acl->permiso("foro_list_admin"))
                    $this->redireccionar("foro/admin");
            else
                   return $this->redireccionar("foro");
        }
        $foro = $this->_model->getForos_x_Id($id_foro);
        if (empty($foro)) {
            if($this->_acl->permiso("foro_list_admin"))
                $this->redireccionar("foro/admin");
            else
                return $this->redireccionar("foro");
        }

        if ($this->botonPress("bt_guardar")) {
            $this->_registrarActividad($id_foro);
        }

        if ($this->botonPress("bt_editar")) {
            $this->_editarActividad($id_foro);
        }
        if ($this->botonPress("bt_eliminar")) {
            $this->_eliminarrActividad($id_foro);
        }
        $foro["For_Actividades"] = json_encode($this->_model->listarActividadForo($id_foro));

        $this->_view->assign('foro', $foro);
        $this->_view->setJs(array('actividad', array(BASE_URL . 'public/js/fullcalendar/moment.min.js'), array(BASE_URL . 'public/js/fullcalendar/fullcalendar.min.js'), array(BASE_URL . 'public/js/fullcalendar/locale/es.js'), array(BASE_URL . 'public/js/jquery-ui.min.js'), array(BASE_URL . 'public/js/jquery-ui-timepicker-addon.js')));
        $this->_view->setCss(array('actividad', array(BASE_URL . "public/css/fullcalendar/fullcalendar.min.css"), array(BASE_URL . "public/css/jquery-ui-timepicker-addon.css"), array(BASE_URL . "public/css/jquery-ui.min.css")));
        $this->_view->renderizar('actividad');
    }

    private function _registrarActividad($id_foro)
    {
        $iFor_IdForo      = $id_foro;
        $iAcf_Titulo      = $this->getTexto('tb_titulo');
        $iAcf_Resumen     = $this->getTexto('tb_resumen');
        $iAcf_FechaInicio = $this->getTexto('start_time');
        $iAcf_FechaFin    = $this->getTexto('end_time');

        $resul = $this->_model->insertarActividadForo($iAcf_Titulo, $iAcf_Resumen, $iAcf_FechaInicio, $iAcf_FechaFin, $iFor_IdForo, 1, "es");

        $this->redireccionar("foro/admin/actividad/$id_foro");
    }

    private function _editarActividad($id_foro)
    {
        $iFor_IdForo          = $id_foro;
        $iAcf_IdActividadForo = $this->getInt('hd_id_actividad');
        $iAcf_Titulo          = $this->getTexto('tb_titulo');
        $iAcf_Resumen         = $this->getTexto('tb_resumen');
        $iAcf_FechaInicio     = $this->getTexto('start_time');
        $iAcf_FechaFin        = $this->getTexto('end_time');

        $resul = $this->_model->actualizarActividadForo($iAcf_IdActividadForo, $iAcf_Titulo, $iAcf_Resumen, $iAcf_FechaInicio, $iAcf_FechaFin, $iFor_IdForo, 1, "es");

        $this->redireccionar("foro/admin/actividad/$id_foro");
    }

    private function _eliminarrActividad($id_foro)
    {
        $iAcf_IdActividadForo = $this->getInt('hd_id_actividad');

        $resul = $this->_model->updestadoRowActividadForo($iAcf_IdActividadForo, 0);

        $this->redireccionar("foro/admin/actividad/$id_foro");
    }

    public function _paginacion_listaMembers($filtro = "")
    {
        //Variables de Ajax_JavaScript
        $pagina         = $this->getInt('pagina');
        $filas          = $this->getInt('filas');
        $totalRegistros = $this->getInt('total_registros');
        $id_foro        = $this->getInt('id_foro');
        $rol_member     = $this->getTexto('rol_member');

        $paginador = new Paginador();

        $lista_members = $this->_model->getMembers_x_Foro($id_foro, $rol_member, $pagina, $filas, $filtro);

        $paginador->paginar($totalRegistros, "listaMembers", $filtro, $pagina, $filas, true);

        $this->_view->assign('lista_members', $lista_members);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('text_busqueda_miembro', $filtro);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listaMembers', false, true);
    }

    public function _tab_members()
    {
        // exit;
        $id_foro    = $this->getInt('id_foro');
        $rol_member = $this->getTexto('rol_member');
        $_SESSION['id_foro'] = $id_foro;
        $_SESSION['rol_member'] = $rol_member;
        // $filtro = $this->getTexto('filtro');

        $pagina     = 1;
        $paginador  = new Paginador();

        $lista_members  = $this->_model->getMembers_x_Foro($id_foro, $rol_member, $pagina, CANT_REG_PAG);
        $totalRegistros = $this->_model->getRowMembers_x_Foro($id_foro, $rol_member);

        $paginador->paginar($totalRegistros["Usf_RowMembers"], "listaMembers", "", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('lista_members', $lista_members);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->assign('text_busqueda_miembro', '');
        $this->_view->renderizar('ajax/listaMembers', false, true);
    }

    public function _tab_members_buscar()
    {
        $id_foro    = $_SESSION['id_foro'];
        $rol_member = $_SESSION['rol_member'];
        $filtro = $this->getTexto('filtro');
        if(empty($filtro)){
            $filtro ="";
        }
        // echo $filtro; exit;

        $pagina     = 1;
        $paginador  = new Paginador();

        $lista_members  = $this->_model->getMembers_x_Foro($id_foro, $rol_member, $pagina, CANT_REG_PAG, $filtro);
        $totalRegistros = count($lista_members);

        $paginador->paginar($totalRegistros, "listaMembers", "$filtro", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('lista_members', $lista_members);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));


        $this->_view->assign('text_busqueda_miembro', $filtro);
        // Session::destroy('id_foro');
        // Session::destroy('rol_member');
        $this->_view->renderizar('ajax/listaMembers', false, true);
    }

    public function _cambiarEstadoMember()
    {
        $id_usuario    = $this->getInt('id_usuario');
        $id_foro       = $this->getInt('id_foro');
        $estado_member = $this->getInt('estado_member');

        $result = $this->_model->cambiarEstadoMember($id_usuario, $id_foro, $estado_member);

        $this->_view->assign('text_busqueda_miembro', "");
        $this->_paginacion_listaMembers();
    }

    public function _eliminarMember()
    {
        $id_usuario = $this->getInt('id_usuario');
        $id_foro    = $this->getInt('id_foro');

        $this->_model->updestadoRowMember($id_usuario, $id_foro, 0);

        $this->_view->assign('text_busqueda_miembro', "");
        $this->_paginacion_listaMembers();
    }

    public function _buscar_user_foro()
    {
        $iRol_IdRol  = $this->getInt('selec_rol');
        $busqueda    = $this->getTexto('tb_filtro_bus');
        $iFor_IdForo = $this->getInt('id_foro');

        $lista_user = $this->_model->getUserRolForo($iRol_IdRol, $iFor_IdForo, $busqueda);

        $this->_view->assign('lista_member_select', $lista_user);

        $this->_view->renderizar('ajax/lista_member_select', false, true);
    }

    public function _asignarUserMember()
    {
        $id_usuario  = $this->getInt('id_usuario');
        $id_foro     = $this->getInt('id_foro');
        $id_rol      = $this->getInt('id_rol');
        $rol_member  = $this->getTexto('ckey_rol');
        $model_index = $this->loadModel('index');
        $mensaje = html_entity_decode($this->getTexto('mensaje'));

      
        $result_inscrip = $model_index->inscribir_participante_foro($id_foro, $id_usuario, $id_rol, 1);

        if(count($result_inscrip)>0){
            // dd($result_inscrip);
            $result = $model_index->getEmail_Usuario($id_usuario);
            $this->sendEmail($result, $mensaje,$id_foro,$id_usuario);
        }
        $pagina    = 1;
        $paginador = new Paginador();

        $lista_members  = $this->_model->getMembers_x_Foro($id_foro, $rol_member, $pagina, CANT_REG_PAG);
        $totalRegistros = $this->_model->getRowMembers_x_Foro($id_foro, $rol_member);

        $paginador->paginar($totalRegistros["Usf_RowMembers"], "listaMembers", "", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('lista_members', $lista_members);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('text_busqueda_miembro', "");
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listaMembers', false, true);
    }

     public function sendEmail($Email, $mensaje,$idforo,$id_usuario )
    {
        $model_user     = $this->loadModel('usuario', 'usuarios');
      
        $partip = $model_user->getUsuario($id_usuario);

        $foro = $this->_model->getForos_x_Id($idforo);

   
        $mensaje = str_replace('|nombre|',$partip["Usu_Nombre"], $mensaje);
        $mensaje = str_replace('|apellidos|',$partip["Usu_Apellidos"], $mensaje);
        $mensaje = str_replace('|usuario|',$partip["Usu_Usuario"], $mensaje);
        $mensaje = str_replace('|titulo_foro|',$foro["For_Titulo"], $mensaje);

        $obj = new Request();
        // echo $obj->getModulo();exit;

        $url = BASE_URL.$obj->getModulo();
        $email = $Email[0];       
        $Subject = 'PRIC - OTCA | Invitacion a participar en el foro';
        
        $contenido = $mensaje;

        $idUsuario = Session::get('id_usuario');
        $user = $model_user->getUsuario($idUsuario);
        $fromName = $user["Usu_Nombre"]." ".$user["Usu_Apellidos"]." | FORO - PRIC" ;

        $Correo = new Correo();
        $SendCorreo = $Correo->enviar($email, "NAME", $Subject, $contenido);
        $this->_view->assign('url', $url);
    }

    public function _getPermisosMember()
    {
        $id_usuario = $this->getInt('id_user');
        $id_foro    = $this->getInt('id_foro');
        $id_rol     = $this->getInt('id_rol');

        $model_user     = $this->loadModel('usuario', 'usuarios');
        $user           = $model_user->getUsuario($id_usuario);
        $lista_permisos = $this->_model->getPermisosMember($id_foro, $id_usuario, $id_rol);

        $this->_view->assign('user', $user);
        $this->_view->assign('lista_permisos', $lista_permisos);
        $this->_view->renderizar('ajax/listaPermisosMember', false, true);
    }

    public function _updatePermisoMember()
    {
        $id_usuario = $this->getInt('id_user');
        $id_foro    = $this->getInt('id_foro');
        $id_permiso = $this->getInt('id_permiso');
        $estado     = $this->getInt('estado');

        $result = $this->_model->updPermisoMember($id_usuario, $id_foro, $id_permiso, $estado);
        echo json_encode($result);
    }

    public function _load_temp_files()
    {

    }

    public function _registrar_entidad(){
         $model_entidad= $this->loadModel('entidad','hidrogeo');

        if(!empty($this->getSql('nombre'))){           
            $idEntidad = $model_entidad->registrarEntidad(
                    $this->getSql('nombre'),$this->getSql('siglas'),1);
            $foro=array('Ent_Id_Entidad' => $idEntidad[0]);
            $this->_view->assign('foro',$foro);
        }

        $this->_view->assign('list_entidad',$model_entidad->getEntidades("where Ent_Estado =1"));
        $this->_view->renderizar('ajax/include_select_entidad', false, true);

    }

}
