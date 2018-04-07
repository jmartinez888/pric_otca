<style type="text/css">
	#micanvas_nuevo{
	  border: 1px solid gray !important;
	  position: absolute;
	  top: 0;
	  left: 0;
	  z-index: 3;
	  -webkit-user-select: none;
	  -moz-user-select: none;
	  -ms-user-select: none;
	  user-select: none;
	}


	#tmp_fondo_pizarra{
	  position: absolute;
	  max-width: 700px;
	  max-height: 400px;
	  top: 0px;
	  left: 0px;
	  z-index: 1;
	  -webkit-user-select: none;
	  -moz-user-select: none;
	  -ms-user-select: none;
	  user-select: none;
	}

	.contenido-pizarra_nuevo{
	  position: relative;
	  width: 700px;
	  height: 400px;
	  margin-bottom: 10px;
	}

	#lb_help{
	  display: none;
	}
</style>


{include file='modules/elearning/views/uploader/uploader.tpl'}

<div class="modal fade" id="panelNuevaPizarra" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-lg">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Agregar Pizarra</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body" style="padding: 10px !important">
        <label id="lb_help">Haga click en un punto y deslice el mouse para dibujar la imagen</label>
        <input hidden="hidden" value="" id="tmp_img_url" />
        <input hidden="hidden" value="" id="tmp_piz_x" />
        <input hidden="hidden" value="" id="tmp_piz_y" />
        <input hidden="hidden" value="" id="tmp_piz_width" />
        <input hidden="hidden" value="" id="tmp_piz_height" />
        <center>
          <div class="contenido-pizarra_nuevo">
            <canvas height="400px" width="700px" id="micanvas_nuevo" class="no-seleccionable"></canvas>
          </div>
        </center>
        <button class="btn btn-success" id="btn-guardar-pizarra">Guardar Pizarra</button>
        <button class="btn btn-info" id="btn-cancelar-nueva-pizarra">Cancelar</button>
      </div>
    </div>
  </div>
</div>


<script type="text/javascript">
$(document).ready(function(){
	$("#btn-agregar-pizarra").click(function(){
		var params = {
			route: "modules/elearning/views/gleccion/_contenido/_pizarra",
			pre: $("hiddenLeccion").val()
		};
		InitUploader(function(a){
			$("#panelNuevaPizarra").modal("show");
			setTimeout(function(){
				AddImg(a);
			}, 200);
		}, params);
	});

	$("#btn-guardar-pizarra").click(function(){
		if($("#tmp_img_url").val()==0){ $.fn.Mensaje({ mensaje: "Es necesario cargar una imagen"}); return; }
		if($("#tmp_piz_x").val()==0){ $.fn.Mensaje({ mensaje: "Ajuste la imagen a la pizarra"}); return; }
		if($("#tmp_piz_width").val()==0){ $.fn.Mensaje({ mensaje: "Ajuste la imagen a la pizarra"}); return; }


		var params = {
		    leccion : $("#hiddenLeccion").val(),
		    url: $("#tmp_img_url").val(),
		    x: $("#tmp_piz_x").val(),
		    y: $("#tmp_piz_y").val(),
		    width: $("#tmp_piz_width").val(),
		    height: $("#tmp_piz_height").val()
		  };
		  $.fn.Mensaje({
		    mensaje: "¿Desea guardar esta pizarra?",
		    tipo: "SiNo",
		    funcionSi: function(){
		    	$.ajax({
		    		url: $("#hiddenURL").val() + "elearning/pizarra/_registrar_pizarra",
		    		type: "post",
		    		data: params,
		    		success: function(a){
		    			SocketNuevaPizarra();
		    			$.fn.Mensaje({
		    				mensaje: "Se registró la pizarra",
		    				funcionCerrar: function(){
		    					$("#panelNuevaPizarra").modal("hide");
		    					ClearAll();
		    				}
		    			});
		    		}
		    	});
		    }
		  });
	});

	$("#btn-cancelar-nueva-pizarra").click(function(){ 
		$("#panelNuevaPizarra").modal("hide");
		ClearAll(); 
	});

	function SocketNuevaPizarra(){
		var msg = { us: USUARIO.id, act: 101, add: $("#tmp_img_url").val() };
  		SOCKET_PIZARRA.send(msg);
	}

	function AddImg(a){
		var DATA = JSON.parse(a);
		DATA = DATA.data[0].url;
		DATA = DATA.split("\\");
		DATA = DATA[DATA.length-1];
		DATA = DATA.split("/");
		DATA = DATA[DATA.length-1];

		$("#tmp_img_url").val(DATA);
		DATA = $("#hiddenURL").val() + "modules/elearning/views/gleccion/_contenido/_pizarra/" + DATA;

		var CON = $(".contenido-pizarra_nuevo");
		$("#tmp_fondo_pizarra").remove();
		CON.prepend("<img id='tmp_fondo_pizarra' src='" + DATA + "' />");

		$("#lb_help").show();
	}

	function ClearAll(){
	  $("#tmp_img_url").val("");
	  $("#tmp_piz_x").val("");
	  $("#tmp_piz_y").val("");
	  $("#tmp_piz_width").val("");
	  $("#tmp_piz_height").val("");
	  $("#tmp_fondo_pizarra").remove();
	  $("#btn-cargar-img-pizarra").show();
	  $("#lb_help").hide();
	}



	var CANVAS = $("#micanvas_nuevo");
	var X = $("#tmp_piz_x");
	var Y = $("#tmp_piz_y");
	var WIDTH = $("#tmp_piz_width");
	var HEIGHT = $("#tmp_piz_height");
	var pos = { x : 0, y: 0 };
	var CLICK = false;

	CANVAS.mousedown(function(e){
	  if( $("#tmp_img_url").val().toString().length==0 ){ return; }
	  var IMG  = $("#tmp_fondo_pizarra");
	  pos.x = (e.pageX - CANVAS.offset().left);
	  pos.y = (e.pageY - CANVAS.offset().top);

	  X.val(pos.x); Y.val(pos.y);
	  IMG.css({ top: pos.y, left: pos.x, width: "10px", height: "10px" });
	  CLICK = true;
	});

	CANVAS.mouseup(function(e){
	  if( $("#tmp_img_url").val().toString().length==0 ){ return; }
	  var other = { x: (e.pageX - CANVAS.offset().left) - pos.x, y: (e.pageY - CANVAS.offset().top)- pos.y  }

	  WIDTH.val(other.x);
	  HEIGHT.val(other.y);
	  CLICK = false;
	});

	CANVAS.mousemove(function(e){
	  if( $("#tmp_img_url").val().toString().length==0 ){ return; }
	  if(!CLICK){ return; }
	  var other = { x: (e.pageX - CANVAS.offset().left), y: (e.pageY - CANVAS.offset().top)  }
	  var IMG  = $("#tmp_fondo_pizarra");
	  IMG.css({ top: pos.y, left: pos.x, width: (other.x-pos.x) + "px", height: (other.y-pos.y) + "px" });
	});

});
</script>