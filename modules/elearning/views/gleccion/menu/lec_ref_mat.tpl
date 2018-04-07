<style>
  .item-referencia{
    position: relative;
    margin-bottom: 10px;
    border-bottom: 1px solid #ddd;
  }
  .btnEliminar{
    position: absolute; top: 0px; right: 0px;
  }
  .cortar{
    width:98%;
    height:auto;
    padding:2%;
    text-overflow:ellipsis;
    white-space:nowrap;
    overflow:hidden;
  }
  .cortar:hover {
    width: auto;
    white-space: initial;
    overflow:visible;
    cursor: pointer;
    background-color: whitesmoke;
    z-index: 9999;
  }
</style>
<div class="col-lg-3">
  <div class="panel panel-default margin-top-10">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Referencias</strong>
      </h3>
    </div>
    <div class="panel-body">
      {if isset($referencias) && count($referencias) > 0 }
        {foreach from=$referencias item=r}
          <div class="item-referencia">
            <input class="Hidden_IdReferencia" hidden="hidden" value="{$r.Ref_IdReferencia}" />
            <strong>{$r.Ref_Titulo}</strong>
            <div class="cortar">{$r.Ref_Descripcion}</div>
            <button class="btnEliminar"><i class="glyphicon glyphicon-trash"></i></button>
          </div>
        {/foreach}
      {else}
        <div>No tienes referencias</div>
      {/if}
      <button class="btn btn-default" id="btn_agregar_referencia">Agregar</button>
    </div>
  </div>

  <div class="panel panel-default margin-top-10">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Material Didáctico</strong>
      </h3>
    </div>
    <div class="panel-body">
      {if isset($material) && count($material) > 0 }
        {foreach from=$material item=r}
          <div class="item-referencia">
            <input class="Hidden_IdMaterial" hidden="hidden" value="{$r.Mat_IdMaterial}" />
            <input class="Hidden_IdEnlace" hidden="hidden" value="{$r.Mat_Enlace}" />
            <button class="btnAbrirEnlace">Abrir</button>
            <strong>{substr($r.Mat_Descripcion, 0, 10)}...</strong>
            <button class="btnEliminarMaterial"><i class="glyphicon glyphicon-trash"></i></button>
          </div>
        {/foreach}
      {else}
        <div>No tienes material didáctico</div>
      {/if}
      <button class="btn btn-default" id="btn_agregar_material">Agregar</button>
    </div>
  </div>
</div>

{include file='modules/elearning/views/uploader/uploader.tpl'}

<div class="modal fade" id="panelNuevaReferencia" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-xs">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Agregar Referencia</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body">
        <form id="frm_registro_referencia" method="post" action="gleccion/_registrar_referencia">
          <div class="col-lg-12 margin-top-10"><strong>Titulo</strong></div>
          <input hidden="hidden" value="{$leccion.Lec_IdLeccion}" name="leccion"/>
          <div class="col-lg-12"><input class="form-control" name="titulo" id="inTituloRef" /></div>
          <div class="col-lg-12 margin-top-10"><strong>Referencia</strong></div>
          <div class="col-lg-12"><input class="form-control" name="descripcion" id="inDescripcionRef" /></div>
          <div class="col-lg-12 margin-top-10"><button class="btn btn-success" id="btn_registrar_referencia">Registrar</button></div>
        <form>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="panelNuevoMaterial" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-focus-on="input:first">
  <div class="modal-dialog modal-xs">
    <div class="panel">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Agregar Matirial Didáctico</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body">
        <div class="col-lg-12"><input type="radio" value="0" checked="checked" name="opcion" id="inlopcionmat"/> Enlace a documento</div>
          <div class="col-lg-12"><strong>Link</strong></div>
          <form id="frm_registro_material" method="post" action="gleccion/_registrar_material_link">
          <div class="col-lg-12"><input class="form-control" name="link" id="inMatLink" /></div>
          <div class="col-lg-12 margin-top-10"><strong>Descripción</strong></div>
          <div class="col-lg-12"><textarea class="form-control" name="descripcion" id="inMatLinkDescripcion"></textarea></div>
          <div class="col-lg-12 margin-top-10"><button class="btn btn-success pull-right" id="btn_registrar_material_link">Guardar</button></div>
        <form>
        <div class="col-lg-12 margin-top-10"><input type="radio" value="1" name="opcion"/>Archivo local</div>
        <div class="col-lg-12 margin-top-10"><button class="btn btn-success" id="btn_registrar_material_file" disabled="disabled">Subir archivo</button></div>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="panelNuevoMaterialArchivo" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-focus-on="input:first">
  <div class="modal-dialog modal-xs">
    <div class="panel">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Agregar Archivos</strong>
      </div>
      <div class="panel-body">
        <div class="col-lg-12" id="contenido-material-archivo">
        </div>
        <div class="col-lg-6 margin-top-10">
          <button class="btn btn-success" id="btn_registrar_material_file2">Guardar material</button>
        </div>
        <div class="col-lg-6 margin-top-10">
          <button class="btn btn-success pull-right" id="btn_cancelar_material_file">Cancelar</button>
        </div>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  $("#btn_registrar_material_link").click(function(){
    var Link = $("#inMatLink").val();
    var Descripcion = $("#inMatLinkDescripcion").val();
    var Leccion =  $("#hidden_leccion").val();

    if(Link.length==0){
      Mensaje("Ingrese el link", function(){
        $("#inMatLink").focus();
      });
      return;
    }
    if(Descripcion.length==0){
      Mensaje("Ingrese el link", function(){
        $("#inMatLinkDescripcion").focus();
      });
      return;
    }
    $.fn.Mensaje({
      mensaje: "¿Desea guardar el material?",
      tipo: "SiNo",
      funcionSi: function(){
        var params = { tipo: 1, url: Link, leccion: Leccion, descripcion: Descripcion };
        AsincTaks("gleccion/_registrar_material", params, function(a){
          $("#panelNuevoMaterialArchivo").modal("hide");

          setTimeout(function(){
            Mensaje("Material registrado", function(){
              CargarPagina("gleccion/_view_leccion", {
                curso: $("#hidden_curso").val(),
                modulo : $("#hidden_modulo").val(),
                leccion : $("#hidden_leccion").val(),
              }, false, false);
            });
          }, 300);
        });
      }
    });
  });

  $("#btn_agregar_referencia").click(function(){
    $("#panelNuevaReferencia").modal("show");
    $("#inTituloRef").focus();
  });
  $("#btn_registrar_referencia").click(function(e){
    e.preventDefault();
    if( $("#inTituloRef").val().toString().length==0 ){
      Mensaje("Ingrese datos", function(){
        $("#inTituloRef").focus();
      });
      return;
    }
    if( $("#inDescripcionRef").val().toString().length==0 ){
      Mensaje("Ingrese datos", function(){
        $("#inDescripcionRef").focus();
      });
      return;
    }
    $.fn.Mensaje({ mensaje: "¿Desea registrar esta referencia?", tipo: "SiNo",
      funcionSi: function(){
        SubmitForm($("#frm_registro_referencia"), $(this), function(data, e){
          CargarPagina("gleccion/_view_leccion", {
            curso: $("#hidden_curso").val(),
            modulo : $("#hidden_modulo").val(),
            leccion : $("#hidden_leccion").val()
          }, false, false);
        });
      }
    });
  });
  $(".btnAbrirEnlace").click(function(){
    var Link = $("#hidden_root").val() + "gleccion/_contenido/_material/";
    Link += $(this).parent().find(".Hidden_IdEnlace").val();

    var a = document.createElement("a");
		a.target = "_blank";
		a.href =  Link;
		a.click();
  });

  $(".btnEliminar").click(function(){
    var IdRef = $(this).parent().find(".Hidden_IdReferencia").val();
    $.fn.Mensaje({ mensaje: "¿Seguro de quitar esta referencia?", tipo: "SiNo",
      funcionSi: function(){
        AsincTaks("gleccion/_eliminar_referencia", { id : IdRef }, function(a){
          CargarPagina("gleccion/_view_leccion", {
            curso: $("#hidden_curso").val(),
            modulo : $("#hidden_modulo").val(),
            leccion : $("#hidden_leccion").val(),
          }, false, false);
        }, null);
      }
    });
  });


  $(".btnEliminarMaterial").click(function(){
    var IdMat = $(this).parent().find(".Hidden_IdMaterial").val();
    $.fn.Mensaje({ mensaje: "¿Seguro de quitar este material adjunto?", tipo: "SiNo",
      funcionSi: function(){
        AsincTaks("gleccion/_eliminar_material", { id : IdMat }, function(a){
          CargarPagina("gleccion/_view_leccion", {
            curso: $("#hidden_curso").val(),
            modulo : $("#hidden_modulo").val(),
            leccion : $("#hidden_leccion").val(),
          }, false, false);
        }, null);
      }
    });
  });
  $("#btn_agregar_material").click(function(){
    $("#panelNuevoMaterial").modal("show");
  });
  $("input[name=opcion]").change(function(){
    var Value = $(this).val();
    if(Value==1){
      $("#inMatLink").prop("disabled", true);
      $("#inMatLinkDescripcion").prop("disabled", true);
      $("#btn_registrar_material_link").prop("disabled", true);
      $("#btn_registrar_material_file").prop("disabled", false);
    }else{
      $("#inMatLink").prop("disabled", false);
      $("#inMatLinkDescripcion").prop("disabled", false);
      $("#btn_registrar_material_link").prop("disabled", false);
      $("#btn_registrar_material_file").prop("disabled", true);


      $("#inMatLink").focus();
    }
  });

  $("#btn_registrar_material_file").click(function(e){
    e.preventDefault();
    $("#panelNuevoMaterial").modal("hide");
    setTimeout(function(){

      var params = {
        route: "modules/elearning/views/gleccion/_contenido/_material",
        pre: $("hidden_leccion").val()
      };
      InitUploader(function(a){
        var DATA = JSON.parse(a);
        $("#panelNuevoMaterialArchivo").modal("show");
        var contenedor = $("#contenido-material-archivo");
        contenedor.html("");
        contenedor.append("<label>Archivos</label>");

        var datos = '[';
        DATA.data.forEach(function(row){
          var tmp = row.url.split('\\');
          tmp = tmp[tmp.length-1];
          tmp = row.url.split('/');
          tmp = tmp[tmp.length-1];

          datos += '{ "url":"' + tmp + '"},';
        });
        datos = datos.substring(0, datos.length-1);
        datos += "]";

        contenedor.append("<input value='" + datos + "' id='tmp-archivo-local-url' hidden='hidden'/>");
        DATA.data.forEach(function(row){
          var tmp = row.url.split('\\');
          tmp = tmp[tmp.length-1];
          tmp = tmp.split('-');
          tmp = tmp[tmp.length-1];

          var texto =  "<input class='form-control margin-top-10' value='" + tmp + "' disabled='disabled'/>";
          contenedor.append(texto);
        });
        contenedor.append("<label class='margin-top-10'>Descripción</label>");
        contenedor.append("<input class='form-control' id='in_tmp_mat_arch'/>");

        setTimeout(function(){ $("#in_tmp_mat_arch").focus(); }, 300);
      }, params);
    }, 300);
  });

  $("#btn_cancelar_material_file").click(function(){
    $("#panelNuevoMaterialArchivo").modal("hide");
  });
  $("#btn_registrar_material_file2").click(function(){
    var data = $("#tmp-archivo-local-url").val();
    var descripcion = $("#in_tmp_mat_arch").val();
    var Tipo = 2;
    var leccion = $("#hidden_leccion").val();

    if(descripcion.length==0){
      Mensaje("Ingrese alguna descripción", function(){
        $("#in_tmp_mat_arch").focus();
      });
      return;
    }

    $.fn.Mensaje({
      mensaje: "¿Desea guardar el material?",
      tipo: "SiNo",
      funcionSi: function(){
        var params = { tipo: Tipo, url: data, leccion: leccion, descripcion: descripcion };
        AsincTaks("gleccion/_registrar_material", params, function(a){
          $("#panelNuevoMaterialArchivo").modal("hide");
          setTimeout(function(){
            Mensaje("Material registrado", function(){
              CargarPagina("gleccion/_view_leccion", {
                curso: $("#hidden_curso").val(),
                modulo : $("#hidden_modulo").val(),
                leccion : $("#hidden_leccion").val()
              }, false, false);
            });
          }, 300);
        }, false, false);
      }
    });
  });
</script>
