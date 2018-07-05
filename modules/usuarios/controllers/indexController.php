<?php

use Dompdf\Adapter\CPDF;
use Dompdf\Dompdf;
use Dompdf\Exception;

class indexController extends usuariosController {

    private $_usuarios;

    public function __construct($lang, $url) {
        parent::__construct($lang, $url);
        $this->_aclm = $this->loadModel('index', 'acl');
        $this->_usuarios = $this->loadModel('usuario');
    }

    public function index($PermisoVacio = false) {
        $this->_acl->acceso('listar_usuarios');
        $this->validarUrlIdioma();
        $this->_view->assign('titulo', 'Usuarios');
        $this->_view->getLenguaje("index_inicio");
        $this->_view->setJs(array('index'));

        $pagina = $this->getInt('pagina');
        //$registros = $this->getInt('registros');
        $nombre = $this->getSql('nombre');
        // $this->_acl->acceso('admin');
        if ($this->botonPress("bt_guardar")) {
            $this->registrarUsuario();                
        }

        //Filtro por Activos/Eliminados
        $condicion = " ORDER BY u.Row_Estado DESC ";
        $soloActivos = 0;
        if (!$this->_acl->permiso('ver_eliminados')) {
            $soloActivos = 1;
            $condicion = " WHERE u.Row_Estado = $soloActivos ";
        }
        //Filtro por Activos/Eliminados
        $condicion .= " LIMIT 0," . CANT_REG_PAG . " ";
        // echo $condicion; exit;
        $arrayRowCount = $this->_usuarios->getUsuariosRowCount($condicion);
        // print_r($arrayRowCount);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];

        $paginador = new Paginador();

        if ($this->botonPress("export_data_excel")) {
            $this->_exportarDatos("excel");
        }

        if ($this->botonPress("export_data_pdf")) {
            $this->_exportarDatos("pdf");
        }

        if ($this->botonPress("export_data_csv")) {
            $this->_exportarDatos("csv");
        }

        $this->_view->assign('usuarios', $this->_usuarios->getUsuariosPaginado($condicion));

        $paginador->paginar( $totalRegistros,"listaregistros", "", $pagina, CANT_REG_PAG, true);

        // $this->_view->assign('usuarios', $paginador->paginar($this->_usuarios->getUsuarios(), "listaregistros", "$nombre", $pagina, 25));

        $this->_view->assign('roles', $this->_aclm->getRolesCompleto());
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        // if($PermisoVacio){
        //     $this->_view->assign('_error', 'Error al editar Debe agregar permisos al Usuario');
        // }        
        $this->_view->renderizar('index','usuarios');
    }

    public function _paginacion_listaregistros($txtBuscar = false) {

        //$this->validarUrlIdioma();
        $idRol = $this->getInt('idrol');        
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $totalRegistros = $this->getInt('total_registros');

        $soloActivos = 0;
        $condicion = "";
        if ($txtBuscar && $idRol) 
        {
            $condicion = " INNER JOIN usuario_rol ur on u.Usu_IdUsuario=ur.Usu_IdUsuario WHERE Usu_Usuario liKe '%$txtBuscar%' and ur.Rol_IdRol=$idRol ";
            if (!$this->_acl->permiso('ver_eliminados'))  {
                $soloActivos = 1;
                $condicion .= " AND u.Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY u.Row_Estado DESC  ";
        } 

        else if ($txtBuscar) 
        {
            $condicion = " WHERE Usu_Usuario liKe '%$txtBuscar%' ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND u.Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY u.Row_Estado DESC  ";
        } 

        else if ($idRol) 
        {
            $condicion = " INNER JOIN usuario_rol ur on u.Usu_IdUsuario=ur.Usu_IdUsuario WHERE  ur.Rol_IdRol=$idRol ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND u.Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY u.Row_Estado DESC  ";
        } 

        else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY u.Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE u.Row_Estado = $soloActivos  ";
            }
        }        

        $paginador = new Paginador();

        $paginador->paginar( $totalRegistros,"listaregistros", "$txtBuscar", $pagina, $filas, true);

        $this->_view->assign('usuarios', $this->_usuarios->getUsuariosCondicion($pagina,$filas, $condicion));

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listaregistros', false, true);
    }

    public function _buscarUsuario() {
        //$this->validarUrlIdioma();
        $txtBuscar = $this->getSql('palabra');
        $idRol = $this->getInt('idrol');
        $pagina = $this->getInt('pagina');
        // echo $txtBuscar. ' ' . $idRol; exit;
        $condicion = "";

        $soloActivos = 0;
        // $nombre = $this->getSql('palabra');
        if ($txtBuscar && $idRol) 
        {
            $condicion = " INNER JOIN usuario_rol ur on u.Usu_IdUsuario=ur.Usu_IdUsuario WHERE Usu_Usuario liKe '%$txtBuscar%' and ur.Rol_IdRol=$idRol ";
            if (!$this->_acl->permiso('ver_eliminados'))  {
                $soloActivos = 1;
                $condicion .= " AND u.Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY u.Row_Estado DESC  ";
        } 

        else if ($txtBuscar) 
        {
            $condicion = " WHERE Usu_Usuario liKe '%$txtBuscar%' ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND u.Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY u.Row_Estado DESC  ";
        } 

        else if ($idRol) 
        {
            $condicion = " INNER JOIN usuario_rol ur on u.Usu_IdUsuario=ur.Usu_IdUsuario WHERE  ur.Rol_IdRol=$idRol ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND u.Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY u.Row_Estado DESC  ";
        } 

        else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY u.Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE u.Row_Estado = $soloActivos  ";
            }
        }        

        $paginador = new Paginador();

        $arrayRowCount = $this->_usuarios->getUsuariosRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // echo($totalRegistros);
        // print_r($arrayRowCount); echo($condicion);exit;

         //EXPORTAR DATOS
        if ($this->botonPress("export_data_excel")) {
            $this->_exportarDatos("excel");
        }

        if ($this->botonPress("export_data_pdf")) {
            $this->_exportarDatos("pdf");
        }

        if ($this->botonPress("export_data_csv")) {
            $this->_exportarDatos("csv");
        }
        //

        $this->_view->assign('usuarios', $this->_usuarios->getUsuariosCondicion($pagina,CANT_REG_PAG, $condicion));

        $paginador->paginar( $totalRegistros ,"listaregistros", "$txtBuscar", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listaregistros', false, true);
    }

     public function _exportarDatos($formatoP)
    {   
        $txtBuscar = $this->getSql('palabra');
        $idRol = $this->getSql('buscarRol');
        $pagina = $this->getInt('pagina');
        // echo $txtBuscar . ' '. $idRol; exit();
        $condicion = "";

        if (empty($txtBuscar)) {
            $txtBuscar  = "";
        } 
        if(empty($idRol)){
            $idRol="";
        }  

        $soloActivos = 0;
        // $nombre = $this->getSql('palabra');
        if ($txtBuscar && $idRol) 
        {
            $condicion = " INNER JOIN usuario_rol ur on u.Usu_IdUsuario=ur.Usu_IdUsuario WHERE Usu_Usuario liKe '%$txtBuscar%' and ur.Rol_IdRol=$idRol ";
            if (!$this->_acl->permiso('ver_eliminados'))  {
                $soloActivos = 1;
                $condicion .= " AND u.Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY u.Row_Estado DESC  ";
        } 

        else if ($txtBuscar) 
        {
            $condicion = " WHERE Usu_Usuario liKe '%$txtBuscar%' ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND u.Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY u.Row_Estado DESC  ";
        } 

        else if ($idRol) 
        {
            $condicion = " INNER JOIN usuario_rol ur on u.Usu_IdUsuario=ur.Usu_IdUsuario WHERE  ur.Rol_IdRol=$idRol ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND u.Row_Estado = $soloActivos ";
            }
            $condicion .= " ORDER BY u.Row_Estado DESC  ";
        } 

        else {
            //Filtro por Activos/Eliminados     
            $condicion = " ORDER BY u.Row_Estado DESC ";   
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = " WHERE u.Row_Estado = $soloActivos  ";
            }
        }  

        $lista_datos = $this->_usuarios->getUsuariosCondicion($pagina,CANT_REG_PAG, $condicion);
        // print_r($lista_datos);exit;
        // echo count($lista_datos); exit;
        $formato  = $formatoP;
        $roles ="";
        
        if ($formato == "csv") {
            if (!empty($lista_datos)) {
                error_reporting(0);
                $objPHPExcel = new PHPExcel();

                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, 'Usuario');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, 'Roles');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, 'Estado');

                for ($i = 2; $i <= (count($lista_datos) + 1); $i++) {
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $i, $lista_datos[$i - 2]['Usu_Usuario']);
                    foreach ($lista_datos[$i - 2]['Roles'] as $Roles) {
                        // echo count($Roles) . 'hola'; exit;
                        $roles .= $Roles['Rol_Nombre'] . ', ';
                    }
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $roles);
                    // $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $lista_datos[$i - 2]['Roles']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $i, $lista_datos[$i - 2]['Usu_Estado']);
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
            if (!empty($lista_datos)) {
                // echo "."; exit;
                error_reporting(0);
                $objPHPExcel = new PHPExcel();

                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, 1, 'Usuario');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, 1, 'Roles');
                $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, 1, 'Estado');

                for ($i = 2; $i <= (count($lista_datos) + 1); $i++) {
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0, $i, $lista_datos[$i - 2]['Usu_Usuario']);
                    foreach ($lista_datos[$i - 2]['Roles'] as $Roles) {
                        // echo count($Roles) . 'hola'; exit;
                        $roles .= $Roles['Rol_Nombre'] . ', ';
                    }
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $roles);
                    // $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1, $i, $lista_datos[$i - 2]['Roles']);
                    $objPHPExcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2, $i, $lista_datos[$i - 2]['Usu_Estado']);
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
            // ob_start();
            //header("Content-Type: text/html;charset=utf-8");

            //
        $b = "";
        $c= "";   
        $d= "";
        $cuerpo="";
        $i=1;
         $a = "
            <head>
                <link href='views/layout/frontend/css/bootstrap.min.css' rel='stylesheet' type='text/css'>
                <style type='text/css'>
                    td {

                    }
                </style>
            </head>    
            <body>                     
            <div class='table-responsive'>
            <h3 style='text-align: center; color:black; font-family: inherit;'>USUARIOS</h3>
                    <table class='table'>
                        <thead>
                            <tr>
                                <th></th>
                                <th>Usuario</th>
                                <th>Roles</th>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>";        
            foreach ($lista_datos as $item){ 
                $b .= "<tr>
                    <th scope='row'>".$i++."</th>
                    <td>" . utf8_decode($item['Usu_Usuario']) . "</td>
                    <td>
                        <ul>";
                            foreach ($item['Roles'] as $r){
                               $c .= 
                               "<li>".utf8_decode($r['Rol_Nombre']).
                               "</li>";
                            }
                            $d.="
                        </ul>
                    </td>
                    <td>" . utf8_decode($item['Usu_Estado']) . "</td>                  
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
            
            require_once("libs/autoload.inc.php");
            $dompdf = new Dompdf(); 
            $dompdf->set_paper('A4', 'landscape'); //esta es una forma de ponerlo horizontal
            $dompdf->set_option('isHtml5ParserEnabled', true);
            $dompdf->loadHtml("$a.$cuerpo.$e");
            $dompdf->render();
            $dompdf->stream("'".APP_NAME.'-OTCA_Descargas.pdf');
        }
    }

    public function registrarUsuario()
    {     
        $i=0;
        $error = ""; $error1 = ""; 
        if($this->_usuarios->verificarUsuario($this->getSql('usuario'))){
            $error = ' El usuario <b style="font-size: 1.15em;">' . $this->getAlphaNum('usuario') . '</b> ya existe. ';
            $i=1;
        }
        
        if($this->_usuarios->verificarEmail($this->getSql('email'))){
            if($i!=0) {
                $error1 = '<br> La direccion de correo <b style="font-size: 1.15em;">' . $this->getSql('email') . '</b> ya esta registrada. ';
            }else{
                $error1 = ' La direccion de correo <b style="font-size: 1.15em;">' . $this->getSql('email') . '</b> ya esta registrada. ';
            }
            $i=2;
        }

//        $this->getLibrary('class.phpmailer');
//        $mail = new PHPMailer();
        if($i==0)
        {
            $random = rand(1782598471, mt_getrandmax());
            $idUsuario = $this->_usuarios->registrarUsuario(
                $this->getSql('nombre'),
                $this->getSql('apellidos'),
                $this->getInt('dni'),
                $this->getSql('direccion'),
                $this->getSql('telefono'),
                $this->getSql('institucion'),
                $this->getSql('cargo'),
                $this->getAlphaNum('usuario'),
                $this->getSql('contrasena'),
                $this->getSql('email'), 1, $random 
            );
        }
        
        if (is_array($idUsuario)) {
            if ($idUsuario[0] > 0) {
                $this->_view->assign('_mensaje', 'Usuario <b style="font-size: 1.15em;">'.$this->getAlphaNum('usuario').'</b> registrado..!!');
            } else {
                $this->_view->assign('_error', 'Error al registrar el Usuario');
            }
        } else {
            if($i!=0)
            {
                $this->_view->assign('_error', $error . $error1 );
            }else{
                $this->_view->assign('_error', 'Ocurrio un error al Registrar los datos');
            }            
        }                
    }


    public function _cambiarEstado($idUsusario = false,$estado = false){
        if(!$this->filtrarInt($idUsusario)){            
            $this->_view->assign('_error', 'Error parametro ID ..!!');
            $this->_view->renderizar('index');
            exit;
        }        
        $this->_usuarios->cambiarEstadoUsuario($this->filtrarInt($idUsusario), $this->filtrarInt($estado));
        $this->redireccionar('usuarios');
    }
    public function _eliminarUsuario($Usu_IdUsuario = false, $Usu_RowEstado=false) {
        if(!$this->filtrarInt($Usu_IdUsuario)){            
            $this->_view->assign('_error', 'Error parametro ID ..!!');
            $this->_view->renderizar('index'); exit;
        }else{

            if($this->filtrarInt($Usu_RowEstado)==0)
                $this->_usuarios->eliminarHabilitarUsuario($this->filtrarInt($Usu_IdUsuario), 1);

            else
                $this->_usuarios->eliminarHabilitarUsuario($this->filtrarInt($Usu_IdUsuario), 0);
        }
        $this->redireccionar('usuarios');
    }
    public function divRol() {
        $this->_view->renderizar('ajax/div_rol', false, true);
    }
    public function divEditContra() {
        $this->_view->assign('idusuario',  $this->getPostParam('idusuario'));
        $this->_view->renderizar('ajax/editarContrasena', false, true);
    }
    
    public function rol($usuarioID, $nuevoRol=false) {

        $this->_view->setJs(array('index'));
        
        if($nuevoRol){
            $rolID = $this->_usuarios->insertarRol($nuevoRol,'',1);            
            if (is_array($rolID)) {
                if ($rolID  [0] > 0) {
                    $this->_view->assign('_mensaje', 'El Rol <b>'.$nuevoRol.'</b> fue registrado correctamente..!!');
                } else {
                    $this->_view->assign('_error', 'Error al registrar el Rol');
                }

                // $this->redireccionar("usuarios/index/rol/".$usuarioID."/".false);
            } else {
               $this->_view->assign('_error', 'Ocurrio un error al Registrar los datos');
            }
        }else{
            $this->validarUrlIdioma();
            $this->_view->getLenguaje("index_inicio");
        }
        $this->_view->setJs(array('index'));

        $id = $this->filtrarInt($usuarioID);
        $condicion='';
        if ($this->botonPress("bt_guardarUsuario")) {
            $this->editarUsuario();               
        }
        if ($this->botonPress("bt_guardarContrasena")) {
            $this->editarUsuario($id);               
        }
        $usu = $this->_usuarios->getUsuario($id);       
        //if ($usu['Rol_IdRol']) {
        //    $condicion .= " and u.Rol_IdRol = ".$usu['Rol_IdRol']." ";
        //}
        //$rolUsuario = $this->_usuarios->getUsuarios($condicion);
        $this->_view->assign('titulo', 'Editar Usuario');        
        $this->_view->assign('idusuario', $id);
        $this->_view->assign('datos', $usu);
        //print_r($usu);
        //$this->_view->assign('rol', $rolUsuario['Rol_role']);
        $this->_view->assign('roles', $this->_usuarios->getRoles());
        $this->_view->assign('rolesUsuario', $this->_usuarios->getRolesxUsuario($id));
        if($nuevoRol){
            $this->_view->renderizar('ajax/rol_usuario', false, true);
        }else{
            $this->_view->renderizar('rol');
        }        
    }
    //Modificado Jhon Martinez
    public function permisos($usuarioID) {
        $this->_acl->acceso('agregar_rol');
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("index_inicio");
        //   $this->_acl->acceso('admin');
        $id = $this->filtrarInt($usuarioID);
        
        if (!$id) {
            $this->redireccionar('usuarios');
        }
        if ($this->getInt('guardar') == 1) {
            $values = array_keys($_POST);
            $replace = array();
            $eliminar = array();

            for ($i = 0; $i < count($values); $i++) {
                if (substr($values[$i], 0, 5) == 'perm_') {
                    $permiso = (strlen($values[$i]) - 5);

                    if ($_POST[$values[$i]] == 'x') {
                        $eliminar[] = array(
                            'usuario' => $id,
                            'permiso' => substr($values[$i], -$permiso)
                        );
                    } else {
                        if ($_POST[$values[$i]] == 1) {
                            $v = 1;
                        } else {
                            $v = 0;
                        }
                        $replace[] = array(
                            'usuario' => $id,
                            'permiso' => substr($values[$i], -$permiso),
                            'valor' => $v
                        );
                    }
                }
            }

            for ($i = 0; $i < count($eliminar); $i++) {
                $this->_usuarios->eliminarPermiso(
                        $eliminar[$i]['usuario'], $eliminar[$i]['permiso']);
            }

            for ($i = 0; $i < count($replace); $i++) {
                $this->_usuarios->editarPermiso(
                        $replace[$i]['usuario'], $replace[$i]['permiso'], $replace[$i]['valor']);
            }
            $this->redireccionar('usuarios');
        }

        $permisosUsuario = $this->_usuarios->getPermisosUsuario($id);
        $permisosRole = $this->_usuarios->getPermisosRoles($id);
        
        if (!$permisosUsuario || !$permisosRole) {
            $this->redireccionar('usuarios/index/index/vacio');
        }
        ///print_r($permisosUsuario);exit;
        $this->_view->assign('titulo', 'Permisos de usuario');
        $this->_view->assign('permisos', array_keys($permisosUsuario));
        $this->_view->assign('usuario', $permisosUsuario);
        $this->_view->assign('roles', $permisosRole);
        $this->_view->assign('info', $this->_usuarios->getUsuario($id));
        $this->_view->assign('numeropagina', 1);

        $this->_view->renderizar('permisos','permisos');
    }
    
    public function editarUsuario($Usu_IdUsuario = false)
    {     
        $i=0;
        $error = ""; $error1 = ""; 
       /* $usu = $this->_usuarios->verificarUsuario($this->getSql('usuario'));
       // print_r($usu);exit;
        if($usu[0]!=$this->getInt('idusuario')){
            $error = ' El usuario <b style="font-size: 1.15em;">' . $this->getSql('usuario') . '</b> ya existe. ';
            $i=1;
        }      
        */
        if($Usu_IdUsuario){
            $idUsuario = $this->_usuarios->editarUsuarioClave(
                    $this->getSql('contrasena'),
                    $this->getInt('idusuario')
                );

            if ($idUsuario >0) {
                $this->_view->assign('_mensaje', 'Contraseña cambiado correctamente...!!');
            } else {
                $this->_view->assign('_error', 'Error al editar el Contraseña');
            }
        }else{            
            $usuEmail = $this->_usuarios->verificarEmail($this->getSql('email'));

            if(!empty($usuEmail) && $usuEmail['Usu_IdUsuario']!=$this->getInt('idusuario')){
                if($i!=0) {
                    $error1 = '<br> La direccion de correo <b style="font-size: 1.15em;">' . $this->getSql('email') . '</b> ya esta registrada. ';
                }else{
                    $error1 = ' La direccion de correo <b style="font-size: 1.15em;">' . $this->getSql('email') . '</b> ya esta registrada. ';
                }
                $i=2;
            }
               // $random = rand(1782598471, 9999999999);
            if($i==0){      
                $idUsuario = $this->_usuarios->editarUsuario(
                    $this->getSql('nombre'),
                    $this->getSql('apellidos'),
                    $this->getSql('dni'),
                    $this->getSql('direccion'),
                    $this->getSql('telefono'),
                    $this->getSql('institucion'),
                    $this->getSql('cargo'),
                    $this->getSql('email'),
                    $this->getInt('idusuario')
                );

                $idUsuarioRol = false;

                $this->_usuarios->eliminarRol_usuario($this->getInt('idusuario'));

                     $roles=$_POST['roles'];

                     if(count($roles)!=0){

                         for($i=0;$i<count($roles);$i++){
                            $idUsuarioRol = $this->_usuarios->insertarRol_usuario($this->getInt('idusuario'),$roles[$i]);
                         }
                    }
                        
                if ($idUsuario || $idUsuarioRol) {

                    $this->_view->assign('_mensaje', 'Edición del Usuario <b style="font-size: 1.15em;">'.$this->getAlphaNum('usuario').'</b> completado..!!');
                } else {
                    $this->_view->assign('_error', 'Error al editar el Usuario');
                }
            }  else {
                $this->_view->assign('_error', $error.$error1);
            }
        }
    }

}

?>
