<?php

// use Dompdf\Adapter\CPDF;
// use Dompdf\Dompdf;
// use Dompdf\Exception;

class indexController extends bdrecursosController
{
    private $_bdrecursos;    
    private $_import;
    private $_lista_datos= array();

    public function __construct($lang, $url) 
    {
        parent::__construct($lang, $url);
        $this->_bdrecursos = $this->loadModel('indexbd');
        $this->_import = $this->loadModel('import');
        $this->_registros = $this->loadModel('registros','estandar');  
        $this->_mapa = $this->loadModel('mapa', true);       
    }

    public function index($idrecurso = false) 
    {
        $this->_acl->acceso("listar_recurso");
        $this->validarUrlIdioma();
        //$this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->getLenguaje("index_inicio");
        $this->_view->getLenguaje("bdrecursos_index");
        $this->_view->getLenguaje("bdrecursos_metadata");
        $paginador = new Paginador();

        $this->_view->setJs(array(array(BASE_URL . "getDocumentospublic/js/bootstrap-table.min.js", 
        false), 'bdrecursos'));

        $this->_view->setCss(array(array(BASE_URL . "public/css/bootstrap-table.min.css", false),
        'index'));

        if ($this->botonPress("bt_registrar")) 
        {
            if ($this->getTexto("tb_nombre_recurso") && $this->getTexto("tb_fuente_recurso") &&
                $this->getTexto("tb_origen_recurso") && $this->getTexto("sl_estandar_recurso")) 
            {
                $id_estandar = $this->getTexto("sl_estandar_recurso");
                $estandar_recurso = $this->_registros->getEstandar_recurso("WHERE Esr_IdEstandarRecurso=".$id_estandar."");
                $tipoEstandarRecurso = $estandar_recurso[0]['Esr_Tipo'];

                $recursos = $this->_bdrecursos->getRecursosIndex();        
                
                $a=0;
                
                for ($i=0; $i < count($recursos); $i++) 
                {                               
                    if(strtolower($this->getTexto('tb_nombre_recurso'))==strtolower($recursos[$i]['Rec_Nombre']))
                    {
                        $this->_view->assign('_error', 'El nombre <b style="font-size: 1.15em;">' . $this->getTexto('tb_nombre_recurso') . '</b> no pudo ser registrado, nombre existente');
                        $a=1;
                    }            
                }

                if($a==0)
                {   
                    $nombre_tabla = ''; 
                    
                    if($tipoEstandarRecurso == 2)
                    {
                        //Para crear la tabla data (x cada recurso)

                        $fichaEstandar = $this->_registros->getFichaEstandar($id_estandar);

                        $nombre_tabla = 'data_'.$fichaEstandar[0]['Fie_NombreTabla'];

                        $tabla_data_x_recurso = $this->_bdrecursos->getTablaData($nombre_tabla); 

                        if(!empty($tabla_data_x_recurso))
                        {
                            $i=str_replace('data_'.$fichaEstandar[0]['Fie_NombreTabla'].'_', '', $tabla_data_x_recurso[0]);

                            $i = $this->filtrarInt($i[0]);

                            $ii = $i+1; 
                            $nombre_tabla = 'data_'.$fichaEstandar[0]['Fie_NombreTabla'].'_'.$ii;
                        }
                        else
                        {
                            $nombre_tabla = 'data_'.$fichaEstandar[0]['Fie_NombreTabla'].'_1'; 
                        }
                    } 
                    // echo "'".$this->getTexto("tb_nombre_recurso")."','". 
                    // $this->getTexto("tb_fuente_recurso") ."','". $this->getTexto("hd_tipo_recurso")."','". 
                    // $this->getTexto("sl_estandar_recurso")."','".$this->getTexto("tb_origen_recurso")."','".$nombre_tabla."','".'es'."'"; exit;

                    $idrecurrso = $this->_bdrecursos->insertarRecurso($this->getTexto("tb_nombre_recurso"), 
                    $this->getTexto("tb_fuente_recurso"), $this->getTexto("hd_tipo_recurso"), 0, 
                    $this->getTexto("sl_estandar_recurso"), $this->getTexto("tb_origen_recurso"), $nombre_tabla, 'es');

                    if ($idrecurrso[0] > 0) 
                    {
                        $this->redireccionar("bdrecursos/metadata/" . $idrecurrso[0]);
                    } 
                    else 
                    {
                        $this->_view->assign('_error', 'No se pudo registrar el recurso: ' . $idrecurrso);
                    }                    
                }                
            } 
            else 
            {
                $this->_view->assign('_error', 'Debe Ingresar los Campos Obligatorios (*)');
            }
        } 
        else if ($this->botonPress("bt_actualizar")) 
        {
            if ($this->getTexto("tb_nombre_recurso") && $this->getTexto("tb_fuente_recurso") &&
                $this->getTexto("tb_origen_recurso")) 
            {
                $idrecurrso = $this->_bdrecursos->actualizarRecurso($this->filtrarInt($recurso), $this->getTexto("tb_nombre_recurso"), $this->getTexto("tb_fuente_recurso"), $this->getTexto("tb_origen_recurso"));

                if ($idrecurrso > 0) 
                {
                    $this->_view->assign('_mensaje', 'Operación ejecutada con éxito.');
                } 
                else 
                {
                    $this->_view->assign('_error', 'No se pudo actualizar el recurso: ' . $idrecurrso);
                }
            } 
            else 
            {
                $this->_view->assign('_error', 'Debe Ingresar los Campos Obligatorios (*)');
            }
        }
        
        if ($this->filtrarInt($idrecurso)) 
        {            
            $this->_acl->acceso("editar_recurso");
            $recurso = $this->_bdrecursos->getRecursoCompletoXid($this->filtrarInt($idrecurso));

            if (isset($recurso) && !empty($recurso)) 
            {
                if($recurso['Tir_IdTipoRecurso'] == 2)
                {
                    $capa = $this->_mapa->CapasCompletoXIdrecurso($idrecurso);
                    $id_capa = $capa[0]['Cap_Idcapa'];
                    $this->redireccionar("mapa/gestorcapa/wms/$id_capa");
                }
                else
                {
                    $this->_view->assign('recurso', $recurso);
                }
            } 
            else 
            {
                $this->redireccionar("bdrecursos");
            }
        } 

        $bdarquitectura = $this->loadModel('index', 'arquitectura');
        $this->_view->assign('idioma', Cookie::lenguaje());
        $this->_view->assign('idiomas', $bdarquitectura->getIdiomas());
        $recursosCompleto = $this->_bdrecursos->getRecursosCompleto();
        // print_r($recursosCompleto);exit;

        $bdherramienta = $this->loadModel('herramienta', true);
        $this->_view->assign('registros', $paginador->paginar($recursosCompleto, "lista_recursos", "", false, 25));

        if ($this->botonPress("export_data_excel")) {
            $this->_exportarDatosRecursos("excel");
        }

        if ($this->botonPress("export_data_pdf")) {
            $this->_exportarDatosRecursos("pdf");
        }

        if ($this->botonPress("export_data_csv")) {
            $this->_exportarDatosRecursos("csv");
        }
        $this->_view->assign('recursosCompletos', $recursosCompleto);
        $this->_view->assign('tiporecurso', $this->_bdrecursos->getTipoRecurso());
        $this->_view->assign('origenrecurso', $this->_bdrecursos->getOrigenRecurso());
        $this->_view->assign('fuente', $this->_bdrecursos->getFuente());
        $this->_view->assign('herramientas', $bdherramienta->getHerramienta());
        $this->_view->assign('estandar', $this->_bdrecursos->getEstandar());
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax'));
        $this->_view->assign('control_paginacion', $paginador->getControlPaginaion());
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());

        $this->_view->assign('titulo', 'Banco de Recursos');
        $this->_view->renderizar('index', 'bdrecursos');    
    }

    public function _registrar_importar_datos() 
    {
        ///aca me quede...
        
        $this->_view->assign('recursosCompletos', $recursosCompleto);
        $this->_view->assign('tiporecurso', $this->_bdrecursos->getTipoRecurso());
        $this->_view->assign('origenrecurso', $this->_bdrecursos->getOrigenRecurso());
        $this->_view->assign('fuente', $this->_bdrecursos->getFuente());
        $this->_view->assign('herramientas', $bdherramienta->getHerramienta());
        $this->_view->assign('estandar', $this->_bdrecursos->getEstandar());
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax'));
        $this->_view->assign('control_paginacion', $paginador->getControlPaginaion());
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());

        $this->_view->assign('titulo', 'Banco de Recursos');
        $this->_view->renderizar('index', 'bdrecursos');  
    }

    public function _filtroRecursos() 
    {
        // exit;
        $this->_view->getLenguaje("bdrecursos_index");
        $paginador = new Paginador();

        $tipo = $this->getTexto('tipo'); 
        $nombre = $this->getSql('nombre');
        $estandar = $this->getInt('estandar');
        $fuente = $this->getTexto('fuente');
        $origen = $this->getTexto('origen');
        $herramienta = $this->getInt('herramienta');

        $this->_view->assign('nombre', $nombre);
        $this->_view->assign('sl_estandar', $estandar);
        $this->_view->assign('sl_fuente', $fuente);
        $this->_view->assign('sl_origen', $origen);
        $this->_view->assign('sl_herramienta', $herramienta);

        $bdherramienta = $this->loadModel('herramienta', true);

        $this->_view->assign('registros', $paginador->paginar($this->_bdrecursos->getRecursosCompleto($tipo, $nombre, $estandar, $fuente, $origen, $herramienta), "lista_recursos", "", false, 25));
        $this->_lista_datos = $paginador->paginar($this->_bdrecursos->getRecursosCompleto($tipo, $nombre, $estandar, $fuente, $origen, $herramienta), "lista_recursos", "", false, 25);
        // echo count($this->_lista_datos); exit;

        $this->_view->assign('tiporecurso', $this->_bdrecursos->getTipoRecurso());
        $this->_view->assign('origenrecurso', $this->_bdrecursos->getOrigenRecurso());
        $this->_view->assign('fuente', $this->_bdrecursos->getFuente());
        $this->_view->assign('herramientas', $bdherramienta->getHerramienta());
        $this->_view->assign('estandar', $this->_bdrecursos->getEstandar());
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax'));
        $this->_view->assign('control_paginacion', $paginador->getControlPaginaion());
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());

        // $this->_view->assign('tiporecursoInput', $tipo);
        // echo $tipo; exit;

        $this->_view->renderizar('ajax/lista_recursos', false, true);
    }

    public function _exportarDatosRecursos($formatoP)
    {      
        $this->_view->getLenguaje("bdrecursos_index");
        $paginador = new Paginador();

        $tipo = $_SESSION['tipoRecdescarga'];
        $nombre = $this->getSql('tb_nombre_filter');
        $estandar = $this->getSql('sl_estandar_recurso_filtro');
        $fuente = $this->getSql('sl_fuente_filtro');
        $origen = $this->getSql('sl_origen_filtro');
        $herramienta = $this->getSql('sl_herramienta_filtro');
        $formato = $formatoP;

        $lista_datos = $paginador->paginar($this->_bdrecursos->getRecursosCompleto($tipo, $nombre, $estandar, $fuente, $origen, $herramienta), "lista_recursos", "", false, 25);
        
        $herramientas = "";
        if ($formato == "csv") {
            if (!empty($lista_datos)) {
                error_reporting(0);
                $objPHPExcel = new PHPExcel();

                 $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, 'Rec_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, 'Tir_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, 'Esr_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, 'Rec_Fuente');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, 1, 'Rec_CantidadRegistros');  
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(5, 1, 'herramientas');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(6, 1, 'Rec_FechaRegistro');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(7, 1, 'Rec_Estado');

                for ($i = 2; $i <= (count($lista_datos) + 1); $i++) {
                    // $fila11 = mb_convert_encoding($fila11, 'UTF-16LE', 'UTF-8'); 
                    // chr(255) . chr(254); 
                    // echo $fila11; exit;
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $i, $lista_datos[$i - 2]['Rec_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $lista_datos[$i - 2]['Tir_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $i, $lista_datos[$i - 2]['Esr_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $i, $lista_datos[$i - 2]['Rec_Fuente']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, $i, $lista_datos[$i - 2]['Rec_CantidadRegistros']);
                    foreach ($lista_datos[$i - 2]['herramientas'] as $items) {
                        // echo count($Roles) . 'hola'; exit;
                        $herramientas .= $items['Her_Nombre'] . ', ';
                    }
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(5, $i, $herramientas);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(6, $i, $lista_datos[$i - 2]['Rec_FechaRegistro']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(7, $i, $lista_datos[$i - 2]['Rec_Estado']);
                    $herramientas = "";
                }
                $objPHPExcel->getActiveSheet()->setTitle('ListaDeDescargas');
                $objPHPExcel->setActiveSheetIndex(0);
                ob_end_clean();
                ob_start();
                //
                header("Content-type: application/vnd.ms-excel"); 
                header('Content-Disposition: attachment;filename="'.APP_NAME.'-OTCA_Descargas.csv"');
                header("Pragma: no-cache"); header("Expires: 0"); 
                echo "\xEF\xBB\xBF"; //UTF-8 BOM echo $out;
                //                 
                $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'CSV');
                $objWriter -> setDelimiter ( ',' ) ; 
                $objWriter->save('php://output');
            }
            exit;
        }
        if ($formato == "excel") {
            if (!empty($lista_datos)) {
                // echo "."; exit;
                error_reporting(0);
                $objPHPExcel = new PHPExcel();

                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, 'Rec_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, 'Tir_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, 'Esr_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, 'Rec_Fuente');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, 1, 'Rec_CantidadRegistros');  
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(5, 1, 'herramientas');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(6, 1, 'Rec_FechaRegistro');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(7, 1, 'Rec_Estado');

                for ($i = 2; $i <= (count($lista_datos) + 1); $i++) {
                    // $fila11 = mb_convert_encoding($fila11, 'UTF-16LE', 'UTF-8'); 
                    // chr(255) . chr(254); 
                    // echo $fila11; exit;
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $i, $lista_datos[$i - 2]['Rec_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $lista_datos[$i - 2]['Tir_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $i, $lista_datos[$i - 2]['Esr_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $i, $lista_datos[$i - 2]['Rec_Fuente']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, $i, $lista_datos[$i - 2]['Rec_CantidadRegistros']);
                    foreach ($lista_datos[$i - 2]['herramientas'] as $items) {
                        // echo count($Roles) . 'hola'; exit;
                        $herramientas .= $items['Her_Nombre'] . ', ';
                    }
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(5, $i, $herramientas);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(6, $i, $lista_datos[$i - 2]['Rec_FechaRegistro']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(7, $i, $lista_datos[$i - 2]['Rec_Estado']);
                    $herramientas = "";
                }

                $objPHPExcel->getActiveSheet()->setTitle('ListaDeDescargas');
                $objPHPExcel->setActiveSheetIndex(0);
                ob_end_clean();
                ob_start();
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
            <h3 style='text-align: center; color:black; font-family: inherit;'>BANCO DE RECURSOS</h3>
                    <table class='table'>
                        <thead>
                            <tr>
                                <th></th>
                                <th>Nombres</th>
                                <th>Tipo</th>
                                <th>".utf8_decode('Estándar')."</th>
                                <th>Fuente</th>
                                <th>Registros</th>
                                <th>Herramienta</th>
                                <th>Registro</th>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>";
        $b = "";
        $c="";
        $d="";
        $cuerpo="";
        $i=1;
            foreach ($lista_datos as $item){  
                $b .= 
                "<tr>
                    <th scope='row'>".$i++."</th>
                    <td>" . utf8_decode($item['Rec_Nombre']) . "</td>
                    <td>" . utf8_decode($item['Tir_Nombre']) . "</td>
                    <td>" . utf8_decode($item['Esr_Nombre']) . "</td>
                    <td>" . utf8_decode($item['Rec_Fuente']) . "</td>
                    <td>" . utf8_decode($item['Rec_CantidadRegistros']) . "</td>       
                    <td>
                        <ul>";
                            foreach ($item['herramientas'] as $r){
                               $c .= 
                               "<li>".utf8_decode($r['Her_Nombre']).
                               "</li>";
                            }
                            $d.="
                        </ul>
                    </td>
                    <td style='text-align: center'>" . utf8_decode($item['Rec_FechaRegistro']) . "</td> 
                    <td style='text-align: center'>" . utf8_decode($item['Rec_Estado']) . "</td> 
                </tr>";
                $cuerpo.=$b.$c.$d; 
                $b="";
                $c="";
                $d="";
            }
        $e =  
                     "</tbody>
                </table>
            </div>
            <script type='text/javascript' src='views/layout/frontend/js/bootstrap.min.js' ></script>
        </body>";

            echo $a.$cuerpo.$e;
            require_once("libs/_dompdf/dompdf_config.inc.php");
            $dompdf = new DOMPDF();
            $dompdf->set_paper('A4', 'landscape'); //esta es una forma de ponerlo horizontal
            $dompdf->load_html(ob_get_clean());
            $dompdf->render();
            $pdf      = $dompdf->output();
            $filename = "'".APP_NAME.'-OTCA_Descargas.pdf';
            $dompdf->stream($filename, array("atachment" => 0));
            
            // require_once("libs/autoload.inc.php");
            // $dompdf = new Dompdf(); 
            // $dompdf->set_paper('A4', 'landscape'); //esta es una forma de ponerlo horizontal
            // $dompdf->set_option('isHtml5ParserEnabled', true);
            // $dompdf->loadHtml("$a.$cuerpo.$e");
            // $dompdf->render();
            // $dompdf->stream("'".APP_NAME.'-OTCA_Descargas.pdf');
            
        } 
        Session::destroy('tipoRecdescarga');       
    }


    public function _filtroRecursosDublin($tipoServicio = false) 
    {
        $this->_view->getLenguaje("bdrecursos_index");
        $paginador = new Paginador();

        $tipo = $this->getTexto('tipo');
        $nombre = $this->getSql('nombre');
        $estandar = $this->getInt('estandar');
        $fuente = $this->getTexto('fuente');
        $origen = $this->getTexto('origen');
        $herramienta = $this->getInt('herramienta');

        if ($tipoServicio) {
            $this->_view->assign('tipoServicio', $tipoServicio);
        }else{
            $this->_view->assign('tipoServicio', 'excel');            
        }

        $this->_view->assign('nombre', $nombre);
        $this->_view->assign('sl_estandar', $estandar);
        $this->_view->assign('sl_fuente', $fuente);
        $this->_view->assign('sl_origen', $origen);
        $this->_view->assign('sl_herramienta', $herramienta);

        $bdherramienta = $this->loadModel('herramienta', true);

        $this->_view->assign('registros', $paginador->paginar($this->_bdrecursos->getRecursosCompleto($tipo, $nombre, $estandar, $fuente, $origen, $herramienta), "lista_recursos", "", false, 25));
        $this->_view->assign('tiporecurso', $this->_bdrecursos->getTipoRecurso());
        $this->_view->assign('origenrecurso', $this->_bdrecursos->getOrigenRecurso());
        $this->_view->assign('fuente', $this->_bdrecursos->getFuente());
        $this->_view->assign('herramientas', $bdherramienta->getHerramienta());
        $this->_view->assign('estandar', $this->_bdrecursos->getEstandar());
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax'));
        $this->_view->assign('control_paginacion', $paginador->getControlPaginaion());
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());

        $this->_view->renderizar('ajax/lista_recursos_dublin', false, true);
    }

    public function _actualizarEstado() 
    {
        $pagina = $this->getInt('pagina');
        $this->_view->getLenguaje("bdrecursos_index");

        $paginador = new Paginador();

        $idrecurso = $this->getInt('idrecurso');
        $estado = $this->getInt('estado');

        $tipo = $this->getTexto('tipo');
        $nombre = $this->getTexto('nombre');
        $estandar = $this->getInt('estandar');
        $fuente = $this->getTexto('fuente');
        $origen = $this->getTexto('origen');
        $herramienta = $this->getInt('herramienta');

        $this->_bdrecursos->actualizarEstadoRecurso($idrecurso, $estado);

        $this->_view->assign('nombre', $nombre);
        $this->_view->assign('sl_estandar', $estandar);
        $this->_view->assign('sl_fuente', $fuente);
        $this->_view->assign('sl_origen', $origen);
        $this->_view->assign('sl_herramienta', $herramienta);

        $bdherramienta = $this->loadModel('herramienta', true);
        $this->_view->assign('tiporecurso', $this->_bdrecursos->getTipoRecurso());
        $this->_view->assign('origenrecurso', $this->_bdrecursos->getOrigenRecurso());
        $this->_view->assign('fuente', $this->_bdrecursos->getFuente());
        $this->_view->assign('herramientas', $bdherramienta->getHerramienta());
        $this->_view->assign('estandar', $this->_bdrecursos->getEstandar());

        $this->_view->assign('numeropagina', $pagina);
        $this->_view->assign('registros', $paginador->paginar($this->_bdrecursos->getRecursosCompleto($tipo, $nombre, $estandar, $fuente, $origen, $herramienta), "lista_recursos", "", $pagina, 25));

        //$this->_view->assign("variables", $paginador->paginar($this->_mapa->VariablesPorEstacion($this->filtrarInt($idestacion), ""), "estacion_lista_variables", $this->filtrarInt($idestacion), $pagina, 25));
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax', false));
        $this->_view->assign('control_paginacion', $paginador->getControlPaginaion());
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());

        $this->_view->renderizar('ajax/lista_recursos', false, true);
    }

    public function _eliminarRecurso() 
    {
        $pagina = $this->getInt('pagina');
        $this->_view->getLenguaje("bdrecursos_index");

        $paginador = new Paginador();

        $idrecurso = $this->getInt('idrecurso');
        
        $tipo = $this->getTexto('tipo');
        $nombre = $this->getTexto('nombre');
        $estandar = $this->getInt('estandar');
        $fuente = $this->getTexto('fuente');
        $origen = $this->getTexto('origen');
        $herramienta = $this->getInt('herramienta');

        $this->_bdrecursos->eliminarRecurso($idrecurso);

        $this->_view->assign('nombre', $nombre);
        $this->_view->assign('sl_estandar', $estandar);
        $this->_view->assign('sl_fuente', $fuente);
        $this->_view->assign('sl_origen', $origen);
        $this->_view->assign('sl_herramienta', $herramienta);

        $bdherramienta = $this->loadModel('herramienta', true);
        $this->_view->assign('tiporecurso', $this->_bdrecursos->getTipoRecurso());
        $this->_view->assign('origenrecurso', $this->_bdrecursos->getOrigenRecurso());
        $this->_view->assign('fuente', $this->_bdrecursos->getFuente());
        $this->_view->assign('herramientas', $bdherramienta->getHerramienta());
        $this->_view->assign('estandar', $this->_bdrecursos->getEstandar());

        $this->_view->assign('numeropagina', $pagina);
        $this->_view->assign('registros', $paginador->paginar($this->_bdrecursos->getRecursosCompleto($tipo, $nombre, $estandar, $fuente, $origen, $herramienta), "lista_recursos", "", $pagina, 25));

        //$this->_view->assign("variables", $paginador->paginar($this->_mapa->VariablesPorEstacion($this->filtrarInt($idestacion), ""), "estacion_lista_variables", $this->filtrarInt($idestacion), $pagina, 25));
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax', false));
        $this->_view->assign('control_paginacion', $paginador->getControlPaginaion());
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());

        $this->_view->renderizar('ajax/lista_recursos', false, true);
    }

    public function _paginacion_lista_recursos() 
    {
        $pagina = $this->getInt('pagina');
        $this->_view->getLenguaje("index_inicio");
        $this->_view->getLenguaje("bdrecursos_index");
        $paginador = new Paginador();

        $tipo = $this->getTexto('tipo');
        $_SESSION['tipoRecdescarga'] = $tipo;
        $nombre = $this->getSql('nombre');
        $estandar = $this->getInt('estandar');
        $fuente = $this->getTexto('fuente');
        $origen = $this->getTexto('origen');
        $herramienta = $this->getInt('herramienta');

        $this->_view->assign('nombre', $nombre);
        $this->_view->assign('sl_estandar', $estandar);
        $this->_view->assign('sl_fuente', $fuente);
        $this->_view->assign('sl_origen', $origen);
        $this->_view->assign('sl_herramienta', $herramienta);

        $bdherramienta = $this->loadModel('herramienta', true);
        $this->_view->assign('tiporecurso', $this->_bdrecursos->getTipoRecurso());
        $this->_view->assign('origenrecurso', $this->_bdrecursos->getOrigenRecurso());
        $this->_view->assign('fuente', $this->_bdrecursos->getFuente());
        $this->_view->assign('herramientas', $bdherramienta->getHerramienta());
        $this->_view->assign('estandar', $this->_bdrecursos->getEstandar());

        $this->_view->assign('numeropagina', $pagina);
        $this->_view->assign('registros', $paginador->paginar($this->_bdrecursos->getRecursosCompleto($tipo, $nombre, $estandar, $fuente, $origen, $herramienta), "lista_recursos", "", $pagina, 25));

        //$this->_view->assign("variables", $paginador->paginar($this->_mapa->VariablesPorEstacion($this->filtrarInt($idestacion), ""), "estacion_lista_variables", $this->filtrarInt($idestacion), $pagina, 25));
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax', false));
        $this->_view->assign('control_paginacion', $paginador->getControlPaginaion());
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());

        $this->_view->renderizar('ajax/lista_recursos', false, true);
    }

    public function _getTraduccionRecurso() 
    {
        //$this->validarUrlIdioma();
        $idrecurso = $this->getInt("idrecurso");
        $idIdioma = $this->getTexto("idIdioma");
        $idIdiomaO = $this->getTexto("idIdiomaO");

        $recurso = $this->_bdrecursos->getRecursoMetadataTraducido($idrecurso, Cookie::lenguaje());

        if ($recurso["Idi_IdIdioma"] != $idIdioma) 
        {
            $recurso["Rec_Nombre"] = "";
            $recurso["Rec_Fuente"] = "";
            $recurso["Rec_Origen"] = "";
            $recurso["Idi_IdIdioma"] = "";
        }

        $this->_view->assign('recurso', $recurso);
        $this->_view->assign('idIdiomaO', $idIdiomaO);
        $this->_view->renderizar('ajax/index_nuevo_recurso', false, true);
    }
     
}
?>