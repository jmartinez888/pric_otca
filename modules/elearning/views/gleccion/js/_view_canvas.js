var canvasview = null;
$(document).ready(() => {
  canvasview = new fabric.Canvas('micanvas', {
    backgroundColor: 'white'
  })
  canvasview.setDimensions({width: 650, height:365.625})
  canvasview.setZoom(0.5078125)

})