var CANVAS = $("#micanvas");
var CONTENEDOR_CONT = $("#leccion-contenido");
var COLOR_TOOGLE = $("#hiddenEnabled");
var ACT_TOOGLE = $("#hiddenActividad");
var TOOGLE = $("#hiddenClick");
var INOVER = $("#hiddenOver");
var CURSOR_HELPER = $("#cursor-helper");
var HERRAMIENTA = $("#hiddenHerramienta");
var TIEMPO_TR = $.now();

var PRESS = false, OVER = true;
var CURSOR_HELPER_POS = { x: 0, y: 0};
var COORD = { x1: CANVAS.offset().left, y1: CANVAS.offset().top,
              x2: CANVAS.offset().left + CANVAS.width(), y2: CANVAS.offset().top + CANVAS.height() };

$(window).resize(function() {
  var _cv = $("#micanvas");
  COORD = { x1: _cv.offset().left, y1: _cv.offset().top,
            x2: _cv.offset().left + _cv.width(), y2: _cv.offset().top + _cv.height() };
});
$(document).mousedown(function(e) {
  if(COLOR_TOOGLE==0){ return; }
  if(OVER){
    PRESS = true;
    TOOGLE.val(1);
    var mouse = { x: e.pageX, y: e.pageY };
    $("#hiddenX1").val(mouse.x);
    $("#hiddenY1").val(mouse.y);
    CURSOR_HELPER_POS.x = mouse.x;
    CURSOR_HELPER_POS.y = mouse.y;

    var punto = { x: (mouse.x - CONTENEDOR_CONT.offset().left), y: (mouse.y-CONTENEDOR_CONT.offset().top) }
    CURSOR_HELPER.css({ "top": mouse.y + "px", "left": mouse.x + "px", "display": "" });
  }
});
$(document).mouseup(function(e) {
  var mouse = { x: e.pageX, y: e.pageY};
  PRESS = false;
  $("#hiddenX2").val(mouse.x);
  $("#hiddenY2").val(mouse.y);
});
$(document).mousemove(function(e) {
  var _can = $("#micanvas");
  if(COLOR_TOOGLE==0){ return; }
  var posX = e.pageX < COORD.x1 ? COORD.x1 : (e.pageX > COORD.x2 ? COORD.x2 : e.pageX);
  var posY = e.pageY < COORD.y1 ? COORD.y1 : (e.pageY > COORD.y2 ? COORD.y2 : e.pageY);
  var mouse = { x: posX, y: posY };

  if(mouse.x > COORD.x1 && mouse.x < COORD.x2 && mouse.y > COORD.y1 && mouse.y < COORD.y2){
    OVER= true; INOVER.val(1);
    if(!PRESS && (ACT_TOOGLE.val()==1)){
      if ($.now() - TIEMPO_TR > 30){
        EnviarAccion(7, (mouse.x - _can.offset().left), (mouse.y - _can.offset().top), 0, 0, 0);
        TIEMPO_TR = $.now();
      }
    }
  }else{
    OVER= false; INOVER.val(0);
    if ( ($.now() - TIEMPO_TR > 30) && ACT_TOOGLE.val()==1){
      EnviarAccion(8, 0, 0, 0, 0, 0);
      TIEMPO_TR = $.now();
    }
  }
  if(PRESS && HERRAMIENTA.val() != 5){
    if ( ($.now() - TIEMPO_TR > 30) && ACT_TOOGLE.val()==1){
      EnviarAccion(7, (mouse.x - _can.offset().left), (mouse.y - _can.offset().top), 0, 0, 1);
      TIEMPO_TR = $.now();
    }
    var posX = mouse.x < CURSOR_HELPER_POS.x ? mouse.x : CURSOR_HELPER_POS.x;
    var posY = mouse.y < CURSOR_HELPER_POS.y ? mouse.y : CURSOR_HELPER_POS.y;

    posX -= CONTENEDOR_CONT.offset().left;
    posY -= CONTENEDOR_CONT.offset().top;

    var height = Math.abs(mouse.y - CURSOR_HELPER_POS.y);
    var widht = Math.abs(mouse.x - CURSOR_HELPER_POS.x);


    CURSOR_HELPER.css({"top": posY + "px",
                      "left": posX +"px",
                      "width": widht + "px",
                      "height": height +"px" });
  }
});
