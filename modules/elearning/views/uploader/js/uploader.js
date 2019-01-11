function validate(data, validator){
  var validate = true;
  var formats = (validator.format || "").toUpperCase().split(",");
  var files = validator.files || 1;
  var maxSize = validator.maxSize || 1;
  var maxByteSize = maxSize*1024*1024;
  var archivos = [];
  for(var item of data.entries()){
    if(item[0]!="route"){
      archivos.push(item[1]);
    }
  }
  if(files < archivos.length){
    validator.error = "Solo puedes subir " + files.toString() + " archivo(s)";
    validate = false;
  }
  archivos.forEach(function(file){
    if( parseInt(maxByteSize) < parseInt(file.size)){
      validator.error = "El peso máximo de los <br/> archivos es " + maxSize.toString() + " MB(s)";
      validate = false;
    }else{
      var tmp_name = file.name.split(".");
      tmp_name = tmp_name[tmp_name.length - 1].toUpperCase();
      if(formats.length>0 && formats[0].length > 0){
        if(!formats.includes(tmp_name)){
          var msn = (validator.format || "").replace(/,/g, ", ");
          validator.error = "Los archivos deben tener formato: " + msn;
          validate = false;
        }
      }
    }
  });
  return validate;
}

function InitUploader(post, params){
  var CONTENEDOR = $('.box');
  var INPUT = CONTENEDOR.find('.box__file');
  var LABEL = CONTENEDOR.find('label');
  var ERROR_MSG = CONTENEDOR.find('.box__error span');
  var RESTART = CONTENEDOR.find('.box__restart');
  var BUTTON = CONTENEDOR.find(".box__button");
  var ARCHIVOS = false;

  var route = params.route || "";

  $("#hidden-uploader-route").val(route);
  //alert(route);
  jQuery.event.props.push('dataTransfer');
  var isAdvancedUpload = function(){
    var div = document.createElement('div');
    return ( ( 'draggable' in div ) || ( 'ondragstart' in div && 'ondrop' in div ) ) && 'FormData' in window && 'FileReader' in window;
  }();

  if ( isAdvancedUpload ){
    CONTENEDOR.addClass('has-advanced-upload');

    ['drag','dragstart','dragend','dragover','dragenter','dragleave','drop'].forEach(function(event){
      CONTENEDOR.on(event, function(e){
        e.preventDefault(); e.stopPropagation();
      });
    });
    ['dragover', 'dragenter'].forEach(function(event){
      CONTENEDOR.on(event, function(){
        CONTENEDOR.addClass('is-dragover');
        LABEL.html("Suelte los archivos aquí");
      });
    });
    ['dragleave', 'dragend', 'drop'].forEach(function(event){
      CONTENEDOR.on(event, function(){
        CONTENEDOR.removeClass('is-dragover');
        LABEL.html("<center><strong>Seleccione un archivo</strong>"+
                  "<span class='box__dragndrop'> o arrastre aquí</span>.</center>");
      });
    });
    CONTENEDOR.on('drop', function(e){
      ARCHIVOS = e.dataTransfer.files;
      $.each(ARCHIVOS, function(index, file){
        LABEL.html(file.name);
      });
    });
    INPUT.change(function(e){
      e.preventDefault();
      if($(this).val()!="" && $(this).val()!=null){
        LABEL.html(INPUT.val());
      }
    });
    BUTTON.click(function(e){
      e.preventDefault();

      var formulario = document.getElementById("frm-load-file");
      var input = formulario.querySelector('input[type="file"]');
      var ajaxData = new FormData(formulario);

      $.each(ARCHIVOS, function(index, file){
        ajaxData.append(input.getAttribute('name'), file);
      });

      if(!ARCHIVOS && $("#file").val().toString().length==0){
        $.fn.Mensaje({ mensaje: "Seleccione un archivo", tamano: "sm" });
        return;
      }

      if( params.validator != null){
        if( !validate(ajaxData, params.validator) ){
          var mensaje = params.validator.error || "Los datos no cumplen los parametros establecidos";
          $.fn.Mensaje({ mensaje: mensaje, tamano: "sm" });
          return;
        }
      }

      $(".box__input").hide();
      $(".box__uploading").show();
      // alert(ajaxData);
      $.ajax({
        url: _root_ + "elearning/uploader/post",
        data: ajaxData,
        processData: false,
        contentType: false,
        type: "post",
        success: function(a){
          setTimeout(function(){
            $("#panel-uplader").modal("hide");
            $(".box__uploading").hide();
            $(".box__success").show();
            setTimeout(function(){
              if(post!=null){ post(a); }

              $("#file").val();
              LABEL.html("<center><strong>Seleccione un archivo</strong>"+
                        "<span class='box__dragndrop'> o arrastre aquí</span>.</center>");
              $(".box__input").show();
              $(".box__success").hide();
              $(".box__uploading").hide();
              $(".box__error").hide();
            }, 400);
          }, 600);
        },
        error: function(e){
          alert(e);
          $(".box__uploading").hide();
          $(".box__error").show();
        }
      });
      ARCHIVOS = false;
    });
    INPUT.on('blur', function(){ INPUT.removeClass('has-focus'); });
  }
  $("#panel-uplader").modal("show");
}
