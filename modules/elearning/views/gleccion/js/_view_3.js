// Menu(1);
// RefreshTagUrl();
var _post = null;

$(document).on('ready', function () {   
    // $('body').on('click', '.pagina', function () {
    //     $("#cargando").show();
    //     paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    // });
    // $('body').on('change', '.s_filas', function () {
    //     $("#cargando").show();
    //     paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    // });
    // var paginacion = function (pagina, nombrelista, datos,total_registros) {

    //     var pagina;
    //     if($("#idexamen").length > 0)
    //     pagina = {'pagina':pagina,'filas':$("#s_filas_"+nombrelista).val(),'total_registros':total_registros,'idexamen':$("#idexamen").val() };
        
    //     else
    //     pagina = {'pagina':pagina,'filas':$("#s_filas_"+nombrelista).val(),'total_registros':total_registros,'idcurso':$("#idcurso").val() };
        
    //     $.post(_root_ + 'elearning/gleccion/_paginacion_' + nombrelista + '/' + datos, pagina, function (data) {
    //         $("#" + nombrelista).html('');
    //         $("#cargando").hide();
    //         $("#" + nombrelista).html(data);
    //     });
    // }

    // $("body").on('click', '.estado-examen', function() {
    //   _estado = $(this).attr("estado");
    //   if (_estado === undefined) {
    //       _estado = 0;
    //   }
    //   if (!_estado) {
    //       _estado = 0;
    //   }

    //   if (_estado == 0) {
    //     if ($("#porcentaje").val() < 100 && $(this).attr("Exa_Porcentaje") <= 0) {
    //       $("#cargando").show();
    //       if (_post && _post.readyState != 4) {
    //           _post.abort();
    //       }

    //       _id_examen = $(this).attr("id_examen");
    //       if (_id_examen === undefined) {
    //           _id_examen = 0;
    //       }

    //       _post = $.post(_root_ + 'elearning/gleccion/_cambiarEstadoExamen',
    //           {                    
    //             idcurso: $("#hidden_curso").val(),
    //             _Lec_IdLeccion: $("#hidden_leccion").val(),
    //             pagina: $(".pagination .active span").html(),
    //             palabra: $("#palabraexamen").val(),
    //             filas:$("#s_filas_"+'listarexamens').val(),
    //             _Exa_IdExamen: _id_examen,
    //             _Exa_Estado: _estado
    //           },
    //       function(data) {
    //           $("#listarexamens").html('');
    //           $("#cargando").hide();
    //           $("#listarexamens").html(data);
    //           // mensaje(JSON.parse(data));
    //           // Select all elements with data-toggle="tooltips" in the document
    //           $('[data-toggle="tooltip"]').tooltip(); 
    //       });
    //     } else {
    //       mensaje([["error"," Solo se puede habilitar un examen por lección...!! "]]);
    //     }
    //   } else {
    //       $("#cargando").show();
    //       if (_post && _post.readyState != 4) {
    //           _post.abort();
    //       }

    //       _id_examen = $(this).attr("id_examen");
    //       if (_id_examen === undefined) {
    //           _id_examen = 0;
    //       }

    //       _post = $.post(_root_ + 'elearning/gleccion/_cambiarEstadoExamen',
    //           {                    
    //             idcurso: $("#hidden_curso").val(),
    //             _Lec_IdLeccion: $("#hidden_leccion").val(),
    //             pagina: $(".pagination .active span").html(),
    //             palabra: $("#palabraexamen").val(),
    //             filas:$("#s_filas_"+'listarexamens').val(),
    //             _Exa_IdExamen: _id_examen,
    //             _Exa_Estado: _estado
    //           },
    //       function(data) {
    //           $("#listarexamens").html('');
    //           $("#cargando").hide();
    //           $("#listarexamens").html(data);
    //           // mensaje(JSON.parse(data));
    //           // Select all elements with data-toggle="tooltips" in the document
    //           $('[data-toggle="tooltip"]').tooltip(); 
    //       });
    //     }
    // });

    
    $("#item_examen").click(function() {
      location.href = _root_ + _modulo + "/examen/examens/" + $("#hidden_curso").val() + "/" + $("#hidden_leccion").val();
          
    });

});