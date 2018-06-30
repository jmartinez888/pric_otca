<?php

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
        $this->_acl->autenticado();
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

    public function _paginacion_listarForo()
    {
        //Variables de Ajax_JavaScript
        $pagina         = $this->getInt('pagina');
        $filas          = $this->getInt('filas');
        $totalRegistros = $this->getInt('total_registros');
        $filtro         = $this->getTexto('filtro');

        $paginador = new Paginador();

        // $this->_view->assign('roles', $paginador->paginar($this->_aclm->getRoles($condicion), "listarRoles", "$nombre", $pagina, 25));
        $lista_foros = $this->_model->getForos($filtro, $pagina, $filas);

        $paginador->paginar($totalRegistros, "listarForo", $filtro, $pagina, $filas, true);

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
        $totalRegistros = $this->_model->getRowForos($filtro);

        $paginador->paginar($totalRegistros["For_NRow"], "listarForo", $filtro, $pagina = 0, CANT_REG_PAG, true);

        if ($this->botonPress("export_data_excel")) {
            $this->_exportarDatos($lista_foros, "excel");
        }

        if ($this->botonPress("export_data_pdf")) {
            $this->_exportarDatos($lista_foros, "pdf");
        }

        if ($this->botonPress("export_data_csv")) {
            $this->_exportarDatos($lista_foros, "csv");
        }

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

                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, 'Foro');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, 'Participantes');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, 'Comentarios');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, 'Creador');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, 1, 'Fecha Creacion');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(5, 1, 'Fecha Cierre');

                for ($i = 2; $i <= (count($lista_foros) + 1); $i++) {
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
                header('Content-Type: application/vnd.ms-excel');
                header('Content-Disposition: attachment;filename="'.APP_NAME.'-OTCA_Descargas.txt"');
                header('Cache-Control: max-age=0');
                $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'CSV');
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
            require_once("libs/dompdf/dompdf_config.inc.php");
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

        $this->_model->cambiarEstadoForo($id_foro, $estado_foro);

        $this->_paginacion_listarForo();
    }

    public function _eliminarForo()
    {
        $id_foro = $this->getInt('id_foro');

        $this->_model->updestadoRowForo($id_foro, 0);

        $this->_paginacion_listarForo();
    }
    public function _cerrarForo()
    {
        $id_foro = $this->getInt('id_foro');

        $this->_model->cerrarForo($id_foro);

        $this->_paginacion_listarForo();
    }

    public function form($tipo = "", $funcion = "forum", $id_foro = 0)
    {

        $this->validarUrlIdioma();

        if ($tipo != "new" && $tipo != "edit") {
            $this->redireccionar("foro/admin");
        }
        if ($funcion != "forum" && $funcion != "webinar" && $funcion != "workshop" && $funcion != "query") {
            $this->redireccionar("foro/admin");
        }

        if ($funcion == "query") {
            $this->_view->setTemplate(LAYOUT_FRONTEND);
        }

        if ($this->botonPress("bt_guardar")) {
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

            $iIdi_IdIdioma = 'es';
            $iFor_IdPadre  = $this->getInt('hd_id_padre');
            $iFile_foro    = html_entity_decode($this->getTexto('hd_file_form'));
            $aFile_foro    = json_decode($iFile_foro, true);

            // echo "/iFor_Titulo".$iFor_Titulo. "/iFor_Objetivo".$iFor_Objetivo."/iFor_ResultadosEsperados".$iFor_ResultadosEsperados."/iFor_Palabras".$iFor_Palabras."/iFor_FechaCierre".$iFor_FechaCierre.
            // "/iFor_Tipo".$iFor_Tipo."/iFor_Estado".$iFor_Estado."/iLit_IdLineaTematica".$iLit_IdLineaTematica."/iEnt_IdEntidad".$iEnt_IdEntidad."/iUsu_IdUsuario".$iUsu_IdUsuario."/iIdi_IdIdioma".$iIdi_IdIdioma; exit;

            $model_recurso = $this->loadModel('indexbd', 'bdrecursos');
            if ($tipo == "new") {

                $result_rec  = $model_recurso->insertarRecurso("Base de datos de documentos del foro " . $iFor_Titulo, "Proyecto PRIC/OTCA", 1, 1, 3, "Proyecto PRIC/OTCA", "", $iIdi_IdIdioma);
                $id_recurso  = $result_rec[0];
                $result_foro = $this->_model->insertarForo($iFor_Titulo, $iFor_Resumen, $iFor_Descripcion, $iFor_Palabras, $iFor_FechaCreacion, $iFor_FechaCierre, $iFor_Funcion, $iFor_Tipo, $iFor_Estado, $iFor_IdPadre, $iLit_IdLineaTematica, $iUsu_IdUsuario, $iEnt_IdEntidad, $id_recurso, $iIdi_IdIdioma);
                $id_foro     = $result_foro[0];
                $iRol_IdRol  = $this->_acl->getIdRol_x_ckey($Rol_ckey);

                $model_index    = $this->loadModel('index');
                $result_inscrip = $model_index->inscribir_participante_foro($result_foro[0], $iUsu_IdUsuario, $iRol_IdRol["Rol_IdRol"], 1);

            } else {

                $id_recurso = $this->getInt('hd_id_recurso');
                $this->_model->deleteFileForo($id_foro);
                $this->_model->actualizarForo($id_foro, $iFor_Titulo, $iFor_Resumen, $iFor_Descripcion, $iFor_Palabras, $iFor_FechaCreacion, $iFor_FechaCierre, $iFor_Funcion, $iFor_Tipo, $iFor_Estado, $iFor_IdPadre, $iLit_IdLineaTematica, $iUsu_IdUsuario, $iEnt_IdEntidad, $id_recurso, $iIdi_IdIdioma);

            }

            if (count($aFile_foro)) {
                foreach ($aFile_foro as $key => $value) {
                    if (trim($value["name"]) != "") {
                        $result_e = $this->_model->insertarFileForo($value["name"], $value["type"], $value["size"], $id_foro, $id_recurso);
                    }

                }
            }

            if ($funcion == "query") {
                $this->redireccionar("foro/index/query");
            } else {
                $this->redireccionar("foro/admin/members/" . $result_foro[0]);
            }
        }

        $this->_view->getLenguaje("foro_admin_index");
        $lenguaje = Session::get("fileLenguaje");

        if ($tipo == "edit") {
            $this->_view->assign('titulo', "Foro: Editar Foro");
            $foro = $this->_model->getForosComplit_x_Id($id_foro);
            if (!empty($foro)) {
                $_model_index     = $this->loadModel('index');
                $foro["Archivos"] = $_model_index->getArchivos_x_idforo($id_foro);
                $this->_view->assign('foro', $foro);
                $this->_view->assign('start_date', date('d-m-Y H:m', strtotime($foro["For_FechaCreacion"])));
                if (!empty($foro["For_FechaCierre"])) {
                    $this->_view->assign('end_date', date('d-m-Y H:m', strtotime($foro["For_FechaCierre"])));
                } else {
                    $this->_view->assign('end_date', date('d-m-Y H:m', strtotime($foro["For_FechaCreacion"] . '+1 day')));
                }

            } else {
                return $this->redireccionar("foro/admin");
            }

        } else {
            $this->_view->assign('titulo', $lenguaje["foro_admin_form_titulo"]);
            $this->_view->assign('start_date', date('d-m-Y H:m'));
            $this->_view->assign('end_date', date('d-m-Y H:m', strtotime('+1 day')));
        }

        $this->_view->assign('Form_Funcion', $funcion);
        $this->_view->setJs(array('form', array(BASE_URL . 'public/ckeditor/ckeditor.js'), array(BASE_URL . 'public/ckeditor/adapters/jquery.js'), array(BASE_URL . 'public/js/jquery-ui.min.js'), array(BASE_URL . 'public/js/jquery-ui-timepicker-addon.js')));
        $this->_view->setCss(array('form', array(BASE_URL . "public/css/jquery-ui-timepicker-addon.css"), array(BASE_URL . "public/css/jquery-ui.min.css")));

        if ($tipo == "new" && $id_foro != 0) {
            $this->_view->assign('iFor_IdPadre', $id_foro);
        }
        $this->_view->renderizar('form');
    }

    public function members($id_foro = 0)
    {
        if ($id_foro != 0) {
            $foro = $this->_model->getForos_x_Id($id_foro);

            if (!empty($foro)) {
                $this->_view->getLenguaje("foro_admin_members");
                $lenguaje = Session::get("fileLenguaje");
                $this->_view->assign('titulo', $lenguaje["foro_admin_members_titulo"]);
                $this->_view->setJs(array('members', array(BASE_URL . 'public/ckeditor/ckeditor.js'), array(BASE_URL . 'public/ckeditor/adapters/jquery.js')));

                $paginador = new Paginador();

                $lista_members  = $this->_model->getMembers_x_Foro($id_foro, "lider_foro");
                $totalRegistros = $this->_model->getRowMembers_x_Foro($id_foro, "lider_foro");

                $paginador->paginar($totalRegistros["Usf_RowMembers"], "listaMembers", "", $pagina = 1, CANT_REG_PAG, true);

                $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
                $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
                $this->_view->assign('lista_members', $lista_members);
                $this->_view->assign('foro', $foro);
                $this->_view->assign('lista_rol_foro', $this->_model->getRolForo());
                $this->_view->renderizar('members');
            } else {
                return $this->redireccionar("foro/admin");
            }
        } else {
            return $this->redireccionar("foro/admin");
        }
    }

    public function actividad($id_foro = 0)
    {
        if ($id_foro == 0) {
            $this->redireccionar("foro/admin");
        }
        $foro = $this->_model->getForos_x_Id($id_foro);
        if (empty($foro)) {
            $this->redireccionar("foro/admin");
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

        $lista_members = $this->_model->getMembers_x_Foro($id_foro, $rol_member, $pagina, $filas);

        $paginador->paginar($totalRegistros, "listaMembers", $filtro, $pagina, $filas, true);

        $this->_view->assign('lista_members', $lista_members);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listaMembers', false, true);
    }

    public function _tab_members()
    {
        $id_foro    = $this->getInt('id_foro');
        $rol_member = $this->getTexto('rol_member');
        $pagina     = 1;
        $paginador  = new Paginador();

        $lista_members  = $this->_model->getMembers_x_Foro($id_foro, $rol_member, $pagina, CANT_REG_PAG);
        $totalRegistros = $this->_model->getRowMembers_x_Foro($id_foro, $rol_member);

        $paginador->paginar($totalRegistros["Usf_RowMembers"], "listaMembers", "", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('lista_members', $lista_members);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listaMembers', false, true);
    }

    public function _cambiarEstadoMember()
    {
        $id_usuario    = $this->getInt('id_usuario');
        $id_foro       = $this->getInt('id_foro');
        $estado_member = $this->getInt('estado_member');

        $result = $this->_model->cambiarEstadoMember($id_usuario, $id_foro, $estado_member);

        $this->_paginacion_listaMembers();
    }

    public function _eliminarMember()
    {
        $id_usuario = $this->getInt('id_usuario');
        $id_foro    = $this->getInt('id_foro');

        $this->_model->updestadoRowMember($id_usuario, $id_foro, 0);

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

        $result_inscrip = $model_index->inscribir_participante_foro($id_foro, $id_usuario, $id_rol, 1);
         if(count($result_inscrip)>0){
            $result = $model_index->getEmail_Usuario($id_usuario);
            $this->sendEmail($result);
        }

        $pagina    = 1;
        $paginador = new Paginador();

        $lista_members  = $this->_model->getMembers_x_Foro($id_foro, $rol_member, $pagina, CANT_REG_PAG);
        $totalRegistros = $this->_model->getRowMembers_x_Foro($id_foro, $rol_member);

        $paginador->paginar($totalRegistros["Usf_RowMembers"], "listaMembers", "", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('lista_members', $lista_members);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listaMembers', false, true);
    }

     public function sendEmail($Email)
    {
        try{
            $email = $Email[0];
            $mail = "Prueba de mensaje";
            $Subject = 'INVITACION';
            $contenido = 'mensaje de prueba';
            $fromName = 'PRIC - Creación de Usuario';
            $Correo = new Correo();
            $SendCorreo = $Correo->enviar($email, "NAME", $Subject, $contenido, $fromName);
        }catch{
            
        }

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

}
