// Menu(1);
// RefreshTagUrl();

$("body").on('click', '.estado-examen', function() {
  _estado = $(this).attr("estado");
  if (_estado === undefined) {
      _estado = 0;
  }
  if (!_estado) {
      _estado = 0;
  }

  if (_estado == 0) {
    if ($("#habilitados").val() < 1) {
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
            _idcurso: $("#hidden_curso").val(),
            _Lec_IdLeccion: $("#hidden_leccion").val(),
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
      mensaje([["error"," Solo se puede habilitar un examen por lección...!! "]]);
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
            _idcurso: $("#hidden_curso").val(),
            _Lec_IdLeccion: $("#hidden_leccion").val(),
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
