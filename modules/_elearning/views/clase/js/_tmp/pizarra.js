$("#contenedor-principal-pizarra").css({ "height": "520px"})
var PIZARRAS = [];
var CONTROL_PIZARRA_PANEL = $("#control-pizarra-panel");
var CONTROL_PIZARRA_CONTENT = $("#control-pizarra-content");
var doc = $(document);
var win = $(window);

function AddPizarra(){
  PIZARRAS.push({ id: 1});
  var id = PIZARRAS.length;
  var eliminar = "";
  if(PIZARRAS.length>1){
      eliminar = "<button id='btnQuitarPizarra" + id + "' class='btn btn-success'>x</button>";
  }
  var texto = "<li><a data-toggle='tab' href='#pizarra" + id + "' id='item-pizarra" + id + "'>Pizarra N° 0" + id + eliminar + "</a></li>";
  var contenido = "<div id='pizarra" + id + "' class='tab-pane fade in'>"
                  + "<div class='pizarra'>"
                    + "<canvas id='paper" + id + "' width='655' height='390'>Tu navegador con canvas</canvas>"
                  + "</div>"
                + "</div>";

  CONTROL_PIZARRA_PANEL.append(texto);
  CONTROL_PIZARRA_CONTENT.append(contenido);

  var canvas = $("#paper" + id);
  var ctx = canvas[0].getContext('2d');
  var drawing = false;
  var clients = {};
  var cursors = {};
  var prev = {};
  var lastEmit = $.now();

  $("#item-pizarra" + id).click();
  $("#btnQuitarPizarra" + id).click(function(){
    $("#item-pizarra" + id).remove();
    $("#pizarra" + id).remove();
    $("#item-pizarra0").click();
  });

  canvas.on("mousemove", function(e){
    if (drawing){
        ctx.moveTo(prev.x-200, prev.y-200);
        ctx.lineTo(e.pageX-200, e.pageY-200);
        ctx.stroke();

        prev.x = e.pageX;
        prev.y = e.pageY;
    }
  });
  canvas.on("mousedown", function(e){
    e.preventDefault();
    drawing = true;
    prev.x = e.pageX;
    prev.y = e.pageY;
  });
  canvas.bind("mouseup mouseleave", function(){ drawing = false; });
}

$("#btnAgregarPizarra").click(function(){
  AddPizarra();
});

AddPizarra();
