var _post = null;
$(document).on('ready', function(){

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
            $("#cargando").hide();
            $("#lista_recursos_dublin").html('');
            $("#lista_recursos_dublin").html(data);
        });
    }
    //Fin modal, para seleccionar recurso


	$("#seleccionar_hoja").change( function() {
		$("#cargando").show();
		var hoja = '&hoja=' + document.getElementById('hojas').value;
		var data_tabla = $("#data_tabla").val();
		
		if(data_tabla==1)
		{
			$.post(_root_ + "bdrecursos/import/_listar_ficha_variable", hoja, function(data){
	        	$("#cargando").hide();
	            $('#ficha_estandar').html('');
	            $('#ficha_estandar').html(data);            
	        });
		} else {
			$.post(_root_ + "bdrecursos/import/_listar_ficha_estandar", hoja, function(data){
	        	$("#cargando").hide();
	            $('#ficha_estandar').html('');
	            $('#ficha_estandar').html(data);            
	        });
		}
    });	

});
