<style>
  /*.item-referencia{
    position: relative;
    margin-bottom: 10px;
    border-bottom: 1px solid #ddd;
  }*/
  /*.btnEliminar{
    position: absolute; top: 0px; right: 0px;
  }*/
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
<div class="col-xs-12  div_referencias">
  <div class="panel panel-default " style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">
    <div class="panel-body">
      {if isset($referencias) && count($referencias) > 0 }
        {$i = 1}
        <table class="table table-hover table-condensed table-filtros text-center">
            <thead class="bg-default">
            <tr>
            <th>#</th>
            <th> Título </th>
            <th> Fecha </th>
            <th> Estado </th>
            <th> Opciones </th>
              <tbody>
                {foreach from=$referencias item=r}
                {if $r.Row_Estado == 0}
                <tr style="color: red">
                {else}
                  {if $r.Ref_Estado == 0}
                    <tr style="color: #999c99">
                  {else}
                    <tr>
                  {/if}
                {/if}
                  <td scope="row">{$i++}</td>
                  <td style="text-align: left;">
                    <span data-toggle="tooltip" data-placement="right" title="{$r.Ref_Titulo}">{$r.Ref_Titulo|truncate:250:"..."}</span>
                  </td>
                  <td>{$r.Ref_FechaReg}</td>
                  <td>
                      {if $r.Ref_Estado==0}
                          <i data-toggle="tooltip" data-placement="top"  class="glyphicon glyphicon-remove-sign" title="Deshabilitado" style="color: #DD4B39;"/>
                      {/if}
                      {if $r.Ref_Estado==1}
                          <i data-toggle="tooltip" data-placement="top"  class="glyphicon glyphicon-ok-sign" title="Habilitado" style="color: #088A08;"/>
                      {/if}
                      {if $r.Ref_Estado==2}
                          <i data-toggle="tooltip" data-placement="top"  class="glyphicon glyphicon-info-sign" title="Privado" style="color: #f39c12;"/>
                      {/if}
                  </td>
                  <td>
                    <div class="item-referencia">
                      <input class="Hidden_IdReferencia" hidden="hidden" value="{$r.Ref_IdReferencia}" />
                      <input class="Hidden_IdEnlace" hidden="hidden" value="{$r.Ref_Descripcion}" />
                      <input class="Hidden_TipoMaterial" hidden="hidden" value="1" />
                      <button data-toggle="tooltip" data-placement="top" title="Ver enlace" class="btnAbrirEnlace btn btn-sm btn-primary"><i class="glyphicon glyphicon-link"></i></button>
                      <button data-toggle="tooltip" data-placement="top" title="Eliminar Material" class="btnEliminar btn btn-sm btn-danger"><i class="glyphicon glyphicon-trash"></i></button>
                    </div>
                  </td>
                {/foreach}

              </tbody>
        </table>

      {else}
        <div>No tienes referencias</div>
      {/if}
      <button class="btn btn-success" id="btn_agregar_referencia">Agregar</button>
    </div>

  </div>
</div>
<div class="col-xs-12  div_materiales">
  <div class="panel panel-default " style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">
    <div class="panel-body">
      <div class="table-responsive">
        {if isset($material) && count($material) > 0 }
        {$i = 1}
        <table class="table table-hover table-condensed table-filtros text-center">
            <thead class="bg-default">
            <tr>
            <th>#</th>
            <th class="cabecera"> Descripción </th>
            <th> Fecha </th>
            <th> Estado </th>
            <th> Opciones </th>
              <tbody>
                {foreach from=$material item=r}
                {if $r.Row_Estado == 0}
                <tr style="color: red">
                {else}
                  {if $r.Mat_Estado == 0}
                    <tr style="color: #999c99">
                  {else}
                    <tr>
                  {/if}
                {/if}
                  <td scope="row">{$i++}</td>
                  <td style="text-align: left;">
                    <span data-toggle="tooltip" data-placement="right" title="{$r.Mat_Descripcion}">{$r.Mat_Descripcion|truncate:250:"..."}</span>
                  </td>
                  <td>{$r.Mat_FechaReg}</td>
                  <td>
                      {if $r.Mat_Estado==0}
                          <i data-toggle="tooltip" data-placement="top"  class="glyphicon glyphicon-remove-sign" title="Deshabilitado" style="color: #DD4B39;"/>
                      {/if}
                      {if $r.Mat_Estado==1}
                          <i data-toggle="tooltip" data-placement="top"  class="glyphicon glyphicon-ok-sign" title="Habilitado" style="color: #088A08;"/>
                      {/if}
                      {if $r.Mat_Estado==2}
                          <i data-toggle="tooltip" data-placement="top"  class="glyphicon glyphicon-info-sign" title="Privado" style="color: #f39c12;"/>
                      {/if}
                  </td>
                  <td>
                    <div class="item-referencia">
                      <input class="Hidden_IdMaterial" hidden="hidden" value="{$r.Mat_IdMaterial}" />
                      <input class="Hidden_IdEnlace" hidden="hidden" value="{$r.Mat_Enlace}" />
                      <input class="Hidden_TipoMaterial" hidden="hidden" value="{$r.Mat_Tipo}" />
                      {if $r.Mat_Tipo == 1}
                        <button data-toggle="tooltip" data-placement="top" title="Ver enlace" class="btnAbrirEnlace btn btn-sm btn-primary"><i class="glyphicon glyphicon-link"></i></button>
                      {else}
                        <button data-toggle="tooltip" data-placement="top" title="Descargar Archivo" class="btnAbrirEnlace btn btn-sm btn-warning"><i class="glyphicon glyphicon-paperclip"></i></button>
                      {/if}
                      <button data-toggle="tooltip" data-placement="top" title="Eliminar Material" class="btnEliminarMaterial btn btn-sm btn-danger"><i class="glyphicon glyphicon-trash"></i></button>
                    </div>
                  </td>
                {/foreach}
              </tbody>
        </table>
        {else}
          <div>No tienes material didáctico</div>
        {/if}
      </div>
      <button class="btn btn-success" id="btn_agregar_material">Agregar</button>
    </div>
  </div>
</div>
<div class="col-xs-12  div_tareas">
  <div class="panel panel-default " style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">
    <div class="panel-body">
      <div class="table-responsive">
        {if isset($trabajo) && count($trabajo)}
        {$i = 1}
        <table class="table table-hover table-condensed table-filtros text-center">
          <thead class="bg-default">
          <tr>
          <th>#</th>
          <th class="cabecera"> Título </th>
          <th class="cabecera"> Descripción </th>
          <th> Fecha Inicio </th>
          <th> Fecha Final </th>
          <th> Estado </th>
          <th> Opciones </th>
          <tbody>
          {foreach from=$trabajo item=t}
            <tr >
              <td scope="row">{$i++}</td>
                <td style="text-align: left;">
                  <span data-toggle="tooltip" data-placement="right" title="{$t.Tra_Titulo}">{$t.Tra_Titulo|truncate:250:"..."}</span>
                </td>
                <td style="text-align: left;">
                  <span data-toggle="tooltip" data-placement="right" title="{$t.Tra_Descripcion}">{$t.Tra_Descripcion|truncate:250:"..."}</span>
                </td>
                <td>{$t.Tra_FechaDesde}</td>
                <td>{$t.Tra_FechaHasta}</td>
                <td>
                    {if $t.Tra_Estado==0}
                        <i data-toggle="tooltip" data-placement="top"  class="glyphicon glyphicon-remove-sign" title="Deshabilitado" style="color: #DD4B39;"/>
                    {/if}
                    {if $t.Tra_Estado==1}
                        <i data-toggle="tooltip" data-placement="top"  class="glyphicon glyphicon-ok-sign" title="Habilitado" style="color: #088A08;"/>
                    {/if}
                </td>
                <td>
                  <div class="item-trabajo">
                    <input class="Hidden_IdTrabajo" hidden="hidden" value="{$t.Tra_IdTrabajo}" />
                    <input class="Hidden_Estado" hidden="hidden" value="{$t.Tra_Estado}" />
                    <button data-toggle="tooltip" data-placement="top" title="Editar Tarea" class="btnEditarTrabajo btn btn-sm btn-primary"><i class="glyphicon glyphicon-edit"></i></button>

                      {if $t.Tra_Estado == '1' }
                      <button data-toggle="tooltip" data-placement="top" title="Deshabilitar Tarea" class="btnActivarTrabajo btn btn-sm btn-warning">
                          <i class="glyphicon glyphicon-remove"></i>
                      </button>
                      {else}
                      <button data-toggle="tooltip" data-placement="top" title="Habilitar Tarea" class="btnActivarTrabajo btn btn-sm btn-success">
                          <i class="glyphicon glyphicon-ok"></i>
                      </button>
                      {/if}
                    </button>
                    <button data-toggle="tooltip" data-placement="top" title="Eliminar Tarea" class="btnEliminarTrabajo btn btn-sm btn-danger"><i class="glyphicon glyphicon-trash"></i></button>
                  </div>
                </td>
              </tr>
          {/foreach}
          </tbody>
        </table>
      {else}
        <div>No se ha registrado trabajos</div>
      {/if}
      <br/>
      <button class="btn btn-success" id="btn_agregar_trabajo">Agregar</button>
    </div>
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
        <form class="form-horizontal" id="frm_registro_referencia" method="post" action="gleccion/_registrar_referencia">
          <div class="col-lg-12 margin-t-10"><strong>Titulo</strong></div>
          <input hidden="hidden" value="{$leccion.Lec_IdLeccion}" name="leccion"/>
          <div class="col-lg-12"><input class="form-control" name="titulo" id="inTituloRef" /></div>
          <div class="col-lg-12 margin-t-10"><strong>Referencia</strong></div>
          <div class="col-lg-12"><input class="form-control" name="descripcionRef" id="inDescripcionRef" /></div>
          <div class="col-lg-12 margin-t-10"><button class="btn btn-success" id="btn_registrar_referencia">Registrar</button></div>
        </form>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="panelNuevoMaterial" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-focus-on="input:first">
  <div class="modal-dialog modal-xs">
    <div class="panel">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Agregar Material Didáctico</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body">
        <div class="col-lg-12"><input type="radio" value="0" checked="checked" name="opcion" id="inlopcionmat"/> Enlace a documento</div>
          <div class="col-lg-12"><strong>Link</strong></div>
          <form id="frm_registro_material" method="post" action="gleccion/_registrar_material_link">
          <div class="col-lg-12"><input class="form-control" name="link" id="inMatLink" /></div>
          <div class="col-lg-12 margin-t-10"><strong>Descripción</strong></div>
          <div class="col-lg-12"><textarea class="form-control" name="descripcionMat" id="inMatLinkDescripcion"></textarea></div>
          <div class="col-lg-12 margin-t-10"><button class="btn btn-success pull-right" id="btn_registrar_material_link"><i class="glyphicon glyphicon-floppy-disk"></i> Guardar</button></div>
        </form>
        <div class="col-lg-12 margin-t-10"><input type="radio" value="1" name="opcion"/>Archivo local</div>
        <div class="col-lg-12 margin-t-10"><button class="btn btn-success" id="btn_registrar_material_file" disabled="disabled"><i class="glyphicon glyphicon-open"></i> Subir archivo</button></div>
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
        <div class="col-lg-6 margin-t-10">
          <button class="btn btn-success" id="btn_registrar_material_file2">Guardar material</button>
        </div>
        <div class="col-lg-6 margin-t-10">
          <button class="btn btn-success pull-right" id="btn_cancelar_material_file">Cancelar</button>
        </div>
      </div>
    </div>
  </div>
</div>
{if isset($Lec_Tipo) && $Lec_Tipo == 6}

{include file = 'modules/elearning/views/templates/res/mod_agregar_trabajo.tpl'}
{include file = 'modules/elearning/views/templates/res/mod_editar_trabajo.tpl'}

{/if}

<script type="text/javascript">
  // Para que funcione el tooltip
  $(function () {
      $('[data-toggle="tooltip"]').tooltip();
  });
  $(document).ready(function(){
    $("#btn_registrar_material_link").click(function(e){
      e.preventDefault();
      var Link = $("#inMatLink").val();
      var Descripcion = $("#inMatLinkDescripcion").val();
      var Leccion =  $("#hidden_leccion").val();

      if(Link.length==0){
        Mensaje("Ingrese el link.", function(){
          $("#inMatLink").focus();
        });
        return;
      }
      if(Descripcion.length==0){
        Mensaje("Ingrese descripción.", function(){
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

                location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();
                // CargarPagina("gleccion/_view_leccion", {
                //   curso: $("#hidden_curso").val(),
                //   modulo : $("#hidden_modulo").val(),
                //   leccion : $("#hidden_leccion").val(),
                // }, false, false);
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

            location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();
          });
        }
      });
    });
    $(".btnAbrirEnlace").click(function(){

      if ($(this).parent().find(".Hidden_TipoMaterial").val() == 1) {
        var Link = $(this).parent().find(".Hidden_IdEnlace").val();
      } else {
        var Link = _root_ + "modules/" + _modulo + "/views/gleccion/_contenido/_material/";
        Link += $(this).parent().find(".Hidden_IdEnlace").val();
      }

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
            location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();

            // CargarPagina("gleccion/_view_leccion", {
            //   curso: $("#hidden_curso").val(),
            //   modulo : $("#hidden_modulo").val(),
            //   leccion : $("#hidden_leccion").val(),
            // }, false, false);
          }, null);
        }
      });
    });
    $(".btnEliminarMaterial").click(function(){
      var IdMat = $(this).parent().find(".Hidden_IdMaterial").val();
      $.fn.Mensaje({ mensaje: "¿Seguro de quitar este material adjunto?", tipo: "SiNo",
        funcionSi: function(){
          AsincTaks("gleccion/_eliminar_material", { id : IdMat }, function(a){
            location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();

            // CargarPagina("gleccion/_view_leccion", {
            //   curso: $("#hidden_curso").val(),
            //   modulo : $("#hidden_modulo").val(),
            //   leccion : $("#hidden_leccion").val(),
            // }, false, false);
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
    })
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

            var texto =  "<input class='form-control margin-t-10' value='" + tmp + "' disabled='disabled'/>";
            contenedor.append(texto);
          });
          contenedor.append("<label class='margin-t-10'>Descripción</label>");
          contenedor.append("<input class='form-control' id='in_tmp_mat_arch'/>");

          setTimeout(function(){ $("#in_tmp_mat_arch").focus(); }, 300);
        }, params);
      }, 300);
    });
    $("#btn_cancelar_material_file").click(function(){
      $("#panelNuevoMaterialArchivo").modal("hide");
    });
    $("#btn_registrar_material_file2").click(function(e){
      e.preventDefault();
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
                location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();

                // CargarPagina("gleccion/_view_leccion", {
                //   curso: $("#hidden_curso").val(),
                //   modulo : $("#hidden_modulo").val(),
                //   leccion : $("#hidden_leccion").val()
                // }, false, false);
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
          // alert("ssssssss");
          SubmitForm($("#frm_registro_trabajo"), $(this), function(data, e){
            Mensaje("Se registró la tarea con éxito",
              function(){
                location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();

                // CargarPagina("gleccion/_view_leccion", {
                //   curso: $("#hidden_curso").val(),
                //   modulo : $("#hidden_modulo").val(),
                //   leccion : $("#hidden_leccion").val()
                // }, false, false);
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
                          location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();

                          // CargarPagina("gleccion/_view_leccion", {
                          //   curso: $("#hidden_curso").val(),
                          //   modulo : $("#hidden_modulo").val(),
                          //   leccion : $("#hidden_leccion").val()
                          // }, false, false);
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
          location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();

          // CargarPagina("gleccion/_view_leccion", {
          //   curso: $("#hidden_curso").val(),
          //   modulo : $("#hidden_modulo").val(),
          //   leccion : $("#hidden_leccion").val()
          // }, false, false);
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
                location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();

                // CargarPagina("gleccion/_view_leccion", {
                //   curso: $("#hidden_curso").val(),
                //   modulo : $("#hidden_modulo").val(),
                //   leccion : $("#hidden_leccion").val()
                // }, false, false);
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
              location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();

              // CargarPagina("gleccion/_view_leccion", {
              //   curso: $("#hidden_curso").val(),
              //   modulo : $("#hidden_modulo").val(),
              //   leccion : $("#hidden_leccion").val()
              // }, false, false);
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
                location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();

                // CargarPagina("gleccion/_view_leccion", {
                //   curso: $("#hidden_curso").val(),
                //   modulo : $("#hidden_modulo").val(),
                //   leccion : $("#hidden_leccion").val()
                // }, false, false);
              });
            },
            false, false
          );

        }, params);
      }, 300);
    });

  });

  function ValidarFechas(fecha1, fecha2){

    var separadores = ['/',' '];

    if(fecha1==null){
      fecha1 = new Date();
    }

    else{
      var array=fecha1.split(new RegExp(separadores.join('|'),'g'));
      fecha1=array[1]+'/'+array[0]+'/'+array[2]+' '+array[3];
      fecha1 = new Date(Date.parse(fecha1 + ":00"));
    }

    var array2=fecha2.split(new RegExp(separadores.join('|'),'g'));
    fecha2=array2[1]+'/'+array2[0]+'/'+array2[2]+' '+array2[3];

    fecha2 = new Date(Date.parse(fecha2 + ":00"));
    // alert(fecha1 + " //// " + fecha2);
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
