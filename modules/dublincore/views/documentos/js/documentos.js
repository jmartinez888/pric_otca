var _post = null;
var _Dub_IdDublincore_ = 0;
$(document).on('ready', function() {
    $('body').on('click', '.pagina', function() {
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"));
    });

    $('body').on('change', '.s_filas', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    });
    var paginacion = function (pagina, nombrelista, datos,total_registros) {
        
		$("#cargando").show();
        // var pagina = 'pagina=' + pagina;
		// var palabra = '&palabra=' + $("#palabra").val();
		// var metodo = 'paginar_resultados';
		// var query = $("#query").val();

		//var palabra = $('#'+palabra).val();     
		// var palabrafiltro = $('#palabra').val();     
	    var tema = $('#filtrotemadocumento').val(); 
	    var tipo = $('#filtrotipodocumento').val();  
	    var autor = $('#filtroautordocumento').val();
        var formato = $('#filtroformatodocumento').val();
        var letra = $('#filtroletradocumento').val();
        var usuario = $('#filtrousuariodocumento').val();
	    var pais = $('#filtropaisdocumento').val(); 
        // alert(usuario);
        // $(".abc").attr("letra");
	    // if(!palabrafiltro){palabrafiltro='all'}
	    if(!tema){tema='all'}
		if(!tipo){tipo='all'}
		if(!autor){autor='all'}
		if(!pais){pais='all'}
        if(!formato){formato='all'}
        if(!letra){letra='all'}
        if(!usuario){usuario='all'}
	    // tema = '&tema=' + tema; 
	    // tipo = '&tipo=' + tipo; 
	    // autor = '&autor=' + autor; 
	    // pais = '&pais=' + pais;
	    
	    var _post_ = {'pagina':pagina,'filas':$("#s_filas_"+nombrelista).val(),'tema':tema,'tipo':tipo,'autor':autor,
        'formato':formato,'letra':letra,'usuario':usuario,'pais':pais,'total_registros':total_registros};
        
		//if(query!=""){palabra = '&palabra=' +query;}
		
        $.post(_root_ + 'dublincore/documentos/_paginacion_' + nombrelista + '/' + datos, _post_, function(data){
			$('#' + nombrelista).html('');
			$("#cargando").hide();
            $('#' + nombrelista).html(data);
			$('[data-toggle="tooltip"]').tooltip();
        });
    }   

    //Busqueda Avanzada
    $("body").on('click', "#busquedaAvanzada", function() {
        if ($('#ba_div').hasClass('hidden')) {
            $('#ba_div').removeClass('hidden');
        } else {
            $('#ba_div').addClass('hidden');
        }
    });

    
    //Para el Modal
    $("body").on('click', "#agregar-form-link", function (e) {
        $("#agregar-form").delay(100).fadeIn(100);
        $("#buscar-form").fadeOut(100);
        $('#buscar-form-link').removeClass('active');
        $(this).addClass('active');
        e.preventDefault();
    });

    $("body").on('click', "#buscar-form-link", function (e) {
        $("#buscar-form").delay(100).fadeIn(100);
        $("#agregar-form").fadeOut(100);
        $('#agregar-form-link').removeClass('active');
        $(this).addClass('active');
        e.preventDefault();
    });

    $("body").on('click', "#bt_buscar_filter", function() {
        filtroRecurso();
    });
    $("body").on('change', "#sl_fuente_filtro", function() {
        filtroRecurso();
    });
    // $("body").on('change', "#sl_estandar_recurso_filtro", function() {
    //     filtroRecurso();
    // });
    $("body").on('change', "#sl_origen_filtro", function() {
        filtroRecurso();
    });
    $("body").on('change', "#sl_herramienta_filtro", function() {
        filtroRecurso();
    });

    $('#modal-recurso').on('show.bs.modal', function (e) {
        filtroRecurso();
    });

    var filtroRecurso = function() {
        $("#cargando").show();
        if (_post && _post.readyState != 4) {
            _post.abort();
        }
        tipoServicio = $("#tipoServicio").val(),

        _tipo = "Tabular";
        if (_tipo === undefined) {
            _tipo = "";
        }

        _post = $.post(_root_ + 'bdrecursos/index/_filtroRecursosDublin/' + tipoServicio,
                {
                    tipo: _tipo,
                    nombre: $("#tb_nombre_filter").val(),
                    estandar: 3,
                    fuente: $("#sl_fuente_filtro").val(),
                    origen: $("#sl_origen_filtro").val(),
                    herramienta: $("#sl_herramienta_filtro").val()
                },
        function(data) {
            $("#lista_recursos_dublin").html('');
            $("#cargando").hide();
            $("#lista_recursos_dublin").html(data);
        });
    }
    //Registrar Recurso
    $("body").on('click', "#bt_registrar", function() {
        //registrarRecurso

        _post = $.post(_root_ + 'dublincore/documentos/registrarRecurso',
                {  
                    hd_tipo_recurso: $('#hd_tipo_recurso').val(),
                    tb_nombre_recurso: $('#tb_nombre_recurso').val(),
                    tb_fuente_recurso: $('#tb_fuente_recurso').val(),
                    tb_origen_recurso: $('#tb_origen_recurso').val(),
                    sl_estandar_recurso: $('#sl_estandar_recurso').val()
                },
        function(data) {
            $("#adjuntarArchivo").html('');
            $("#cargando").hide();
            $("#adjuntarArchivo").html(data);
        });
    });    

    //Registrar Archivo
    $("body").on('click', "#btn_registrar_archivo", function() {
        //registrarRecurso
        var Rec_IdRecurso = $('#Rec_IdRecurso').val();
        var archivoFisico = document.getElementById("Arf_IdArchivoFisico");
        // the file is the first element in the files property
        var file = archivoFisico.files[0];
        var Arf_IdArchivoFisico_ =  file.fileName;
        // console.log("File name: " + file.fileName);

        // alert(Rec_IdRecurso }+ archivoFisico);
        _post = $.post(_root_ + 'dublincore/documentos/adjuntarArchivo/' + Rec_IdRecurso,
                {  
                    Idi_IdIdioma: $('#Idi_IdIdioma').val(),
                    Dub_Titulo: $('#Dub_Titulo').val(),
                    Dub_Descripcion: $('#Dub_Descripcion').val(),
                    Aut_IdAutor: $('#Aut_IdAutor').val(),
                    Dub_Editor: $('#Dub_Editor').val(),
                    Dub_Editor: $('#Dub_Colabrorador').val(),
                    Dub_FechaDocumento: $('#Dub_FechaDocumento').val(),
                    Dub_Formato: $('#Dub_Formato').val(),
                    Dub_Formato: $('#Dub_Identificador').val(),
                    Dub_Fuente: $('#Dub_Fuente').val(),
                    Dub_Idioma: $('#Dub_Idioma').val(),
                    Dub_Relacion: $('#Dub_Relacion').val(),
                    Dub_Cobertura: $('#Dub_Cobertura').val(),
                    Dub_Derechos: $('#Dub_Derechos').val(),
                    Dub_PalabraClave: $('#Dub_PalabraClave').val(),
                    Tid_IdTipoDublin: $('#Tid_IdTipoDublin').val(),
                    Ted_IdTemaDublin: $('#Ted_IdTemaDublin').val(),
                    Arf_IdArchivoFisico: Arf_IdArchivoFisico_,
                    Arf_URL: $('#Arf_URL').val(),
                    Pai_IdPais: $('#Pai_IdPais').val(),
                    registrar: $('#registrar').val()
                },
        function(data) {
            $("#adjuntarArchivo").html('');
            $("#cargando").hide();
            $("#adjuntarArchivo").html(data);
        });
    });   
    //Fin modal, para seleccionar recurso

    // Eliminar Dublin
    $("body").on('click', '.confirmar-eliminar-dublin', function() {
        
        if (_post && _post.readyState != 4) {
            _post.abort();
        }
        _id_dublin = $(this).attr("id_dublin");
        if (_id_dublin === undefined) {
            _id_dublin = 0;
        }
        _Dub_IdDublincore_ = _id_dublin;
        _Row_Estado_ = 0;
    });
    $('#confirm-delete').on('show.bs.modal', function(e) { 
        var bookId = $(e.relatedTarget).data('book-id'); 
         $(e.currentTarget).find("#texto_").html(bookId);
    }); 
    $("body").on('click', '.eliminar_dublin', function() {
        $("#cargando").show();
        // _Per_IdPermiso = _eliminar;
        //var palabra = $('#'+palabra).val();     
        // var palabrafiltro = $('#palabra').val();     
        var tema = $('#filtrotemadocumento').val(); 
        var tipo = $('#filtrotipodocumento').val();  
        var autor = $('#filtroautordocumento').val();
        var formato = $('#filtroformatodocumento').val();
        var letra = $('#filtroletradocumento').val();
        var usuario = $('#filtrousuariodocumento').val();
        var pais = $('#filtropaisdocumento').val(); 
        // alert(usuario);
        // $(".abc").attr("letra");
        // if(!palabrafiltro){palabrafiltro='all'}
        if(!tema){tema='all'}
        if(!tipo){tipo='all'}
        if(!autor){autor='all'}
        if(!pais){pais='all'}
        if(!formato){formato='all'}
        if(!letra){letra='all'}
        if(!usuario){usuario='all'}
        // tema = '&tema=' + tema; 
        // tipo = '&tipo=' + tipo; 
        // autor = '&autor=' + autor; 
        // pais = '&pais=' + pais;

        var _post_ = {'_Dub_IdDublincore': _Dub_IdDublincore_,
                        '_Row_Estado': _Row_Estado_,
                        'tema':tema,'tipo':tipo,'autor':autor,
                        'formato':formato,'letra':letra,'usuario':usuario,'pais':pais,
                        'pagina': $(".pagination .active span").html(),
                        'palabra': $("#palabraDublin").val(),
                        'filas':$("#s_filas_"+'resultados').val()
                    };
        
        _post = $.post(_root_ + 'dublincore/documentos/_eliminarDublin',
                _post_,
        function(data) {
            $("#resultados").html('');
            $("#cargando").hide();
            $("#resultados").html(data);
        });
    });
    $("body").on('click', '.confirmar-habilitar-permiso', function() {
        $("#cargando").show();
        if (_post && _post.readyState != 4) {
            _post.abort();
        }
        
        _id_dublin = $(this).attr("id_dublin");
        if (_id_dublin === undefined) {
            _id_dublin = 0;
        }
        _Dub_IdDublincore_ = _id_dublin;
        _Row_Estado_ = 1;
        
        // _Per_IdPermiso = _eliminar;
        //var palabra = $('#'+palabra).val();     
        // var palabrafiltro = $('#palabra').val();     
        var tema = $('#filtrotemadocumento').val(); 
        var tipo = $('#filtrotipodocumento').val();  
        var autor = $('#filtroautordocumento').val();
        var formato = $('#filtroformatodocumento').val();
        var letra = $('#filtroletradocumento').val();
        var usuario = $('#filtrousuariodocumento').val();
        var pais = $('#filtropaisdocumento').val(); 
        // alert(usuario);
        // $(".abc").attr("letra");
        // if(!palabrafiltro){palabrafiltro='all'}
        if(!tema){tema='all'}
        if(!tipo){tipo='all'}
        if(!autor){autor='all'}
        if(!pais){pais='all'}
        if(!formato){formato='all'}
        if(!letra){letra='all'}
        if(!usuario){usuario='all'}
        // tema = '&tema=' + tema; 
        // tipo = '&tipo=' + tipo; 
        // autor = '&autor=' + autor; 
        // pais = '&pais=' + pais;

        var _post_ = {'_Dub_IdDublincore': _Dub_IdDublincore_,
                        '_Row_Estado': _Row_Estado_,
                        'tema':tema,'tipo':tipo,'autor':autor,
                        'formato':formato,'letra':letra,'usuario':usuario,'pais':pais,
                        'pagina': $(".pagination .active span").html(),
                        'palabra': $("#palabraDublin").val(),
                        'filas':$("#s_filas_"+'resultados').val()
                    };
        
        _post = $.post(_root_ + 'dublincore/documentos/_eliminarDublin',
                _post_,
        function(data) {
            $("#resultados").html('');
            $("#cargando").hide();
            $("#resultados").html(data);
        });
    });
    // Eliminar Dublin

	$("body").on('click', ".ce_dublin", function() {
        $("#cargando").show();
        if (_post && _post.readyState != 4) {
            _post.abort();
        }               

        var tema = $('#filtrotemadocumento').val(); 
        var tipo = $('#filtrotipodocumento').val();  
        var autor = $('#filtroautordocumento').val();
        var formato = $('#filtroformatodocumento').val();
        var letra = $('#filtroletradocumento').val();
        var usuario = $('#filtrousuariodocumento').val();
        var pais = $('#filtropaisdocumento').val(); 
        // alert(usuario);
        // $(".abc").attr("letra");
        // if(!palabrafiltro){palabrafiltro='all'}
        if(!tema){tema='all'}
        if(!tipo){tipo='all'}
        if(!autor){autor='all'}
        if(!pais){pais='all'}
        if(!formato){formato='all'}
        if(!letra){letra='all'}
        if(!usuario){usuario='all'}
        
        _post = $.post(_root_ + 'dublincore/documentos/_cambiarEstadoDublin',
                {  
                    tema: tema,
                    tipo: tipo,
                    autor: autor,
                    pais: pais,
                    formato: formato,
                    letra: letra,
                    usuario: usuario,
                    valor_estado: $(this).attr("estado_dublin"),
                    id_dublin: $(this).attr("id_dublin"),
                    palabra: $("#palabra").val(),
                    pagina: $(".pagination .active span").html(),
                    filas: $("#s_filas_resultados").val()
                },
        function(data) {
            $("#resultados").html('');
            $("#cargando").hide();
            $("#resultados").html(data);
        });
    });
	
	$("body").on('click','#tematicas li' ,function() {
        actulizarportematica(this);
    });
	$('#tematicas li').click(function() 
    { 
		actulizarportematica(this);
    });		
	var  actulizarportematica= function(li){
		//document.getElementById('query').value =  $(li).find("span.temadocumento").text();
		//document.getElementById('metodo').value  = 'buscarportemadocumento';
		buscarTemaDocumentos($("#palabra").val(),$(li).find("span.temadocumento").text(),"filtrotipodocumento","filtroautordocumento",'filtroformatodocumento',"filtropaisdocumento","filtrousuariodocumento");
        //paginacion();
	}
	
	$("body").on('click','#tipodocumento li' ,function() {
        actulizarportipo(this);
    });
	$('#tipodocumento li').click(function() 
    { 
		actulizarportipo(this);
    });		
	var  actulizarportipo= function(li){
		/*
		document.getElementById('query').value =  $(li).find("span.palabraclave").text();
		document.getElementById('metodo').value  = 'buscarportipodocumento';
        paginacion();*/
		buscarTipoDocumentos($("#palabra").val(),"filtrotemadocumento",$(li).find("span.palabraclave").text(),"filtroautordocumento",'filtroformatodocumento',"filtropaisdocumento","filtrousuariodocumento");		
	}	
	
	$("body").on('click','#autor li' ,function() {
        actulizarporautor(this);
    });
	$('#autor li').click(function() 
    { 
		actulizarporautor(this);
    });
	var  actulizarporautor= function(li){
		/*
		document.getElementById('query').value =  $(li).find("span.palabraclave").text();
		document.getElementById('metodo').value  = 'buscarportipodocumento';
        paginacion();*/
		buscarAutorDocumentos($("#palabra").val(),"filtrotemadocumento","filtrotipodocumento",$(li).find("span.autordocumento").text(),'filtroformatodocumento',"filtropaisdocumento","filtrousuariodocumento");		
	}
	
    $("body").on('click','#formato li' ,function() {
        actulizarporformato(this);
    });
    $('#formato li').click(function() { 
        actulizarporformato(this);
    });
    var  actulizarporformato= function(li){
        /*
        document.getElementById('query').value =  $(li).find("span.palabraclave").text();
        document.getElementById('metodo').value  = 'buscarportipodocumento';
        paginacion();*/
        buscarFormatoDocumentos($("#palabra").val(),"filtrotemadocumento","filtrotipodocumento","filtroautordocumento",$(li).find("span.formatodocumento").text(),"filtropaisdocumento","filtrousuariodocumento");      
    }
	
	$("body").on('click',".pais",function() {
        actulizarporpais(this);
    });
	var  actulizarporpais= function(li){
		/*document.getElementById('query').value =  $(li).attr("pais");
		document.getElementById('metodo').value  = 'buscarporpais';
        paginacion();*/
		buscarPaisDocumentos($("#palabra").val(),"filtrotemadocumento","filtrotipodocumento","filtroautordocumento",'filtroformatodocumento',$(li).attr("pais"),"filtrousuariodocumento");        		
	}  
	$("body").on('click',".abc",function() {
        actulizarporletra(this);
    });
	var  actulizarporletra= function(li){
		/*document.getElementById('query').value =  $(li).attr("pais");
		document.getElementById('metodo').value  = 'buscarporpais';
        paginacion();*/
		buscarLetraDocumentos($("#palabra").val(),"filtrotemadocumento","filtrotipodocumento","filtroautordocumento",'filtroformatodocumento',"filtropaisdocumento","filtrousuariodocumento",$(li).attr("letra"));        		
	}    
    

});

function tecla_enter_dublincore(evento)
{    
    var iAscii;
    if (evento.keyCode){
        iAscii = evento.keyCode;
    }  
    if (iAscii == 13) 
    {
        buscarPalabraDocumentos('palabra','filtrotemadocumento','filtrotipodocumento','filtroautordocumento','filtroformatodocumento','filtropaisdocumento',"filtrousuariodocumento");
        evento.preventDefault();
    }
   
}

function buscarPalabraDocumentos(palabra, tema, tipo, autor, formato, pais, usuario = "all") { 
    var palabra = $('#'+palabra).val();     
    var tema = $('#'+tema).val(); 
    var tipo = $('#'+tipo).val();
    var autor = $('#'+autor).val(); 
    var formato = $('#'+formato).val(); 
    var pais = $('#'+pais).val(); 
    if(usuario != 1){
        var usuario = $('#'+usuario).val(); 
        if(!usuario){usuario = "all"}
    }

    if(!palabra){palabra='all'}
    if(!tema){tema='all'}
	if(!tipo){tipo='all'}
	if(!autor){autor='all'}
    if(!formato){formato='all'}
	if(!pais){pais='all'}

    document.location.href = _root_ + 'dublincore/documentos/busqueda/' + palabra + '/' + tema + '/' + tipo + '/' + autor + '/' + formato + '/' + pais + '/' + usuario
       
}
function buscarTemaDocumentos(palabra, tema, tipo, autor, foramto, pais, usuario = "all") { 
    var palabra = palabra;     
    var tema = tema;  
    var tipo = $('#'+tipo).val(); 
    var autor = $('#'+autor).val();
    var formato = $('#'+formato).val(); 
    var pais = $('#'+pais).val(); 
    var usuario = $('#'+usuario).val(); 
    if(!palabra){palabra='all'}
    if(!tema){tema='all'}
	if(!tipo){tipo='all'}
	if(!autor){autor='all'}
    if(!formato){formato='all'}
	if(!pais){pais='all'}
    if(!usuario){usuario = "all"}

    document.location.href = _root_ + 'dublincore/documentos/busqueda/' + palabra + '/' + tema + '/' + tipo + '/' + autor + '/' + formato + '/' + pais + '/' + usuario
        
}
function buscarTipoDocumentos(palabra, tema, tipo, autor, foramto, pais, usuario = "all") { 
    var palabra = palabra;     
    var tema = $('#'+tema).val(); 
    var tipo = tipo; 
    var autor = $('#'+autor).val(); 
    var formato = $('#'+formato).val();
    var pais = $('#'+pais).val(); 
    var usuario = $('#'+usuario).val(); 
    if(!palabra){palabra='all'}
    if(!tema){tema='all'}
	if(!tipo){tipo='all'}
	if(!autor){autor='all'}
    if(!formato){formato='all'}
	if(!pais){pais='all'}
    if(!usuario){usuario = "all"}

    document.location.href = _root_ + 'dublincore/documentos/busqueda/' + palabra + '/' + tema + '/' + tipo + '/' + autor + '/' + formato + '/' + pais + '/' + usuario
    
}
function buscarAutorDocumentos(palabra, tema, tipo, autor, foramto, pais, usuario = "all") { 
    var palabra = palabra;     
    var tema = $('#'+tema).val(); 
    var tipo = $('#'+tipo).val();
    var autor = autor; 
    var formato = $('#'+formato).val();
    var pais = $('#'+pais).val(); 
    var usuario = $('#'+usuario).val(); 
    if(!palabra){palabra='all'}
    if(!tema){tema='all'}
	if(!tipo){tipo='all'}
	if(!autor){autor='all'}
    if(!formato){formato='all'}
	if(!pais){pais='all'}
    if(!usuario){usuario = "all"}

    document.location.href = _root_ + 'dublincore/documentos/busqueda/' + palabra + '/' + tema + '/' + tipo + '/' + autor + '/' + formato + '/' + pais + '/' + usuario
       
}
function buscarFormatoDocumentos(palabra, tema, tipo, autor, formato, pais, usuario = "all") { 
    var palabra = palabra;     
    var tema = $('#'+tema).val(); 
    var tipo = $('#'+tipo).val();
    var autor = $('#'+autor).val();
    var formato = formato; 
    var pais = $('#'+pais).val();
    var usuario = $('#'+usuario).val(); 
    if(!palabra){palabra='all'}
    if(!tema){tema='all'}
    if(!tipo){tipo='all'}
    if(!autor){autor='all'}
    if(!formato){formato='all'}
    if(!pais){pais='all'}
    if(!usuario){usuario = "all"}

    document.location.href = _root_ + 'dublincore/documentos/busqueda/' + palabra + '/' + tema + '/' + tipo + '/' + autor + '/' + formato + '/' + pais + '/' + usuario
    
}
function buscarPaisDocumentos(palabra, tema, tipo, autor, formato, pais, usuario = "all") { 
    var palabra = palabra;     
    var tema = $('#'+tema).val(); 
    var tipo = $('#'+tipo).val(); 
    var autor = $('#'+autor).val(); 
    var formato = $('#'+formato).val();
    var pais = pais; 
    var usuario = $('#'+usuario).val(); 
    if(!palabra){palabra='all'}
    if(!tema){tema='all'}
	if(!tipo){tipo='all'}
	if(!autor){autor='all'}
    if(!formato){formato='all'}
	if(!pais){pais='all'}
    if(!usuario){usuario = "all"}

    document.location.href = _root_ + 'dublincore/documentos/busqueda/' + palabra + '/' + tema + '/' + tipo + '/' + autor + '/' + formato + '/' + pais + '/' + usuario
        
}
function buscarLetraDocumentos(palabra, tema, tipo, autor, formato, pais, usuario = "all", letra) { 
    var palabra = palabra;     
    var tema = $('#'+tema).val(); 
    var tipo = $('#'+tipo).val(); 
    var autor = $('#'+autor).val(); 
    var formato = $('#'+formato).val();
    var pais = $('#'+pais).val();
    var usuario = $('#'+usuario).val(); 
    var letra = letra; 
    if(!palabra){palabra='all'}
    if(!tema){tema='all'}
	if(!tipo){tipo='all'}
	if(!autor){autor='all'}
    if(!formato){formato='all'}
	if(!pais){pais='all'}
    if(!usuario){usuario = "all"}
	if(!letra){letra='all'}

    document.location.href = _root_ + 'dublincore/documentos/busqueda/' + palabra + '/' + tema + '/' + tipo + '/' + autor + '/' + formato + '/' + pais + '/' + usuario + '/' + letra
    
}
