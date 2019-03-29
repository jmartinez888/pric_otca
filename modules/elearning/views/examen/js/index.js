var _post = null;
var _Per_IdPermiso_ = 0;
var nextinput = $("#nextinput").val();
var contadorinputs = nextinput-1;
var contblanco=1;
if ($("#contblanco").val() > 0) {
    contblanco = $("#contblanco").val();
}

// Menu(1);
$(document).on('ready', function () {   
    // $('#form1').validator().on('submit', function (e) {
    //     if (e.isDefaultPrevented()) {

    //     } else {

    //     }
    // });
    // try {
    //     RefreshTagUrl();
    // } catch(e) {
       
    // }
    
    $("#hidden_curso").val($("#idcurso").val());

    $('body').on('click', '.pagina', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    });
    $('body').on('change', '.s_filas', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    });


    //  $(".btn-preguntas").click(function(){
    // var IdExamen = $(this).parent().find(".hidden_IdExamen").val();
    //   $("#hidden_IdExamen").val(IdExamen);
    //       CargarPagina("examen/preguntas", { id: $("#idcurso").val(), idleccion:IdExamen }, false, $(this));
    // });
     
    $("body").on('change', "#selectmodulo", function () {      
        $("#cargando").show();
        $.post(_root_ + 'elearning/examen/actualizarlecciones',
        {
            id:$("#selectmodulo").val(),
            idCurso:$("#idcurso").val()  
        }, function (data) {
            $("#completar").html('');
            $("#cargando").hide();
            $("#completar").html(data);
            $('[data-toggle="tooltip"]').tooltip();
        });
    });

    var paginacion = function (pagina, nombrelista, datos,total_registros) {

        var pagina;

        if (parseInt($("#hidden_leccion").val()) > 0) {
           var hidden_leccion = $("#hidden_leccion").val();
        } else {
           var hidden_leccion = "";
        } 

        if($("#idexamen").length > 0)
            pagina = {'pagina':pagina,'filas':$("#s_filas_"+nombrelista).val(),'total_registros':total_registros,'idexamen':$("#idexamen").val() };
        else
            pagina = {'pagina':pagina,'filas':$("#s_filas_"+nombrelista).val(),'total_registros':total_registros,'idcurso':$("#idcurso").val(), 'idleccion':hidden_leccion };
        
        $.post(_root_ + 'elearning/examen/_paginacion_' + nombrelista + '/' + datos, pagina, function (data) {
            $("#" + nombrelista).html('');
            $("#cargando").hide();
            $("#" + nombrelista).html(data);
        });

    }

    $('#img').change(function(e) {
          addImage(e); 
         });

         function addImage(e){
          var file = e.target.files[0],
          imageType = /image.*/;
        
          if (!file.type.match(imageType))
           return;
      
          var reader = new FileReader();
          reader.onload = fileOnload;
          reader.readAsDataURL(file);
         }
      
         function fileOnload(e) {
          var result=e.target.result;
          $('#cuadro1').attr("style","background-image: url('"+result+"'); background-size: 100%; -moz-background-size: 100%; -o-background-size: 100%; -webkit-background-size: 100%; -khtml-background-size: 100%;  height:21cm; position: relative;");
         }

    $("#gestion_idiomas").on('click', ".idioma_s", function () {
        let _this = $(this);

        let parentLi = _this.parent('li');
        console.log(parentLi);
        var id = _this.attr("id");
        var tag = $("#hd_" + id);
        var idIdioma = tag.val();
        console.log(idIdioma)
        $('#idioma_target_id').val(idIdioma)
        gestionIdiomas($("#idRol").val(), $("#idIdiomaOriginal").val(), idIdioma);
    });
    
    $("#gestion_idiomas_pregunta").on('click', ".idioma_s", function () {
        let _this = $(this);

        let parentLi = _this.parent('li');
        console.log(parentLi);
        var id = _this.attr("id");
        var tag = $("#hd_" + id);
        var idIdioma = tag.val();
        console.log(idIdioma)
        $('#idioma_target_id').val(idIdioma)

        // idrol, idIdiomaOriginal, idIdioma
        loading.show();
        $.post(location.href,
                {
                    mode: 'get_tpl_idioma',
                    curso_id: $('#idcurso').val(),        
                    examen_id: $('#examen_id').val(),        
                    idioma_id: idIdioma,
                    idioma_original_id: $("#idioma_original_id").val()
                }, function (data) {
            $("#replace_contenido_pregunta").html('');
            loading.hide();
            $("#replace_contenido_pregunta").html(data);
            $('form').validator();
        });

        
        
    });

    var oldVal = "";
    $("#in_pregunta4").on("change keyup paste", function() {
        var currentVal = $(this).val();
        if(currentVal == oldVal) {
            return; //check to prevent multiple simultaneous triggers
        }

        oldVal = currentVal;
        var texto = ' ' + $(this).val();
        var textoseparado = texto.split("|");
        $("#alt").html("");
        var j=1;
        var cabecera = makeTemplate('tpl-cabezera');
        $("#alt").append(cabecera);
        contblanco=1;
        for(var i=0; i< textoseparado.length; i++){
            if(i%2!=0 &&i!=textoseparado.length-1){
                // var campo = "<input type='text' id='espacio"+j+"' value='"+textoseparado[i]+"'>";
                let campo = makeTemplate('tpl-campo-pre-4', {
                    maximo: $('#maximo').val(),
                    varj: j,
                    textoseparado: textoseparado[i]
                })
                $("#tabla").append(campo);
                j++;
                contblanco++;
                // Select all elements with data-toggle="tooltips" in the document
                $('[data-toggle="tooltip"]').tooltip(); 
            }
        }
        // var cierre ="</table></div>"
        // $("#alt").append(cierre);
        document.getElementById("btn_registrar_pregunta").disabled = false;
        if(j==1)
            $("#alt").html(LANG_UTILS_VIEW.espacio_blanco_con_separadores);
    });

    var oldVal2 = "";
    $("body").on('change', ".puntos_blanco", function () {
        // var currentVal = $(this).val();
        // if(currentVal == oldVal2) {
        //     return; //check to prevent multiple simultaneous triggers
        // }

        // oldVal2 = currentVal;

        var suma = 0;
        for(var i=1; i< contblanco; i++){
            suma = suma + parseInt($("#puntos"+i).val());
        }

        $("#puntos").val(suma);
        $("#puntoslabel").text(`${LANG_UTILS_VIEW.str_puntos}: ${suma}`);
        var maximo = parseInt($("#maximo").val())-parseInt(suma);
        // $("#maximo").val(maximo);
        for(var i=1; i< contblanco; i++){
            // if("puntos"+i!=this.id)
            if($("#puntos"+i).val()==0)
            {
                $("#puntos"+i).attr('max', parseInt(maximo));
                $("#puntos"+i).attr('data-original-title', `${LANG_UTILS_VIEW.nuevo_examen_porcentaje2} ${maximo}`);
            } else {
                var _max = parseInt(maximo)+ parseInt($("#puntos"+i).val());
                $("#puntos"+i).attr('max', parseInt(_max));
                $("#puntos"+i).attr('data-original-title', `${LANG_UTILS_VIEW.elearning_label_mensaje} ${_max}`);
            }
        }  
        document.getElementById("btn_registrar_pregunta").disabled = false;      
    });
    $("body").on('click', "#btn_asignar_puntos", function (e) {
        e.preventDefault();
        $("#puntos").val();
        var maximo = $("#maximo").val();
        var numAlternativas = (contblanco-1);
        var puntosRestantes = maximo%numAlternativas; //Lo que sobra(residuo)
        var puntosEnteros = Math.floor(maximo/numAlternativas);

        for (var i = 1; i < contblanco; i++){
            // if("puntos"+i!=this.id)            
            $("#puntos"+i).val(puntosEnteros);
            $("#puntos"+i).attr('max', puntosEnteros);
            $("#puntos"+i).attr('data-original-title', `${LANG_UTILS_VIEW.nuevo_examen_porcentaje2} ${puntosEnteros}`);
        } 
        for (var j = 1; j < contblanco; j++) {
            if (puntosRestantes > 0) {
                var _max = parseInt($("#puntos"+j).attr('max')) + 1;
                $("#puntos"+j).val(_max);
                $("#puntos"+j).attr('max', _max);
                $("#puntos"+j).attr('data-original-title', `${LANG_UTILS_VIEW.elearning_label_mensaje} ${_max}`);
            } 
            puntosRestantes--;            
        }
        $("#puntos").val(maximo);
        $("#puntoslabel").text(`${LANG_UTILS_VIEW.str_puntos}: ${maximo}`);
        document.getElementById("btn_registrar_pregunta").disabled = false;
    });

    $('#confirm-delete').on('show.bs.modal', function(e) { 
        var bookId = $(e.relatedTarget).data('book-id'); 
         $(e.currentTarget).find("#texto_").html(bookId);
    }); 

    
    //preguntaS
    $("body").on('click', ".nueva_pregunta", function () { 
        // $("#cargando").show(); 
        if ($("#puntos").val() > 0) {
            location.href = $(this).attr("_href");
        }else{
            $("#msj-invalido").modal("show");
        }
        // buscarpregunta($("#palabrapregunta").val(), $("#idexamen").val());
    }); 
    $("body").on('click', "#buscarpregunta", function () { 
        $("#cargando").show();       
        buscarpregunta($("#palabrapregunta").val(), $("#idexamen").val());
    }); 
    $("body").on('click', "#buscarexamen", function () { 
        $("#cargando").show();     
        if (parseInt($("#hidden_leccion").val()) > 0) {
            buscarexamen($("#palabraexamen").val(), $("#idcurso").val(), $("#hidden_leccion").val());                      
        } else {
            buscarexamen($("#palabraexamen").val(), $("#idcurso").val());
        }  
    }); 

    $("body").on('click', "#buscarExamenAlumno", function () { 
        $("#cargando").show();
        buscarExamenAlumno($("#palabraExamenAlumno").val());
    }); 

    // $("body").on('click', '.estado-examen', function() {
    //     $("#cargando").show();
    //     if (_post && _post.readyState != 4) {
    //         _post.abort();
    //     }

    //     _id_examen = $(this).attr("id_examen");
    //     if (_id_examen === undefined) {
    //         _id_examen = 0;
    //     }
    //     _estado = $(this).attr("estado");
    //     if (_estado === undefined) {
    //         _estado = 0;
    //     }
    //     if (!_estado) {
    //         _estado = 0;
    //     }

    //     _post = $.post(_root_ + 'elearning/examen/_cambiarEstadoExamens',
    //         {                    
    //             _Mod_Idexamen: _id_examen,
    //             _Mod_Estado: _estado,
    //             pagina: $(".pagination .active span").html(),
    //             palabra: $("#palabraexamen").val(),
    //             filas:$("#s_filas_"+'listarexamens').val(),
    //             // idexamen:$("#idexamen").val()
                
    //         },
    //     function(data) {
    //         $("#listarexamens").html('');
    //         $("#cargando").hide();
    //         $("#listarexamens").html(data);
    //         $('[data-toggle="tooltip"]').tooltip(); 
    //         // mensaje(JSON.parse(data));
    //     });
    // });

    $("body").on('click', '.estado-examen', function() {
      _estado = $(this).attr("estado");
      if (_estado === undefined) {
          _estado = 0;
      }
      if (!_estado) {
          _estado = 0;
      }
      // _hidden_leccion = 0;
      if (_estado == 0) {
        if (parseInt($("#hidden_leccion").val()) > 0) {
            if (parseInt($("#hidden_habilitado").val()) > 0) {
                _hidden_leccion = 1;
            } else {
                _hidden_leccion = 0;
            }            
        } else {
            _hidden_leccion = 0;
        }

        if (parseInt($("#porcentaje").val()) <= 100 && _hidden_leccion == 0 && parseInt($("#porcentaje").val())+parseInt($(this).attr("Exa_Porcentaje")) <= 100 ) {
          $("#cargando").show();
          if (_post && _post.readyState != 4) {
              _post.abort();
          }

          _id_examen = $(this).attr("id_examen");
          if (_id_examen === undefined) {
              _id_examen = 0;
          }

          _post = $.post(_root_ + 'elearning/examen/_cambiarEstadoExamen',
              {                    
                idcurso: $("#hidden_curso").val(),
                _Lec_IdLeccion: $("#hidden_leccion").val(),
                pagina: $(".pagination .active span").html(),
                palabra: $("#palabraexamen").val(),
                filas:$("#s_filas_"+'listarexamens').val(),
                _Exa_IdExamen: _id_examen,
                _Exa_Estado: _estado
              },
          function(data) {
              $("#listarexamens").html('');
              $("#cargando").hide();
              $("#listarexamens").html(data);
              // mensaje(JSON.parse(data));
              // Select all elements with data-toggle="tooltips" in the document
              $('[data-toggle="tooltip"]').tooltip(); 
          });
        } else {
            if (parseInt($("#porcentaje").val())+parseInt($(this).attr("Exa_Porcentaje")) > 100 ) {
                mensaje([["error", ` ${LANG_UTILS_VIEW.elearning_cursos_no_se_puede_habilitar_examen_supera_porcentaje} `]]);
            }
            if (_hidden_leccion == 1) {
                mensaje([["error", ` ${LANG_UTILS_VIEW.elearning_cursos_solo_puede_habilitar_examen_leccion} `]]);
            }
            if (parseInt($("#porcentaje").val()) > 100 ) {
                mensaje([["error", ` ${LANG_UTILS_VIEW.elearning_cursos_porcentaje_supero} `]]);
            }
        }
      } else {
          $("#cargando").show();
          if (_post && _post.readyState != 4) {
              _post.abort();
          }

          _id_examen = $(this).attr("id_examen");
          if (_id_examen === undefined) {
              _id_examen = 0;
          }

          _post = $.post(_root_ + 'elearning/examen/_cambiarEstadoExamen',
              {                    
                idcurso: $("#hidden_curso").val(),
                _Lec_IdLeccion: $("#hidden_leccion").val(),
                pagina: $(".pagination .active span").html(),
                palabra: $("#palabraexamen").val(),
                filas:$("#s_filas_"+'listarexamens').val(),
                _Exa_IdExamen: _id_examen,
                _Exa_Estado: _estado
              },
          function(data) {
              $("#listarexamens").html('');
              $("#cargando").hide();
              $("#listarexamens").html(data);
              // mensaje(JSON.parse(data));
              // Select all elements with data-toggle="tooltips" in the document
              $('[data-toggle="tooltip"]').tooltip(); 
          });
        }
    });
    $("body").on('click', '.confirmar-eliminar-examen', function() {
        
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_examen = $(this).attr("id_examen");
        if (_id_examen === undefined) {
            _id_examen = 0;
        }

        _Mod_Idexamen_ = _id_examen;
        _Row_Estado_ = 0;
    });
    $("body").on('click', '.confirmar-habilitar-examen', function() {
        $("#cargando").show();
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_examen = $(this).attr("id_examen");
        if (_id_examen === undefined) {
            _id_examen = 0;
        }

        _Mod_Idexamen_ = _id_examen;
        _Row_Estado_ = 1;
        
        _post = $.post(_root_ + 'elearning/examen/_eliminar_examen',
                {                    
                    _Exa_IdExamen: _Mod_Idexamen_,
                    _Row_Estado: _Row_Estado_,
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabraexamen").val(),
                    filas:$("#s_filas_"+'listarexamens').val(),
                    idcurso: $("#hidden_curso").val(),
                    _Lec_IdLeccion: $("#hidden_leccion").val()
                    
                },
        function(data) {
            $("#listarexamens").html('');
            $("#cargando").hide();
            $("#listarexamens").html(data);
            // Select all elements with data-toggle="tooltips" in the document
            $('[data-toggle="tooltip"]').tooltip(); 
        });
    });
    $("body").on('click', '.eliminar_examen', function() {
        $("#cargando").show();
        // _Per_IdPermiso = _eliminar;
        _post = $.post(_root_ + 'elearning/examen/_eliminar_examen',
                {                    
                    _Exa_IdExamen: _Mod_Idexamen_,
                    _Row_Estado: _Row_Estado_,
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabraexamen").val(),
                    filas:$("#s_filas_"+'listarexamens').val(),
                    idcurso: $("#hidden_curso").val(),
                    _Lec_IdLeccion: $("#hidden_leccion").val()
                    
                },
        function(data) {
            $("#listarexamens").html('');
            $("#cargando").hide();
            $("#listarexamens").html(data);
            // Select all elements with data-toggle="tooltips" in the document
            $('[data-toggle="tooltip"]').tooltip(); 
        });
    });
    $("body").on('click', '.estado-pregunta', function() {
        _estado = $(this).attr("estado");
        if (_estado === undefined) {
            _estado = 0;
        }
        if (!_estado) {
            _estado = 0;
        }
        // alert($("#puntos").val());
        // alert($(this).attr("Pre_Puntos"));
        if ((parseInt($("#puntos").val()) > 0 && parseInt($(this).attr("Pre_Puntos")) <= parseInt($("#puntos").val())) || _estado == 1) {
            $("#cargando").show();
            if (_post && _post.readyState != 4) {
                _post.abort();
            }

            _id_pregunta = $(this).attr("id_pregunta");
            if (_id_pregunta === undefined) {
                _id_pregunta = 0;
            }

            _post = $.post(_root_ + 'elearning/examen/_cambiarEstadopreguntas',
                    {                    
                        _Mod_Idpregunta: _id_pregunta,
                        _Mod_Estado: _estado,
                        idcurso: $("#idcurso").val(),
                        pagina: $(".pagination .active span").html(),
                        palabra: $("#palabrapregunta").val(),
                        filas:$("#s_filas_"+'listarpreguntas').val(),
                        idexamen:$("#idexamen").val()
                    },
            function(data) {
                $("#listarpreguntas").html('');
                $("#cargando").hide();
                $("#listarpreguntas").html(data);
                // mensaje(JSON.parse(data));
                // Select all elements with data-toggle="tooltips" in the document
                $('[data-toggle="tooltip"]').tooltip(); 
            });
        } else {
            if (parseInt($("#puntos").val()) == 0) { 
                mensaje([["error", ` ${LANG_UTILS_VIEW.elearning_cursos_alcanzado_todos_puntos_peso_registrados} `]]);
            } else {
                if (parseInt($(this).attr("Pre_Puntos")) > parseInt($("#puntos").val())) { 
                    mensaje([["error", ` ${LANG_UTILS_VIEW.elearning_cursos_puntaje_pregunta_supera_habilitar} `]]);
                }                
            }
        }
    });

    $("body").on('click', '.confirmar-eliminar-pregunta', function() {
        
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_pregunta = $(this).attr("id_pregunta");
        if (_id_pregunta === undefined) {
            _id_pregunta = 0;
        }

        _Mod_Idpregunta_ = _id_pregunta;
        _Row_Estado_ = 0;
    });
    $("body").on('click', '.confirmar-habilitar-pregunta', function() {
        $("#cargando").show();
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_pregunta = $(this).attr("id_pregunta");
        if (_id_pregunta === undefined) {
            _id_pregunta = 0;
        }

        _Mod_Idpregunta_ = _id_pregunta;
        _Row_Estado_ = 1;
        
        _post = $.post(_root_ + 'elearning/examen/_eliminar_pregunta',
                {                    
                    _Mod_Idpregunta: _Mod_Idpregunta_,
                    _Row_Estado: _Row_Estado_,
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabrapregunta").val(),
                    filas:$("#s_filas_"+'listarpreguntas').val(),
                    idexamen:$("#idexamen").val()
                },
        function(data) {
            $("#listarpreguntas").html('');
            $("#cargando").hide();
            $("#listarpreguntas").html(data);
            // Select all elements with data-toggle="tooltips" in the document
            $('[data-toggle="tooltip"]').tooltip(); 
        });
    });
    $("body").on('click', '.eliminar_pregunta', function() {
        $("#cargando").show();
        // _Per_IdPermiso = _eliminar;
        _post = $.post(_root_ + 'elearning/examen/_eliminar_pregunta',
                {                    
                    _Mod_Idpregunta: _Mod_Idpregunta_,
                    _Row_Estado: _Row_Estado_,
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabrapregunta").val(),
                    filas:$("#s_filas_"+'listarpreguntas').val(),
                    idexamen:$("#idexamen").val()
                },
        function(data) {
            $("#listarpreguntas").html('');
            $("#cargando").hide();
            $("#listarpreguntas").html(data);
            // Select all elements with data-toggle="tooltips" in the document
            $('[data-toggle="tooltip"]').tooltip(); 
        });
    });


    // EXAMEN_ALUMNO======================================================

    $("body").on('click', '.estado-examen-alumno', function() {
        _estado = $(this).attr("estado");
        if (_estado === undefined) {
            _estado = 0;
        }
        if (!_estado) {
             _estado = 0;
        }

        $("#cargando").show();
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_examen = $(this).attr("id_examen_alumno");
        if (_id_examen === undefined) {
            _id_examen = 0;
        }

        _post = $.post(_root_ + 'elearning/examen/_cambiarEstadoExamenAlumno',
            {                    
                idcurso: $("#idcurso").val(),
                _Lec_IdLeccion: $("#hidden_leccion").val(),
                pagina: $(".pagination .active span").html(),
                palabra: $("#palabraExamenAlumno").val(),
                filas:$("#s_filas_"+'listarExamensAlumno').val(),
                _Exl_IdExamenAlumno: _id_examen,
                _Exl_Estado: _estado
            },
        function(data) {
            $("#listarExamensAlumno").html('');
            $("#cargando").hide();
            $("#listarExamensAlumno").html(data);
          // mensaje(JSON.parse(data));
          // Select all elements with data-toggle="tooltips" in the document
            $('[data-toggle="tooltip"]').tooltip(); 
        });
    });



});


function buscarpregunta(criterio, idexamen) {
    $("#cargando").show();
    $.post(_root_ + 'elearning/examen/_buscarpregunta',
    {
        palabra:criterio,
        idexamen:idexamen
        
    }, function (data) {
        $("#listarpreguntas").html('');
        $("#cargando").hide();
        $("#listarpreguntas").html(data);
    });
}

function buscarexamen(criterio, idcurso, idleccion=0) {
    $("#cargando").show();
    $.post(_root_ + 'elearning/examen/_buscarexamens',
    {
        palabra:criterio,
        idcurso:idcurso,
        _Lec_IdLeccion:idleccion
        
    }, function (data) {
        $("#listarexamens").html('');
        $("#cargando").hide();
        $("#listarexamens").html(data);
    });
}

function buscarExamenAlumno(criterio, Exl_IdExamenAlumno=0) {
    $("#cargando").show();
    $.post(_root_ + 'elearning/examen/_buscarexamensAlumno',
    {
        palabra:criterio,
        idcurso:$("#idcurso").val(),
        _Exl_IdExamenAlumno:$("#Exl_IdExamenAlumno").val()
        
    }, function (data) {
        $("#listarExamensAlumno").html('');
        $("#cargando").hide();
        $("#listarExamensAlumno").html(data);
    });
}

function gestionIdiomas(idrol, idIdiomaOriginal, idIdioma) {
    $("#cargando").show();
    $.post(base_url('elearning/examen/editarexamen_gestion_idiomas'),
            {
                curso_id: $('#idcurso').val(),        
                examen_id: $('#examen_id').val(),        
                idioma_id: idIdioma,
                idioma_original_id: idIdiomaOriginal
            }, function (data) {
        $("#replace_contenido").html('');
        $("#cargando").hide();
        $("#replace_contenido").html(data);
        $('form').validator();
    });
}

$("#btn_añadir1").click(function(){
    if(contadorinputs<6){
        // var campo = "<div><div class='col-lg-10'><input placeholder='Alternativa' class='form-control margin-t-10' name='alt"+nextinput+"' id='alt"+nextinput+"'/></div><div class='col-lg-1'><input type='radio' value='"+nextinput+"' class='radioalt margin-t-10' name='valor_preg'/></div><div class='col-lg-1'><button class='btn btn-danger glyphicon pull-right margin-t-10 glyphicon-minus' class='btn_quitar' id='btn_quitar"+nextinput+"'></button></div></div>";
        let campo = makeTemplate('tpl-campo-add1', {
            nextinput: nextinput
        })
        // var campo = "<div class='col-lg-11'><input placeholder='Alternativa "+nextinput+"' class='form-control margin-t-10' name='alt"+nextinput+"' id='alt"+nextinput+"'/></div><div class='col-lg-1'><input type='radio' value='"+nextinput+"' class='radioalt margin-t-10' name='valor_preg'/></div>";
        $("#alt").append(campo);
        nextinput++;
        contadorinputs++;
        $("#contador").val(contadorinputs);
        $("#nextinput").val(nextinput);
        // Select all elements with data-toggle="tooltips" in the document
        $('[data-toggle="tooltip"]').tooltip(); 
    }
});

$("#btn_añadir2").click(function(){
    if(contadorinputs<6){
        // var campo = "<div><div class='col-lg-10'><input placeholder='Alternativa' class='form-control margin-t-10' name='alt"+nextinput+"' id='alt"+nextinput+"'/></div><div class='col-lg-1'><input type='radio' value='"+nextinput+"' class='radioalt margin-t-10' name='valor_preg'/></div><div class='col-lg-1'><button class='btn btn-danger glyphicon pull-right margin-t-10 glyphicon-minus' class='btn_quitar' id='btn_quitar"+nextinput+"'></button></div></div>";
        let campo = makeTemplate('tpl-campo-add2', {
            nextinput: nextinput
        })
        // var campo = "<div class='col-lg-11'><input placeholder='Alternativa "+nextinput+"' class='form-control margin-t-10' name='alt"+nextinput+"' id='alt"+nextinput+"'/></div><div class='col-lg-1'><input type='radio' value='"+nextinput+"' class='radioalt margin-t-10' name='valor_preg'/></div>";
        $("#alt").append(campo);
        nextinput++;
        contadorinputs++;
        $("#contador").val(contadorinputs);
        $("#nextinput").val(nextinput);
        // Select all elements with data-toggle="tooltips" in the document
        $('[data-toggle="tooltip"]').tooltip(); 
    }
});

$("#btn_añadir4").click(function(){
    // var campo = "<div><div class='col-lg-10'><input placeholder='Alternativa' class='form-control margin-t-10' name='alt"+nextinput+"' id='alt"+nextinput+"'/></div><div class='col-lg-1'><input type='radio' value='"+nextinput+"' class='radioalt margin-t-10' name='valor_preg'/></div><div class='col-lg-1'><button class='btn btn-danger glyphicon pull-right margin-t-10 glyphicon-minus' class='btn_quitar' id='btn_quitar"+nextinput+"'></button></div></div>";
    if(contadorinputs<6){
        let campo = makeTemplate('tpl-campo-add4', {
            nextinput: nextinput
        })
    // var campo = "<div class='col-lg-11'><input placeholder='Alternativa "+nextinput+"' class='form-control margin-t-10' name='alt"+nextinput+"' id='alt"+nextinput+"'/></div><div class='col-lg-1'><input type='radio' value='"+nextinput+"' class='radioalt margin-t-10' name='valor_preg'/></div>";
        $("#alt").append(campo);
        nextinput++;
        contadorinputs++;
        $("#contador").val(contadorinputs);
        $("#nextinput").val(nextinput);
    // Select all elements with data-toggle="tooltips" in the document
        $('[data-toggle="tooltip"]').tooltip(); 
    }
});

$("#alt").on('click', '.remove_button', function(e){ //Once remove button is clicked
    e.preventDefault();
    nextinput--;
    contadorinputs--;
    $("#contador").val(contadorinputs);
    $("#nextinput").val(nextinput);
    $(this).parent('div').parent('div').remove(); //Remove field html //Decrement field counter
    
    $('[data-toggle="tooltip"]').tooltip(); 
});
