var CANVAS = $("#micanvas");
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
