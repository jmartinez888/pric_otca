$(".learn_chat_window_button").click(function(){
	var estado = $(this).find(".estado");
	var icon = $(this).find(".glyphicon");

	if(estado.val()==1){
		icon.removeClass("glyphicon-triangle-bottom").addClass("glyphicon-triangle-top");
		$(".learn_chat_content").hide();
		estado.val(0);
	}else{
		$(".learn_chat_content").show();
		icon.removeClass("glyphicon-triangle-top").addClass("glyphicon-triangle-bottom");
		estado.val(1);
	}
});
