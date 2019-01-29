$(document).ready(e => {
	var btnLeccion = $('#btn-show-leccion')
  var btnClose = $('#btn-close-leccion')
  var items = $('#leccionar-container .item-leccion')
  btnClose.on('click', e => {
      items.not('.item-active').addClass('hidden')
      btnLeccion.removeClass('hidden')
      btnClose.addClass('hidden')
  })
  btnLeccion.on('click', e => {
      items.removeClass('hidden')
      btnLeccion.addClass('hidden')
      btnClose.removeClass('hidden')
  })
})