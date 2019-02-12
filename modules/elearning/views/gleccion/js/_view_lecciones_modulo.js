// Menu(1);
RefreshTagUrl();
$(document).on('ready', function () { 

    // Jhon Martinez
    $("body").on('click', "#item_modulo", function (e) {
    // $("#item_modulo").click(function() {
      e.preventDefault();
      $(this).removeClass("active");
      $("#item_lecciones").removeClass("active"); 
      // $(this).css('font-weight', 'bold');
      $(this).addClass("active");
      $('.div_modulo').css('display', 'block');
      $('.div_lecciones').css('display', 'none');
    });
    $("body").on('click', "#item_lecciones", function (e) {
    // $("#item_lecciones").click(function() {
      e.preventDefault();
      $(this).removeClass("active");
      $("#item_modulo").removeClass("active");
      // $(this).css('font-weight', 'bold');
      $(this).addClass("active");
      $('.div_lecciones').css('display', 'block');
      $('.div_modulo').css('display', 'none');
    });

    $("body").on('click', "#btn_nueva_leccion", function (e) {
    // $("#btn_nueva_leccion").click(function(){
      e.preventDefault();
      if($(this).html()=="Cancelar"){
        $("#panelNuevaLeccion").hide(100);
        $('html, body').animate({
              scrollTop: $(document).height()
          }, 800);
        $(this).html("<i class='glyphicon glyphicon-book'></i> Nueva Lección");
      }else{
        $("#panelNuevaLeccion").removeClass("fade").show(200);
        $('html, body').animate({
              scrollTop: 2000
          }, 800);
        $("#inTitulo").focus();

        $(this).html("Cancelar");
      }
      $("input[name=titulo]").val("");
      $("input[name=descripcion]").val("");
    });

    $("body").on('click', "#btn_guardar_leccion", function (e) {
    // $("#btn_guardar_leccion").click(function(e){
      e.preventDefault();
      SubmitForm($("#frm_registro"), $(this), function(data, event){
        Mensaje("Lección registrada con éxito", function(){
          location.href = _root_ + _modulo + "/gleccion/_view_lecciones_modulo/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val();
          // CargarPagina("gleccion/_view_lecciones_modulo", { id: $("#hidden_modulo").val() }, false, false);
        })
      });
    }); 

    $("body").on('click', ".btnFinalizarReg", function (e) {
    // $(".btnFinalizarReg").click(function(){
      e.preventDefault();
      var IdLeccion = $(this).parent().find(".hidden_IdLeccion").val();
      $("#hidden_leccion").val(IdLeccion);
      location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + IdLeccion;
      // CargarPagina("gleccion/_view_leccion", {
      //   curso: $("#hidden_curso").val(),
      //   modulo : $("#hidden_modulo").val(),
      //   leccion : IdLeccion,
      // }, false, false);
    });

    // $(".btnExamen").click(function(){
    //   var Curso = $(this).parent().find(".hidden_IdCurso").val();
    //   var Link = $("#hidden_url").val() + "examen/examens/" + Curso;
    //   location.href = Link;
    // });

    $("body").on('click', ".btnEliminar", function (e) {
    // $(".btnEliminar").click(function(){
      e.preventDefault();
      var IdLeccion = $(this).parent().find(".hidden_IdLeccion").val();

      $.fn.Mensaje({
        mensaje: "¿Esta seguro de eliminar esta lección?",
        tipo: "SiNo",
        funcionSi: function(){
          AsincTaks("gleccion/_eliminar_leccion", { id : IdLeccion }, function(a){
            setTimeout(function(){
                Mensaje("Se Eliminó la Lección", function(){
                  location.href = _root_ + _modulo + "/gleccion/_view_lecciones_modulo/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val();
                    // CargarPagina("gleccion/_view_lecciones_modulo", {}, false, false);
                }, "Alerta", "alert");
            }, 300); 
            // CargarPagina("gleccion/_view_lecciones_modulo", {}, false, false);
          }, null);
        }
      });
    });
    $("body").on('click', ".btnDeshabilitar", function (e) {
    // $(".btnDeshabilitar").click(function(){
      e.preventDefault();
      var IdLeccion = $(this).parent().find(".hidden_IdLeccion").val();
      ToggleEstado(IdLeccion, "0");
    });
    $("body").on('click', ".btnHabilitar", function (e) {
    // $(".btnHabilitar").click(function(){
      e.preventDefault();
      var IdLeccion = $(this).parent().find(".hidden_IdLeccion").val();
      ToggleEstado(IdLeccion, "1");
    });
    $("body").on('click', "#btn_actualizar_modulo", function (e) {
    // $("#btn_actualizar_modulo").click(function(e){
      e.preventDefault();
      SubmitForm($("#frm-act-modulo"), $(this), function(data, event){
        Mensaje("Datos actualizados", function(){
          location.href = _root_ + _modulo + "/gleccion/_view_lecciones_modulo/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val();
          // CargarPagina("gleccion/_view_lecciones_modulo", { id: $("#hidden_modulo").val() }, false, false);
        });
      });
    });
    $("body").on('click', ".idioma_s", function (e) {
        e.preventDefault();
        var id = $(this).attr("id");
        var idIdioma = $("#hd_" + id).val();
        gestionIdiomas($("#hidden_modulo").val(), $("#IdiomaOriginal").val(), idIdioma);
        // buscar($("#palabra").val(), $("#buscarTipo").val(), $("#idPadreIdiomas").val(),idIdioma);
        
    }); 
});

function gestionIdiomas(Moc_IdModuloCurso, idIdiomaOriginal, idIdioma) {
    $("#cargando").show();
    $.post(_root_  + _modulo + '/gleccion/gestion_idiomas',
            {
                idIdioma: idIdioma,
                Moc_IdModuloCurso: Moc_IdModuloCurso,
                idIdiomaOriginal: idIdiomaOriginal
            }, function (data) {
        $("#gestion_idiomas").html('');
        $("#cargando").hide(); 
        $("#gestion_idiomas").html(data);

        // cargarCKeditor();
        // $('textarea#editor1').ckeditor();
        // $('form').validator();
    });
}

function ToggleEstado(IdLeccion, _estado){
  AsincTaks("gleccion/_estado_leccion", { id : IdLeccion, estado : _estado }, function(a){
    var result = JSON.parse(a);
    if (_estado == 1) {
      var _mensaje = "La lección ha sido Habilitado...!!!";
      var _icon = "info-sign";
    } else {
      var _mensaje = "La lección ha sido Deshabilitado...!!!";
      var _icon = "exclamation-sign";
    }
    setTimeout(function(){
      if(result.estado == 1){
        Mensaje(_mensaje, function(){
          location.href = _root_ + _modulo + "/gleccion/_view_lecciones_modulo/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val();
            // CargarPagina("gleccion/_view_lecciones_modulo", {}, false, false);
        }, "",_icon);
      }else{
        Mensaje(result.mensaje, null);
      }
    }, 300); 
  });
}


