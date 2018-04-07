var COLOR = $("#hiddenColor");
var HERRAMIENTA = $("#hiddenHerramienta");
var FUENTE = $("#hiddenFuente");
var TOOGLE = $("#hiddenClick");
var INOVER = $("#hiddenOver");


var CONTENEDOR_CONT = $("#leccion-contenido");
var CURSOR_HELPER = $("#cursor-helper"); var CV = $("#micanvas");
var COORD = { x1: CV.offset().left, y1: CV.offset().top,
              x2: CV.offset().left + CV.width(), y2: CV.offset().top + CV.height() };

$(window).resize(function() {
  COORD = { x1: CV.offset().left, y1: CV.offset().top,
            x2: CV.offset().left + CV.width(), y2: CV.offset().top + CV.height() };
});
var CANVAS = document.getElementById("micanvas");
var CTX = CANVAS.getContext('2d');

$("#btnBorrarPizarra").click(function(){
  CanvasClear(CTX, CV);
  EnviarAccion(6, 0,0,0,0,"");
});
$("#btnBorrador").click(function(){
  CTX.fillStyle = "#ffffff";
});
$(document).mouseup(function(e) {
  if(TOOGLE.val()==1){
    var coord = Coordenadas();
    var her = HERRAMIENTA.val();
    if( $("#hiddenEnabled").val() == 0){ TOOGLE.val(0); return; };

    if(her==1){ DibujarRecta(coord.x1,coord.y1,coord.x2,coord.y2); }
    if(her==2){ Cuadrado(coord.x1,coord.y1,coord.x2,coord.y2); }
    if(her==3){ Marcardor(coord.x1,coord.y1); }
    if(her==4){ Texto(coord.x1,coord.y1); }
    if(her==6){ Imagen(coord.x1,coord.y1,coord.x2,coord.y2);}

    TOOGLE.val(0);
  }
  CURSOR_HELPER.css({ "width": "0px", "height": "0px", "display" :"none" });
});
$(document).mousemove(function(e) {
  if (HERRAMIENTA.val()==5 && TOOGLE.val()==1 && INOVER.val()==1){
    var posX = e.pageX - COORD.x1;
    var posY = e.pageY - COORD.y1;
    Borrador(posX, posY);
  }
});

function Coordenadas(){
  return {
    x1: $("#hiddenX1").val() - COORD.x1,
    y1: $("#hiddenY1").val() - COORD.y1,
    x2: $("#hiddenX2").val() - COORD.x1,
    y2: $("#hiddenY2").val() - COORD.y1
  };
}

function DibujarRecta(x1, y1, x2, y2){
  CanvasRecta(CTX, x1, y1, x2, y2, COLOR.val());
  EnviarAccion(1, x1, y1, x2, y2, "");
}

function Cuadrado(x1, y1, x2, y2){
  CanvasCuadro(CTX, x1, y1, x2, y2, COLOR.val(), $("#hiddenGrosor").val());
  EnviarAccion(2, x1, y1, x2, y2, "");
}

function Circulo(x1, y1){
  CTX.arc(360,70,50,0,(Math.PI/180)*360,true);
  CTX.strokeStyle = COLOR.val();
  CTX.lineWidth = 10;
  CTX.stroke();
}

function Cir(cx, cy, rx, ry){
  CTX.save();
  CTX.beginPath();
  CTX.translate(cx-rx, cy-ry);
  CTX.scale(rx, ry);
  CTX.arc(1, 1, 1, 0, 2 * Math.PI, false);
  CTX.restre();
  CTX.closePath();
}

function Marcardor(x1, y1){
  x1 +=  (COORD.x1 - CONTENEDOR_CONT.offset().left) - 110;
  y1 +=  (COORD.y1 - CONTENEDOR_CONT.offset().top) - 10;

  Marcador(x1, y1, $("#hiddenUsuarioClase").val());
  EnviarAccion(3, x1, y1, 0, 0, $("#hiddenUsuarioClase").val());
}

function Texto(_x1, _y1){
  var coord = { x1: _x1 + COORD.x1 - CONTENEDOR_CONT.offset().left, y1: _y1 + COORD.y1  - CONTENEDOR_CONT.offset().top };
  $("#texto-helper").css({ "top": coord.y1 + "px", "left": coord.x1 + "px", "font-size": FUENTE.val() + "px" })
  $("#back-texto").show();
  $("#texto-helper").show().focus();
  $("#texto-helper").unbind("keypress").keypress(function(e){
    var tecla = e.keyCode;
    if(tecla == 13){
      _y1 = _y1 + parseInt(FUENTE.val());

      CTX.font = "bold " + FUENTE.val() + "px sans-serif";
      CTX.fillStyle = COLOR.val();
      CTX.fillText($(this).val(),_x1, _y1);

      if($(this).val().toString().length>0){
        EnviarAccion(4, _x1, _y1, 0, 0, $(this).val());
      }
      $(this).val("").hide();
      $("#back-texto").hide();
    }
  });
}

function Borrador(x1, y1){
  var g = $("#hiddenGrosor").val();
  CTX.fillRect(x1 -(g/2), y1-(g/2), g, g);
}

function Imagen(x1, y1, x2, y2){
  var _x1 = x1 > x2 ? x2 : x1;
  var _x2 = x2 > x1 ? x2 : x1;
  var _y1 = y1 > y2 ? y2 : y1;
  var _y2 = y2 > y1 ? y2 : y1;
  var img = new Image();
  img.src = "https://mdn.mozillademos.org/files/224/Canvas_default_grid.png";
  CTX.drawImage(img, _x1, _y1, _x2-_x1, _y2-_y1);
}



function EnviarAccion(accion, x1, y1, x2, y2, add){
  if( accion==4){
    var msg = { us: USUARIO.id, lec: $("#hiddenLeccion").val(), act: accion, x1: x1, y1: y1, x2: x2, y2: y2
      , col: COLOR.val(), gr: FUENTE.val(), add: add };
  }
  else{
    var msg = { us: USUARIO.id, lec: $("#hiddenLeccion").val(), act: accion, x1: x1, y1: y1, x2: x2, y2: y2
      , col: COLOR.val(), gr: $("#hiddenGrosor").val(), add: add };
  }

  SOCKET_PIZARRA.send(msg);
}

AddSocketInstance(SOCKET_PIZARRA);
AddSocketInstance(SOCKET_CLASE);
AddSocketInstance(SOCKET_MENSAJE);
StartServer();
