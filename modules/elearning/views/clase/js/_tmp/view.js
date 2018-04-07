var VIEW_WIDTH = 0;
var VIEW_HEIGHT = 0;

$(document).ready(function($){
	VIEW_WIDTH = $(window).width();
	VIEW_HEIGHT = $(window).height();

  if(VIEW_WIDTH > 700){
    $(".content-chat").css({"height" : (VIEW_HEIGHT-110 ) + "px"});
  }
});

$(window).resize(function() {
  VIEW_WIDTH = $(window).width();
  VIEW_HEIGHT = $(window).height();

  if(VIEW_WIDTH > 700){
		$(".content-chat").css({"height" : (VIEW_HEIGHT-110) + "px"});
  }
});
