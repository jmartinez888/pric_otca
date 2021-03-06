<?php

// use Dompdf\Adapter\CPDF;
// use Dompdf\Dompdf;
// use Dompdf\Exception;

class indexController extends aclController
{
    private $_aclm;
    
    public function __construct($lang,$url) 
    {
        parent::__construct($lang,$url);
        $this->_aclm = $this->loadModel('index');        
    }
    
    public function index()
    {       
        $this->_acl->autenticado();
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("index_inicio");
        $this->_view->assign('titulo', 'Listas de acceso');
        
        $this->_view->renderizar('index');
    }
    
    /*Roles*/
    //Modificado por Jhon Martinez
    public function roles()
    {
        $this->_acl->acceso('listar_usuarios');
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("index_inicio");
        $this->_view->setJs(array('index'));
        $nombre = $this->getSql('nombre');
        $pagina = $this->getInt('pagina');
        
        $paginador = new Paginador();
        if ($this->botonPress("bt_guardarRol")) 
        {
              $this->nuevo_role();                
        }

        //Filtro por Activos/Eliminados
        $condicion = " ORDER BY r.Row_Estado DESC ";
        $soloActivos = 0;
        if (!$this->_acl->permiso('ver_eliminados')) {
            $soloActivos = 1;
            $condicion = " WHERE r.Row_Estado = $soloActivos ";
        }
        //Filtro por Activos/Eliminados

        $arrayRowCount = $this->_aclm->getRolesRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];

        // $this->_view->assign('roles', $paginador->paginar($this->_aclm->getRoles(), "listarRoles", "$nombre", $pagina, 25));

        if ($this->botonPress("export_data_excel")) {
            $this->_exportarDatosRoles("excel");
        }

        if ($this->botonPress("export_data_pdf")) {
            $this->_exportarDatosRoles("pdf");
        }

        if ($this->botonPress("export_data_csv")) {
            $this->_exportarDatosRoles("csv");
        }

        $this->_view->assign('modulos', $this->_aclm->getModulos(0,0));
        $this->_view->assign('roles', $this->_aclm->getRolesPaginado($pagina,CANT_REG_PAG,$soloActivos));

        $paginador->paginar( $totalRegistros,"listarRoles", "", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->assign('titulo', 'Administración de roles');
        $this->_view->renderizar('roles');
    }    
    //Modificado por Jhon Martinez
    public function nuevo_role($usu=false)
    {
        $this->_acl->acceso('agregar_rol');
        if(!$this->getSql('nuevoRol'))
        {
            if(!$usu)
            {                
                $this->_view->assign('_error','Debe llenar el campo Rol.');
                $this->_view->renderizar('ajax/nuevo_rol', false, true);
            }
        }
        if($this->_aclm->verificarRol($this->getSql('nuevoRol')))
        {
            $this->_view->assign('_error', 'El rol <b style="font-size: 1.15em;">'.$this->getSql('nuevoRol').'</b> ya existe');
        }
        else
        {   
    
            $idRol = $this->_aclm->insertarRol(
                $this->getSql('nuevoRol'),$this->getSql('key_'),$this->getSql('modulo_'),'es',1                
            );  
            if (is_array($idRol)) 
            {
                if ($idRol[0] > 0) 
                {
                    $this->_view->assign('_mensaje', 'Registro Completado..!!');
                } 
                else 
                {
                    $this->_view->assign('_error', 'Error al registrar la Usuario');
                }
            }
            else 
            {
               $this->_view->assign('_error', 'Ocurrio un error al Registrar los datos');
            }
        } 

        // if($usu)
        // {
        //     $this->_view->renderizar('ajax/nuevo_rol', false, true);
        // }
    }
    //Modificado por Jhon Martinez
    public function _cambiarEstadoRol()
    {
        $this->_acl->acceso('editar_rol');
        //Para Mensajes
        $resultado = array();
        $mensaje = "error";
        $contenido = "";
        //Variables de Ajax_JavaScript
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $Rol_IdRol = $this->getInt('_Rol_IdRol');
        $Rol_Estado = $this->getInt('_Rol_Estado');
        
        if(!$Rol_IdRol){            
            $this->_view->assign('_error', 'Error parametro ID ..!!');  
            $this->_view->renderizar('index');
            exit;          
        } else {
            //Actualizacion de estado en la BD
            $rowCountEstado = $this->_aclm->cambiarEstadoRol($Rol_IdRol, $Rol_Estado);
            //Mensaje de Actualizacion
            if ($rowCountEstado > 0) {
                if ($Rol_Estado == 1) {
                    $contenido = ' Se cambio de estado correctamente a <b>Deshabilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign" title="Deshabilitado" style="background: #FFF; color: #DD4B39; padding: 2px;"/> ...!! ';              
                }
                if ($Rol_Estado == 0) {
                     $contenido = ' Se cambio de estado correctamente a <b>Habilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign" title="Habilitado" style=" background: #FFF;  color: #088A08; padding: 2px;"/> ...!! ';
                }     
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));       
            } else {
                $this->_view->assign('_error', 'Error de variable(s) en consulta..!!');
            }        
        }
        //Mensaje JSON
        $mensaje_json = json_encode($resultado);
        // echo($mensaje_json); exit();
        $this->_view->assign('_mensaje_json', $mensaje_json);

        $soloActivos = 0;
        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Rol_Nombre liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND r.Row_Estado = $soloActivos ";
            }
            
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY r.Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE r.Row_Estado = $soloActivos  ";
            }
        }  

        $paginador = new Paginador();

        $arrayRowCount = $this->_aclm->getRolesRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // echo($totalRegistros);
        // print_r($arrayRowCount); echo($condicion);exit;
        $this->_view->assign('roles', $this->_aclm->getRolesCondicion($pagina,$filas, $condicion));

        $paginador->paginar( $totalRegistros ,"listarRoles", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->renderizar('ajax/listarRoles', false, true);
    }
    //Modificado por Jhon Martinez
    public function _paginacion_listarRoles($txtBuscar = false) 
    {
        //$this->validarUrlIdioma();
        // $pagina = $this->getInt('pagina');
        //$registros = $this->getInt('registros');

        // $nombre = $this->getSql('nombre');
        // if ($nombre) {
        //     $condicion .= " where Rol_Nombre liKe '%$nombre%' ";
        // }

        //Variables de Ajax_JavaScript
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $totalRegistros = $this->getInt('total_registros');

        $soloActivos = 0;
        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Rol_Nombre liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND r.Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY r.Row_Estado DESC ";
            }
            
        } else {
            $condicion = " ORDER BY r.Row_Estado DESC ";
            //Filtro por Activos/Eliminados  
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE r.Row_Estado = $soloActivos  ";
            }
        }  

        $paginador = new Paginador();

        // $this->_view->assign('roles', $paginador->paginar($this->_aclm->getRoles($condicion), "listarRoles", "$nombre", $pagina, 25));

        $paginador->paginar( $totalRegistros,"listarRoles", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('roles', $this->_aclm->getRolesCondicion($pagina,$filas, $condicion));

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarRoles', false, true);
    }
    //Modificado por Jhon Martinez
    public function _buscarRol() 
    {
        //$this->validarUrlIdioma();
        // $nombre = $this->getSql('palabra');
        // $condicion = "";

        // if ($nombre) {
        //     $condicion .= " where Rol_role liKe '%$nombre%' ";
        // }

        //Variables de Ajax_JavaScript
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $totalRegistros = $this->getInt('total_registros');

        $soloActivos = 0;
        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Rol_Nombre liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND r.Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY r.Row_Estado DESC ";
            }
            
        } else {
            $condicion = " ORDER BY r.Row_Estado DESC ";
            //Filtro por Activos/Eliminados  
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE r.Row_Estado = $soloActivos  ";
            }
        }  

        $paginador = new Paginador();

        $arrayRowCount = $this->_aclm->getRolesRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];

        $paginador->paginar( $totalRegistros,"listarRoles", "$txtBuscar", $pagina,CANT_REG_PAG, true);

        $this->_view->assign('roles', $this->_aclm->getRolesCondicion($pagina,CANT_REG_PAG, $condicion));
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarRoles', false, true);
    }

    public function _exportarDatosRoles($formatoP)
    {       
        $txtBuscar = $this->getSql('palabraRol');   
        // echo $txtBuscar; exit;
        $soloActivos = 0; 
        $pagina = $this->getInt('pagina');
        // $filtro2 = $this->getSql('select_busqueda');
        $formato  = $formatoP;

        if (empty($filtro)) {
            $filtro  = "";
        } 
        // if(empty($filtro2)){
        //     $filtro2="";
        // }        

        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Rol_Nombre liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND r.Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY r.Row_Estado DESC ";
            }
            
        } else {
            $condicion = " ORDER BY r.Row_Estado DESC ";
            //Filtro por Activos/Eliminados  
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE r.Row_Estado = $soloActivos  ";
            }
        }

        $lista_datos = $this->_aclm->getRolesCondicion($pagina,CANT_REG_PAG, $condicion);
        
        if ($formato == "csv") {
            if (!empty($lista_datos)) {
                error_reporting(0);
                $objPHPExcel = new PHPExcel();

                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, 'Rol_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, 'Mod_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, 'Rol_Estado');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, 'Row_Estado');

                for ($i = 2; $i <= (count($lista_datos) + 1); $i++) {
                    // $fila11 = mb_convert_encoding($fila11, 'UTF-16LE', 'UTF-8'); 
                    // chr(255) . chr(254); 
                    // echo $fila11; exit;
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $i, $lista_datos[$i - 2]['Rol_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $lista_datos[$i - 2]['Mod_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $i, $lista_datos[$i - 2]['Rol_Estado']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $i, $lista_datos[$i - 2]['Row_Estado']);
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

                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, 'Rol_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, 'Mod_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, 'Rol_Estado');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, 'Row_Estado');

                for ($i = 2; $i <= (count($lista_datos) + 1); $i++) {
                    // $fila11 = mb_convert_encoding($fila11, 'UTF-16LE', 'UTF-8'); 
                    // chr(255) . chr(254); 
                    // echo $fila11; exit;
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $i, $lista_datos[$i - 2]['Rol_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $lista_datos[$i - 2]['Mod_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $i, $lista_datos[$i - 2]['Rol_Estado']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $i, $lista_datos[$i - 2]['Row_Estado']);
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
            <h3 style='text-align: center; color:black; font-family: inherit;'>ROLES DEL SISTEMA</h3>
                    <table class='table'>
                        <thead>
                            <tr>
                                <th></th>
                                <th>Rol</th>
                                <th>".utf8_decode('Módulo')."</th>
                                <th>Estado</th>
                                <th>Row_Estado</th>
                            </tr>
                        </thead>
                        <tbody>";
        $b = "";
        $c="";
        $d="";
        $cuerpo="";
        $i=1;
            foreach ($lista_datos as $item){  
                $b .= "<tr>
                    <th scope='row'>".$i++."</th>
                    <td>" . utf8_decode($item['Rol_Nombre']) . "</td>
                    <td>";
                        if(!empty($item['Mod_Nombre'])){
                            $c.= utf8_decode($item['Mod_Nombre']);
                        }
                        if(empty($item['Mod_Nombre'])){
                            $c.="-";
                        } 
                    $d.=
                    "</td>
                    <td style='text-align: center'>" . utf8_decode($item['Rol_Estado']) . "</td>    
                    <td style='text-align: center'>" . utf8_decode($item['Row_Estado']) . "</td>        
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
    }

    //Modificado por Jhon Martinez
    public function editarRol($Rol_IdRol = false)
    {
        $this->_acl->acceso('editar_rol');
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("index_inicio");
        $this->_view->setJs(array('index'));
        $rol = $this->_aclm->getRol($this->filtrarInt($Rol_IdRol));

        if ($this->botonPress("bt_cancelarEditarRol")) {
            $this->redireccionar('acl/index/roles');
        }

        if ($this->botonPress("bt_editarRol")) 
        {            
            if($this->getSql('idIdiomaSeleccionado') == $rol['Idi_IdIdioma'])
            {
                $id = $this->_aclm->editarRol($this->filtrarInt($Rol_IdRol), $this->getSql('Rol_Nombre'),$this->getSql('key_'),$this->getSql('modulo_'));
                if($id)
                {
                    $this->_view->assign('_mensaje', 'Rol editado Correctamente');
                    $rol = $this->_aclm->getRol($this->filtrarInt($Rol_IdRol));
                }  
                else 
                {
                    $this->_view->assign('_error', 'Error al editar Rol');
                }
            } else {
                $id = $this->_aclm->editarTraduccion($this->filtrarInt($Rol_IdRol), $this->getSql('Rol_Nombre'), $this->getSql('idIdiomaSeleccionado'));
                if($id)
                {
                    $this->_view->assign('_mensaje', 'Traducción de Rol editado Correctamente');
                }  
                else 
                {
                    $this->_view->assign('_error', 'Error al editar Rol');
                }
            }
            //$this->redireccionar('acl/index/roles');
            //exit;
        }        
        $this->_view->assign('modulos', $this->_aclm->getModulos(0,0));
        $this->_view->assign('idiomas',$this->_aclm->getIdiomas());        
        $this->_view->assign('datos',$rol);
        $this->_view->renderizar('ajax/editarRol','editarRol');
    }
    
    public function gestion_idiomas_rol() 
    {
        $this->_view->getLenguaje('template_backend');
        $Idi_IdIdioma =  $this->getPostParam('idIdioma');        
        $Rol_IdRol = $this->getPostParam('idrol');
                   
        $datos = $this->_aclm->getRolTraducido($Rol_IdRol, $Idi_IdIdioma);

        $this->_view->assign('idiomas',$this->_aclm->getIdiomas());
        if ($datos["Idi_IdIdioma"]==$Idi_IdIdioma) 
        {
            $this->_view->assign('datos',$datos);    
        }
        else
        {
            $datos["Rol_role"]="";
            $datos["Idi_IdIdioma"]=$Idi_IdIdioma;
            $this->_view->assign('datos',$datos);  
        }            
        //$this->_view->assign('IdiomaOriginal',$this->getPostParam('idIdiomaOriginal'));        
        $this->_view->renderizar('ajax/gestion_idiomas_rol', false, true);
    }

    //Modificado por Jhon Martinez
    public function _eliminarRol()
    {
        $this->_acl->acceso('editar_rol');
                
        //Variables Ajax_Javascript
        $Rol_IdRol = $this->getInt('_Rol_IdRol');
        $Row_Estado = $this->getInt('_Row_Estado');
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');       
        // echo $Per_IdPermiso."//".$Row_Estado;
        //Para Mensajes
        $resultado = array();
        $mensaje = "error";
        $contenido = "";
        //Para mensajes

        if ($Row_Estado == 0) {
            if(!$Rol_IdRol)
            {            
                $contenido = 'Error parametro ID ..!!'; 
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));          
            } else {
                $usu = $this->_aclm->getUsuarioRol($Rol_IdRol);
                // print_r($role);
                if ($usu <= 0)
                {                   
                    $rowCount = $this->_aclm->eliminarHabilitarRol($Rol_IdRol,$Row_Estado);
                    // echo $rowCount3;//exit;
                    if($rowCount && $rowCount > 0)
                    {
                        $contenido = 'El rol fue elimnado correctamente...!!!'; 
                        $mensaje = "ok";
                        array_push($resultado, array(0 => $mensaje, 1 => $contenido));  
                    } else {
                        $contenido = 'No se pudo eliminar rol, error de consulta...!!!'; 
                        $mensaje = "error";
                        array_push($resultado, array(0 => $mensaje, 1 => $contenido)); 
                    }
                    
                } else {
                    $contenido = 'No se pudo eliminar rol asignado a usuario...!!!'; 
                    $mensaje = "error";
                    array_push($resultado, array(0 => $mensaje, 1 => $contenido)); 
                }  
                // echo $error;exit;        
            }
        } else {
            $rowCount = $this->_aclm->eliminarHabilitarRol($Rol_IdRol,$Row_Estado);            
            if($rowCount)
            {
                $contenido = 'El rol fue activado correctamente...!!!'; 
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            } else {
                $contenido = 'No se pudo activar rol error en consulta...!!!'; 
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            }
        }

        $mensaje_json = json_encode($resultado);
        // echo($mensaje_json); exit();
        $this->_view->assign('_mensaje_json', $mensaje_json);

        $soloActivos = 0;
        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Rol_Nombre liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND r.Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY r.Row_Estado DESC ";
            }
            
        } else {
            $condicion = " ORDER BY r.Row_Estado DESC ";
            //Filtro por Activos/Eliminados  
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE r.Row_Estado = $soloActivos  ";
            }
        }  

        $paginador = new Paginador();

        $arrayRowCount = $this->_aclm->getRolesRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];

        $paginador->paginar( $totalRegistros,"listarRoles", "$txtBuscar", $pagina,$filas, true);

        $this->_view->assign('roles', $this->_aclm->getRolesCondicion($pagina, $filas, $condicion));

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarRoles', false, true);
    }
    
    /*Permisos*/
    //Modificado por Jhon Martinez
    public function permisos($error = "")
    {
        $this->_acl->acceso('listar_usuarios');
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("index_inicio");
        $this->_view->setJs(array('index'));

        // if($error!="")
        // {
        //     if($error == 1)
        //     {
        //         $this->_view->assign('_mensaje', 'El permiso fue elimnado correctamente...!!!');
        //     }  
        //     else 
        //     {
        //         $this->_view->assign('_error', $error);
        //     }            
        // }
        // $txtBuscar = $this->getSql('nombre');
        $pagina = $this->getInt('pagina');

        //Filtro por Activos/Eliminados
        $condicion = " ORDER BY p.Row_Estado DESC ";
        $soloActivos = 0;
        if (!$this->_acl->permiso('ver_eliminados')) {
            $soloActivos = 1;
            $condicion = " WHERE p.Row_Estado = $soloActivos ";
        }
        //Filtro por Activos/Eliminados

        $paginador = new Paginador();
        
        if ($this->botonPress("bt_guardarPermiso")) 
        {
              $this->nuevo_permiso();                
        }

        if ($this->botonPress("export_data_excel")) {
            $this->_exportarDatosPermisos("excel");
        }

        if ($this->botonPress("export_data_pdf")) {
            $this->_exportarDatosPermisos("pdf");
        }

        if ($this->botonPress("export_data_csv")) {
            $this->_exportarDatosPermisos("csv");
        }

        $arrayRowCount = $this->_aclm->getPermisosRowCount($condicion);
        $this->_view->assign('modulos', $this->_aclm->getModulos(0,0));
        $this->_view->assign('permisos', $this->_aclm->getPermisos($pagina,CANT_REG_PAG,$soloActivos));

        $paginador->paginar( $arrayRowCount['CantidadRegistros'],"listarPermisos", "", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionPermisos', $paginador->getView('paginacion_ajax_s_filas'));
        
        $this->_view->assign('titulo', 'Administracion de permisos');
        $this->_view->renderizar('permisos', 'acl');
    }    
    //Modificado por Jhon Martinez
    public function _cambiarEstadoPermisos(){
        $this->_acl->acceso('agregar_rol');
        // $this->_view->setJs(array(array(BASE_URL . 'public/js/util.js',true)));

        //Para Mensajes
        $resultado = array();
        $mensaje = "error";
        $contenido = "";
        //Para mensajes

        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $Per_IdPermiso = $this->getInt('_Per_IdPermiso');
        $Per_Estado = $this->getInt('_Per_Estado');
        // echo $Per_Estado."//".$Per_IdPermiso; exit;

        if(!$Per_IdPermiso){            
            $contenido = 'Error parametro ID ..!!'; 
            $mensaje = "error";
            array_push($resultado, array(0 => $mensaje, 1 => $contenido));            
        } else {
            $rowCountEstado = $this->_aclm->cambiarEstadoPermisos($Per_IdPermiso, $Per_Estado);
            if ($rowCountEstado > 0) {
                if ($Per_Estado == 1) {
                    $contenido = ' Se cambio de estado correctamente a <b>Deshabilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign" title="Deshabilitado" style="background: #FFF; color: #DD4B39; padding: 2px;"/> ...!! ';              
                }
                if ($Per_Estado == 0) {
                     $contenido = ' Se cambio de estado correctamente a <b>Habilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign" title="Habilitado" style=" background: #FFF;  color: #088A08; padding: 2px;"/> ...!! ';
                }     
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));       
            } else {
                $contenido = 'Error de variable(s) en consulta..!!'; 
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido)); 
            }        

        }
        $mensaje_json = json_encode($resultado);
        // echo($mensaje_json); exit();
        $this->_view->assign('_mensaje_json', $mensaje_json);

        $soloActivos = 0;
        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Per_Nombre liKe '%$txtBuscar%' ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND p.Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY p.Row_Estado DESC  ";
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY p.Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE p.Row_Estado = $soloActivos  ";
            }

            //Filtro por Activos/Eliminados
        }  

        $paginador = new Paginador();

        $arrayRowCount = $this->_aclm->getPermisosRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // echo($totalRegistros);
        // print_r($arrayRowCount); echo($condicion);exit;
        $this->_view->assign('permisos', $this->_aclm->getPermisosCondicion($pagina,$filas, $condicion));

        $paginador->paginar( $totalRegistros ,"listarPermisos", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionPermisos', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarPermisos', false, true);
    }
    //Modificado por Jhon Martinez
    public function editarPermiso($Per_IdPermiso = false){
        $this->_acl->acceso('agregar_rol');
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("index_inicio");
        $this->_view->setJs(array('index'));
        if ($this->botonPress("bt_editarPermiso")) {
            $id = $this->_aclm->editarPermiso($this->filtrarInt($Per_IdPermiso), $this->getSql('permiso_nombre'), $this->getSql('key_'), $this->getInt('modulo_'));
            if($id){
                $this->_view->assign('_mensaje', 'Permiso <b>'.$this->getSql('permiso_nombre').'</b> editado Correctamente...');
            }  else {
                $this->_view->assign('_error', 'Error al editar Permiso');
            }            
            // $this->redireccionar('acl/index/permisos');
            // exit;
        }
        if ($this->botonPress("bt_cancelarEditarPermiso")) {
            $this->redireccionar('acl/index/permisos');
        }
        
        $permiso = $this->_aclm->getPermiso($this->filtrarInt($Per_IdPermiso)); 
        
        $this->_view->assign('datos',$permiso);
        $this->_view->assign('modulos', $this->_aclm->getModulos(0,0));
        $this->_view->renderizar('ajax/editarPermiso');
    }
    
    public function gestion_idiomas_permisos() {
        $this->_view->getLenguaje('template_backend');
        $Idi_IdIdioma =  $this->getPostParam('idIdioma');        
        $Per_IdPermiso = $this->getPostParam('idpermisos');
                   
        $datos = $this->_aclm->getPermisoTraducido($Per_IdPermiso, $Idi_IdIdioma);
        print_r($datos);
        $this->_view->assign('idiomas',$this->_aclm->getIdiomas());
        if ($datos["Idi_IdIdioma"]==$Idi_IdIdioma) {
            $this->_view->assign('datos',$datos);    
        }else{
            $datos["Per_Permiso"]="";
            $datos["Per_Ckey"]="";
            $datos["Idi_IdIdioma"]=$Idi_IdIdioma;
            $this->_view->assign('datos',$datos);  
        }            
        //$this->_view->assign('IdiomaOriginal',$this->getPostParam('idIdiomaOriginal'));        
        $this->_view->renderizar('ajax/gestion_idiomas_permisos', false, true);
    }
    //Modificado por Jhon Martinez
    public function _paginacion_listarPermisos($txtBuscar = false) 
    {
        //$this->validarUrlIdioma();
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $totalRegistros = $this->getInt('total_registros');

        $condicion = " ";
        $soloActivos = 0;
        // $nombre = $this->getSql('palabra');
        if ($txtBuscar) 
        {
            $condicion = " WHERE Per_Nombre liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND p.Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY p.Row_Estado DESC  ";
            }
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY p.Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE p.Row_Estado = $soloActivos  ";
            }
        }         


        $paginador = new Paginador();
        // $arrayRowCount = $this->_aclm->getPermisosRowCount$arrayRowCount = 0,($condicion);

        $paginador->paginar( $totalRegistros,"listarPermisos", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('permisos', $this->_aclm->getPermisosCondicion($pagina,$filas, $condicion));
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacionPermisos', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarPermisos', false, true);
    }
    //Modificado por Jhon Martinez
    public function _buscarPermiso() 
    {
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $condicion = "";

        $soloActivos = 0;
        // $nombre = $this->getSql('palabra');
        if ($txtBuscar) 
        {
            $condicion = " WHERE Per_Nombre liKe '%$txtBuscar%' ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND p.Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY p.Row_Estado DESC  ";
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY p.Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE p.Row_Estado = $soloActivos  ";
            }

            //Filtro por Activos/Eliminados
        }        


        $paginador = new Paginador();

        $arrayRowCount = $this->_aclm->getPermisosRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // echo($totalRegistros);
        // print_r($arrayRowCount); echo($condicion);exit;
        $this->_view->assign('permisos', $this->_aclm->getPermisosCondicion($pagina,CANT_REG_PAG, $condicion));

        $paginador->paginar( $totalRegistros ,"listarPermisos", "$txtBuscar", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionPermisos', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarPermisos', false, true);
    }

    public function _exportarDatosPermisos($formatoP)
    {       
        $txtBuscar = $this->getSql('palabraPermiso');   
        // echo $txtBuscar; exit;
        $soloActivos = 0; 
        $pagina = $this->getInt('pagina');
        // $filtro2 = $this->getSql('select_busqueda');
        $formato  = $formatoP;

        if (empty($filtro)) {
            $filtro  = "";
        } 
        // if(empty($filtro2)){
        //     $filtro2="";
        // }        

        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Per_Nombre liKe '%$txtBuscar%' ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND p.Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY p.Row_Estado DESC  ";
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY p.Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE p.Row_Estado = $soloActivos  ";
            }
        }    

        $lista_datos = $this->_aclm->getPermisosCondicion($pagina,CANT_REG_PAG, $condicion);
        
        if ($formato == "csv") {
            if (!empty($lista_datos)) {
                error_reporting(0);
                $objPHPExcel = new PHPExcel();

                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, 'Per_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, 'Mod_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, 'Per_Ckey');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, 'Per_Estado');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, 1, 'Row_Estado');

                for ($i = 2; $i <= (count($lista_datos) + 1); $i++) {
                    // $fila11 = mb_convert_encoding($fila11, 'UTF-16LE', 'UTF-8'); 
                    // chr(255) . chr(254); 
                    // echo $fila11; exit;
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $i, $lista_datos[$i - 2]['Per_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $lista_datos[$i - 2]['Mod_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $i, $lista_datos[$i - 2]['Per_Ckey']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $i, $lista_datos[$i - 2]['Per_Estado']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, $i, $lista_datos[$i - 2]['Row_Estado']);
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

                 $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, 'Per_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, 'Mod_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, 'Per_Ckey');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, 'Per_Estado');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, 1, 'Row_Estado');

                for ($i = 2; $i <= (count($lista_datos) + 1); $i++) {
                    // $fila11 = mb_convert_encoding($fila11, 'UTF-16LE', 'UTF-8'); 
                    // chr(255) . chr(254); 
                    // echo $fila11; exit;
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $i, $lista_datos[$i - 2]['Per_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $lista_datos[$i - 2]['Mod_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $i, $lista_datos[$i - 2]['Per_Ckey']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $i, $lista_datos[$i - 2]['Per_Estado']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, $i, $lista_datos[$i - 2]['Row_Estado']);
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
            <h3 style='text-align: center; color:black; font-family: inherit;'>PERMISOS DEL SISTEMA</h3>
                    <table class='table'>
                        <thead>
                            <tr>
                                <th></th>
                                <th>Rol</th>
                                <th>".utf8_decode('Módulo')."</th>
                                <th>Clave</th>
                                <th>Estado</th>
                                <th>Row_Estado</th>
                            </tr>
                        </thead>
                        <tbody>";
        $b = "";
        $c="";
        $d="";
        $cuerpo="";
        $i=1;
            foreach ($lista_datos as $item){  
                $b .= "<tr>
                    <th scope='row'>".$i++."</th>
                    <td>" . utf8_decode($item['Per_Nombre']) . "</td>
                    <td>";
                        if(!empty($item['Mod_Nombre'])){
                            $c.= utf8_decode($item['Mod_Nombre']);
                        }
                        if(empty($item['Mod_Nombre'])){
                            $c.="-";
                        } 
                    $d.=
                    "</td>
                    <td>" . utf8_decode($item['Per_Ckey']) . "</td> 
                    <td style='text-align: center'>" . utf8_decode($item['Per_Estado']) . "</td>  
                    <td style='text-align: center'>" . utf8_decode($item['Row_Estado']) . "</td>        
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
    }

    //Modificado por Jhon Martinez
    public function nuevo_permiso()
    {
        $this->_acl->acceso('agregar_rol');
        $i=0;
        $error = ""; $error1 = ""; $error2 = "";
        
        if($this->_aclm->verificarPermiso($this->getSql('permiso_')))
        {
            $error = ' Permiso <b style="font-size: 1.15em;"> '. $this->getSql('permiso_').' </b> ya Existe.';
            $i=1;
        }
        
        if($this->_aclm->verificarKey($this->getAlphaNum('key_')))
        {
            if($i!=0) 
            {
                $error1 = '<br> Key <b style="font-size: 1.15em;">'. $this->getAlphaNum('key_') .' </b> ya existe.';
            }
            else
            {
                $error1 = ' Key <b style="font-size: 1.15em;">'. $this->getAlphaNum('key_') .' </b> ya existe. ';
            }

            $i=2;
        }
        
        if($i==0)
        {
            $idPermiso = $this->_aclm->insertarPermiso(
                $this->getSql('permiso_'), 
                $this->getAlphaNum('key_'),
                $this->getInt('modulo_'), 'es'
                );
        }
            
        if (is_array($idPermiso)) 
        {
            if ($idPermiso  [0] > 0) 
            {
                $this->_view->assign('_mensaje', 'Se registró correctamente el Permiso <b style="font-size: 1.15em;">'. $this->getSql('permiso_').'</b> ');
            } 
            else 
            {
                $this->_view->assign('_error', 'Error al registrar el Permiso');
            }
        }
        else 
        {
            if($i!=0)
            {
                $this->_view->assign('_error', $error . $error1 );
            }
            else
            {
                $this->_view->assign('_error', 'Ocurrio un error al Registrar los datos');
            }            
        }            
    }    
    //Modificado por Jhon Martinez
    public function _eliminarPermiso()
    {
        $this->_acl->acceso('agregar_rol');
        //Variables Ajax_Javascript
        $Per_IdPermiso = $this->getInt('_Per_IdPermiso');
        $Row_Estado = $this->getInt('_Row_Estado');
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        

        //Para Mensajes
        $resultado = array();
        $mensaje = "error";
        $contenido = "";
        //Para mensajes

        if ($Row_Estado == 0) {
            if(!$Per_IdPermiso)
            {            
                $contenido = 'Error parametro ID ..!!'; 
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));          
            } else {
                $role = $this->_aclm->verificarPermisoRol($Per_IdPermiso);
                // print_r($role);
                if (!$role)
                {
                    $usuario = $this->_aclm->verificarPermisoUsuario($Per_IdPermiso);
                    if(!$usuario){
                        $rowCount = $this->_aclm->eliminarHabilitarPermiso($Per_IdPermiso,$Row_Estado);
                        if($rowCount)
                        {
                            $contenido = 'El permiso fue elimnado correctamente...!!!'; 
                            $mensaje = "ok";
                            array_push($resultado, array(0 => $mensaje, 1 => $contenido));
                        } else {
                            $contenido = 'No se pudo eliminar permiso error en consulta...!!!'; 
                            $mensaje = "error";
                            array_push($resultado, array(0 => $mensaje, 1 => $contenido));
                        }
                    } else {
                        $contenido = 'No se pudo eliminar permiso asignado a usuario...!!!'; 
                        $mensaje = "error";
                        array_push($resultado, array(0 => $mensaje, 1 => $contenido));
                    }
                    
                } else {
                    $contenido = 'No se pudo eliminar permiso asignado a rol...!!!'; 
                    $mensaje = "error";
                    array_push($resultado, array(0 => $mensaje, 1 => $contenido));
                }        
            }
        } else {
            $rowCount = $this->_aclm->eliminarHabilitarPermiso($Per_IdPermiso,$Row_Estado);
            
            if($rowCount)
            {
                $contenido = 'El permiso fue activado correctamente...!!!'; 
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            } else {
                $contenido = 'No se pudo activar permiso, error en variable(s) de consulta...!!!'; 
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            }
        }

        
        $mensaje_json = json_encode($resultado);
        // echo($mensaje_json); exit();
        $this->_view->assign('_mensaje_json', $mensaje_json);

        $soloActivos = 0;
        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Per_Nombre liKe '%$txtBuscar%' ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND p.Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY p.Row_Estado DESC  ";
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY p.Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE p.Row_Estado = $soloActivos  ";
            }

            //Filtro por Activos/Eliminados
        }  

        $paginador = new Paginador();

        $arrayRowCount = $this->_aclm->getPermisosRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // echo($totalRegistros);
        // print_r($arrayRowCount); echo($condicion);exit;
        $this->_view->assign('permisos', $this->_aclm->getPermisosCondicion($pagina,$filas, $condicion));

        $paginador->paginar( $totalRegistros ,"listarPermisos", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionPermisos', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarPermisos', false, true);
        //$this->permisos($error);
    }
    //Modificado por Jhon Martinez
    public function permisos_role($Rol_IdRol)
    {
        $this->_acl->acceso('agregar_rol');
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("index_inicio");
        $Rol_IdRol = $this->filtrarInt($Rol_IdRol);
        
        if(!$Rol_IdRol)
        {
            $this->redireccionar('acl/roles');
        }        
        $row = $this->_aclm->getRol($Rol_IdRol);        
        if(!$row)
        {
            $this->redireccionar('acl/roles');
        }
        if ($this->botonPress("bt_cancelarEditarRol")) {
            $this->redireccionar('acl/index/roles');
        }
        
        $this->_view->assign('titulo', 'Administracion de permisos rol');
        
        if($this->getInt('guardar') == 1)
        {
            $values = array_keys($_POST);
            $replace = array();
            $eliminar = array();
            
            for($i = 0; $i < count($values); $i++)
            {
                if(substr($values[$i],0,5) == 'perm_')
                {
                    $permiso = (strlen($values[$i]) - 5);
                    
                    if($_POST[$values[$i]] == 'x')
                    {
                        $eliminar[] = array(
                            'role' => $Rol_IdRol,
                            'permiso' => substr($values[$i], -$permiso)
                        );
                    }
                    else
                    {
                        if($_POST[$values[$i]] == 1)
                        {
                            $v = 1;
                        }
                        else
                        {
                            $v = 0;
                        }
                        
                        $replace[] = array(
                            'role' => $Rol_IdRol,
                            'permiso' => substr($values[$i], -$permiso),
                            'valor' => $v
                        );
                    }
                }
            }
            
            for($i = 0; $i < count($eliminar); $i++)
            {
                $this->_aclm->eliminarPermisoRol(
                        $eliminar[$i]['role'],
                        $eliminar[$i]['permiso']);
            }
            
            for($i = 0; $i < count($replace); $i++)
            {
                $this->_aclm->editarPermisoRol(
                        $replace[$i]['role'],
                        $replace[$i]['permiso'],
                        $replace[$i]['valor']);
            }
        }
        
        $this->_view->assign('role', $row);
        $this->_view->assign('permisos', $this->_aclm->getPermisosRol($Rol_IdRol));
        $this->_view->renderizar('permisos_role');
    }




    /*modulos*/
    //Modificado por Jhon Martinez
    public function modulos($error = "")
    {
        $this->_acl->acceso('listar_usuarios');
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("index_inicio");
        $this->_view->setJs(array('index'));

        $pagina = $this->getInt('pagina');

        //Filtro por Activos/Eliminados
        $condicion = " ORDER BY Row_Estado DESC ";
        $soloActivos = 0;
        if (!$this->_acl->permiso('ver_eliminados')) {
            $soloActivos = 1;
            $condicion = " WHERE Row_Estado = $soloActivos ";
        }
        //Filtro por Activos/Eliminados

        $paginador = new Paginador();
        
        if ($this->botonPress("bt_guardarModulo")) 
        {
              $this->nuevo_modulo();                
        }

        if ($this->botonPress("export_data_excel")) {
            $this->_exportarDatosModulo("excel");
        }

        if ($this->botonPress("export_data_pdf")) {
            $this->_exportarDatosModulo("pdf");
        }

        if ($this->botonPress("export_data_csv")) {
            $this->_exportarDatosModulo("csv");
        }

        $arrayRowCount = $this->_aclm->getModulosRowCount($condicion);
        $this->_view->assign('modulos', $this->_aclm->getModulosAll($pagina,CANT_REG_PAG,$soloActivos));

        $paginador->paginar( $arrayRowCount['CantidadRegistros'],"listarmodulos", "", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionmodulos', $paginador->getView('paginacion_ajax_s_filas'));
        
        $this->_view->assign('titulo', 'Administracion de modulos');
        $this->_view->renderizar('modulos', 'acl');
    }    
    //Modificado por Jhon Martinez
    public function _cambiarEstadomodulos(){
        $this->_acl->acceso('agregar_rol');
        // $this->_view->setJs(array(array(BASE_URL . 'public/js/util.js',true)));

        //Para Mensajes
        $resultado = array();
        $mensaje = "error";
        $contenido = "";
        //Para mensajes

        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $Mod_IdModulo = $this->getInt('_Mod_IdModulo');
        $Mod_Estado = $this->getInt('_Mod_Estado');
        // echo $Per_Estado."//".$Per_Idmodulo; exit;

        if(!$Mod_IdModulo){            
            $contenido = 'Error parametro ID ..!!'; 
            $mensaje = "error";
            array_push($resultado, array(0 => $mensaje, 1 => $contenido));            
        } else {
            $rowCountEstado = $this->_aclm->cambiarEstadomodulos($Mod_IdModulo, $Mod_Estado);
            if ($rowCountEstado > 0) {
                if ($Mod_Estado == 1) {
                    $contenido = ' Se cambio de estado correctamente a <b>Deshabilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign" title="Deshabilitado" style="background: #FFF; color: #DD4B39; padding: 2px;"/> ...!! ';              
                }
                if ($Mod_Estado == 0) {
                     $contenido = ' Se cambio de estado correctamente a <b>Habilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign" title="Habilitado" style=" background: #FFF;  color: #088A08; padding: 2px;"/> ...!! ';
                }     
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));       
            } else {
                $contenido = 'Error de variable(s) en consulta..!!'; 
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido)); 
            }        

        }
        $mensaje_json = json_encode($resultado);
        // echo($mensaje_json); exit();
        $this->_view->assign('_mensaje_json', $mensaje_json);

        $soloActivos = 0;
        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Mod_Nombre liKe '%$txtBuscar%' ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY Row_Estado DESC  ";
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE Row_Estado = $soloActivos  ";
            }

            //Filtro por Activos/Eliminados
        }  

        $paginador = new Paginador();

        $arrayRowCount = $this->_aclm->getModulosRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // echo($totalRegistros);
        // print_r($arrayRowCount); echo($condicion);exit;
        $this->_view->assign('modulos', $this->_aclm->getModulosCondicion($pagina,$filas, $condicion));

        $paginador->paginar( $totalRegistros ,"listarmodulos", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionmodulos', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarmodulos', false, true);
    }
    //Modificado por Jhon Martinez
    public function editarmodulo($Mod_IdModulo = false){
        $this->_acl->acceso('agregar_rol');
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("index_inicio");
        $this->_view->setJs(array('index'));
        if ($this->botonPress("bt_editarmodulo")) {
            $id = $this->_aclm->editarModulo( $this->getSql('modulo_'), $this->getSql('codigo_'), $this->getSql('descripcion_'),$this->filtrarInt($Mod_IdModulo));
            if($id){
                $this->_view->assign('_mensaje', 'modulo <b>'.$this->getSql('modulo_').'</b> editado Correctamente...');
            }  else {
                $this->_view->assign('_error', 'Error al editar modulo');
            }            
            // $this->redireccionar('acl/index/modulos');
            // exit;
        }
        if ($this->botonPress("bt_cancelarEditarmodulo")) {
            $this->redireccionar('acl/index/modulos');
        }
        
        $modulo = $this->_aclm->getModulo($this->filtrarInt($Mod_IdModulo)); 
        
        $this->_view->assign('datos',$modulo);
        $this->_view->renderizar('ajax/editarModulo');
    }
    
    public function gestion_idiomas_modulos() {
        $this->_view->getLenguaje('template_backend');
        $Idi_IdIdioma =  $this->getPostParam('idIdioma');        
        $Per_Idmodulo = $this->getPostParam('idmodulos');
                   
        $datos = $this->_aclm->getmoduloTraducido($Per_Idmodulo, $Idi_IdIdioma);
        // print_r($datos);
        $this->_view->assign('idiomas',$this->_aclm->getIdiomas());
        if ($datos["Idi_IdIdioma"]==$Idi_IdIdioma) {
            $this->_view->assign('datos',$datos);    
        }else{
            $datos["Per_modulo"]="";
            $datos["Per_Ckey"]="";
            $datos["Idi_IdIdioma"]=$Idi_IdIdioma;
            $this->_view->assign('datos',$datos);  
        }            
        //$this->_view->assign('IdiomaOriginal',$this->getPostParam('idIdiomaOriginal'));        
        $this->_view->renderizar('ajax/gestion_idiomas_modulos', false, true);
    }
    //Modificado por Jhon Martinez
    public function _paginacion_listarmodulos($txtBuscar = false) 
    {
        //$this->validarUrlIdioma();
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $totalRegistros = $this->getInt('total_registros');

        $condicion = " ";
        $soloActivos = 0;
        // $nombre = $this->getSql('palabra');
        if ($txtBuscar) 
        {
            $condicion = " WHERE Mod_Nombre liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY Row_Estado DESC  ";
            }
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE Row_Estado = $soloActivos  ";
            }
        }         


        $paginador = new Paginador();
        // $arrayRowCount = $this->_aclm->getmodulosRowCount$arrayRowCount = 0,($condicion);

        $paginador->paginar( $totalRegistros,"listarmodulos", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('modulos', $this->_aclm->getModulosCondicion($pagina,$filas, $condicion));
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacionmodulos', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarmodulos', false, true);
    }
    //Modificado por Jhon Martinez
    public function _buscarmodulo() 
    {
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $condicion = "";

        $soloActivos = 0;
        // $nombre = $this->getSql('palabra');
        if ($txtBuscar) 
        {
            $condicion = " WHERE Mod_Nombre liKe '%$txtBuscar%' ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY Row_Estado DESC  ";
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE Row_Estado = $soloActivos  ";
            }

            //Filtro por Activos/Eliminados
        }        


        $paginador = new Paginador();

        $arrayRowCount = $this->_aclm->getModulosRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // echo($totalRegistros);
        // print_r($arrayRowCount); echo($condicion);exit;
        $this->_view->assign('modulos', $this->_aclm->getModulosCondicion($pagina,CANT_REG_PAG, $condicion));

        $paginador->paginar( $totalRegistros ,"listarmodulos", "$txtBuscar", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionmodulos', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarmodulos', false, true);
    }

    public function _exportarDatosModulo($formatoP)
    {       
        $txtBuscar = $this->getSql('palabraModulo');   
        // echo $txtBuscar; exit;
        $soloActivos = 0; 
        $pagina = $this->getInt('pagina');
        // $filtro2 = $this->getSql('select_busqueda');
        $formato  = $formatoP;

        if (empty($filtro)) {
            $filtro  = "";
        } 
        // if(empty($filtro2)){
        //     $filtro2="";
        // }        

        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Mod_Nombre liKe '%$txtBuscar%' ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY Row_Estado DESC  ";
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE Row_Estado = $soloActivos  ";
            }

            //Filtro por Activos/Eliminados
        }    

        $lista_datos = $this->_aclm->getModulosCondicion($pagina,CANT_REG_PAG, $condicion);
        
        if ($formato == "csv") {
            if (!empty($lista_datos)) {
                error_reporting(0);
                $objPHPExcel = new PHPExcel();

                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, 'Mod_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, 'Mod_Codigo');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, 'Mod_Descripcion');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, 'Mod_Estado');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, 1, 'Row_Estado');

                for ($i = 2; $i <= (count($lista_datos) + 1); $i++) {
                    // $fila11 = mb_convert_encoding($fila11, 'UTF-16LE', 'UTF-8'); 
                    // chr(255) . chr(254); 
                    // echo $fila11; exit;
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $i, $lista_datos[$i - 2]['Mod_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $lista_datos[$i - 2]['Mod_Codigo']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $i, $lista_datos[$i - 2]['Mod_Descripcion']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $i, $lista_datos[$i - 2]['Mod_Estado']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, $i, $lista_datos[$i - 2]['Row_Estado']);
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

                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, 'Mod_Nombre');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, 'Mod_Codigo');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, 'Mod_Descripcion');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, 1, 'Mod_Estado');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, 1, 'Row_Estado');

                for ($i = 2; $i <= (count($lista_datos) + 1); $i++) {
                    // $fila11 = mb_convert_encoding($fila11, 'UTF-16LE', 'UTF-8'); 
                    // chr(255) . chr(254); 
                    // echo $fila11; exit;
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $i, $lista_datos[$i - 2]['Mod_Nombre']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $lista_datos[$i - 2]['Mod_Codigo']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $i, $lista_datos[$i - 2]['Mod_Descripcion']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3, $i, $lista_datos[$i - 2]['Mod_Estado']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4, $i, $lista_datos[$i - 2]['Row_Estado']);
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
            <h3 style='text-align: center; color:black; font-family: inherit;'>ADMINISTRACIÓN DE MÓDULOS</h3>
                    <table class='table'>
                        <thead>
                            <tr>
                                <th></th>
                                <th>".utf8_decode('Módulo')."</th>
                                <th>".utf8_decode('Código')."</th>
                                <th>".utf8_decode('Descripción')."</th>
                                <th>Estado</th>
                                <th>Row_Estado</th>
                            </tr>
                        </thead>
                        <tbody>";
        $b = "";
        $c="";
        $d="";
        $cuerpo="";
        $i=1;
            foreach ($lista_datos as $item){  
                $b .= "<tr>
                    <th scope='row'>".$i++."</th>
                    <td>" . utf8_decode($item['Mod_Nombre']) . "</td>
                    <td>" . utf8_decode($item['Mod_Codigo']) . "</td>
                    <td>";
                        if(!empty($item['Mod_Descripcion'])){
                            $c.= utf8_decode($item['Mod_Descripcion']);
                        }
                        if(empty($item['Mod_Descripcion'])){
                            $c.="-";
                        } 
                    $d.=
                    "</td>
                    <td style='text-align: center'>" . utf8_decode($item['Mod_Estado']) . "</td>  
                    <td style='text-align: center'>" . utf8_decode($item['Row_Estado']) . "</td>        
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
    }

    //Modificado por Jhon Martinez
    public function nuevo_modulo()
    {

        $this->_acl->acceso('agregar_rol');
        $i=0;
        $error = ""; $error1 = ""; $error2 = "";
        
        if($this->_aclm->verificarModulo($this->getSql('modulo_')))
        {
            $error = ' modulo <b style="font-size: 1.15em;"> '. $this->getSql('modulo_').' </b> ya Existe.';
            $i=1;
        }
        
        if($i==0)
        {
            $idmodulo = $this->_aclm->insertarModulo(
                $this->getSql('modulo_'), 
                $this->getAlphaNum('codigo_'),
                $this->getSql('descripcion_'), 1
                );
        }

        if (is_array($idmodulo)) 
        {

            if ($idmodulo  [0] > 0) 
            {
                $this->_view->assign('_mensaje', 'Se registró correctamente el modulo <b style="font-size: 1.15em;">'. $this->getSql('modulo_').'</b> ');
            } 
            else 
            {
                $this->_view->assign('_error', 'Error al registrar el modulo');
            }
        }
        else 
        {
            if($i!=0)
            {
                $this->_view->assign('_error', $error . $error1 );
            }
            else
            {
                $this->_view->assign('_error', 'Ocurrio un error al Registrar los datos');
            }            
        }            
    }    
    //Modificado por Jhon Martinez
    public function _eliminar_modulo()
    {
        $this->_acl->acceso('agregar_rol');
        //Variables Ajax_Javascript
        $Mod_Idmodulo = $this->getInt('_Mod_IdModulo');
        $Row_Estado = $this->getInt('_Row_Estado');
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        

        //Para Mensajes
        $resultado = array();
        $mensaje = "error";
        $contenido = "";
        //Para mensajes

        if ($Row_Estado == 0) {
            if(!$Mod_Idmodulo)
            {            
                $contenido = 'Error parametro ID ..!!'; 
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));          
            } else {

                    $usuario = $this->_aclm->verificarmoduloPermiso($Mod_Idmodulo);
                    if(!$usuario){

                        $rol = $this->_aclm->verificarmoduloRol($Mod_Idmodulo);
                        if(!$rol){
                            $rowCount = $this->_aclm->eliminarHabilitarModulo($Mod_Idmodulo,$Row_Estado);
                            if($rowCount)
                            {
                                $contenido = 'El modulo fue eliminado correctamente...!!!'; 
                                $mensaje = "ok";
                                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
                            } else {
                                $contenido = 'No se pudo eliminar modulo error en consulta...!!!'; 
                                $mensaje = "error";
                                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
                            }
                        } else {
                            $contenido = 'No se pudo eliminar modulo asignado a rol...!!!'; 
                            $mensaje = "error";
                            array_push($resultado, array(0 => $mensaje, 1 => $contenido));
                        }
                    } else {
                        $contenido = 'No se pudo eliminar modulo asignado a permiso...!!!'; 
                        $mensaje = "error";
                        array_push($resultado, array(0 => $mensaje, 1 => $contenido));
                    }
                           
            }
        } else {
            $rowCount = $this->_aclm->eliminarHabilitarModulo($Mod_Idmodulo,$Row_Estado);
            
            if($rowCount)
            {
                $contenido = 'El modulo fue activado correctamente...!!!'; 
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            } else {
                $contenido = 'No se pudo activar modulo, error en variable(s) de consulta...!!!'; 
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            }
        }

        
        $mensaje_json = json_encode($resultado);
        // echo($mensaje_json); exit();
        $this->_view->assign('_mensaje_json', $mensaje_json);

        $soloActivos = 0;
        $condicion = "";
        if ($txtBuscar) 
        {
            $condicion = " WHERE Mod_Nombre liKe '%$txtBuscar%' ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY Row_Estado DESC  ";
        } else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE Row_Estado = $soloActivos  ";
            }

            //Filtro por Activos/Eliminados
        }  

        $paginador = new Paginador();

        $arrayRowCount = $this->_aclm->getmodulosRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // echo($totalRegistros);
        // print_r($arrayRowCount); echo($condicion);exit;
        $this->_view->assign('modulos', $this->_aclm->getmodulosCondicion($pagina,$filas, $condicion));

        $paginador->paginar( $totalRegistros ,"listarmodulos", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionmodulos', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarmodulos', false, true);
        //$this->modulos($error);
    }
    //Modificado por Jhon Martinez
    public function modulos_role($Rol_IdRol)
    {
        $this->_acl->acceso('agregar_rol');
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("index_inicio");
        $Rol_IdRol = $this->filtrarInt($Rol_IdRol);
        
        if(!$Rol_IdRol)
        {
            $this->redireccionar('acl/roles');
        }        
        $row = $this->_aclm->getRol($Rol_IdRol);        
        if(!$row)
        {
            $this->redireccionar('acl/roles');
        }
        if ($this->botonPress("bt_cancelarEditarRol")) {
            $this->redireccionar('acl/index/roles');
        }
        
        $this->_view->assign('titulo', 'Administracion de modulos rol');
        
        if($this->getInt('guardar') == 1)
        {
            $values = array_keys($_POST);
            $replace = array();
            $eliminar = array();
            
            for($i = 0; $i < count($values); $i++)
            {
                if(substr($values[$i],0,5) == 'perm_')
                {
                    $modulo = (strlen($values[$i]) - 5);
                    
                    if($_POST[$values[$i]] == 'x')
                    {
                        $eliminar[] = array(
                            'role' => $Rol_IdRol,
                            'modulo' => substr($values[$i], -$modulo)
                        );
                    }
                    else
                    {
                        if($_POST[$values[$i]] == 1)
                        {
                            $v = 1;
                        }
                        else
                        {
                            $v = 0;
                        }
                        
                        $replace[] = array(
                            'role' => $Rol_IdRol,
                            'modulo' => substr($values[$i], -$modulo),
                            'valor' => $v
                        );
                    }
                }
            }
            
            for($i = 0; $i < count($eliminar); $i++)
            {
                $this->_aclm->eliminarmoduloRol(
                        $eliminar[$i]['role'],
                        $eliminar[$i]['modulo']);
            }
            
            for($i = 0; $i < count($replace); $i++)
            {
                $this->_aclm->editarmoduloRol(
                        $replace[$i]['role'],
                        $replace[$i]['modulo'],
                        $replace[$i]['valor']);
            }
        }
        
        $this->_view->assign('role', $row);
        $this->_view->assign('modulos', $this->_aclm->getmodulosRol($Rol_IdRol));
        $this->_view->renderizar('modulos_role');
    }
}
?>