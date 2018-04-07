<?php

class editarController extends ofertaController
{	
	private $_inst;
	public function __construct($lang, $url) {
        parent::__construct($lang, $url);
        $this->_inst=$this->loadModel('editar');
    }

    public function index($id=false,$id_od=false) {
    	$this->validarUrlIdioma();
        $this->_acl->autenticado();    	
    	$this->_view->setJs(array('index'));
        $this->_view->setJs(array('select2'));
        $this->_view->setCss(array('select2'));

		$nombre = $this->getSql('nombre');
        $pagina = $this->getInt('pagina');
        $paginador = new Paginador();
        $datos_ins = $this->_inst->getInstitucionPorId($id);
        $this->_view->assign('paises', $this->_inst->getPaises());
        $this->_view->assign('tipos', $this->_inst->getTipos());
        $this->_view->assign('ins', $this->_inst->getIns());
        $this->_view->assign('datos_ins', $datos_ins);
        $this->_view->assign('Ciudades', $this->_inst->getCiudadesPorIdPai($datos_ins['Pai_IdPais']));
        $this->_view->assign('numeracion', 0);
        $this->_view->assign('totalRegistros', 0);
        //eliminar otros_Datos
        if($this->getInt('eliminar') == 1){
            
            $lista=$this->_inst->getEliminarOD($this->getInt('id_ins_o_d'));
        
            $ins = $this->getSql('nombre');
            
            $otros_datos_ins = $this->_inst->obtenerotrosdatos($id);

            $this->_view->assign('otros_datos_ins', $otros_datos_ins);
            
            $this->_view->assign('ultimo_id', $id);
            $this->_view->assign('ins', $ins);
            $this->_view->assign('titulo', 'Instituciones');
           $this->_view->setTemplate(LAYOUT_FRONTEND);
            $this->_view->renderizar('otros_datos','editar');
            exit;
            
        }
        //fin eliminar otros_datos
        //editar institucion
        if($this->getInt('guardar') == 1){
            if($_FILES["img"]["name"]==""){
                $img = $this->getSql('img_actual');
            }else{
                $img = "logos/".$_FILES["img"]["name"];
                $carpeta="C:/xampp/htdocs/framework_mvc_php_multi-idioma/modules/oferta/views/instituciones/img/logos/";
                opendir($carpeta);
                $destino = $carpeta.$_FILES["img"]["name"];
                copy($_FILES["img"]["tmp_name"],$destino);
                unlink("C:/xampp/htdocs/framework_mvc_php_multi-idioma/modules/oferta/views/instituciones/img/".$this->getSql('img_actual'));
            }
            $lista=$this->_inst->editarIns($id,$this->getInt('ciudad'),$this->getInt('idpadre'),$this->getSql('nombre'),$this->getSql('email'),$this->getSql('representante'),$this->getSql('tel'),$this->getSql('direccion'),$this->getSql('tipo'),$img,$this->getSql('website'),$this->getSql('latX'),$this->getSql('latY'));
            
            $ins = $this->getSql('nombre');
            $mensaje ="Actualizado Correctamente";
            
            $this->_view->assign('mensaje_guardado', $mensaje);
            
            $otros_datos_ins = $this->_inst->obtenerotrosdatos($id);

            $this->_view->assign('otros_datos_ins', $otros_datos_ins);
            
            $this->_view->assign('ultimo_id', $id);
            $this->_view->assign('ins', $ins);
            $this->_view->assign('titulo', 'Instituciones');
            $this->_view->setTemplate(LAYOUT_FRONTEND);
            $this->_view->renderizar('otros_datos','editar');
            exit;
            
        }
        //fin editar institucion
        //guardar otros datos
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
        //fin guardar otros datos
        //editar otros datos
        if($id_od!==false){
            
            if($this->getInt('editar_otros_datos') == 1){
                $ultimo_id=$this->getInt('ultimo_idE');
                $id_od=$this->getInt('id_editar_otros_datos');
                $editar_otrosdatos = $this->_inst->editarotrosdatos($id_od,$ultimo_id,$this->getSql('atributoE'),$this->getSql('valorE'));
                $otros_datos_ins = $this->_inst->obtenerotrosdatos($ultimo_id);
                $this->_view->assign('otros_datos_ins', $otros_datos_ins);
                $this->_view->assign('titulo', 'Instituciones');
                $this->_view->assign('ultimo_id', $ultimo_id);
                $this->_view->setTemplate(LAYOUT_FRONTEND);
                $this->_view->renderizar('otros_datos','registro');
                exit;
            }
            $od = $this->_inst->obtenerOD($id_od);
            $this->_view->assign('editar_od', $od);
            $otros_datos_ins = $this->_inst->obtenerotrosdatos($id);
            $this->_view->assign('otros_datos_ins', $otros_datos_ins);
            $this->_view->assign('titulo', 'Instituciones');
            $this->_view->assign('ultimo_id', $id);
            $this->_view->setTemplate(LAYOUT_FRONTEND);
            $this->_view->renderizar('otros_datos','registro');
            exit;
        }
    	//fin editar otros datos
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
    public function ofertas_academicas($id=false,$id_oferta=false) {
        $this->validarUrlIdioma();
        $this->_acl->autenticado();
        $this->_view->setJs(array('index'));

        if($this->getInt('guardar') == 1){
            $lista=$this->_inst->insertarOferta($id,$this->getInt('tematica'),$this->getSql('nombre'),$this->getSql('descripcion'),$this->getSql('tipooferta'),$this->getSql('contacto'));
            
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
            exit;
        }
        //eliminar otros_Datos
        if($this->getInt('eliminar') == 1){
            
            $lista=$this->_inst->getEliminarOA($this->getInt('id_oferta'));
        
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
            $this->_view->renderizar('ofertas_academicas','editar');
            
        }
        //fin eliminar otros_datos
        if($id_oferta!==false){
            
            if($this->getInt('editar') == 1){
                $lista=$this->_inst->editarOferta($id_oferta,$this->getInt('tematica'),$this->getSql('nombre'),$this->getSql('descripcion'),$this->getSql('tipooferta'),$this->getSql('contacto'));    
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
                exit;
            }
            $detalleofertas = $this->_inst->getDetOfertasPorId($id_oferta);
            $this->_view->assign('editar_oferta', $detalleofertas);

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
            exit;
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
    public function investigacion($id=false,$ident = false,$id_ident=false) {
        $this->validarUrlIdioma();
        $this->_acl->autenticado();
        $this->_view->setJs(array('index'));

        if($this->getInt('guardar_inv') == 1){
            $lista=$this->_inst->insertarInv($id,$this->getInt('tematica'),$this->getSql('nombre'),$this->getSql('descripcion'),$this->getSql('tipooferta'),$this->getSql('contacto'));
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
            $this->_view->renderizar('investigacion','editar');
            exit;
        }

        //eliminar otros_Datos
        if($this->getInt('eliminar_inv') == 1){
            
            $lista=$this->_inst->getEliminarOA($this->getInt('id_inv'));
        
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
            $this->_view->renderizar('investigacion','editar');
        }
        //fin eliminar otros_datos
        //eliminar otros_Datos
        if($this->getInt('eliminar_dif') == 1){
            
            $lista=$this->_inst->getEliminarDif($this->getInt('id_dif'));
        
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
            $this->_view->renderizar('investigacion','editar');
        }
        //fin eliminar otros_datos
        if($this->getInt('guardar_dif') == 1){
            $lista=$this->_inst->insertarDif($id,$this->getSql('difusion'),$this->getSql('descripcion'),$this->getSql('enlace'));
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
            $this->_view->renderizar('investigacion','editar');
                    exit;
        }
        if($ident!==false){
            if($ident=="proyecto"){
                
                if($this->getInt('editar_inv') == 1){
                    $lista=$this->_inst->editar_inv($id_ident,$this->getInt('tematica'),$this->getSql('nombre'),$this->getSql('descripcion'),$this->getSql('tipooferta'),$this->getSql('contacto'));
                    $lista=$this->_inst->getInstitucionPorId($id);
                    $tematica = $this->_inst->getTematicas();
                    $listaofertas = $this->_inst->getInvPorId($id);
                    $listaDif = $this->_inst->getDifPorId($id);
                    
                    $this->_view->assign('listaofertas', $listaofertas);
                    
                    $this->_view->assign('listaDif', $listaDif);
                    $this->_view->assign('id', $id);
                    $this->_view->assign('tematica', $tematica);
                    $this->_view->assign('listaIns', $lista);
                    $this->_view->assign('titulo', 'Investigación');
                    $this->_view->setTemplate(LAYOUT_FRONTEND);
                    $this->_view->renderizar('investigacion','editar');
                    exit;
                }
                $this->_view->assign('ident', $ident);
                $editar_inv = $this->_inst->getInvPorIdInv($id_ident);
                $this->_view->assign('editar_inv', $editar_inv);
                $lista=$this->_inst->getInstitucionPorId($id);
                $tematica = $this->_inst->getTematicas();
                $listaofertas = $this->_inst->getInvPorId($id);
                $listaDif = $this->_inst->getDifPorId($id);
               // $this->_view->assign('tipooferta', $tipooferta);
                $this->_view->assign('listaofertas', $listaofertas);
                $this->_view->assign('listaDif', $listaDif);
                $this->_view->assign('id', $id);
                $this->_view->assign('tematica', $tematica);
                $this->_view->assign('listaIns', $lista);
                $this->_view->assign('titulo', 'Investigación');
                $this->_view->setTemplate(LAYOUT_FRONTEND);
                $this->_view->renderizar('investigacion','editar');
                exit;
            }
            if($ident=="difusion"){
                if($this->getInt('editar_dif') == 1){
                    $lista=$this->_inst->editar_dif($id_ident,$this->getSql('difusion'),$this->getSql('descripcion'),$this->getSql('enlace'));
                    $lista=$this->_inst->getInstitucionPorId($id);
                    $tematica = $this->_inst->getTematicas();
                    $listaofertas = $this->_inst->getInvPorId($id);
                    $listaDif = $this->_inst->getDifPorId($id);
                   // $this->_view->assign('tipooferta', $tipooferta);
                    $this->_view->assign('listaofertas', $listaofertas);
                    
                    $this->_view->assign('listaDif', $listaDif);
                    $this->_view->assign('id', $id);
                    $this->_view->assign('tematica', $tematica);
                    $this->_view->assign('listaIns', $lista);
                    $this->_view->assign('titulo', 'Investigación');
                    $this->_view->setTemplate(LAYOUT_FRONTEND);
                    $this->_view->renderizar('investigacion','editar');
                    exit;
                }
                $this->_view->assign('ident', $ident);
                $editar_dif = $this->_inst->getDifPorIdDif($id_ident);
                $this->_view->assign('editar_dif', $editar_dif);
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
                $this->_view->renderizar('investigacion','editar');
                exit;
            }
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
        $this->_view->renderizar('investigacion','editar');
    }
    public function eliminar($ind=false,$id_ind=false) {
        $this->validarUrlIdioma();
        
        $this->_view->setJs(array('index'));

        if($ind == "otros_datos"){
            $eliminar = $this->_inst->getEliminarOD($id_ind);
            $otros_datos_ins = $this->_inst->obtenerotrosdatos($id_ind);
            $this->_view->assign('otros_datos_ins', $otros_datos_ins);
            $this->_view->assign('titulo', 'Instituciones');
            $this->_view->assign('ultimo_id', $id_ind);
            $this->_view->setTemplate(LAYOUT_FRONTEND);
            $this->_view->renderizar('index','editar');
            exit;
        }    
    }
}
?>