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
  .item-arch-adj{
    border: 1px solid black;
    margin-bottom: 10px;
    padding: 10px;
    border-radius: 5px;
    position: relative;
  }
  .btnElimArcAdj{
    position: absolute;
    top: 7px;
    right: 7px;
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

  {if ($curso.Mod_IdModCurso==2)}

  <div class="panel panel-default margin-top-10">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Tareas</strong>
      </h3>
    </div>
    <div class="panel-body">
      {if count($trabajo)}
        {$index = 1}
        {foreach from=$trabajo item=t}
          <div class="item-trabajo">
            <input class="Hidden_IdTrabajo" hidden="hidden" value="{$t.Tra_IdTrabajo}" />
            <input class="Hidden_Estado" hidden="hidden" value="{$t.Tra_Estado}" />
            <strong>Tarea {$index}</strong>
            <button class="btnEditarTrabajo"><i class="glyphicon glyphicon-edit"></i></button>
            <button class="btnActivarTrabajo">
              {if $t.Tra_Estado == '1' }
              <i class="glyphicon glyphicon-remove"></i>
              {else}
              <i class="glyphicon glyphicon-ok"></i>
              {/if}
            </button>
            <button class="btnEliminarTrabajo"><i class="glyphicon glyphicon-trash"></i></button>
          </div>
          {$index = $index + 1}
        {/foreach}
      {else}
        <div>No se ha registrado trabajos</div>
      {/if}
      <br/>
      <button class="btn btn-default" id="btn_agregar_trabajo">Agregar</button>
    </div>
  </div>
  {/if}

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


<div class="modal fade" id="panelNuevoTrabajo" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-xs">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Agregar Tarea</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body">
        <form></form>
        <form id="frm_registro_trabajo" method="POST" action="gtrabajo/_registrar_trabajo">
          <div class="col-lg-12 margin-top-10"><strong>Titulo</strong></div>
          <input hidden="hidden" value="{$leccion.Lec_IdLeccion}" name="leccion"/>
          <div class="col-lg-12">
            <input class="form-control" name="titulo" id="inTituloTra" />
          </div>
          <div class="col-lg-12 margin-top-10"><strong>Tipo Tarea</strong></div>
          <div class="col-lg-12">
            <select class="form-control" name="tipo" id="slTipoTra">
              <option value="-1" selected="selected" disabled="disabled">Seleccione una opción</option>
              {foreach from=$tipo_trabajo item=c}
              <option value="{$c.Con_Valor}">{$c.Con_Descripcion}</option>
              {/foreach}
            </select>
          </div>
          <div class="col-lg-12 margin-top-10"><strong>Descripción</strong></div>
          <div class="col-lg-12">
            <textarea class="form-control" name="descripcion" id="inDescTra" rows="4" maxlength="300"></textarea>
          </div>
          <div class="col-lg-6" style="margin-top: 10px">
            <label>Activo desde: </label>
            <input class="form-control" name="desde" id="inDesdeTraDate" readonly="true" style="cursor: pointer;"/>
          </div>
          <div class="col-lg-6" style="margin-top: 10px">
            <label>Activo hasta: </label>
            <input class="form-control" name="hasta" id="inHastaTraDate" readonly="true" style="cursor: pointer;"/>
          </div>
          <div class="col-lg-12 margin-top-10">
            <button class="btn btn-success" id="btn_registrar_trabajo">Registrar</button>
          </div>
        <form>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="panelEditarTrabajo" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-xs">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Modificar Tarea</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body">
        <form></form>
        <form id="frm_actualizar_trabajo" method="POST" action="gtrabajo/_actualizar_trabajo">
          <div class="col-lg-12 margin-top-10"><strong>Titulo</strong></div>
          <input hidden="hidden" id="inUpdIdTrabajo" name="trabajo"/>
          <div class="col-lg-12">
            <input class="form-control" name="titulo" id="inUpdTituloTra" />
          </div>
          <div class="col-lg-12 margin-top-10"><strong>Tipo Tarea</strong></div>
          <div class="col-lg-12">
            <select class="form-control" name="tipo" id="slUpdTipoTra">
              <option value="-1" selected="selected" disabled="disabled">Seleccione una opción</option>
              {foreach from=$tipo_trabajo item=c}
              <option value="{$c.Con_Valor}">{$c.Con_Descripcion}</option>
              {/foreach}
            </select>
          </div>
          <div class="col-lg-12 margin-top-10"><strong>Descripción</strong></div>
          <div class="col-lg-12">
            <textarea class="form-control" name="descripcion" id="inUpdDescTra" rows="4" maxlength="300"></textarea>
          </div>
          <div class="col-lg-6" style="margin-top: 10px">
            <label>Activo desde: </label>
            <input class="form-control" name="desde" id="inUpdDesdeTraDate" readonly="true" style="cursor: pointer;"/>
          </div>
          <div class="col-lg-6" style="margin-top: 10px">
            <label>Activo hasta: </label>
            <input class="form-control" name="hasta" id="inUpdHastaTraDate" readonly="true" style="cursor: pointer;"/>
          </div>
          <div class="col-lg-12" style="margin-top: 10px">
            <label>Archivos adjuntos: </label>
            <div id="divArcAdjTrabajo"></div>
            <button class="btn btn-default" id="btnAgregarArchivoTrabajo">Adjuntar archivo</button>
          </div>
          <div class="col-lg-12 margin-top-10">
            <button class="btn btn-success" id="btn_actualizar_trabajo">Actualizar</button>
          </div>
        <form>
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


  $("#btn_agregar_trabajo").click(function(){
    $('#inDesdeTraDate').datetimepicker({
        language: 'es',format: "dd/mm/yyyy hh:ii"
    });
    $('#inHastaTraDate').datetimepicker({
        language: 'es',format: "dd/mm/yyyy hh:ii"
    });
    $("#panelNuevoTrabajo").modal("show");
  });
  $("#btn_registrar_trabajo").click(function(e){
    e.preventDefault();
    if( $("#inTituloTra").val().toString().length==0 ){
      Mensaje("Ingrese título", function(){ $("#inTituloTra").focus(); });
      return;
    }
    if( $("#slTipoTra").val()==null || $("#slTipoTra").val()==-1 ){
      Mensaje("Seleccione tipo de trabajo", function(){ $("#slTipoTra").focus(); });
      return;
    }
    if( $("#inDescTra").val().toString().length==0 ){
      Mensaje("Ingrese descripción del trabajo", function(){ $("#inDescTra").focus(); });
      return;
    }
    if( $("#inDesdeTraDate").val().toString().length==0 ){
      Mensaje("Ingrese la fecha de incio de recepción de trabajos", function(){ $("#inDesdeTraDate").focus(); });
      return;
    }
    if( $("#inHastaTraDate").val().toString().length==0 ){
      Mensaje("Ingrese la fecha de fin de recepción de trabajos", function(){ $("#inHastaTraDate").focus(); });
      return;
    }
    if( !ValidarFechas(null, $("#inDesdeTraDate").val() ) ){
      Mensaje("La fecha inicial debe ser mayor a la actual", function(){ $("#inDesdeTraDate").focus(); });
      return;
    }
    if( !ValidarFechas(null, $("#inHastaTraDate").val() ) ){
      Mensaje("La fecha final debe ser mayor a la actual", function(){ $("#inHastaTraDate").focus(); });
      return;
    }
    if( !ValidarFechas($("#inDesdeTraDate").val(), $("#inHastaTraDate").val() ) ){
      Mensaje("La fecha final debe ser mayor a la inicial", function(){ $("#inHastaTraDate").focus(); });
      return;
    }
    $.fn.Mensaje({ mensaje: "¿Desea registrar la tarea?", tipo: "SiNo", tamano: "sm",
      funcionSi: function(){
        SubmitForm($("#frm_registro_trabajo"), $(this), function(data, e){
          Mensaje("Se registró la tarea con éxito",
            function(){
              CargarPagina("gleccion/_view_leccion", {
                curso: $("#hidden_curso").val(),
                modulo : $("#hidden_modulo").val(),
                leccion : $("#hidden_leccion").val()
              }, false, false);
          });
        });
      }
    });
  });
  $(".btnEditarTrabajo").click(function(){
    var Trabajo = $(this).parent().find(".Hidden_IdTrabajo").val();
    AsincTaks(
      "gtrabajo/_get_trabajo", { id: Trabajo },
      function(a){
        var data = JSON.parse(a);
        if(data.estado==1){
          $('#inUpdHastaTraDate').datetimepicker({
              language: 'es',format: "dd/mm/yyyy hh:ii"
          });
          $('#inUpdDesdeTraDate').datetimepicker({
              language: 'es',format: "dd/mm/yyyy hh:ii"
          });
          $("#inUpdIdTrabajo").val(data.data.Tra_IdTrabajo);
          $("#inUpdTituloTra").val(data.data.Tra_Titulo);
          $("#inUpdDescTra").val(data.data.Tra_Descripcion);
          $("#slUpdTipoTra").val(data.data.Tra_Tipo);
          $("#inUpdDesdeTraDate").val(data.data.Tra_FechaDesde);
          $("#inUpdHastaTraDate").val(data.data.Tra_FechaHasta);


          var Archivos = data.data.Archivos;
          if(Archivos!=null){
            $("#divArcAdjTrabajo").html("");
            Archivos.forEach(function(item){
              AddFileAdjunto(item);
            });
            $(".btnElimArcAdj").unbind("click").click(function(e){
              e.preventDefault();
              var Id = $(this).parent().find(".inIdArcAdj").val();
              $.fn.Mensaje({
                mensaje: "¿Desea eliminar el archivo?",
                tipo: "SiNo", tamano: "sm",
                funcionSi: function(){
                  AsincTaks(
                    "gtrabajo/_eliminar_archivo", { id: Id },
                    function(a){
                      Mensaje("Archivo eliminado", function(){
                        CargarPagina("gleccion/_view_leccion", {
                          curso: $("#hidden_curso").val(),
                          modulo : $("#hidden_modulo").val(),
                          leccion : $("#hidden_leccion").val()
                        }, false, false);
                      });
                    },
                    false, false
                  );
                }
              });
            });
          }

          $("#panelEditarTrabajo").modal("show");

        }else{
          Mensaje("Existe un problema con la tarea seleccionada", null);
        }
      },
      false, false
    );
  });
  $(".btnActivarTrabajo").click(function(){
    var Trabajo = $(this).parent().find(".Hidden_IdTrabajo").val();
    var Estado = $(this).parent().find(".Hidden_Estado").val();
    Estado = Estado == "1" ? "0" : "1";
    AsincTaks(
      "gtrabajo/_actualizar_estado_trabajo", { id: Trabajo, estado: Estado },
      function(a){
        CargarPagina("gleccion/_view_leccion", {
          curso: $("#hidden_curso").val(),
          modulo : $("#hidden_modulo").val(),
          leccion : $("#hidden_leccion").val()
        }, false, false);
      },
      false, false
    );
  });
  $("#btn_actualizar_trabajo").click(function(e){
    e.preventDefault();

    $.fn.Mensaje({
      tipo: "SiNo", tamano: "sm",
      mensaje: "¿Desea actualizar esta tarea?",
      funcionSi: function(){
        SubmitForm($("#frm_actualizar_trabajo"), $(this), function(data, e){
          Mensaje("Se actualizó la tarea con éxito",
            function(){
              CargarPagina("gleccion/_view_leccion", {
                curso: $("#hidden_curso").val(),
                modulo : $("#hidden_modulo").val(),
                leccion : $("#hidden_leccion").val()
              }, false, false);
          });
        });
      }
    });
  });
  $(".btnEliminarTrabajo").click(function(){
    var Trabajo = $(this).parent().find(".Hidden_IdTrabajo").val();

    $.fn.Mensaje({
      tipo: "SiNo", tamano: "sm",
      mensaje: "¿Desea eliminar esta tarea?",
      funcionSi: function(){
        AsincTaks(
          "gtrabajo/_eliminar_trabajo", { id: Trabajo },
          function(a){
            CargarPagina("gleccion/_view_leccion", {
              curso: $("#hidden_curso").val(),
              modulo : $("#hidden_modulo").val(),
              leccion : $("#hidden_leccion").val()
            }, false, false);
          },
          false, false
        );
      }
    });
  });
  $("#btnAgregarArchivoTrabajo").click(function(e){
    e.preventDefault();
    var Archs = $(".item-arch-adj");
    Archs = Archs.length || 0;
    if(Archs > 2){
      Mensaje("Solo puede adjuntar un máximo de 3 archivos", null);
      return;
    }
    $("#panelEditarTrabajo").modal("hide");
    setTimeout(function(){
      var params = {
        route: "modules/elearning/views/gleccion/_contenido/_trabajos",
        pre: $("#inUpdIdTrabajo").val(),
        validator: {
          files: 3 - Archs,
          maxSize: 10,
          formats: ""
        }
      };

      InitUploader(function(a){
        var DATA = JSON.parse(a);

        AsincTaks("gtrabajo/_registrar_archivo",
          { id: $("#inUpdIdTrabajo").val(), archivos: JSON.stringify(DATA.data) },
          function(result){
            Mensaje("Se agregó el(los) archivo(s) adjunto(s) a la tarea", function(){
              CargarPagina("gleccion/_view_leccion", {
                curso: $("#hidden_curso").val(),
                modulo : $("#hidden_modulo").val(),
                leccion : $("#hidden_leccion").val()
              }, false, false);
            });
          },
          false, false
        );

      }, params);
    }, 300);
  });

  function ValidarFechas(fecha1, fecha2){
    if(fecha1==null){
      fecha1 = new Date();
    }else{
      fecha1 = new Date(Date.parse(fecha1 + ":00"));
    }
    fecha2 = new Date(Date.parse(fecha2 + ":00"));

    var diferencia = fecha2.getTime() - fecha1.getTime();

    if(diferencia > 0){
      return true;
    }
    return false;
  }

  function AddFileAdjunto(item){
    console.log(item);
    var cadena = "<div class='col-lg-12 item-arch-adj'>";
    cadena += "<a href='" + $("#hidden_root").val() + "gleccion/_contenido/_trabajos/" + item.Arc_Ruta;
    cadena +=  "' target='_blank'>" + item.Arc_Ruta.substring(item.Arc_Ruta.length-20, item.Arc_Ruta.length) + "</a>";
    cadena +=  "<input class='inIdArcAdj estado' value='" + item.Arc_IdArchivo + "' />";
    cadena +=  "<button class='btnElimArcAdj'><i class='glyphicon glyphicon-trash'></i></button>";
    cadena +=  "</div>";
    $("#divArcAdjTrabajo").append(cadena);
  }
</script>
