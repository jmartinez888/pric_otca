$(".pizarra-mini").click(function(){
	var Pizarra = $(this).find(".hidden_IdPizarra").val();
	if (Pizarra==0){ Pizarra = -1; }
	$.ajax({ 
		url: $("#hiddenURL").val() + "elearning/clase/_registrar_interaccion",
		data: { leccion: $("#hiddenLeccion").val(), pizarra: Pizarra },
		type: "POST",
		success: function(a){
			if(Pizarra==-1){ Pizarra = 0; }
			var msg = { us: USUARIO.id, lec: $("#hiddenLeccion").val(), act: 100, add: Pizarra };
		  	SOCKET_PIZARRA.send(msg);
		}
	});
});
