<?php

class registroController extends ofertaController
{	
	private $_inst;
	public function __construct($lang, $url) {
        parent::__construct($lang, $url);
        $this->_inst=$this->loadModel('registro');
    }

    public function index() {
    	$this->validarUrlIdioma();
    	$this->_acl->autenticado();
    	$this->_view->setJs(array('index'));
        $this->_view->setJs(array('select2'));
        $this->_view->setCss(array('select2'));

		$nombre = $this->getSql('nombre');
        $pagina = $this->getInt('pagina');
        $paginador = new Paginador();

        //$arrayRowCount = $this->_inst->getInstitucionesRowCount();
        //$totalRegistros = $arrayRowCount['CantidadRegistros'];
        $this->_view->assign('paises', $this->_inst->getPaises());
        $this->_view->assign('tipos', $this->_inst->getTipos());
        $this->_view->assign('ins', $this->_inst->getIns());
        $this->_view->assign('numeracion', 0);
        $this->_view->assign('totalRegistros', 0);
        
    	//$lista=$this->_inst->getInstituciones(0,CANT_REG_PAG);
    	//$paginador->paginar( $totalRegistros,"listarInstituciones", "", $pagina, CANT_REG_PAG, true);
    	
    	//$this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        //print($this->getInt('guardar'));
        
        
        if($this->getInt('guardar') == 1){
            $img = "logos/".$_FILES["img"]["name"];
            $nombre_Institucion = $this->getSql('nombre');
            $existe_nombre_Institucion = $this->_inst->existe_nombre_Institucion($nombre_Institucion);
            
            if(count($existe_nombre_Institucion)){
            $mensaje ="Esta Institución ya existe y no se puede volver a registrar.";        
            $this->_view->assign('mensaje_guardado', $mensaje);
            $this->_view->assign('titulo', 'Instituciones');
            $this->_view->setTemplate(LAYOUT_FRONTEND);
            $this->_view->renderizar('index','registro');
            exit;
            }
            if($this->getSql('latX')=="" && $this->getSql('latY')==""){
                $mensaje ="Por favor ubique a la Institución en el mapa.";        
                $this->_view->assign('mensaje_guardado', $mensaje);
                $this->_view->assign('titulo', 'Instituciones');
                $this->_view->setTemplate(LAYOUT_FRONTEND);
                $this->_view->renderizar('index','registro');
                exit;
            }

            if($_FILES["img"]["name"]==""){
                $mensaje ="Seleccione una Imagen representativa.";        
                $this->_view->assign('mensaje_guardado', $mensaje);
                $this->_view->assign('titulo', 'Instituciones');
                $this->_view->setTemplate(LAYOUT_FRONTEND);
                $this->_view->renderizar('index','registro');
            exit;
            }
            $existe_img_Institucion = $this->_inst->existe_img_Institucion("logos/".$_FILES["img"]["name"]);
            if(count($existe_img_Institucion)){
                $mensaje ="Cambie el nombre de la Imagen representativa porque ese nombre ya existe.";        
                $this->_view->assign('mensaje_guardado', $mensaje);
                $this->_view->assign('titulo', 'Instituciones');
                $this->_view->setTemplate(LAYOUT_FRONTEND);
                $this->_view->renderizar('index','registro');
            exit;
            }
            $lista=$this->_inst->insertarIns($this->getInt('ciudad'),$this->getInt('idpadre'),$this->getSql('nombre'),$this->getSql('descripcion'),$this->getSql('email'),$this->getSql('representante'),$this->getSql('tel'),$this->getSql('direccion'),$this->getSql('tipo'),$img,$this->getSql('website'),$this->getSql('latX'),$this->getSql('latY'));
            
            
        
        if($lista){
            $carpeta="C:/xampp/htdocs/framework_mvc_php_multi-idioma/modules/oferta/views/instituciones/img/logos/";
            opendir($carpeta);
            $destino = $carpeta.$_FILES["img"]["name"];
            
                copy($_FILES["img"]["tmp_name"],$destino);
                $ins = $this->getSql('nombre');
                $mensaje ="Registrado Correctamente";
                $ultimo_ida = $this->_inst->obtenerultimoid();
                $ultimo_id=$ultimo_ida['Ins_IdInstitucion'];
                $this->_view->assign('mensaje_guardado', $mensaje);
                if(Session::get('id_usuario')){
                    $id_usuario = Session::get('id_usuario');   
                    $insertar_ins_usuario = $this->_inst->registar_inst_usuario($ultimo_id,$id_usuario);
                }
                $otros_datos_ins = $this->_inst->obtenerotrosdatos($ultimo_id);

                $this->_view->assign('otros_datos_ins', $otros_datos_ins);
                
                $this->_view->assign('ultimo_id', $ultimo_id);
                $this->_view->assign('ins', $ins);
                $this->_view->assign('titulo', 'Instituciones');
                $this->_view->setTemplate(LAYOUT_FRONTEND);
                $this->_view->renderizar('otros_datos','registro');
                exit;
            
        }else{
            $mensaje ="Hubo un error";
        }
                    $this->_view->assign('mensaje_guardado', $mensaje);
        }
        if($this->getInt('guardar_otros_datos') == 1){
            $ultimo_id=$this->getInt('ultimo_id');

            $insertar_otrosdatos = $this->_inst->insertarotrosdatos($ultimo_id,$this->getSql('atributo'),$this->getSql('valor'));
            $otros_datos_ins = $this->_inst->obtenerotrosdatos($ultimo_id);
            $this->_view->assign('otros_datos_ins', $otros_datos_ins);
            $this->_view->assign('titulo', 'Instituciones');
            $this->_view->assign('ultimo_id', $ultimo_id);
            $this->_view->setTemplate(LAYOUT_FRONTEND);
            $this->_view->renderizar('otros_datos','registro');
            exit;
        }
    	//$this->_view->assign('listaIns', $lista);
    	$this->_view->assign('titulo', 'Instituciones');
    	$this->_view->setTemplate(LAYOUT_FRONTEND);
    	$this->_view->renderizar('index','registro');

    }

    public function _mostrarciudades($txtBuscar) 
    {
        $this->_view->setJs(array('index'));
        $this->_view->assign('Ciudades', $this->_inst->getCiudadesPorIdPai($txtBuscar));
        $this->_view->assign('titulo', 'Instituciones');
        $this->_view->renderizar('ajax/mostrarciudades', false, true);
    }
    
    public function buscarporpalabras($dato = '',$pais='')
    {
        if($dato=="all"){$dato="";}
        if($pais=="all"){$pais="";}
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $arrayRowCount = $this->_inst->getInstitucionesBusquedaRowCount($dato,$pais);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];  
        $this->_view->setJs(array('index'));
        $paginador = new Paginador();
        if($pagina==0){
        $numeracion=0;
    }else{
        $numeracion=($pagina-1)*10;    
    }
        $this->_view->assign('titulo', 'Instituciones');
        $paginador->paginar( $totalRegistros,"listarInstituciones", "$dato", $pagina, CANT_REG_PAG, true);
        $this->_view->assign('paises', $this->_inst->getPaises());
        $this->_view->assign('listaIns', $this->_inst->getInstitucionesBusqueda($pagina,CANT_REG_PAG,$dato,$pais));
        $this->_view->assign('numeracion', $numeracion);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('index', 'instituciones');
    }
public function ficha($id=false) {
        $this->validarUrlIdioma();
        
        $this->_view->setJs(array('index'));

        $lista=$this->_inst->getInstitucionPorId($id);
        
        $this->_view->assign('listaIns', $lista);
        $this->_view->assign('titulo', 'Ficha Institucion');
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->renderizar('ficha','instituciones');

    }
    public function ofertas_academicas($id=false) {
        $this->validarUrlIdioma();
        $this->_acl->autenticado();
        $this->_view->setJs(array('index'));

        if($this->getInt('guardar') == 1){
            $lista=$this->_inst->insertarOferta($id,$this->getInt('tematica'),$this->getSql('nombre'),$this->getSql('descripcion'),$this->getSql('tipooferta'),$this->getSql('contacto'));
        }
        $lista=$this->_inst->getInstitucionPorId($id);
        $tipooferta = $this->_inst->getTiposOferta();
        $tematica = $this->_inst->getTematicas();
        $listaofertas = $this->_inst->getOfertasPorId($id);
        $this->_view->assign('tipooferta', $tipooferta);
        $this->_view->assign('listaofertas', $listaofertas);
        $this->_view->assign('id', $id);
        $this->_view->assign('tematica', $tematica);
        $this->_view->assign('listaIns', $lista);
        $this->_view->assign('titulo', 'Registro de Ofertas');
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->renderizar('ofertas_academicas','registro');

    }
    public function guardar() {
        $this->validarUrlIdioma();
        
        $this->_view->setJs(array('index'));
        
        
        $this->_view->assign('titulo', 'Instituciones');
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->renderizar('index','index');

    }
    public function investigacion($id=false) {
        $this->validarUrlIdioma();
        $this->_acl->autenticado();
        $this->_view->setJs(array('index'));

        if($this->getInt('guardar_inv') == 1){
            $lista=$this->_inst->insertarInv($id,$this->getInt('tematica'),$this->getSql('nombre'),$this->getSql('descripcion'),$this->getSql('tipooferta'),$this->getSql('contacto'));
        }
        if($this->getInt('guardar_dif') == 1){
            $lista=$this->_inst->insertarDif($id,$this->getSql('difusion'));
        }

        $lista=$this->_inst->getInstitucionPorId($id);
        $tematica = $this->_inst->getTematicas();
        $listaofertas = $this->_inst->getInvPorId($id);
        $listaDif = $this->_inst->getDifPorId($id);
        //$this->_view->assign('tipooferta', $tipooferta);
        $this->_view->assign('listaofertas', $listaofertas);
        $this->_view->assign('listaDif', $listaDif);
        $this->_view->assign('id', $id);
        $this->_view->assign('tematica', $tematica);
        $this->_view->assign('listaIns', $lista);
        $this->_view->assign('titulo', 'Investigación');
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->renderizar('investigacion','registro');

    }
}
?>  