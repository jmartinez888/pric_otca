var BORRADOR = 0;

function CanvasRecta(ctx, x1, y1, x2, y2, color){
  setBorrador(0);
  ctx.beginPath();
  ctx.strokeStyle = color;
  ctx.moveTo(x1,y1);
  ctx.lineTo(x2,y2);
  ctx.closePath();
  ctx.stroke();
}

function CanvasCuadro(ctx, x1, y1, x2, y2, color, gr){
  setBorrador(0);
  ctx.fillStyle = color;
  ctx.fillRect(x1, y1, x2-x1, gr);
  ctx.fillRect(x1, y1, gr, y2-y1);
  ctx.fillRect(x2 - gr, y1, gr, y2-y1);
  ctx.fillRect(x1, y2 - gr, x2-x1, gr);
}

function Marcador(x1, y1, text){
  setBorrador(0);
  $("#marcador").html(text);
  $("#marcador").show().css({ "top": y1 + "px", "left": x1 + "px" });
}

function CanvasClear(ctx, obj){
  setBorrador(0);
  ctx.clearRect(0, 0, obj.width(), obj.height());
}

function RemoveMarcador(){
  setBorrador(0);
  $("#marcador").hide();
}

function CanvasTexto(ctx, x1, y1, fuente, color, text){
  setBorrador(0);
  ctx.font = "bold " + fuente + "px sans-serif";
  ctx.fillStyle = color;
  ctx.fillText(text, x1, y1);
}

function CanvasCursor(ctx, x, y, state, grosor){
  if(state == 1){
    if(BORRADOR==1){
      ctx.fillRect(x1 -(grosor/2), y1-(grosor/2), grosor, grosor);
    }
    $("#mouse_on").show();
    $("#mouse_off").hide();
  }else{
    $("#mouse_off").show();
    $("#mouse_on").hide();
  }
  $("#mouse-helper").css({ "top": y + "px", "left": x + "px", "display": "" });
}
function CanvasCursorOff(){
  $("#mouse-helper").hide();
}

function CanvasBorrador(ctx){
  ctx.fillStyle = "#ffffff";
  setBorrador(1);
}

function setBorrador(s){
  if(s==1){
    console.log("Se activó el borrador");
  }else{
    console.log("Se cerró el borrador");
  }
  BORRADOR = s;
}
