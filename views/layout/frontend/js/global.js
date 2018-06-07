/*!
 * jQuery JavaScript Library v1.5.2
 * http://jquery.com/
 *
 * Copyright 2011, John Resig
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * Includes Sizzle.js
 * http://sizzlejs.com/
 * Copyright 2011, The Dojo Foundation
 * Released under the MIT, BSD, and GPL Licenses.
 *
 * Date: Thu Mar 31 15:28:23 2011 -0400
 */
 //--------------------------------------------------
$(document).ready(function() {
	// hover image desc
	$(".image-caption .container").has(".hover").each(function() { 
		var gthis = $(this);

		gthis.bind("mouseover",function(obj) {
			gthis.find(".hover").show();	
		});
		
		gthis.bind("mouseout",function(obj) {
			gthis.find(".hover").hide();	
		});		
	});

	// email links
	$(".email-link a.email").each(function(){
		var link = $(this);
		
		aEmail = this.title.split("--");
		sEmail = aEmail[2] + "@" + aEmail[1] + "." + aEmail[0];
		link.attr("href","mailto:"+sEmail);
	});	
	
	
	// gallery right
	$(".right-column .gallery").each(function() { 
	
		var gthis = $(this);
		var iIndex = gthis.find("> ul > li").first().index();
		
		var oLi = gthis.find("> ul > li").eq(iIndex);
		oLi.siblings().hide();
		var iLen = oLi.parent().find("li").length;
		if (iLen > 1) {
	
			var bClick = true;
			
			gthis.find(".paging .prev").bind("click",function(){
				if (bClick)
				{
					bClick = false;	

					if (iIndex == 0)
						iIndex = iLen;
										
					iIndex--;	
					gthis.find("> ul > li").eq(iIndex).siblings().hide();
					gthis.find("> ul > li").eq(iIndex).fadeIn(function() {bClick = true;});
					
				}		
				return false;
			});
			
			gthis.find(".paging .next").bind("click",function(){
				if (bClick)
				{
					bClick = false;
					
					if (iIndex == iLen-1)
						iIndex = -1;	
					
					iIndex++;	
					gthis.find("> ul > li").eq(iIndex).siblings().hide();
					gthis.find("> ul > li").eq(iIndex).fadeIn(function() {bClick = true;});
						
	
				}	
				
				return false;
			});	
				
		} else {
			gthis.find(".paging").hide();
		}

	});
	
	
	// tabbed gallery
	iIndex = $(".priorities .tabs li").first().index();
	$(".priorities .tabbedcontent > li").hide();
	
	$(".priorities .tabs > li").bind("click",function(){
	
		$(this).addClass("selected").siblings().removeClass("selected");
		var iIndex = $(this).index();
		var oLi = $(".priorities .tabbedcontent > li").eq(iIndex);
		oLi.siblings().hide();
		oLi.fadeIn(300);

		
		if (oLi.find("li").length > 6) {
			$(".priorities .paging").show();
			var bClick = true;
			var iLiWidth = oLi.find("li").eq(0).outerWidth(true);
			
			$(".priorities .paging .prev").bind("click",function(){
				if (bClick)
				{
					bClick = false;				
					oLi.find("div").scrollTo("-="+iLiWidth,300,{axis:"x", onAfter:function(){ bClick = true } })
				}		
				return false;
			});
			
			$(".priorities .paging .next").bind("click",function(){
				if (bClick)
				{
					bClick = false;
					if( (oLi.find("ul").width() - oLi.find("div").width() - parseInt(oLi.find("li").css("margin-right"))) > oLi.find("ul").position().left*-1 ) 
					{	
						oLi.find("div").scrollTo("+="+iLiWidth,300,{axis:"x", onAfter:function(){ bClick = true } })
					}
					else
					{
						bClick = true;
					}
				}	
				return false;
			});	
				
		} else {
			$(".priorities .paging").hide();
		}
		
		return false;
	});
	
	
	$(".priorities .tabs li").eq(iIndex).trigger("click");
		
	// footer gallery

	// gallery right
	$(".teasers .teasers .gallery").each(function() { 
	
		var gthis = $(this);
		var iIndex = gthis.find("> ul > li").first().index();
		var oLi = gthis.find("> ul > li").eq(iIndex);
		oLi.siblings().hide();
		var iLen = oLi.parent().find("li").length;
		
		if (iLen > 1) {
	
			var bClick = true;

			gthis.find(".paging .prev").bind("click",function(){
				
				if (bClick)
				{
					bClick = false;	

					if (iIndex == 0)
						iIndex = iLen;
					
					iIndex--;	
					gthis.find("> ul > li").eq(iIndex).siblings().hide();
					gthis.find("> ul > li").eq(iIndex).fadeIn(function() {bClick = true;});
					
				}		
				return false;
			});
			
			gthis.find(".paging .next").bind("click",function(){
				
				if (bClick)
				{
					bClick = false;
					
					if (iIndex == iLen-1)
						iIndex = -1;	
					
					iIndex++;	
					gthis.find("> ul > li").eq(iIndex).siblings().hide();
					gthis.find("> ul > li").eq(iIndex).fadeIn(function() {bClick = true;});
						
	
				}	
				
				return false;
			});	
				
		} else {
			gthis.find(".paging").hide();
		}

	});	
	
	
/*	var oLi = $(".teasers .gallery > ul > li").eq(iIndex);
	oLi.siblings().hide();
	iLen = oLi.parent().find("li").length;
	
	if (iLen > 1) {

		var bClick = true;
		
		$(".teasers .paging .prev").bind("click",function(){
			if (bClick)
			{
				bClick = false;	

				if (iIndex == 0)
					iIndex = iLen;
					
				iIndex--;	
				$(".teasers .gallery > ul > li").eq(iIndex).siblings().hide();
				$(".teasers .gallery > ul > li").eq(iIndex).fadeIn(function() {bClick = true;});

				
			}		
			return false;
		});
		
		$(".teasers .paging .next").bind("click",function(){
			if (bClick)
			{
				bClick = false;

				if (iIndex == iLen-1)
					iIndex = -1;				
				
				iIndex++;	
				$(".teasers .gallery > ul > li").eq(iIndex).siblings().hide();
				$(".teasers .gallery > ul > li").eq(iIndex).fadeIn(function() {bClick = true;});
					

			}	
			
			return false;
		});	
			
	} else {
		$(".teasers .paging").hide();
	}
	
	return false;
	*/	
});


function noCache()
{
	return "uNC=" + parseInt(Math.random()*10000000);

}
//--------------------------------------------------
/*
 Galleria v 1.2.2 2011-02-25
 http://galleria.aino.se

 Copyright (c) 2011, Aino
 Licensed under the MIT license.
*/
(function(e){var s=this,t=s.document,I=e(t),E=false,x=navigator.userAgent.toLowerCase(),J=s.location.hash.replace(/#\//,""),y=function(){return j.TOUCH?"touchstart":"click"},u=function(){var a=3,b=t.createElement("div"),c=b.getElementsByTagName("i");do b.innerHTML="<!--[if gt IE "+ ++a+"]><i></i><![endif]--\>";while(c[0]);return a>4?a:void 0}(),z=function(){return{html:t.documentElement,body:t.body,head:t.getElementsByTagName("head")[0],title:t.title}},K=function(){var a=[];e.each("data ready thumbnail loadstart loadfinish image play pause progress fullscreen_enter fullscreen_exit idle_enter idle_exit rescale lightbox_open lightbox_close lightbox_image".split(" "),
function(b,c){a.push(c);/_/.test(c)&&a.push(c.replace(/_/g,""))});return a}(),L=function(a){var b;if(typeof a!=="object")return a;e.each(a,function(c,d){if(/^[a-z]+_/.test(c)){b="";e.each(c.split("_"),function(i,k){b+=i>0?k.substr(0,1).toUpperCase()+k.substr(1):k});a[b]=d;delete a[c]}});return a},F=function(a){if(e.inArray(a,K)>-1)return j[a.toUpperCase()];return a},B={trunk:{},add:function(a,b,c,d){d=d||false;this.clear(a);if(d){var i=b;b=function(){i();B.add(a,b,c)}}this.trunk[a]=s.setTimeout(b,
c)},clear:function(a){var b=function(d){s.clearTimeout(this.trunk[d]);delete this.trunk[d]},c;if(a&&a in this.trunk)b.call(B,a);else if(typeof a==="undefined")for(c in this.trunk)this.trunk.hasOwnProperty(c)&&b.call(B,c)}},C=[],g=function(){return{array:function(a){return Array.prototype.slice.call(a)},create:function(a,b){b=b||"div";var c=t.createElement(b);c.className=a;return c},forceStyles:function(a,b){a=e(a);a.attr("style")&&a.data("styles",a.attr("style")).removeAttr("style");a.css(b)},revertStyles:function(){e.each(g.array(arguments),
function(a,b){b=e(b).removeAttr("style");b.data("styles")&&b.attr("style",b.data("styles")).data("styles",null)})},moveOut:function(a){g.forceStyles(a,{position:"absolute",left:-1E4})},moveIn:function(){g.revertStyles.apply(g,g.array(arguments))},hide:function(a,b,c){a=e(a);a.data("opacity")||a.data("opacity",a.css("opacity"));var d={opacity:0};b?a.stop().animate(d,b,c):a.css(d)},show:function(a,b,c){a=e(a);var d=parseFloat(a.data("opacity"))||1,i={opacity:d};d===1&&a.data("opacity",null);b?a.stop().animate(i,
b,c):a.css(i)},addTimer:function(){B.add.apply(B,g.array(arguments));return this},clearTimer:function(){B.clear.apply(B,g.array(arguments));return this},wait:function(a){a=e.extend({until:function(){return false},success:function(){},error:function(){j.raise("Could not complete wait function.")},timeout:3E3},a);var b=g.timestamp(),c,d,i=function(){d=g.timestamp();c=d-b;if(a.until(c)){a.success();return false}if(d>=b+a.timeout){a.error();return false}s.setTimeout(i,2)};s.setTimeout(i,2)},toggleQuality:function(a,
b){if(!(u!==7&&u!==8||!a)){if(typeof b==="undefined")b=a.style.msInterpolationMode==="nearest-neighbor";a.style.msInterpolationMode=b?"bicubic":"nearest-neighbor"}},insertStyleTag:function(a){var b=t.createElement("style");z().head.appendChild(b);if(b.styleSheet)b.styleSheet.cssText=a;else{a=t.createTextNode(a);b.appendChild(a)}},loadScript:function(a,b){var c=false,d=e("<script>").attr({src:a,async:true}).get(0);d.onload=d.onreadystatechange=function(){if(!c&&(!this.readyState||this.readyState===
"loaded"||this.readyState==="complete")){c=true;d.onload=d.onreadystatechange=null;typeof b==="function"&&b.call(this,this)}};z().head.appendChild(d)},parseValue:function(a){if(typeof a==="number")return a;else if(typeof a==="string")return(a=a.match(/\-?\d/g))&&a.constructor===Array?parseInt(a.join(""),10):0;else return 0},timestamp:function(){return(new Date).getTime()},loadCSS:function(a,b,c){var d,i=false,k;e("link[rel=stylesheet]").each(function(){if(RegExp(a).test(this.href)){d=this;return false}});
if(typeof b==="function"){c=b;b=void 0}c=c||function(){};if(d){c.call(d,d);return d}k=t.styleSheets.length;if(E)a+="?"+g.timestamp();if(e("#"+b).length){e("#"+b).attr("href",a);k--;i=true}else{d=e("<link>").attr({rel:"stylesheet",href:a,id:b}).get(0);s.setTimeout(function(){var l=e('link[rel="stylesheet"], style');l.length?l.get(0).parentNode.insertBefore(d,l[0]):z().head.appendChild(d);if(u)d.attachEvent("onreadystatechange",function(){if(d.readyState==="complete")i=true});else i=true},10)}typeof c===
"function"&&g.wait({until:function(){return i&&t.styleSheets.length>k},success:function(){g.addTimer("css",function(){c.call(d,d)},100)},error:function(){j.raise("Theme CSS could not load")},timeout:1E3});return d}}}(),G={fade:function(a,b){e(a.next).css("opacity",0).show().animate({opacity:1},a.speed,b);a.prev&&e(a.prev).css("opacity",1).show().animate({opacity:0},a.speed)},flash:function(a,b){e(a.next).css("opacity",0);a.prev?e(a.prev).animate({opacity:0},a.speed/2,function(){e(a.next).animate({opacity:1},
a.speed,b)}):e(a.next).animate({opacity:1},a.speed,b)},pulse:function(a,b){a.prev&&e(a.prev).hide();e(a.next).css("opacity",0).animate({opacity:1},a.speed,b)},slide:function(a,b){var c=e(a.next).parent(),d=this.$("images"),i=this._stageWidth,k=this.getOptions("easing");c.css({left:i*(a.rewind?-1:1)});d.animate({left:i*(a.rewind?1:-1)},{duration:a.speed,queue:false,easing:k,complete:function(){d.css("left",0);c.css("left",0);b()}})},fadeslide:function(a,b){var c=0,d=this.getOptions("easing"),i=this.getStageWidth();
if(a.prev){c=g.parseValue(e(a.prev).css("left"));e(a.prev).css({opacity:1,left:c}).animate({opacity:0,left:c+i*(a.rewind?1:-1)},{duration:a.speed,queue:false,easing:d})}c=g.parseValue(e(a.next).css("left"));e(a.next).css({left:c+i*(a.rewind?-1:1),opacity:0}).animate({opacity:1,left:c},{duration:a.speed,complete:b,queue:false,easing:d})}},j=function(){var a=this;this._theme=void 0;this._options={};this._playing=false;this._playtime=5E3;this._active=null;this._queue={length:0};this._data=[];this._dom=
{};this._thumbnails=[];this._initialized=false;this._stageHeight=this._stageWidth=0;this._target=void 0;this._id=Math.random();e.each("container stage images image-nav image-nav-left image-nav-right info info-text info-title info-description info-author thumbnails thumbnails-list thumbnails-container thumb-nav-left thumb-nav-right loader counter tooltip".split(" "),function(f,h){a._dom[h]=g.create("galleria-"+h)});e.each("current total".split(" "),function(f,h){a._dom[h]=g.create("galleria-"+h,"span")});
var b=this._keyboard={keys:{UP:38,DOWN:40,LEFT:37,RIGHT:39,RETURN:13,ESCAPE:27,BACKSPACE:8,SPACE:32},map:{},bound:false,press:function(f){var h=f.keyCode||f.which;h in b.map&&typeof b.map[h]==="function"&&b.map[h].call(a,f)},attach:function(f){var h,n;for(h in f)if(f.hasOwnProperty(h)){n=h.toUpperCase();if(n in b.keys)b.map[b.keys[n]]=f[h]}if(!b.bound){b.bound=true;I.bind("keydown",b.press)}},detach:function(){b.bound=false;I.unbind("keydown",b.press)}},c=this._controls={0:void 0,1:void 0,active:0,
swap:function(){c.active=c.active?0:1},getActive:function(){return c[c.active]},getNext:function(){return c[1-c.active]}},d=this._carousel={next:a.$("thumb-nav-right"),prev:a.$("thumb-nav-left"),width:0,current:0,max:0,hooks:[],update:function(){var f=0,h=0,n=[0];e.each(a._thumbnails,function(o,p){if(p.ready){f+=p.outerWidth||e(p.container).outerWidth(true);n[o+1]=f;h=Math.max(h,p.outerHeight||e(p.container).outerHeight(true))}});a.$("thumbnails").css({width:f,height:h});d.max=f;d.hooks=n;d.width=
a.$("thumbnails-list").width();d.setClasses();a.$("thumbnails-container").toggleClass("galleria-carousel",f>d.width)},bindControls:function(){var f;d.next.bind(y(),function(h){h.preventDefault();if(a._options.carouselSteps==="auto")for(f=d.current;f<d.hooks.length;f++){if(d.hooks[f]-d.hooks[d.current]>d.width){d.set(f-2);break}}else d.set(d.current+a._options.carouselSteps)});d.prev.bind(y(),function(h){h.preventDefault();if(a._options.carouselSteps==="auto")for(f=d.current;f>=0;f--)if(d.hooks[d.current]-
d.hooks[f]>d.width){d.set(f+2);break}else{if(f===0){d.set(0);break}}else d.set(d.current-a._options.carouselSteps)})},set:function(f){for(f=Math.max(f,0);d.hooks[f-1]+d.width>=d.max&&f>=0;)f--;d.current=f;d.animate()},getLast:function(f){return(f||d.current)-1},follow:function(f){if(f===0||f===d.hooks.length-2)d.set(f);else{for(var h=d.current;d.hooks[h]-d.hooks[d.current]<d.width&&h<=d.hooks.length;)h++;if(f-1<d.current)d.set(f-1);else f+2>h&&d.set(f-h+d.current+2)}},setClasses:function(){d.prev.toggleClass("disabled",
!d.current);d.next.toggleClass("disabled",d.hooks[d.current]+d.width>=d.max)},animate:function(){d.setClasses();var f=d.hooks[d.current]*-1;isNaN(f)||a.$("thumbnails").animate({left:f},{duration:a._options.carouselSpeed,easing:a._options.easing,queue:false})}},i=this._tooltip={initialized:false,open:false,init:function(){i.initialized=true;g.insertStyleTag(".galleria-tooltip{padding:3px 8px;max-width:50%;background:#ffe;color:#000;z-index:3;position:absolute;font-size:11px;line-height:1.3opacity:0;box-shadow:0 0 2px rgba(0,0,0,.4);-moz-box-shadow:0 0 2px rgba(0,0,0,.4);-webkit-box-shadow:0 0 2px rgba(0,0,0,.4);}");
a.$("tooltip").css("opacity",0.8);g.hide(a.get("tooltip"))},move:function(f){var h=a.getMousePosition(f).x;f=a.getMousePosition(f).y;var n=a.$("tooltip");h=h;var o=f,p=n.outerHeight(true)+1,q=n.outerWidth(true),r=p+15;q=a.$("container").width()-q-2;p=a.$("container").height()-p-2;if(!isNaN(h)&&!isNaN(o)){h+=10;o-=30;h=Math.max(0,Math.min(q,h));o=Math.max(0,Math.min(p,o));if(f<r)o=r;n.css({left:h,top:o})}},bind:function(f,h){i.initialized||i.init();var n=function(o,p){i.define(o,p);e(o).hover(function(){g.clearTimer("switch_tooltip");
a.$("container").unbind("mousemove",i.move).bind("mousemove",i.move).trigger("mousemove");i.show(o);j.utils.addTimer("tooltip",function(){a.$("tooltip").stop().show();g.show(a.get("tooltip"),400);i.open=true},i.open?0:500)},function(){a.$("container").unbind("mousemove",i.move);g.clearTimer("tooltip");a.$("tooltip").stop();g.hide(a.get("tooltip"),200,function(){a.$("tooltip").hide();g.addTimer("switch_tooltip",function(){i.open=false},1E3)})})};typeof h==="string"?n(f in a._dom?a.get(f):f,h):e.each(f,
function(o,p){n(a.get(o),p)})},show:function(f){f=e(f in a._dom?a.get(f):f);var h=f.data("tt"),n=function(o){s.setTimeout(function(p){return function(){i.move(p)}}(o),10);f.unbind("mouseup",n)};if(h=typeof h==="function"?h():h){a.$("tooltip").html(h.replace(/\s/,"&nbsp;"));f.bind("mouseup",n)}},define:function(f,h){if(typeof h!=="function"){var n=h;h=function(){return n}}f=e(f in a._dom?a.get(f):f).data("tt",h);i.show(f)}},k=this._fullscreen={scrolled:0,active:false,enter:function(f){k.active=true;
g.hide(a.getActiveImage());a.$("container").addClass("fullscreen");k.scrolled=e(s).scrollTop();g.forceStyles(a.get("container"),{position:"fixed",top:0,left:0,width:"100%",height:"100%",zIndex:1E4});var h={height:"100%",overflow:"hidden",margin:0,padding:0};g.forceStyles(z().html,h);g.forceStyles(z().body,h);a.attachKeyboard({escape:a.exitFullscreen,right:a.next,left:a.prev});a.rescale(function(){g.addTimer("fullscreen_enter",function(){g.show(a.getActiveImage());typeof f==="function"&&f.call(a)},
100);a.trigger(j.FULLSCREEN_ENTER)});e(s).resize(function(){k.scale()})},scale:function(){a.rescale()},exit:function(f){k.active=false;g.hide(a.getActiveImage());a.$("container").removeClass("fullscreen");g.revertStyles(a.get("container"),z().html,z().body);s.scrollTo(0,k.scrolled);a.detachKeyboard();a.rescale(function(){g.addTimer("fullscreen_exit",function(){g.show(a.getActiveImage());typeof f==="function"&&f.call(a)},50);a.trigger(j.FULLSCREEN_EXIT)});e(s).unbind("resize",k.scale)}},l=this._idle=
{trunk:[],bound:false,add:function(f,h){if(f){l.bound||l.addEvent();f=e(f);var n={},o;for(o in h)if(h.hasOwnProperty(o))n[o]=f.css(o);f.data("idle",{from:n,to:h,complete:true,busy:false});l.addTimer();l.trunk.push(f)}},remove:function(f){f=jQuery(f);e.each(l.trunk,function(h,n){if(n.length&&!n.not(f).length){a._idle.show(f);a._idle.trunk.splice(h,1)}});if(!l.trunk.length){l.removeEvent();g.clearTimer("idle")}},addEvent:function(){l.bound=true;a.$("container").bind("mousemove click",l.showAll)},removeEvent:function(){l.bound=
false;a.$("container").unbind("mousemove click",l.showAll)},addTimer:function(){g.addTimer("idle",function(){a._idle.hide()},a._options.idleTime)},hide:function(){a.trigger(j.IDLE_ENTER);e.each(l.trunk,function(f,h){var n=h.data("idle");if(n){h.data("idle").complete=false;h.stop().animate(n.to,{duration:a._options.idleSpeed,queue:false,easing:"swing"})}})},showAll:function(){g.clearTimer("idle");e.each(a._idle.trunk,function(f,h){a._idle.show(h)})},show:function(f){var h=f.data("idle");if(!h.busy&&
!h.complete){h.busy=true;a.trigger(j.IDLE_EXIT);g.clearTimer("idle");f.stop().animate(h.from,{duration:a._options.idleSpeed/2,queue:false,easing:"swing",complete:function(){e(this).data("idle").busy=false;e(this).data("idle").complete=true}})}l.addTimer()}},m=this._lightbox={width:0,height:0,initialized:false,active:null,image:null,elems:{},init:function(){a.trigger(j.LIGHTBOX_OPEN);if(!m.initialized){m.initialized=true;var f={},h=a._options,n="";h={overlay:"position:fixed;display:none;opacity:"+
h.overlayOpacity+";filter:alpha(opacity="+h.overlayOpacity*100+");top:0;left:0;width:100%;height:100%;background:"+h.overlayBackground+";z-index:99990",box:"position:fixed;display:none;width:400px;height:400px;top:50%;left:50%;margin-top:-200px;margin-left:-200px;z-index:99991",shadow:"position:absolute;background:#000;width:100%;height:100%;",content:"position:absolute;background-color:#fff;top:10px;left:10px;right:10px;bottom:10px;overflow:hidden",info:"position:absolute;bottom:10px;left:10px;right:10px;color:#444;font:11px/13px arial,sans-serif;height:13px",
close:"position:absolute;top:10px;right:10px;height:20px;width:20px;background:#fff;text-align:center;cursor:pointer;color:#444;font:16px/22px arial,sans-serif;z-index:99999",image:"position:absolute;top:10px;left:10px;right:10px;bottom:30px;overflow:hidden;display:block;",prevholder:"position:absolute;width:50%;top:0;bottom:40px;cursor:pointer;",nextholder:"position:absolute;width:50%;top:0;bottom:40px;right:-1px;cursor:pointer;",prev:"position:absolute;top:50%;margin-top:-20px;height:40px;width:30px;background:#fff;left:20px;display:none;line-height:40px;text-align:center;color:#000",
next:"position:absolute;top:50%;margin-top:-20px;height:40px;width:30px;background:#fff;right:20px;left:auto;display:none;line-height:40px;text-align:center;color:#000",title:"float:left",counter:"float:right;margin-left:8px;"};var o={};if(u===8){h.nextholder+="background:#000;filter:alpha(opacity=0);";h.prevholder+="background:#000;filter:alpha(opacity=0);"}e.each(h,function(p,q){n+=".galleria-lightbox-"+p+"{"+q+"}"});g.insertStyleTag(n);e.each("overlay box content shadow title info close prevholder prev nextholder next counter image".split(" "),
function(p,q){a.addElement("lightbox-"+q);f[q]=m.elems[q]=a.get("lightbox-"+q)});m.image=new j.Picture;e.each({box:"shadow content close prevholder nextholder",info:"title counter",content:"info image",prevholder:"prev",nextholder:"next"},function(p,q){var r=[];e.each(q.split(" "),function(w,v){r.push("lightbox-"+v)});o["lightbox-"+p]=r});a.append(o);e(f.image).append(m.image.container);e(z().body).append(f.overlay,f.box);(function(p){return p.hover(function(){e(this).css("color","#bbb")},function(){e(this).css("color",
"#444")})})(e(f.close).bind(y(),m.hide).html("&#215;"));e.each(["Prev","Next"],function(p,q){var r=e(f[q.toLowerCase()]).html(/v/.test(q)?"&#8249;&nbsp;":"&nbsp;&#8250;"),w=e(f[q.toLowerCase()+"holder"]);w.bind(y(),function(){m["show"+q]()});u<8?r.show():w.hover(function(){r.show()},function(){r.stop().fadeOut(200)})});e(f.overlay).bind(y(),m.hide)}},rescale:function(f){var h=Math.min(e(s).width()-40,m.width),n=Math.min(e(s).height()-60,m.height);n=Math.min(h/m.width,n/m.height);h=m.width*n+40;n=
m.height*n+60;h={width:h,height:n,marginTop:Math.ceil(n/2)*-1,marginLeft:Math.ceil(h/2)*-1};f?e(m.elems.box).css(h):e(m.elems.box).animate(h,a._options.lightboxTransitionSpeed,a._options.easing,function(){var o=m.image,p=a._options.lightboxFadeSpeed;a.trigger({type:j.LIGHTBOX_IMAGE,imageTarget:o.image});o.show();g.show(o.image,p);g.show(m.elems.info,p)})},hide:function(){m.image.image=null;e(s).unbind("resize",m.rescale);e(m.elems.box).hide();g.hide(m.elems.info);g.hide(m.elems.overlay,200,function(){e(this).hide().css("opacity",
a._options.overlayOpacity);a.trigger(j.LIGHTBOX_CLOSE)})},showNext:function(){m.show(a.getNext(m.active))},showPrev:function(){m.show(a.getPrev(m.active))},show:function(f){m.active=f=typeof f==="number"?f:a.getIndex();m.initialized||m.init();e(s).unbind("resize",m.rescale);var h=a.getData(f),n=a.getDataLength();g.hide(m.elems.info);m.image.load(h.image,function(o){m.width=o.original.width;m.height=o.original.height;e(o.image).css({width:"100.5%",height:"100.5%",top:0,zIndex:99998,opacity:0});m.elems.title.innerHTML=
h.title;m.elems.counter.innerHTML=f+1+" / "+n;e(s).resize(m.rescale);m.rescale()});e(m.elems.overlay).show();e(m.elems.box).show()}};return this};j.prototype={constructor:j,init:function(a,b){var c=this;b=L(b);C.push(this);this._original={target:a,options:b,data:null};if(this._target=this._dom.target=a.nodeName?a:e(a).get(0)){this._options={autoplay:false,carousel:true,carouselFollow:true,carouselSpeed:400,carouselSteps:"auto",clicknext:false,dataConfig:function(){return{}},dataSelector:"img",dataSource:this._target,
debug:void 0,easing:"galleria",extend:function(){},height:"auto",idleTime:3E3,idleSpeed:200,imageCrop:false,imageMargin:0,imagePan:false,imagePanSmoothness:12,imagePosition:"50%",keepSource:false,lightboxFadeSpeed:200,lightboxTransition_speed:500,linkSourceTmages:true,maxScaleRatio:void 0,minScaleRatio:void 0,overlayOpacity:0.85,overlayBackground:"#0b0b0b",pauseOnInteraction:true,popupLinks:false,preload:2,queue:true,show:0,showInfo:true,showCounter:true,showImagenav:true,thumbCrop:true,thumbEventType:y(),
thumbFit:true,thumbMargin:0,thumbQuality:"auto",thumbnails:true,transition:"fade",transitionInitial:void 0,transitionSpeed:400,width:"auto"};if(b&&b.debug===true)E=true;e(this._target).children().hide();typeof j.theme==="object"?this._init():g.wait({until:function(){return typeof j.theme==="object"},success:function(){c._init.call(c)},error:function(){j.raise("No theme found.",true)},timeout:5E3})}else j.raise("Target not found.")},_init:function(){var a=this;if(this._initialized){j.raise("Init failed: Gallery instance already initialized.");
return this}this._initialized=true;if(!j.theme){j.raise("Init failed: No theme found.");return this}e.extend(true,this._options,j.theme.defaults,this._original.options);this.bind(j.DATA,function(){this._original.data=this._data;this.get("total").innerHTML=this.getDataLength();var b=this.$("container"),c={width:0,height:0},d=g.create("galleria-image");g.wait({until:function(){e.each(["width","height"],function(k,l){c[l]=a._options[l]&&typeof a._options[l]==="number"?a._options[l]:Math.max(g.parseValue(b.css(l)),
g.parseValue(a.$("target").css(l)),b[l](),a.$("target")[l]())});var i=function(){return true};if(a._options.thumbnails){a.$("thumbnails").append(d);i=function(){return!!e(d).height()}}return i()&&c.width&&c.height>10},success:function(){e(d).remove();b.width(c.width);b.height(c.height);j.WEBKIT?s.setTimeout(function(){a._run()},1):a._run()},error:function(){j.raise("Width & Height not found.",true)},timeout:2E3})});this.bind(j.READY,function(b){return function(){g.show(this.get("counter"));this._options.carousel&&
this._carousel.bindControls();if(this._options.autoplay){this.pause();if(typeof this._options.autoplay==="number")this._playtime=this._options.autoplay;this.trigger(j.PLAY);this._playing=true}if(b)typeof this._options.show==="number"&&this.show(this._options.show);else{b=true;if(this._options.clicknext){e.each(this._data,function(c,d){delete d.link});this.$("stage").css({cursor:"pointer"}).bind(y(),function(){a.next()})}j.History&&j.History.change(function(c){c=parseInt(c.value.replace(/\//,""),10);
isNaN(c)?s.history.go(-1):a.show(c,void 0,true)});j.theme.init.call(this,this._options);this._options.extend.call(this,this._options);/^[0-9]{1,4}$/.test(J)&&j.History?this.show(J,void 0,true):this.show(this._options.show)}}}(false));this.append({"info-text":["info-title","info-description","info-author"],info:["info-text"],"image-nav":["image-nav-right","image-nav-left"],stage:["images","loader","counter","image-nav"],"thumbnails-list":["thumbnails"],"thumbnails-container":["thumb-nav-left","thumbnails-list",
"thumb-nav-right"],container:["stage","thumbnails-container","info","tooltip"]});g.hide(this.$("counter").append(this.get("current")," / ",this.get("total")));this.setCounter("&#8211;");g.hide(a.get("tooltip"));e.each(Array(2),function(b){var c=new j.Picture;e(c.container).css({position:"absolute",top:0,left:0});a.$("images").append(c.container);a._controls[b]=c});this.$("images").css({position:"relative",top:0,left:0,width:"100%",height:"100%"});this.$("thumbnails, thumbnails-list").css({overflow:"hidden",
position:"relative"});this.$("image-nav-right, image-nav-left").bind(y(),function(b){a._options.clicknext&&b.stopPropagation();a._options.pause_on_interaction&&a.pause();b=/right/.test(this.className)?"next":"prev";a[b]()});e.each(["info","counter","image-nav"],function(b,c){a._options["show"+c.substr(0,1).toUpperCase()+c.substr(1).replace(/-/,"")]===false&&g.moveOut(a.get(c.toLowerCase()))});this.load();if(!this._options.keep_source&&!u)this._target.innerHTML="";this.$("target").append(this.get("container"));
this._options.carousel&&this.bind(j.THUMBNAIL,function(){this.updateCarousel()});return this},_createThumbnails:function(){var a,b,c,d,i,k=this,l=this._options,m=function(){var q=k.$("thumbnails").find(".active");if(!q.length)return false;return q.find("img").attr("src")}(),f=typeof l.thumbnails==="string"?l.thumbnails.toLowerCase():null,h=function(q){return t.defaultView&&t.defaultView.getComputedStyle?t.defaultView.getComputedStyle(c.container,null)[q]:i.css(q)},n=function(q,r,w){return function(){e(w).append(q);
k.trigger({type:j.THUMBNAIL,thumbTarget:q,index:r})}},o=function(q){l.pauseOnInteraction&&k.pause();var r=e(q.currentTarget).data("index");k.getIndex()!==r&&k.show(r);q.preventDefault()},p=function(q){q.scale({width:q.data.width,height:q.data.height,crop:l.thumbCrop,margin:l.thumbMargin,complete:function(r){var w=["left","top"],v,A;e.each(["Width","Height"],function(D,H){v=H.toLowerCase();if((l.thumbCrop!==true||l.thumbCrop===v)&&l.thumbFit){A={};A[v]=r[v];e(r.container).css(A);A={};A[w[D]]=0;e(r.image).css(A)}r["outer"+
H]=e(r.container)["outer"+H](true)});g.toggleQuality(r.image,l.thumbQuality===true||l.thumbQuality==="auto"&&r.original.width<r.width*3);k.trigger({type:j.THUMBNAIL,thumbTarget:r.image,index:r.data.order})}})};this._thumbnails=[];this.$("thumbnails").empty();for(a=0;this._data[a];a++){d=this._data[a];if(l.thumbnails===true){c=new j.Picture(a);b=d.thumb||d.image;this.$("thumbnails").append(c.container);i=e(c.container);c.data={width:g.parseValue(h("width")),height:g.parseValue(h("height")),order:a};
l.thumbFit&&l.thumbCrop!==true?i.css({width:0,height:0}):i.css({width:c.data.width,height:c.data.height});c.load(b,p);l.preload==="all"&&c.add(d.image)}else if(f==="empty"||f==="numbers"){c={container:g.create("galleria-image"),image:g.create("img","span"),ready:true};f==="numbers"&&e(c.image).text(a+1);this.$("thumbnails").append(c.container);s.setTimeout(n(c.image,a,c.container),50+a*20)}else c={container:null,image:null};e(c.container).add(l.keepSource&&l.linkSourceImages?d.original:null).data("index",
a).bind(l.thumbEventType,o);m===b&&e(c.container).addClass("active");this._thumbnails.push(c)}},_run:function(){var a=this;a._createThumbnails();g.wait({until:function(){j.OPERA&&a.$("stage").css("display","inline-block");a._stageWidth=a.$("stage").width();a._stageHeight=a.$("stage").height();return a._stageWidth&&a._stageHeight>50},success:function(){a.trigger(j.READY)},error:function(){j.raise("Stage measures not found",true)}})},load:function(a,b,c){var d=this;this._data=[];this._thumbnails=[];
this.$("thumbnails").empty();if(typeof b==="function"){c=b;b=null}a=a||this._options.dataSource;b=b||this._options.dataSelector;c=c||this._options.dataConfig;if(a.constructor===Array){if(this.validate(a)){this._data=a;this._parseData().trigger(j.DATA)}else j.raise("Load failed: JSON Array not valid.");return this}e(a).find(b).each(function(i,k){k=e(k);var l={},m=k.parent().attr("href");if(/\.(png|gif|jpg|jpeg)(\?.*)?$/i.test(m))l.image=m;else if(m)l.link=m;d._data.push(e.extend({title:k.attr("title"),
thumb:k.attr("src"),image:k.attr("src"),description:k.attr("alt"),link:k.attr("longdesc"),original:k.get(0)},l,c(k)))});this.getDataLength()?this.trigger(j.DATA):j.raise("Load failed: no data found.");return this},_parseData:function(){var a=this;e.each(this._data,function(b,c){if("thumb"in c===false)a._data[b].thumb=c.image});return this},splice:function(){Array.prototype.splice.apply(this._data,g.array(arguments));return this._parseData()._createThumbnails()},push:function(){Array.prototype.push.apply(this._data,
g.array(arguments));return this._parseData()._createThumbnails()},_getActive:function(){return this._controls.getActive()},validate:function(){return true},bind:function(a,b){a=F(a);this.$("container").bind(a,this.proxy(b));return this},unbind:function(a){a=F(a);this.$("container").unbind(a);return this},trigger:function(a){a=typeof a==="object"?e.extend(a,{scope:this}):{type:F(a),scope:this};this.$("container").trigger(a);return this},addIdleState:function(){this._idle.add.apply(this._idle,g.array(arguments));
return this},removeIdleState:function(){this._idle.remove.apply(this._idle,g.array(arguments));return this},enterIdleMode:function(){this._idle.hide();return this},exitIdleMode:function(){this._idle.showAll();return this},enterFullscreen:function(){this._fullscreen.enter.apply(this,g.array(arguments));return this},exitFullscreen:function(){this._fullscreen.exit.apply(this,g.array(arguments));return this},toggleFullscreen:function(){this._fullscreen[this.isFullscreen()?"exit":"enter"].apply(this,g.array(arguments));
return this},bindTooltip:function(){this._tooltip.bind.apply(this._tooltip,g.array(arguments));return this},defineTooltip:function(){this._tooltip.define.apply(this._tooltip,g.array(arguments));return this},refreshTooltip:function(){this._tooltip.show.apply(this._tooltip,g.array(arguments));return this},openLightbox:function(){this._lightbox.show.apply(this._lightbox,g.array(arguments));return this},closeLightbox:function(){this._lightbox.hide.apply(this._lightbox,g.array(arguments));return this},
getActiveImage:function(){return this._getActive().image||void 0},getActiveThumb:function(){return this._thumbnails[this._active].image||void 0},getMousePosition:function(a){return{x:a.pageX-this.$("container").offset().left,y:a.pageY-this.$("container").offset().top}},addPan:function(a){if(this._options.imageCrop!==false){a=e(a||this.getActiveImage());var b=this,c=a.width()/2,d=a.height()/2,i=parseInt(a.css("left"),10),k=parseInt(a.css("top"),10),l=i||0,m=k||0,f=0,h=0,n=false,o=g.timestamp(),p=0,
q=0,r=function(v,A,D){if(v>0){q=Math.round(Math.max(v*-1,Math.min(0,A)));if(p!==q){p=q;if(u===8)a.parent()["scroll"+D](q*-1);else{v={};v[D.toLowerCase()]=q;a.css(v)}}}},w=function(v){if(!(g.timestamp()-o<50)){n=true;c=b.getMousePosition(v).x;d=b.getMousePosition(v).y}};if(u===8){a.parent().scrollTop(m*-1).scrollLeft(l*-1);a.css({top:0,left:0})}this.$("stage").unbind("mousemove",w).bind("mousemove",w);g.addTimer("pan",function(){if(n){f=a.width()-b._stageWidth;h=a.height()-b._stageHeight;i=c/b._stageWidth*
f*-1;k=d/b._stageHeight*h*-1;l+=(i-l)/b._options.imagePanSmoothness;m+=(k-m)/b._options.imagePanSmoothness;r(h,m,"Top");r(f,l,"Left")}},50,true);return this}},proxy:function(a,b){if(typeof a!=="function")return function(){};b=b||this;return function(){return a.apply(b,g.array(arguments))}},removePan:function(){this.$("stage").unbind("mousemove");g.clearTimer("pan");return this},addElement:function(){var a=this._dom;e.each(g.array(arguments),function(b,c){a[c]=g.create("galleria-"+c)});return this},
attachKeyboard:function(){this._keyboard.attach.apply(this._keyboard,g.array(arguments));return this},detachKeyboard:function(){this._keyboard.detach.apply(this._keyboard,g.array(arguments));return this},appendChild:function(a,b){this.$(a).append(this.get(b)||b);return this},prependChild:function(a,b){this.$(a).prepend(this.get(b)||b);return this},remove:function(){this.$(g.array(arguments).join(",")).remove();return this},append:function(a){var b,c;for(b in a)if(a.hasOwnProperty(b))if(a[b].constructor===
Array)for(c=0;a[b][c];c++)this.appendChild(b,a[b][c]);else this.appendChild(b,a[b]);return this},_scaleImage:function(a,b){b=e.extend({width:this._stageWidth,height:this._stageHeight,crop:this._options.imageCrop,max:this._options.maxScaleRatio,min:this._options.minScaleRatio,margin:this._options.imageMargin,position:this._options.imagePosition},b);(a||this._controls.getActive()).scale(b);return this},updateCarousel:function(){this._carousel.update();return this},rescale:function(a,b,c){var d=this;
if(typeof a==="function"){c=a;a=void 0}var i=function(){d._stageWidth=a||d.$("stage").width();d._stageHeight=b||d.$("stage").height();d._scaleImage();d._options.carousel&&d.updateCarousel();d.trigger(j.RESCALE);typeof c==="function"&&c.call(d)};j.WEBKIT&&!a&&!b?g.addTimer("scale",i,5):i.call(d);return this},refreshImage:function(){this._scaleImage();this._options.imagePan&&this.addPan();return this},show:function(a,b,c){if(!(a===false||!this._options.queue&&this._queue.stalled)){a=Math.max(0,Math.min(parseInt(a,
10),this.getDataLength()-1));b=typeof b!=="undefined"?!!b:a<this.getIndex();c=c||false;if(!c&&j.History)j.History.value(a.toString());else{this._active=a;Array.prototype.push.call(this._queue,{index:a,rewind:b});this._queue.stalled||this._show();return this}}},_show:function(){var a=this,b=this._queue[0],c=this.getData(b.index);if(c){var d=c.image,i=this._controls.getActive(),k=this._controls.getNext(),l=k.isCached(d),m=this._thumbnails[b.index],f=function(){a._queue.stalled=false;g.toggleQuality(k.image,
a._options.imageQuality);e(i.container).css({zIndex:0,opacity:0});e(k.container).css({zIndex:1,opacity:1});a._controls.swap();a._options.imagePan&&a.addPan(k.image);c.link&&e(k.image).css({cursor:"pointer"}).bind(y(),function(){if(a._options.popupLinks)s.open(c.link,"_blank");else s.location.href=c.link});Array.prototype.shift.call(a._queue);a._queue.length&&a._show();a._playCheck();a.trigger({type:j.IMAGE,index:b.index,imageTarget:k.image,thumbTarget:m.image})};this._options.carousel&&this._options.carouselFollow&&
this._carousel.follow(b.index);if(this._options.preload){var h,n,o=this.getNext();try{for(n=this._options.preload;n>0;n--){h=new j.Picture;h.add(a.getData(o).image);o=a.getNext(o)}}catch(p){}}g.show(k.container);e(a._thumbnails[b.index].container).addClass("active").siblings(".active").removeClass("active");a.trigger({type:j.LOADSTART,cached:l,index:b.index,imageTarget:k.image,thumbTarget:m.image});k.load(d,function(q){a._scaleImage(q,{complete:function(r){g.show(r.container);"image"in i&&g.toggleQuality(i.image,
false);g.toggleQuality(r.image,false);a._queue.stalled=true;a.removePan();a.setInfo(b.index);a.setCounter(b.index);a.trigger({type:j.LOADFINISH,cached:l,index:b.index,imageTarget:r.image,thumbTarget:a._thumbnails[b.index].image});var w=i.image===null&&a._options.transitionInitial?a._options.transition_Initial:a._options.transition;w in G===false?f():G[w].call(a,{prev:i.image,next:r.image,rewind:b.rewind,speed:a._options.transitionSpeed||400},f)}})})}},getNext:function(a){a=typeof a==="number"?a:this.getIndex();
return a===this.getDataLength()-1?0:a+1},getPrev:function(a){a=typeof a==="number"?a:this.getIndex();return a===0?this.getDataLength()-1:a-1},next:function(){this.getDataLength()>1&&this.show(this.getNext(),false);return this},prev:function(){this.getDataLength()>1&&this.show(this.getPrev(),true);return this},get:function(a){return a in this._dom?this._dom[a]:null},getData:function(a){return a in this._data?this._data[a]:this._data[this._active]},getDataLength:function(){return this._data.length},
getIndex:function(){return typeof this._active==="number"?this._active:false},getStageHeight:function(){return this._stageHeight},getStageWidth:function(){return this._stageWidth},getOptions:function(a){return typeof a==="undefined"?this._options:this._options[a]},setOptions:function(a,b){if(typeof a==="object")e.extend(this._options,a);else this._options[a]=b;return this},play:function(a){this._playing=true;this._playtime=a||this._playtime;this._playCheck();this.trigger(j.PLAY);return this},pause:function(){this._playing=
false;this.trigger(j.PAUSE);return this},playToggle:function(a){return this._playing?this.pause():this.play(a)},isPlaying:function(){return this._playing},isFullscreen:function(){return this._fullscreen.active},_playCheck:function(){var a=this,b=0,c=g.timestamp(),d="play"+this._id;if(this._playing){g.clearTimer(d);var i=function(){b=g.timestamp()-c;if(b>=a._playtime&&a._playing){g.clearTimer(d);a.next()}else if(a._playing){a.trigger({type:j.PROGRESS,percent:Math.ceil(b/a._playtime*100),seconds:Math.floor(b/
1E3),milliseconds:b});g.addTimer(d,i,20)}};g.addTimer(d,i,20)}},setIndex:function(a){this._active=a;return this},setCounter:function(a){if(typeof a==="number")a++;else if(typeof a==="undefined")a=this.getIndex()+1;this.get("current").innerHTML=a;if(u){a=this.$("counter");var b=a.css("opacity"),c=a.attr("style");c&&parseInt(b,10)===1?a.attr("style",c.replace(/filter[^\;]+\;/i,"")):this.$("counter").css("opacity",b)}return this},setInfo:function(a){var b=this,c=this.getData(a);e.each(["title","description",
"author"],function(d,i){var k=b.$("info-"+i);c[i]?k[c[i].length?"show":"hide"]().html(c[i]):k.empty().hide()});return this},hasInfo:function(a){var b="title description".split(" "),c;for(c=0;b[c];c++)if(this.getData(a)[b[c]])return true;return false},jQuery:function(a){var b=this,c=[];e.each(a.split(","),function(i,k){k=e.trim(k);b.get(k)&&c.push(k)});var d=e(b.get(c.shift()));e.each(c,function(i,k){d=d.add(b.get(k))});return d},$:function(){return this.jQuery.apply(this,g.array(arguments))}};e.each(K,
function(a,b){var c=/_/.test(b)?b.replace(/_/g,""):b;j[b.toUpperCase()]="galleria."+c});e.extend(j,{IE9:u===9,IE8:u===8,IE7:u===7,IE6:u===6,IE:!!u,WEBKIT:/webkit/.test(x),SAFARI:/safari/.test(x),CHROME:/chrome/.test(x),QUIRK:u&&t.compatMode&&t.compatMode==="BackCompat",MAC:/mac/.test(navigator.platform.toLowerCase()),OPERA:!!s.opera,IPHONE:/iphone/.test(x),IPAD:/ipad/.test(x),ANDROID:/android/.test(x),TOUCH:!!(/iphone/.test(x)||/ipad/.test(x)||/android/.test(x))});j.addTheme=function(a){a.name||j.raise("No theme name specified");
a.defaults=typeof a.defaults!=="object"?{}:L(a.defaults);var b=false,c;if(typeof a.css==="string"){e("link").each(function(d,i){c=RegExp(a.css);if(c.test(i.href)){b=true;j.theme=a;return false}});b||e("script").each(function(d,i){c=RegExp("galleria\\."+a.name.toLowerCase()+"\\.");if(c.test(i.src)){b=i.src.replace(/[^\/]*$/,"")+a.css;g.addTimer("css",function(){g.loadCSS(b,"galleria-theme",function(){j.theme=a})},1)}});b||j.raise("No theme CSS loaded")}else j.theme=a;return a};j.loadTheme=function(a,
b){var c=false,d=C.length;j.theme=void 0;g.loadScript(a,function(){c=true});g.wait({until:function(){return c},error:function(){j.raise("Theme at "+a+" could not load, check theme path.",true)},success:function(){if(d){var i=[];e.each(j.get(),function(k,l){var m=e.extend(l._original.options,{data_source:l._data},b);l.$("container").remove();var f=new j;f._id=l._id;f.init(l._original.target,m);i.push(f)});C=i}},timeout:2E3})};j.get=function(a){if(C[a])return C[a];else if(typeof a!=="number")return C;
else j.raise("Gallery index "+a+" not found")};j.addTransition=function(a,b){G[a]=b};j.utils=g;j.log=function(){try{s.console.log.apply(s.console,g.array(arguments))}catch(a){try{s.opera.postError.apply(s.opera,arguments)}catch(b){s.alert(g.array(arguments).split(", "))}}};j.raise=function(a,b){if(E||b)throw Error((b?"Fatal error":"Error")+": "+a);};j.Picture=function(a){this.id=a||null;this.image=null;this.container=g.create("galleria-image");e(this.container).css({overflow:"hidden",position:"relative"});
this.original={width:0,height:0};this.loaded=this.ready=false};j.Picture.prototype={cache:{},add:function(a){var b=0,c=this,d=new Image,i=function(){if((!this.width||!this.height)&&b<1E3){b++;e(d).load(i).attr("src",a+"?"+(new Date).getTime())}c.original={height:this.height,width:this.width};c.cache[a]=a;c.loaded=true};e(d).css("display","block");if(c.cache[a]){d.src=a;i.call(d);return d}e(d).load(i).attr("src",a);return d},show:function(){g.show(this.image)},hide:function(){g.moveOut(this.image)},
clear:function(){this.image=null},isCached:function(a){return!!this.cache[a]},load:function(a,b){var c=this;e(this.container).empty(true);this.image=this.add(a);g.hide(this.image);e(this.container).append(this.image);g.wait({until:function(){return c.loaded&&c.image.complete&&c.original.width&&c.image.width},success:function(){s.setTimeout(function(){b.call(c,c)},50)},error:function(){s.setTimeout(function(){b.call(c,c)},50);j.raise("image not loaded in 10 seconds: "+a)},timeout:1E4});return this.container},
scale:function(a){a=e.extend({width:0,height:0,min:void 0,max:void 0,margin:0,complete:function(){},position:"center",crop:false},a);if(!this.image)return this.container;var b,c,d=this,i=e(d.container);g.wait({until:function(){b=a.width||i.width()||g.parseValue(i.css("width"));c=a.height||i.height()||g.parseValue(i.css("height"));return b&&c},success:function(){var k=(b-a.margin*2)/d.original.width,l=(c-a.margin*2)/d.original.height,m={"true":Math.max(k,l),width:k,height:l,"false":Math.min(k,l)}[a.crop.toString()];
if(a.max)m=Math.min(a.max,m);if(a.min)m=Math.max(a.min,m);e(d.container).width(b).height(c);e.each(["width","height"],function(o,p){e(d.image)[p](d.image[p]=d[p]=Math.round(d.original[p]*m))});var f={},h={};k=function(o,p,q){var r=0;if(/\%/.test(o)){o=parseInt(o,10)/100;p=d.image[p]||e(d.image)[p]();r=Math.ceil(p*-1*o+q*o)}else r=g.parseValue(o);return r};var n={top:{top:0},left:{left:0},right:{left:"100%"},bottom:{top:"100%"}};e.each(a.position.toLowerCase().split(" "),function(o,p){if(p==="center")p=
"50%";f[o?"top":"left"]=p});e.each(f,function(o,p){n.hasOwnProperty(p)&&e.extend(h,n[p])});f=f.top?e.extend(f,h):h;f=e.extend({top:"50%",left:"50%"},f);e(d.image).css({position:"relative",top:k(f.top,"height",c),left:k(f.left,"width",b)});d.show();d.ready=true;a.complete.call(d,d)},error:function(){j.raise("Could not scale image: "+d.image.src)},timeout:1E3});return this}};e.extend(e.easing,{galleria:function(a,b,c,d,i){if((b/=i/2)<1)return d/2*b*b*b*b+c;return-d/2*((b-=2)*b*b*b-2)+c},galleriaIn:function(a,
b,c,d,i){return d*(b/=i)*b*b*b+c},galleriaOut:function(a,b,c,d,i){return-d*((b=b/i-1)*b*b*b-1)+c}});e.fn.galleria=function(a){return this.each(function(){(new j).init(this,a)})};s.Galleria=j})(jQuery);
//--------------------------------------------------
$(function(){
	$('#_TB').addClass("hasjs");

	/* navigation submenus*/
	$('#nav > li').hover(
		function(){
			$('#nav > li').removeClass("hover");
			$(this).addClass("hover");
		},
		function(){
			$('#nav > li').removeClass("hover");
		}
	);
	
	/* region picker*/
	$('#region-picker:not(ul a)').toggle(
		function(){
			$(this).removeClass("active");
			$(this).addClass("active");
		},
		function(){
			$(this).removeClass("active");
		}
	);
	$('#region-picker ul li:not(.selected) a').bind("click",function() {
		document.location.href=$(this).attr("href");
	})
	
});
//--------------------------------------------------
if (typeof jQuery != 'undefined') {
    jQuery(document).ready(function($) {
        var filetypes = /\.(zip|exe|pdf|doc*|xls*|ppt*|mp3)$/i;
        var baseHref = '';
        if (jQuery('base').attr('href') != undefined)
            baseHref = jQuery('base').attr('href');
        jQuery('a').each(function() {
            var href = jQuery(this).attr('href');
            if (href && (href.match(/^https?\:/i)) && (!href.match(document.domain))) {
                jQuery(this).click(function() {
                    var extLink = href.replace(/^https?\:\/\//i, '');
                    _gaq.push(['_trackEvent', 'External', 'Click', extLink]);
                    if (jQuery(this).attr('target') != undefined && jQuery(this).attr('target').toLowerCase() != '_blank') {
                        setTimeout(function() { location.href = href; }, 200);
                        return false;
                    }
                });
            }
            else if (href && href.match(/^mailto\:/i)) {
                jQuery(this).click(function() {
                    var mailLink = href.replace(/^mailto\:/i, '');
                    _gaq.push(['_trackEvent', 'Email', 'Click', mailLink]);
                });
            }
            else if (href && href.match(filetypes)) {
                jQuery(this).click(function() {
                    var extension = (/[.]/.exec(href)) ? /[^.]+$/.exec(href) : undefined;
                    var filePath = href;
                    _gaq.push(['_trackEvent', 'Download', 'Click-' + extension, filePath]);
                    if (jQuery(this).attr('target') != undefined && jQuery(this).attr('target').toLowerCase() != '_blank') {
                        setTimeout(function() { location.href = baseHref + href; }, 200);
                        return false;
                    }
                });
            }
        });
    });
}

//--------------------------------------------------
/*
 * jQuery commenting plug-in 0.2
 *
 *
 * Copyright (c) 2008 Getunik / Jonas Rothfuchs
 *
 * $Id: jquery.getu.commenting.js,v 1.1 2009/06/10 07:55:59 jrs Exp $
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */

(function($) {
	$.extend($.fn, {
		addCommenting: function( options ) {
			commentator = new $.commentator( options, $(this[0]) );
			
			return true;
		}
	});
	
	// constructor for validator
	$.commentator = function( options, block ) {
		this.settings = $.extend( {}, $.commentator.defaults, options );
		this.currentBlock = block;
		this.init();
		this.setCommentFunctions();
	};
	
	$.extend($.commentator, {
		defaults: {
			usePaging: true,
			langID: 1,
			typeName: 'xnews',
			container: '.comment-list',
			switchContent: 'a.toggle:first',
			switchForm: 'a.toggle:last',
			showCommentSwitch: 'a.show',
			hideCommentSwitch: 'a.hide',
			flagSwitch: '.flag',
			pageSwitch: '.pages a',
			moreSwitch: '.more-comments',
			moreFooter: '.footer',
			textFlagFailed: 'flaggin failed default',
			designFunction: 'getCommentsByPage',
			corePath: '',
			coreCFC: 'asyncFunctions.cfc',
			sortOrder: 'DESC',
			toggleBlock: function (element, status) {
				$(this).toggleClass('open');
				$(this).next('div').toggleClass('show');
			},
			showComment: function (element) {
				$(this).next('a.hide').show();
				$(this).parents('.comment').toggleClass('show');
				$(this).hide();
			},
			hideComment: function (element) {
				$(this).prev('a.show').show();
				$(this).parents('.comment').toggleClass('show');
				$(this).hide();
			},
			onReload: function () {
				
			},
			onReloadEnd: function () {
				
			},
			flaggingSuccess: function (){
				$(this).parents('.comment').addClass('flagged');
			},
			flaggingFailed: function () {
				$(this).text('flagging failed X');
			}
		},
		
		setDefaults: function(settings) {
			$.extend( $.commentator.defaults, settings );
		},
		
		messages: {
			
		},
		prototype: {
			init: function () {
				this.settings.asyncComponent = this.settings.corePath+this.settings.coreCFC;
				this.parts = {
					toggleContent: this.currentBlock.find(this.settings.switchContent)
						.click(this.settings.toggleBlock),
					toggleForm: this.currentBlock.find(this.settings.switchForm)
						.click(this.settings.toggleBlock),
					contentContainer: this.currentBlock.find(this.settings.container)
				};
			},
			
			setCommentFunctions: function () {
				var _settings = this.settings;
				var _container = this.parts.contentContainer;
				console.log(_container);
				$.extend(this.parts, {
					showSwitchs: this.parts.contentContainer.find(this.settings.showCommentSwitch)
						.click(this.settings.showComment),
					hideSwitchs: this.parts.contentContainer.find(this.settings.hideCommentSwitch)
						.click(this.settings.hideComment),
					flagLinks: this.parts.contentContainer.find(this.settings.flagSwitch)
						.click(function() {
							var target = this;
							$.getJSON(_settings.asyncComponent,{
							method:'reportComment',
							iCommentID:$(target).attr('commentID')
							},function(dataJSON){
								if (dataJSON.bReported) {
									_settings.flaggingSuccess.call(target);
								} else {
									_settings.flaggingFailed.call(target);
								}
							});
						}),
					pageLinks: this.parts.contentContainer.find(this.settings.pageSwitch)
						.click(function() {
							var page = ($(this).attr('page') !== null) ? $(this).attr('page') : $(this).text();
							_container.css('visibility','hidden');
							_settings.onReload.call(_container);

							$.getJSON(_settings.asyncComponent,{
								method: _settings.designFunction,
								sTypeName: _settings.typeName,
								iParentID: $(this).attr('parentID'),
								iLangID: _settings.langID,
								iPage: page,
								sSortOrder: _settings.sortOrder
								},function(dataJSON){
									_container.html(dataJSON.htmlCode);
									_container.css('visibility','visible');
									commentator.setCommentFunctions();
									_settings.onReloadEnd.call(_container);
									window.location = '#comments';
								});
					}),
					moreLink: this.parts.contentContainer.find(this.settings.moreSwitch)
						.click(function() {
							var page = ($(this).attr('page') !== null) ? $(this).attr('page') : $(this).text();
							_container.find(_settings.moreFooter).remove();
							_settings.onReload.call(_container);
							$.getJSON(_settings.asyncComponent,{
								method: _settings.designFunction,
								sTypeName: _settings.typeName,
								iParentID: $(this).attr('parentID'),
								iLangID: _settings.langID,
								iPage: page,
								sSortOrder: _settings.sortOrder
								},function(dataJSON){
									_container.append(dataJSON.htmlCode);
									commentator.setCommentFunctions();
									_settings.onReloadEnd.call(_container);
								});
					})
				});
			}
		}
	});
	
})(jQuery);
//--------------------------------------------------
/**
 * jQuery.ScrollTo - Easy element scrolling using jQuery.
 * Copyright (c) 2007-2009 Ariel Flesler - aflesler(at)gmail(dot)com | http://flesler.blogspot.com
 * Dual licensed under MIT and GPL.
 * Date: 5/25/2009
 * @author Ariel Flesler
 * @version 1.4.2
 *
 * http://flesler.blogspot.com/2007/10/jqueryscrollto.html
 */
;(function(d){var k=d.scrollTo=function(a,i,e){d(window).scrollTo(a,i,e)};k.defaults={axis:'xy',duration:parseFloat(d.fn.jquery)>=1.3?0:1};k.window=function(a){return d(window)._scrollable()};d.fn._scrollable=function(){return this.map(function(){var a=this,i=!a.nodeName||d.inArray(a.nodeName.toLowerCase(),['iframe','#document','html','body'])!=-1;if(!i)return a;var e=(a.contentWindow||a).document||a.ownerDocument||a;return d.browser.safari||e.compatMode=='BackCompat'?e.body:e.documentElement})};d.fn.scrollTo=function(n,j,b){if(typeof j=='object'){b=j;j=0}if(typeof b=='function')b={onAfter:b};if(n=='max')n=9e9;b=d.extend({},k.defaults,b);j=j||b.speed||b.duration;b.queue=b.queue&&b.axis.length>1;if(b.queue)j/=2;b.offset=p(b.offset);b.over=p(b.over);return this._scrollable().each(function(){var q=this,r=d(q),f=n,s,g={},u=r.is('html,body');switch(typeof f){case'number':case'string':if(/^([+-]=)?\d+(\.\d+)?(px|%)?$/.test(f)){f=p(f);break}f=d(f,this);case'object':if(f.is||f.style)s=(f=d(f)).offset()}d.each(b.axis.split(''),function(a,i){var e=i=='x'?'Left':'Top',h=e.toLowerCase(),c='scroll'+e,l=q[c],m=k.max(q,i);if(s){g[c]=s[h]+(u?0:l-r.offset()[h]);if(b.margin){g[c]-=parseInt(f.css('margin'+e))||0;g[c]-=parseInt(f.css('border'+e+'Width'))||0}g[c]+=b.offset[h]||0;if(b.over[h])g[c]+=f[i=='x'?'width':'height']()*b.over[h]}else{var o=f[h];g[c]=o.slice&&o.slice(-1)=='%'?parseFloat(o)/100*m:o}if(/^\d+$/.test(g[c]))g[c]=g[c]<=0?0:Math.min(g[c],m);if(!a&&b.queue){if(l!=g[c])t(b.onAfterFirst);delete g[c]}});t(b.onAfter);function t(a){r.animate(g,j,b.easing,a&&function(){a.call(this,n,b)})}}).end()};k.max=function(a,i){var e=i=='x'?'Width':'Height',h='scroll'+e;if(!d(a).is('html,body'))return a[h]-d(a)[e.toLowerCase()]();var c='client'+e,l=a.ownerDocument.documentElement,m=a.ownerDocument.body;return Math.max(l[h],m[h])-Math.min(l[c],m[c])};function p(a){return typeof a=='object'?a:{top:a,left:a}}})(jQuery);
//--------------------------------------------------
/**
 * jQuery Validation Plugin 1.8.0
 *
 * http://bassistance.de/jquery-plugins/jquery-plugin-validation/
 * http://docs.jquery.com/Plugins/Validation
 *
 * Copyright (c) 2006 - 2011 Jörn Zaefferer
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */
(function(c){c.extend(c.fn,{validate:function(a){if(this.length){var b=c.data(this[0],"validator");if(b)return b;b=new c.validator(a,this[0]);c.data(this[0],"validator",b);if(b.settings.onsubmit){this.find("input, button").filter(".cancel").click(function(){b.cancelSubmit=true});b.settings.submitHandler&&this.find("input, button").filter(":submit").click(function(){b.submitButton=this});this.submit(function(d){function e(){if(b.settings.submitHandler){if(b.submitButton)var f=c("<input type='hidden'/>").attr("name",
b.submitButton.name).val(b.submitButton.value).appendTo(b.currentForm);b.settings.submitHandler.call(b,b.currentForm);b.submitButton&&f.remove();return false}return true}b.settings.debug&&d.preventDefault();if(b.cancelSubmit){b.cancelSubmit=false;return e()}if(b.form()){if(b.pendingRequest){b.formSubmitted=true;return false}return e()}else{b.focusInvalid();return false}})}return b}else a&&a.debug&&window.console&&console.warn("nothing selected, can't validate, returning nothing")},valid:function(){if(c(this[0]).is("form"))return this.validate().form();
else{var a=true,b=c(this[0].form).validate();this.each(function(){a&=b.element(this)});return a}},removeAttrs:function(a){var b={},d=this;c.each(a.split(/\s/),function(e,f){b[f]=d.attr(f);d.removeAttr(f)});return b},rules:function(a,b){var d=this[0];if(a){var e=c.data(d.form,"validator").settings,f=e.rules,g=c.validator.staticRules(d);switch(a){case "add":c.extend(g,c.validator.normalizeRule(b));f[d.name]=g;if(b.messages)e.messages[d.name]=c.extend(e.messages[d.name],b.messages);break;case "remove":if(!b){delete f[d.name];
return g}var h={};c.each(b.split(/\s/),function(j,i){h[i]=g[i];delete g[i]});return h}}d=c.validator.normalizeRules(c.extend({},c.validator.metadataRules(d),c.validator.classRules(d),c.validator.attributeRules(d),c.validator.staticRules(d)),d);if(d.required){e=d.required;delete d.required;d=c.extend({required:e},d)}return d}});c.extend(c.expr[":"],{blank:function(a){return!c.trim(""+a.value)},filled:function(a){return!!c.trim(""+a.value)},unchecked:function(a){return!a.checked}});c.validator=function(a,
b){this.settings=c.extend(true,{},c.validator.defaults,a);this.currentForm=b;this.init()};c.validator.format=function(a,b){if(arguments.length==1)return function(){var d=c.makeArray(arguments);d.unshift(a);return c.validator.format.apply(this,d)};if(arguments.length>2&&b.constructor!=Array)b=c.makeArray(arguments).slice(1);if(b.constructor!=Array)b=[b];c.each(b,function(d,e){a=a.replace(RegExp("\\{"+d+"\\}","g"),e)});return a};c.extend(c.validator,{defaults:{messages:{},groups:{},rules:{},errorClass:"error",
validClass:"valid",errorElement:"label",focusInvalid:true,errorContainer:c([]),errorLabelContainer:c([]),onsubmit:true,ignore:[],ignoreTitle:false,onfocusin:function(a){this.lastActive=a;if(this.settings.focusCleanup&&!this.blockFocusCleanup){this.settings.unhighlight&&this.settings.unhighlight.call(this,a,this.settings.errorClass,this.settings.validClass);this.addWrapper(this.errorsFor(a)).hide()}},onfocusout:function(a){if(!this.checkable(a)&&(a.name in this.submitted||!this.optional(a)))this.element(a)},
onkeyup:function(a){if(a.name in this.submitted||a==this.lastElement)this.element(a)},onclick:function(a){if(a.name in this.submitted)this.element(a);else a.parentNode.name in this.submitted&&this.element(a.parentNode)},highlight:function(a,b,d){c(a).addClass(b).removeClass(d)},unhighlight:function(a,b,d){c(a).removeClass(b).addClass(d)}},setDefaults:function(a){c.extend(c.validator.defaults,a)},messages:{required:"This field is required.",remote:"Please fix this field.",email:"Please enter a valid email address.",
url:"Please enter a valid URL.",date:"Please enter a valid date.",dateISO:"Please enter a valid date (ISO).",number:"Please enter a valid number.",digits:"Please enter only digits.",creditcard:"Please enter a valid credit card number.",equalTo:"Please enter the same value again.",accept:"Please enter a value with a valid extension.",maxlength:c.validator.format("Please enter no more than {0} characters."),minlength:c.validator.format("Please enter at least {0} characters."),rangelength:c.validator.format("Please enter a value between {0} and {1} characters long."),
range:c.validator.format("Please enter a value between {0} and {1}."),max:c.validator.format("Please enter a value less than or equal to {0}."),min:c.validator.format("Please enter a value greater than or equal to {0}.")},autoCreateRanges:false,prototype:{init:function(){function a(e){var f=c.data(this[0].form,"validator");e="on"+e.type.replace(/^validate/,"");f.settings[e]&&f.settings[e].call(f,this[0])}this.labelContainer=c(this.settings.errorLabelContainer);this.errorContext=this.labelContainer.length&&
this.labelContainer||c(this.currentForm);this.containers=c(this.settings.errorContainer).add(this.settings.errorLabelContainer);this.submitted={};this.valueCache={};this.pendingRequest=0;this.pending={};this.invalid={};this.reset();var b=this.groups={};c.each(this.settings.groups,function(e,f){c.each(f.split(/\s/),function(g,h){b[h]=e})});var d=this.settings.rules;c.each(d,function(e,f){d[e]=c.validator.normalizeRule(f)});c(this.currentForm).validateDelegate(":text, :password, :file, select, textarea",
"focusin focusout keyup",a).validateDelegate(":radio, :checkbox, select, option","click",a);this.settings.invalidHandler&&c(this.currentForm).bind("invalid-form.validate",this.settings.invalidHandler)},form:function(){this.checkForm();c.extend(this.submitted,this.errorMap);this.invalid=c.extend({},this.errorMap);this.valid()||c(this.currentForm).triggerHandler("invalid-form",[this]);this.showErrors();return this.valid()},checkForm:function(){this.prepareForm();for(var a=0,b=this.currentElements=this.elements();b[a];a++)this.check(b[a]);
return this.valid()},element:function(a){this.lastElement=a=this.clean(a);this.prepareElement(a);this.currentElements=c(a);var b=this.check(a);if(b)delete this.invalid[a.name];else this.invalid[a.name]=true;if(!this.numberOfInvalids())this.toHide=this.toHide.add(this.containers);this.showErrors();return b},showErrors:function(a){if(a){c.extend(this.errorMap,a);this.errorList=[];for(var b in a)this.errorList.push({message:a[b],element:this.findByName(b)[0]});this.successList=c.grep(this.successList,
function(d){return!(d.name in a)})}this.settings.showErrors?this.settings.showErrors.call(this,this.errorMap,this.errorList):this.defaultShowErrors()},resetForm:function(){c.fn.resetForm&&c(this.currentForm).resetForm();this.submitted={};this.prepareForm();this.hideErrors();this.elements().removeClass(this.settings.errorClass)},numberOfInvalids:function(){return this.objectLength(this.invalid)},objectLength:function(a){var b=0,d;for(d in a)b++;return b},hideErrors:function(){this.addWrapper(this.toHide).hide()},
valid:function(){return this.size()==0},size:function(){return this.errorList.length},focusInvalid:function(){if(this.settings.focusInvalid)try{c(this.findLastActive()||this.errorList.length&&this.errorList[0].element||[]).filter(":visible").focus().trigger("focusin")}catch(a){}},findLastActive:function(){var a=this.lastActive;return a&&c.grep(this.errorList,function(b){return b.element.name==a.name}).length==1&&a},elements:function(){var a=this,b={};return c([]).add(this.currentForm.elements).filter(":input").not(":submit, :reset, :image, [disabled]").not(this.settings.ignore).filter(function(){!this.name&&
a.settings.debug&&window.console&&console.error("%o has no name assigned",this);if(this.name in b||!a.objectLength(c(this).rules()))return false;return b[this.name]=true})},clean:function(a){return c(a)[0]},errors:function(){return c(this.settings.errorElement+"."+this.settings.errorClass,this.errorContext)},reset:function(){this.successList=[];this.errorList=[];this.errorMap={};this.toShow=c([]);this.toHide=c([]);this.currentElements=c([])},prepareForm:function(){this.reset();this.toHide=this.errors().add(this.containers)},
prepareElement:function(a){this.reset();this.toHide=this.errorsFor(a)},check:function(a){a=this.clean(a);if(this.checkable(a))a=this.findByName(a.name).not(this.settings.ignore)[0];var b=c(a).rules(),d=false,e;for(e in b){var f={method:e,parameters:b[e]};try{var g=c.validator.methods[e].call(this,a.value.replace(/\r/g,""),a,f.parameters);if(g=="dependency-mismatch")d=true;else{d=false;if(g=="pending"){this.toHide=this.toHide.not(this.errorsFor(a));return}if(!g){this.formatAndAdd(a,f);return false}}}catch(h){this.settings.debug&&
window.console&&console.log("exception occured when checking element "+a.id+", check the '"+f.method+"' method",h);throw h;}}if(!d){this.objectLength(b)&&this.successList.push(a);return true}},customMetaMessage:function(a,b){if(c.metadata){var d=this.settings.meta?c(a).metadata()[this.settings.meta]:c(a).metadata();return d&&d.messages&&d.messages[b]}},customMessage:function(a,b){var d=this.settings.messages[a];return d&&(d.constructor==String?d:d[b])},findDefined:function(){for(var a=0;a<arguments.length;a++)if(arguments[a]!==
undefined)return arguments[a]},defaultMessage:function(a,b){return this.findDefined(this.customMessage(a.name,b),this.customMetaMessage(a,b),!this.settings.ignoreTitle&&a.title||undefined,c.validator.messages[b],"<strong>Warning: No message defined for "+a.name+"</strong>")},formatAndAdd:function(a,b){var d=this.defaultMessage(a,b.method),e=/\$?\{(\d+)\}/g;if(typeof d=="function")d=d.call(this,b.parameters,a);else if(e.test(d))d=jQuery.format(d.replace(e,"{$1}"),b.parameters);this.errorList.push({message:d,
element:a});this.errorMap[a.name]=d;this.submitted[a.name]=d},addWrapper:function(a){if(this.settings.wrapper)a=a.add(a.parent(this.settings.wrapper));return a},defaultShowErrors:function(){for(var a=0;this.errorList[a];a++){var b=this.errorList[a];this.settings.highlight&&this.settings.highlight.call(this,b.element,this.settings.errorClass,this.settings.validClass);this.showLabel(b.element,b.message)}if(this.errorList.length)this.toShow=this.toShow.add(this.containers);if(this.settings.success)for(a=
0;this.successList[a];a++)this.showLabel(this.successList[a]);if(this.settings.unhighlight){a=0;for(b=this.validElements();b[a];a++)this.settings.unhighlight.call(this,b[a],this.settings.errorClass,this.settings.validClass)}this.toHide=this.toHide.not(this.toShow);this.hideErrors();this.addWrapper(this.toShow).show()},validElements:function(){return this.currentElements.not(this.invalidElements())},invalidElements:function(){return c(this.errorList).map(function(){return this.element})},showLabel:function(a,
b){var d=this.errorsFor(a);if(d.length){d.removeClass().addClass(this.settings.errorClass);d.attr("generated")&&d.html(b)}else{d=c("<"+this.settings.errorElement+"/>").attr({"for":this.idOrName(a),generated:true}).addClass(this.settings.errorClass).html(b||"");if(this.settings.wrapper)d=d.hide().show().wrap("<"+this.settings.wrapper+"/>").parent();this.labelContainer.append(d).length||(this.settings.errorPlacement?this.settings.errorPlacement(d,c(a)):d.insertAfter(a))}if(!b&&this.settings.success){d.text("");
typeof this.settings.success=="string"?d.addClass(this.settings.success):this.settings.success(d)}this.toShow=this.toShow.add(d)},errorsFor:function(a){var b=this.idOrName(a);return this.errors().filter(function(){return c(this).attr("for")==b})},idOrName:function(a){return this.groups[a.name]||(this.checkable(a)?a.name:a.id||a.name)},checkable:function(a){return/radio|checkbox/i.test(a.type)},findByName:function(a){var b=this.currentForm;return c(document.getElementsByName(a)).map(function(d,e){return e.form==
b&&e.name==a&&e||null})},getLength:function(a,b){switch(b.nodeName.toLowerCase()){case "select":return c("option:selected",b).length;case "input":if(this.checkable(b))return this.findByName(b.name).filter(":checked").length}return a.length},depend:function(a,b){return this.dependTypes[typeof a]?this.dependTypes[typeof a](a,b):true},dependTypes:{"boolean":function(a){return a},string:function(a,b){return!!c(a,b.form).length},"function":function(a,b){return a(b)}},optional:function(a){return!c.validator.methods.required.call(this,
c.trim(a.value),a)&&"dependency-mismatch"},startRequest:function(a){if(!this.pending[a.name]){this.pendingRequest++;this.pending[a.name]=true}},stopRequest:function(a,b){this.pendingRequest--;if(this.pendingRequest<0)this.pendingRequest=0;delete this.pending[a.name];if(b&&this.pendingRequest==0&&this.formSubmitted&&this.form()){c(this.currentForm).submit();this.formSubmitted=false}else if(!b&&this.pendingRequest==0&&this.formSubmitted){c(this.currentForm).triggerHandler("invalid-form",[this]);this.formSubmitted=
false}},previousValue:function(a){return c.data(a,"previousValue")||c.data(a,"previousValue",{old:null,valid:true,message:this.defaultMessage(a,"remote")})}},classRuleSettings:{required:{required:true},email:{email:true},url:{url:true},date:{date:true},dateISO:{dateISO:true},dateDE:{dateDE:true},number:{number:true},numberDE:{numberDE:true},digits:{digits:true},creditcard:{creditcard:true}},addClassRules:function(a,b){a.constructor==String?this.classRuleSettings[a]=b:c.extend(this.classRuleSettings,
a)},classRules:function(a){var b={};(a=c(a).attr("class"))&&c.each(a.split(" "),function(){this in c.validator.classRuleSettings&&c.extend(b,c.validator.classRuleSettings[this])});return b},attributeRules:function(a){var b={};a=c(a);for(var d in c.validator.methods){var e=a.attr(d);if(e)b[d]=e}b.maxlength&&/-1|2147483647|524288/.test(b.maxlength)&&delete b.maxlength;return b},metadataRules:function(a){if(!c.metadata)return{};var b=c.data(a.form,"validator").settings.meta;return b?c(a).metadata()[b]:
c(a).metadata()},staticRules:function(a){var b={},d=c.data(a.form,"validator");if(d.settings.rules)b=c.validator.normalizeRule(d.settings.rules[a.name])||{};return b},normalizeRules:function(a,b){c.each(a,function(d,e){if(e===false)delete a[d];else if(e.param||e.depends){var f=true;switch(typeof e.depends){case "string":f=!!c(e.depends,b.form).length;break;case "function":f=e.depends.call(b,b)}if(f)a[d]=e.param!==undefined?e.param:true;else delete a[d]}});c.each(a,function(d,e){a[d]=c.isFunction(e)?
e(b):e});c.each(["minlength","maxlength","min","max"],function(){if(a[this])a[this]=Number(a[this])});c.each(["rangelength","range"],function(){if(a[this])a[this]=[Number(a[this][0]),Number(a[this][1])]});if(c.validator.autoCreateRanges){if(a.min&&a.max){a.range=[a.min,a.max];delete a.min;delete a.max}if(a.minlength&&a.maxlength){a.rangelength=[a.minlength,a.maxlength];delete a.minlength;delete a.maxlength}}a.messages&&delete a.messages;return a},normalizeRule:function(a){if(typeof a=="string"){var b=
{};c.each(a.split(/\s/),function(){b[this]=true});a=b}return a},addMethod:function(a,b,d){c.validator.methods[a]=b;c.validator.messages[a]=d!=undefined?d:c.validator.messages[a];b.length<3&&c.validator.addClassRules(a,c.validator.normalizeRule(a))},methods:{required:function(a,b,d){if(!this.depend(d,b))return"dependency-mismatch";switch(b.nodeName.toLowerCase()){case "select":return(a=c(b).val())&&a.length>0;case "input":if(this.checkable(b))return this.getLength(a,b)>0;default:return c.trim(a).length>
0}},remote:function(a,b,d){if(this.optional(b))return"dependency-mismatch";var e=this.previousValue(b);this.settings.messages[b.name]||(this.settings.messages[b.name]={});e.originalMessage=this.settings.messages[b.name].remote;this.settings.messages[b.name].remote=e.message;d=typeof d=="string"&&{url:d}||d;if(this.pending[b.name])return"pending";if(e.old===a)return e.valid;e.old=a;var f=this;this.startRequest(b);var g={};g[b.name]=a;c.ajax(c.extend(true,{url:d,mode:"abort",port:"validate"+b.name,
dataType:"json",data:g,success:function(h){f.settings.messages[b.name].remote=e.originalMessage;var j=h===true;if(j){var i=f.formSubmitted;f.prepareElement(b);f.formSubmitted=i;f.successList.push(b);f.showErrors()}else{i={};h=h||f.defaultMessage(b,"remote");i[b.name]=e.message=c.isFunction(h)?h(a):h;f.showErrors(i)}e.valid=j;f.stopRequest(b,j)}},d));return"pending"},minlength:function(a,b,d){return this.optional(b)||this.getLength(c.trim(a),b)>=d},maxlength:function(a,b,d){return this.optional(b)||
this.getLength(c.trim(a),b)<=d},rangelength:function(a,b,d){a=this.getLength(c.trim(a),b);return this.optional(b)||a>=d[0]&&a<=d[1]},min:function(a,b,d){return this.optional(b)||a>=d},max:function(a,b,d){return this.optional(b)||a<=d},range:function(a,b,d){return this.optional(b)||a>=d[0]&&a<=d[1]},email:function(a,b){return this.optional(b)||/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i.test(a)},
url:function(a,b){return this.optional(b)||/^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(a)},
date:function(a,b){return this.optional(b)||!/Invalid|NaN/.test(new Date(a))},dateISO:function(a,b){return this.optional(b)||/^\d{4}[\/-]\d{1,2}[\/-]\d{1,2}$/.test(a)},number:function(a,b){return this.optional(b)||/^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test(a)},digits:function(a,b){return this.optional(b)||/^\d+$/.test(a)},creditcard:function(a,b){if(this.optional(b))return"dependency-mismatch";if(/[^0-9-]+/.test(a))return false;var d=0,e=0,f=false;a=a.replace(/\D/g,"");for(var g=a.length-1;g>=
0;g--){e=a.charAt(g);e=parseInt(e,10);if(f)if((e*=2)>9)e-=9;d+=e;f=!f}return d%10==0},accept:function(a,b,d){d=typeof d=="string"?d.replace(/,/g,"|"):"png|jpe?g|gif";return this.optional(b)||a.match(RegExp(".("+d+")$","i"))},equalTo:function(a,b,d){d=c(d).unbind(".validate-equalTo").bind("blur.validate-equalTo",function(){c(b).valid()});return a==d.val()}}});c.format=c.validator.format})(jQuery);
(function(c){var a={};if(c.ajaxPrefilter)c.ajaxPrefilter(function(d,e,f){e=d.port;if(d.mode=="abort"){a[e]&&a[e].abort();a[e]=f}});else{var b=c.ajax;c.ajax=function(d){var e=("port"in d?d:c.ajaxSettings).port;if(("mode"in d?d:c.ajaxSettings).mode=="abort"){a[e]&&a[e].abort();return a[e]=b.apply(this,arguments)}return b.apply(this,arguments)}}})(jQuery);
(function(c){!jQuery.event.special.focusin&&!jQuery.event.special.focusout&&document.addEventListener&&c.each({focus:"focusin",blur:"focusout"},function(a,b){function d(e){e=c.event.fix(e);e.type=b;return c.event.handle.call(this,e)}c.event.special[b]={setup:function(){this.addEventListener(a,d,true)},teardown:function(){this.removeEventListener(a,d,true)},handler:function(e){arguments[0]=c.event.fix(e);arguments[0].type=b;return c.event.handle.apply(this,arguments)}}});c.extend(c.fn,{validateDelegate:function(a,
b,d){return this.bind(b,function(e){var f=c(e.target);if(f.is(a))return d.apply(f,arguments)})}})})(jQuery);

//--------------------------------------------------
// ColorBox v1.3.20.1 - jQuery lightbox plugin
// (c) 2012 Jack Moore - jacklmoore.com
// License: http://www.opensource.org/licenses/mit-license.php
(function(e,t,n){function G(n,r,i){var o=t.createElement(n);return r&&(o.id=s+r),i&&(o.style.cssText=i),e(o)}function Y(e){var t=T.length,n=(U+e)%t;return n<0?t+n:n}function Z(e,t){return Math.round((/%/.test(e)?(t==="x"?tt():nt())/100:1)*parseInt(e,10))}function et(e){return B.photo||/\.(gif|png|jp(e|g|eg)|bmp|ico)((#|\?).*)?$/i.test(e)}function tt(){return n.innerWidth||N.width()}function nt(){return n.innerHeight||N.height()}function rt(){var t,n=e.data(R,i);n==null?(B=e.extend({},r),console&&console.log&&console.log("Error: cboxElement missing settings object")):B=e.extend({},n);for(t in B)e.isFunction(B[t])&&t.slice(0,2)!=="on"&&(B[t]=B[t].call(R));B.rel=B.rel||R.rel||"nofollow",B.href=B.href||e(R).attr("href"),B.title=B.title||R.title,typeof B.href=="string"&&(B.href=e.trim(B.href))}function it(t,n){e.event.trigger(t),n&&n.call(R)}function st(){var e,t=s+"Slideshow_",n="click."+s,r,i,o;B.slideshow&&T[1]?(r=function(){M.text(B.slideshowStop).unbind(n).bind(f,function(){if(B.loop||T[U+1])e=setTimeout(J.next,B.slideshowSpeed)}).bind(a,function(){clearTimeout(e)}).one(n+" "+l,i),g.removeClass(t+"off").addClass(t+"on"),e=setTimeout(J.next,B.slideshowSpeed)},i=function(){clearTimeout(e),M.text(B.slideshowStart).unbind([f,a,l,n].join(" ")).one(n,function(){J.next(),r()}),g.removeClass(t+"on").addClass(t+"off")},B.slideshowAuto?r():i()):g.removeClass(t+"off "+t+"on")}function ot(t){V||(R=t,rt(),T=e(R),U=0,B.rel!=="nofollow"&&(T=e("."+o).filter(function(){var t=e.data(this,i),n;return t&&(n=t.rel||this.rel),n===B.rel}),U=T.index(R),U===-1&&(T=T.add(R),U=T.length-1)),W||(W=X=!0,g.show(),B.returnFocus&&e(R).blur().one(c,function(){e(this).focus()}),m.css({opacity:+B.opacity,cursor:B.overlayClose?"pointer":"auto"}).show(),B.w=Z(B.initialWidth,"x"),B.h=Z(B.initialHeight,"y"),J.position(),d&&N.bind("resize."+v+" scroll."+v,function(){m.css({width:tt(),height:nt(),top:N.scrollTop(),left:N.scrollLeft()})}).trigger("resize."+v),it(u,B.onOpen),H.add(A).hide(),P.html(B.close).show()),J.load(!0))}function ut(){!g&&t.body&&(Q=!1,N=e(n),g=G(K).attr({id:i,"class":p?s+(d?"IE6":"IE"):""}).hide(),m=G(K,"Overlay",d?"position:absolute":"").hide(),L=G(K,"LoadingOverlay").add(G(K,"LoadingGraphic")),y=G(K,"Wrapper"),b=G(K,"Content").append(C=G(K,"LoadedContent","width:0; height:0; overflow:hidden"),A=G(K,"Title"),O=G(K,"Current"),_=G(K,"Next"),D=G(K,"Previous"),M=G(K,"Slideshow").bind(u,st),P=G(K,"Close")),y.append(G(K).append(G(K,"TopLeft"),w=G(K,"TopCenter"),G(K,"TopRight")),G(K,!1,"clear:left").append(E=G(K,"MiddleLeft"),b,S=G(K,"MiddleRight")),G(K,!1,"clear:left").append(G(K,"BottomLeft"),x=G(K,"BottomCenter"),G(K,"BottomRight"))).find("div div").css({"float":"left"}),k=G(K,!1,"position:absolute; width:9999px; visibility:hidden; display:none"),H=_.add(D).add(O).add(M),e(t.body).append(m,g.append(y,k)))}function at(){return g?(Q||(Q=!0,j=w.height()+x.height()+b.outerHeight(!0)-b.height(),F=E.width()+S.width()+b.outerWidth(!0)-b.width(),I=C.outerHeight(!0),q=C.outerWidth(!0),g.css({"padding-bottom":j,"padding-right":F}),_.click(function(){J.next()}),D.click(function(){J.prev()}),P.click(function(){J.close()}),m.click(function(){B.overlayClose&&J.close()}),e(t).bind("keydown."+s,function(e){var t=e.keyCode;W&&B.escKey&&t===27&&(e.preventDefault(),J.close()),W&&B.arrowKey&&T[1]&&(t===37?(e.preventDefault(),D.click()):t===39&&(e.preventDefault(),_.click()))}),e("."+o,t).live("click",function(e){e.which>1||e.shiftKey||e.altKey||e.metaKey||(e.preventDefault(),ot(this))})),!0):!1}var r={transition:"elastic",speed:300,width:!1,initialWidth:"600",innerWidth:!1,maxWidth:!1,height:!1,initialHeight:"450",innerHeight:!1,maxHeight:!1,scalePhotos:!0,scrolling:!0,inline:!1,html:!1,iframe:!1,fastIframe:!0,photo:!1,href:!1,title:!1,rel:!1,opacity:.9,preloading:!0,current:"image {current} of {total}",previous:"previous",next:"next",close:"close",xhrError:"This content failed to load.",imgError:"This image failed to load.",open:!1,returnFocus:!0,reposition:!0,loop:!0,slideshow:!1,slideshowAuto:!0,slideshowSpeed:2500,slideshowStart:"start slideshow",slideshowStop:"stop slideshow",onOpen:!1,onLoad:!1,onComplete:!1,onCleanup:!1,onClosed:!1,overlayClose:!0,escKey:!0,arrowKey:!0,top:!1,bottom:!1,left:!1,right:!1,fixed:!1,data:undefined},i="colorbox",s="cbox",o=s+"Element",u=s+"_open",a=s+"_load",f=s+"_complete",l=s+"_cleanup",c=s+"_closed",h=s+"_purge",p=!e.support.opacity&&!e.support.style,d=p&&!n.XMLHttpRequest,v=s+"_IE6",m,g,y,b,w,E,S,x,T,N,C,k,L,A,O,M,_,D,P,H,B,j,F,I,q,R,U,z,W,X,V,$,J,K="div",Q;if(e.colorbox)return;e(ut),J=e.fn[i]=e[i]=function(t,n){var s=this;t=t||{},ut();if(at()){if(!s[0]){if(s.selector)return s;s=e("<a/>"),t.open=!0}n&&(t.onComplete=n),s.each(function(){e.data(this,i,e.extend({},e.data(this,i)||r,t))}).addClass(o),(e.isFunction(t.open)&&t.open.call(s)||t.open)&&ot(s[0])}return s},J.position=function(e,t){function f(e){w[0].style.width=x[0].style.width=b[0].style.width=e.style.width,b[0].style.height=E[0].style.height=S[0].style.height=e.style.height}var n,r=0,i=0,o=g.offset(),u,a;N.unbind("resize."+s),g.css({top:-9e4,left:-9e4}),u=N.scrollTop(),a=N.scrollLeft(),B.fixed&&!d?(o.top-=u,o.left-=a,g.css({position:"fixed"})):(r=u,i=a,g.css({position:"absolute"})),B.right!==!1?i+=Math.max(tt()-B.w-q-F-Z(B.right,"x"),0):B.left!==!1?i+=Z(B.left,"x"):i+=Math.round(Math.max(tt()-B.w-q-F,0)/2),B.bottom!==!1?r+=Math.max(nt()-B.h-I-j-Z(B.bottom,"y"),0):B.top!==!1?r+=Z(B.top,"y"):r+=Math.round(Math.max(nt()-B.h-I-j,0)/2),g.css({top:o.top,left:o.left}),e=g.width()===B.w+q&&g.height()===B.h+I?0:e||0,y[0].style.width=y[0].style.height="9999px",n={width:B.w+q,height:B.h+I,top:r,left:i},e===0&&g.css(n),g.dequeue().animate(n,{duration:e,complete:function(){f(this),X=!1,y[0].style.width=B.w+q+F+"px",y[0].style.height=B.h+I+j+"px",B.reposition&&setTimeout(function(){N.bind("resize."+s,J.position)},1),t&&t()},step:function(){f(this)}})},J.resize=function(e){W&&(e=e||{},e.width&&(B.w=Z(e.width,"x")-q-F),e.innerWidth&&(B.w=Z(e.innerWidth,"x")),C.css({width:B.w}),e.height&&(B.h=Z(e.height,"y")-I-j),e.innerHeight&&(B.h=Z(e.innerHeight,"y")),!e.innerHeight&&!e.height&&(C.css({height:"auto"}),B.h=C.height()),C.css({height:B.h}),J.position(B.transition==="none"?0:B.speed))},J.prep=function(t){function o(){return B.w=B.w||C.width(),B.w=B.mw&&B.mw<B.w?B.mw:B.w,B.w}function u(){return B.h=B.h||C.height(),B.h=B.mh&&B.mh<B.h?B.mh:B.h,B.h}if(!W)return;var n,r=B.transition==="none"?0:B.speed;C.remove(),C=G(K,"LoadedContent").append(t),C.hide().appendTo(k.show()).css({width:o(),overflow:B.scrolling?"auto":"hidden"}).css({height:u()}).prependTo(b),k.hide(),e(z).css({"float":"none"}),d&&e("select").not(g.find("select")).filter(function(){return this.style.visibility!=="hidden"}).css({visibility:"hidden"}).one(l,function(){this.style.visibility="inherit"}),n=function(){function y(){p&&g[0].style.removeAttribute("filter")}var t,n,o=T.length,u,a="frameBorder",l="allowTransparency",c,d,v,m;if(!W)return;c=function(){clearTimeout($),L.detach().hide(),it(f,B.onComplete)},p&&z&&C.fadeIn(100),A.html(B.title).add(C).show();if(o>1){typeof B.current=="string"&&O.html(B.current.replace("{current}",U+1).replace("{total}",o)).show(),_[B.loop||U<o-1?"show":"hide"]().html(B.next),D[B.loop||U?"show":"hide"]().html(B.previous),B.slideshow&&M.show();if(B.preloading){t=[Y(-1),Y(1)];while(n=T[t.pop()])m=e.data(n,i),m&&m.href?(d=m.href,e.isFunction(d)&&(d=d.call(n))):d=n.href,et(d)&&(v=new Image,v.src=d)}}else H.hide();B.iframe?(u=G("iframe")[0],a in u&&(u[a]=0),l in u&&(u[l]="true"),u.name=s+ +(new Date),B.fastIframe?c():e(u).one("load",c),u.src=B.href,B.scrolling||(u.scrolling="no"),e(u).addClass(s+"Iframe").appendTo(C).one(h,function(){u.src="//about:blank"})):c(),B.transition==="fade"?g.fadeTo(r,1,y):y()},B.transition==="fade"?g.fadeTo(r,0,function(){J.position(0,n)}):J.position(r,n)},J.load=function(t){var n,r,i=J.prep;X=!0,z=!1,R=T[U],t||rt(),it(h),it(a,B.onLoad),B.h=B.height?Z(B.height,"y")-I-j:B.innerHeight&&Z(B.innerHeight,"y"),B.w=B.width?Z(B.width,"x")-q-F:B.innerWidth&&Z(B.innerWidth,"x"),B.mw=B.w,B.mh=B.h,B.maxWidth&&(B.mw=Z(B.maxWidth,"x")-q-F,B.mw=B.w&&B.w<B.mw?B.w:B.mw),B.maxHeight&&(B.mh=Z(B.maxHeight,"y")-I-j,B.mh=B.h&&B.h<B.mh?B.h:B.mh),n=B.href,$=setTimeout(function(){L.show().appendTo(b)},100),B.inline?(G(K).hide().insertBefore(e(n)[0]).one(h,function(){e(this).replaceWith(C.children())}),i(e(n))):B.iframe?i(" "):B.html?i(B.html):et(n)?(e(z=new Image).addClass(s+"Photo").error(function(){B.title=!1,i(G(K,"Error").html(B.imgError))}).load(function(){var e;z.onload=null,B.scalePhotos&&(r=function(){z.height-=z.height*e,z.width-=z.width*e},B.mw&&z.width>B.mw&&(e=(z.width-B.mw)/z.width,r()),B.mh&&z.height>B.mh&&(e=(z.height-B.mh)/z.height,r())),B.h&&(z.style.marginTop=Math.max(B.h-z.height,0)/2+"px"),T[1]&&(B.loop||T[U+1])&&(z.style.cursor="pointer",z.onclick=function(){J.next()}),p&&(z.style.msInterpolationMode="bicubic"),setTimeout(function(){i(z)},1)}),setTimeout(function(){z.src=n},1)):n&&k.load(n,B.data,function(t,n,r){i(n==="error"?G(K,"Error").html(B.xhrError):e(this).contents())})},J.next=function(){!X&&T[1]&&(B.loop||T[U+1])&&(U=Y(1),J.load())},J.prev=function(){!X&&T[1]&&(B.loop||U)&&(U=Y(-1),J.load())},J.close=function(){W&&!V&&(V=!0,W=!1,it(l,B.onCleanup),N.unbind("."+s+" ."+v),m.fadeTo(200,0),g.stop().fadeTo(300,0,function(){g.add(m).css({opacity:1,cursor:"auto"}).hide(),it(h),C.remove(),setTimeout(function(){V=!1,it(c,B.onClosed)},1)}))},J.remove=function(){e([]).add(g).add(m).remove(),g=null,e("."+o).removeData(i).removeClass(o).die()},J.element=function(){return e(R)},J.settings=r})(jQuery,document,this);
//--------------------------------------------------
var videoPlayerInitialised=false;var playerReadyListeners=[];function playerReady(obj){var player=document.getElementById('mainstage_video');videoPlayerInitialised=true;for(var i=0;i<playerReadyListeners.length;i++){playerReadyListeners[i](player);}
player.addViewListener('PLAY','playerPlayEvent');player.addModelListener('STATE','stateMonitor');}
function onPlayerReady(listener){playerReadyListeners[playerReadyListeners.length]=listener;}
var playerPlayListeners=[];function playerPlayEvent(){var player=document.getElementById('mainstage_video');for(var i=0;i<playerPlayListeners.length;i++){playerPlayListeners[i](player);}}
function onPlayerPlay(listener){playerPlayListeners[playerPlayListeners.length]=listener;}
var playerCompleteListeners=[];function onPlayerComplete(listener){playerCompleteListeners[playerCompleteListeners.length]=listener;}
function playerCompleteEvent(){var player=document.getElementById('mainstage_video');for(var i=0;i<playerCompleteListeners.length;i++){playerCompleteListeners[i](player);}}
function stateMonitor(obj)
{if(obj.newstate=='COMPLETED')
{playerCompleteEvent();}};(function($){VISIBLE_STORY_COUNT=3;PAUSE_BEFORE_STORIES_PANEL=2000;STORIES_FADE_IN_STAGGER_DELAY=200;STORIES_SCROLL_TIME=600;STORY_HEIGHT=90;BACKGROUND_FADE_TIME=1000;HEADLINE_SLIDE_TIME=600;AUTOSCROLL_DELAY=10000;CLICK_THROUGH_TO_STORY_DELAY=1000;var headlineAnimationOff={'left':'150px','opacity':0};var headlineAnimationOn={'left':'0px','opacity':1};function Feature(mainstage,initialStoryData){var videoFlashVariables={controlbar:'over'};var videoParameters={menu:"false",allowfullscreen:"true",allowscriptaccess:"always"};
	var storyHtml=$('<a class="main_story"><div class="transition_layer"></div><p class="alt"></p><div class="headline"><div class="headline_inner"><h1></h1><h2><span></span></h2></div></div><div id="mainstage_video"></div></a><aside class="categoria_slider"></aside>');$(mainstage).html(storyHtml);var currentStoryData;var transitionLayer=$('.transition_layer',storyHtml);transitionLayer.fadeTo(1,0);
		// var categoria_slider=$('.categoria_slider');//jocar
		var headline=$('.headline',storyHtml);
		function showStory(storyData){
			currentStoryData=storyData;
			if(storyData.href){
				$(storyHtml).attr({'href':storyData.href});}else{$(storyHtml).removeAttr('href');}
				if(storyData.credit){
					$(storyHtml).attr({'title':storyData.credit});
				}
				$(storyHtml).css({'background-image':'url('+storyData.backgroundImage+')'});
				$('.categoria_slider').text(storyData.categoria); //jocar
				$('h2 span',headline).text(storyData.headline2);
				$('.alt',storyHtml).text(storyData.alt);
				$('h1',headline).text(storyData.headline);
				$('h2 span',headline).text(storyData.headline2);if(!storyData.headline){headline.css(headlineAnimationOff);}
if(storyData.video){initVideo(storyData);}}
var switchHeadline=function(storyData){if(storyData.href){$('a.main_story',mainstage).attr('href',storyData.href);}else{$('a.main_story',mainstage).removeAttr('href');}
if(storyData.credit){$('a.main_story',mainstage).attr({'title':storyData.credit});}
if(storyData.headline){$('h1',headline).text(storyData.headline);$('h2 span',headline).text(storyData.headline2);headline.animate(headlineAnimationOn,HEADLINE_SLIDE_TIME);}}
function transitionToStory(storyData){
	$('#mainstage_video',mainstage).replaceWith('<div id="mainstage_video"></div>');
	videoPlayerInitialised=false;
	$('.categoria_slider').text(storyData.categoria); //jocar
	$('a.main_story',mainstage).css({'background-image':'url('+currentStoryData.backgroundImage+')'});
	$('a.main_story .alt').text(currentStoryData.alt);
	if(storyData.credit){
		$('a.main_story',mainstage).attr({'title':storyData.credit});
	}
	transitionLayer.stop().css({'opacity':0});
	transitionLayer.css({'background-image':'url('+storyData.backgroundImage+')'});
	transitionLayer.fadeTo(BACKGROUND_FADE_TIME,1,function(){
		$('a.main_story',mainstage).css({'background-image':'url('+storyData.backgroundImage+')'});
		$('a.main_story .alt').text(storyData.alt);
		if(storyData.video){
			initVideo(storyData);}
		});
	if(currentStoryData.headline){
		headline.stop().animate(headlineAnimationOff,HEADLINE_SLIDE_TIME,function(){
			switchHeadline(storyData);})
	}else{
		switchHeadline(storyData);
	}
	currentStoryData=storyData;
}
function initVideo(storyData){$('#mainstage_video').css({'z-index':-2});swfobject.embedSWF("http://assets.wwf.org.uk/custom/homepage/resources/player.swf","mainstage_video","638","311","9.0.0",false,videoFlashVariables,videoParameters,false);$('#mainstage_video').css({'z-index':-2});onPlayerReady(function(player){player.style.zIndex=-2;player.sendEvent('LOAD',{file:storyData.video,image:storyData.backgroundImage});player.style.zIndex=12;})
onPlayerComplete(function(){$('#mainstage_video').css({"visibility":"hidden"});$('a.main_story').css({"background-image":"url("+storyData.endImage+")"}).attr("href",storyData.href)
$('div.transition_layer').css("opacity","0")})}
function onPlayVideo(listener){onPlayerPlay(listener);}
showStory(initialStoryData);return{showStory:showStory,transitionToStory:transitionToStory,onPlayVideo:onPlayVideo}}
function StoriesPanel(mainstage,data,feature){
	var currentStoryNumber=0;var topVisibleTrayIndex=0;var topPopulatedTrayIndex=0;var bottomPopulatedTrayIndex=-1;
	var storiesPanel=$('<div class="stories_panel"><div class="stories_nav stories_nav_up"><a href="javascript:void(0)">Up</a></div><div class="stories_viewport"><div class="stories_tray"><ul class="stories"></ul></div></div><div class="stories_nav stories_nav_down"><a href="javascript:void(0)">Down</a></div></div>');
	var storiesUl=$('ul.stories',storiesPanel);var headline=$('.headline',mainstage);var lastNavigationClickTime;function storyNumberAtTrayIndex(i){var storyNumber=((VISIBLE_STORY_COUNT-1)-i)%data.length;if(storyNumber<0)storyNumber+=data.length;return storyNumber;}
function scrollTrayIntoPosition(){while(topVisibleTrayIndex<topPopulatedTrayIndex)prependStory();var bottomVisibleTrayIndex=topVisibleTrayIndex+VISIBLE_STORY_COUNT-1;while(bottomVisibleTrayIndex>bottomPopulatedTrayIndex)appendStory();$('.stories_tray',storiesPanel).stop().animate({'top':(-topVisibleTrayIndex*STORY_HEIGHT)+'px'},STORIES_SCROLL_TIME);}
function selectStory(trayIndex){

	topVisibleTrayIndex=trayIndex-VISIBLE_STORY_COUNT+1;
	scrollTrayIntoPosition();
	var storyNumber=storyNumberAtTrayIndex(trayIndex);
	$('li.current_story',storiesUl).removeClass('current_story');
	$('li.story_number_'+storyNumber,storiesUl).addClass('current_story');
	if(storyNumber!=currentStoryNumber){
		currentStoryNumber=storyNumber;
		feature.transitionToStory(data[storyNumber]);
		return true;
	}else
	{
		return false;
	}
}
function createStoryLi(trayIndex){
	var storyNumber=storyNumberAtTrayIndex(trayIndex);var storyData=data[storyNumber];var story=$('<li class="story"><div class="thumbnail"><img src="" width="72" height="53" alt="" /></div><div class="title"><a></a></div></li>');story.addClass('story_number_'+storyNumber);if(storyNumber==currentStoryNumber)story.addClass('current_story');$('.thumbnail img',story).attr('src',storyData.thumbnail);$('.title a',story).attr('href',storyData.href);$('.title a',story).text(storyData.storyTitle);story.hover(function(){story.addClass('story_hover');},function(){story.removeClass('story_hover');}).click(function(){disableAutoscroll();var storyHasChanged=selectStory(trayIndex);var currentTime=(new Date).getTime();if(storyHasChanged||lastNavigationClickTime>(currentTime-CLICK_THROUGH_TO_STORY_DELAY)){lastNavigationClickTime=currentTime;}else{var href=$('.title a',this).attr('href');if(href!=null){document.location.href=href;}}
return false;})
return story;}
function prependStory(){topPopulatedTrayIndex-=1;var story=createStoryLi(topPopulatedTrayIndex);storiesUl.prepend(story);centreStoryText(story);storiesUl.css({'top':topPopulatedTrayIndex*STORY_HEIGHT});}
function appendStory(opts){opts=opts||[];bottomPopulatedTrayIndex+=1;var story=createStoryLi(bottomPopulatedTrayIndex);storiesUl.append(story);centreStoryText(story);if(opts.fade){story.hide();setTimeout(function(){story.fadeIn()},(bottomPopulatedTrayIndex+1)*STORIES_FADE_IN_STAGGER_DELAY);}}
function centreStoryText(story){var title=$('.title',story);title.css({'padding-top':(STORY_HEIGHT-title.get(0).offsetHeight)/2+'px'});}
function selectNextStory(){selectStory(topVisibleTrayIndex+VISIBLE_STORY_COUNT);}
function selectPreviousStory(){selectStory(topVisibleTrayIndex+VISIBLE_STORY_COUNT-2);}
var autoscrollTimer;var isAutoscrolling=false;var autoscrollIsDisabled=false;function startAutoscroll(){if(!isAutoscrolling&&!autoscrollIsDisabled){autoscrollTimer=setInterval(selectPreviousStory,AUTOSCROLL_DELAY);isAutoscrolling=true;}}
function stopAutoscroll(){clearInterval(autoscrollTimer);isAutoscrolling=false;}
function disableAutoscroll(){autoscrollIsDisabled=true;stopAutoscroll();}
mainstage.append(storiesPanel);$('.stories_nav_up',storiesPanel).hide();$('.stories_nav_down',storiesPanel).hide();$('.stories_nav_up',storiesPanel).fadeIn();for(i=0;i<VISIBLE_STORY_COUNT;i++){appendStory({fade:true});}
setTimeout(function(){$('.stories_nav_down',storiesPanel).fadeIn(function(){headline.wrap('<div class="headline_viewport"></div>');});},(VISIBLE_STORY_COUNT+1)*STORIES_FADE_IN_STAGGER_DELAY);$('.stories_nav_up',storiesPanel).click(function(){disableAutoscroll();selectPreviousStory();})
$('.stories_nav_down',storiesPanel).click(function(){disableAutoscroll();selectNextStory();})
return{startAutoscroll:startAutoscroll,stopAutoscroll:stopAutoscroll,disableAutoscroll:disableAutoscroll};}
$.fn.wwfMainstage=function(data){var mainstage=this;var feature=Feature(mainstage,data[0]);if(data.length>1){$(function(){setTimeout(function(){storiesPanel=StoriesPanel(mainstage,data,feature);$(mainstage).hover(function(){storiesPanel.stopAutoscroll();},function(){storiesPanel.startAutoscroll();})
feature.onPlayVideo(function(){storiesPanel.disableAutoscroll();})
storiesPanel.startAutoscroll();},PAUSE_BEFORE_STORIES_PANEL);})}
$(window).load(function(){var backgroundImages=[];for(var i=0;i<data.length;i++){backgroundImages[i]=new Image();backgroundImages[i].src=data[i].backgroundImage;}})}})(jQuery);



//--------------------------------------------------
/* SWFObject v2.1 <http://code.google.com/p/swfobject/>
	Copyright (c) 2007-2008 Geoff Stearns, Michael Williams, and Bobby van der Sluis
	This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
*/
var swfobject=function(){var b="undefined",Q="object",n="Shockwave Flash",p="ShockwaveFlash.ShockwaveFlash",P="application/x-shockwave-flash",m="SWFObjectExprInst",j=window,K=document,T=navigator,o=[],N=[],i=[],d=[],J,Z=null,M=null,l=null,e=false,A=false;var h=function(){var v=typeof K.getElementById!=b&&typeof K.getElementsByTagName!=b&&typeof K.createElement!=b,AC=[0,0,0],x=null;if(typeof T.plugins!=b&&typeof T.plugins[n]==Q){x=T.plugins[n].description;if(x&&!(typeof T.mimeTypes!=b&&T.mimeTypes[P]&&!T.mimeTypes[P].enabledPlugin)){x=x.replace(/^.*\s+(\S+\s+\S+$)/,"$1");AC[0]=parseInt(x.replace(/^(.*)\..*$/,"$1"),10);AC[1]=parseInt(x.replace(/^.*\.(.*)\s.*$/,"$1"),10);AC[2]=/r/.test(x)?parseInt(x.replace(/^.*r(.*)$/,"$1"),10):0}}else{if(typeof j.ActiveXObject!=b){var y=null,AB=false;try{y=new ActiveXObject(p+".7")}catch(t){try{y=new ActiveXObject(p+".6");AC=[6,0,21];y.AllowScriptAccess="always"}catch(t){if(AC[0]==6){AB=true}}if(!AB){try{y=new ActiveXObject(p)}catch(t){}}}if(!AB&&y){try{x=y.GetVariable("$version");if(x){x=x.split(" ")[1].split(",");AC=[parseInt(x[0],10),parseInt(x[1],10),parseInt(x[2],10)]}}catch(t){}}}}var AD=T.userAgent.toLowerCase(),r=T.platform.toLowerCase(),AA=/webkit/.test(AD)?parseFloat(AD.replace(/^.*webkit\/(\d+(\.\d+)?).*$/,"$1")):false,q=false,z=r?/win/.test(r):/win/.test(AD),w=r?/mac/.test(r):/mac/.test(AD);/*@cc_on q=true;@if(@_win32)z=true;@elif(@_mac)w=true;@end@*/return{w3cdom:v,pv:AC,webkit:AA,ie:q,win:z,mac:w}}();var L=function(){if(!h.w3cdom){return }f(H);if(h.ie&&h.win){try{K.write("<script id=__ie_ondomload defer=true src=//:><\/script>");J=C("__ie_ondomload");if(J){I(J,"onreadystatechange",S)}}catch(q){}}if(h.webkit&&typeof K.readyState!=b){Z=setInterval(function(){if(/loaded|complete/.test(K.readyState)){E()}},10)}if(typeof K.addEventListener!=b){K.addEventListener("DOMContentLoaded",E,null)}R(E)}();function S(){if(J.readyState=="complete"){J.parentNode.removeChild(J);E()}}function E(){if(e){return }if(h.ie&&h.win){var v=a("span");try{var u=K.getElementsByTagName("body")[0].appendChild(v);u.parentNode.removeChild(u)}catch(w){return }}e=true;if(Z){clearInterval(Z);Z=null}var q=o.length;for(var r=0;r<q;r++){o[r]()}}function f(q){if(e){q()}else{o[o.length]=q}}function R(r){if(typeof j.addEventListener!=b){j.addEventListener("load",r,false)}else{if(typeof K.addEventListener!=b){K.addEventListener("load",r,false)}else{if(typeof j.attachEvent!=b){I(j,"onload",r)}else{if(typeof j.onload=="function"){var q=j.onload;j.onload=function(){q();r()}}else{j.onload=r}}}}}function H(){var t=N.length;for(var q=0;q<t;q++){var u=N[q].id;if(h.pv[0]>0){var r=C(u);if(r){N[q].width=r.getAttribute("width")?r.getAttribute("width"):"0";N[q].height=r.getAttribute("height")?r.getAttribute("height"):"0";if(c(N[q].swfVersion)){if(h.webkit&&h.webkit<312){Y(r)}W(u,true)}else{if(N[q].expressInstall&&!A&&c("6.0.65")&&(h.win||h.mac)){k(N[q])}else{O(r)}}}}else{W(u,true)}}}function Y(t){var q=t.getElementsByTagName(Q)[0];if(q){var w=a("embed"),y=q.attributes;if(y){var v=y.length;for(var u=0;u<v;u++){if(y[u].nodeName=="DATA"){w.setAttribute("src",y[u].nodeValue)}else{w.setAttribute(y[u].nodeName,y[u].nodeValue)}}}var x=q.childNodes;if(x){var z=x.length;for(var r=0;r<z;r++){if(x[r].nodeType==1&&x[r].nodeName=="PARAM"){w.setAttribute(x[r].getAttribute("name"),x[r].getAttribute("value"))}}}t.parentNode.replaceChild(w,t)}}function k(w){A=true;var u=C(w.id);if(u){if(w.altContentId){var y=C(w.altContentId);if(y){M=y;l=w.altContentId}}else{M=G(u)}if(!(/%$/.test(w.width))&&parseInt(w.width,10)<310){w.width="310"}if(!(/%$/.test(w.height))&&parseInt(w.height,10)<137){w.height="137"}K.title=K.title.slice(0,47)+" - Flash Player Installation";var z=h.ie&&h.win?"ActiveX":"PlugIn",q=K.title,r="MMredirectURL="+j.location+"&MMplayerType="+z+"&MMdoctitle="+q,x=w.id;if(h.ie&&h.win&&u.readyState!=4){var t=a("div");x+="SWFObjectNew";t.setAttribute("id",x);u.parentNode.insertBefore(t,u);u.style.display="none";var v=function(){u.parentNode.removeChild(u)};I(j,"onload",v)}U({data:w.expressInstall,id:m,width:w.width,height:w.height},{flashvars:r},x)}}function O(t){if(h.ie&&h.win&&t.readyState!=4){var r=a("div");t.parentNode.insertBefore(r,t);r.parentNode.replaceChild(G(t),r);t.style.display="none";var q=function(){t.parentNode.removeChild(t)};I(j,"onload",q)}else{t.parentNode.replaceChild(G(t),t)}}function G(v){var u=a("div");if(h.win&&h.ie){u.innerHTML=v.innerHTML}else{var r=v.getElementsByTagName(Q)[0];if(r){var w=r.childNodes;if(w){var q=w.length;for(var t=0;t<q;t++){if(!(w[t].nodeType==1&&w[t].nodeName=="PARAM")&&!(w[t].nodeType==8)){u.appendChild(w[t].cloneNode(true))}}}}}return u}function U(AG,AE,t){var q,v=C(t);if(v){if(typeof AG.id==b){AG.id=t}if(h.ie&&h.win){var AF="";for(var AB in AG){if(AG[AB]!=Object.prototype[AB]){if(AB.toLowerCase()=="data"){AE.movie=AG[AB]}else{if(AB.toLowerCase()=="styleclass"){AF+=' class="'+AG[AB]+'"'}else{if(AB.toLowerCase()!="classid"){AF+=" "+AB+'="'+AG[AB]+'"'}}}}}var AD="";for(var AA in AE){if(AE[AA]!=Object.prototype[AA]){AD+='<param name="'+AA+'" value="'+AE[AA]+'" />'}}v.outerHTML='<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"'+AF+">"+AD+"</object>";i[i.length]=AG.id;q=C(AG.id)}else{if(h.webkit&&h.webkit<312){var AC=a("embed");AC.setAttribute("type",P);for(var z in AG){if(AG[z]!=Object.prototype[z]){if(z.toLowerCase()=="data"){AC.setAttribute("src",AG[z])}else{if(z.toLowerCase()=="styleclass"){AC.setAttribute("class",AG[z])}else{if(z.toLowerCase()!="classid"){AC.setAttribute(z,AG[z])}}}}}for(var y in AE){if(AE[y]!=Object.prototype[y]){if(y.toLowerCase()!="movie"){AC.setAttribute(y,AE[y])}}}v.parentNode.replaceChild(AC,v);q=AC}else{var u=a(Q);u.setAttribute("type",P);for(var x in AG){if(AG[x]!=Object.prototype[x]){if(x.toLowerCase()=="styleclass"){u.setAttribute("class",AG[x])}else{if(x.toLowerCase()!="classid"){u.setAttribute(x,AG[x])}}}}for(var w in AE){if(AE[w]!=Object.prototype[w]&&w.toLowerCase()!="movie"){F(u,w,AE[w])}}v.parentNode.replaceChild(u,v);q=u}}}return q}function F(t,q,r){var u=a("param");u.setAttribute("name",q);u.setAttribute("value",r);t.appendChild(u)}function X(r){var q=C(r);if(q&&(q.nodeName=="OBJECT"||q.nodeName=="EMBED")){if(h.ie&&h.win){if(q.readyState==4){B(r)}else{j.attachEvent("onload",function(){B(r)})}}else{q.parentNode.removeChild(q)}}}function B(t){var r=C(t);if(r){for(var q in r){if(typeof r[q]=="function"){r[q]=null}}r.parentNode.removeChild(r)}}function C(t){var q=null;try{q=K.getElementById(t)}catch(r){}return q}function a(q){return K.createElement(q)}function I(t,q,r){t.attachEvent(q,r);d[d.length]=[t,q,r]}function c(t){var r=h.pv,q=t.split(".");q[0]=parseInt(q[0],10);q[1]=parseInt(q[1],10)||0;q[2]=parseInt(q[2],10)||0;return(r[0]>q[0]||(r[0]==q[0]&&r[1]>q[1])||(r[0]==q[0]&&r[1]==q[1]&&r[2]>=q[2]))?true:false}function V(v,r){if(h.ie&&h.mac){return }var u=K.getElementsByTagName("head")[0],t=a("style");t.setAttribute("type","text/css");t.setAttribute("media","screen");if(!(h.ie&&h.win)&&typeof K.createTextNode!=b){t.appendChild(K.createTextNode(v+" {"+r+"}"))}u.appendChild(t);if(h.ie&&h.win&&typeof K.styleSheets!=b&&K.styleSheets.length>0){var q=K.styleSheets[K.styleSheets.length-1];if(typeof q.addRule==Q){q.addRule(v,r)}}}function W(t,q){var r=q?"visible":"hidden";if(e&&C(t)){C(t).style.visibility=r}else{V("#"+t,"visibility:"+r)}}function g(s){var r=/[\\\"<>\.;]/;var q=r.exec(s)!=null;return q?encodeURIComponent(s):s}var D=function(){if(h.ie&&h.win){window.attachEvent("onunload",function(){var w=d.length;for(var v=0;v<w;v++){d[v][0].detachEvent(d[v][1],d[v][2])}var t=i.length;for(var u=0;u<t;u++){X(i[u])}for(var r in h){h[r]=null}h=null;for(var q in swfobject){swfobject[q]=null}swfobject=null})}}();return{registerObject:function(u,q,t){if(!h.w3cdom||!u||!q){return }var r={};r.id=u;r.swfVersion=q;r.expressInstall=t?t:false;N[N.length]=r;W(u,false)},getObjectById:function(v){var q=null;if(h.w3cdom){var t=C(v);if(t){var u=t.getElementsByTagName(Q)[0];if(!u||(u&&typeof t.SetVariable!=b)){q=t}else{if(typeof u.SetVariable!=b){q=u}}}}return q},embedSWF:function(x,AE,AB,AD,q,w,r,z,AC){if(!h.w3cdom||!x||!AE||!AB||!AD||!q){return }AB+="";AD+="";if(c(q)){W(AE,false);var AA={};if(AC&&typeof AC===Q){for(var v in AC){if(AC[v]!=Object.prototype[v]){AA[v]=AC[v]}}}AA.data=x;AA.width=AB;AA.height=AD;var y={};if(z&&typeof z===Q){for(var u in z){if(z[u]!=Object.prototype[u]){y[u]=z[u]}}}if(r&&typeof r===Q){for(var t in r){if(r[t]!=Object.prototype[t]){if(typeof y.flashvars!=b){y.flashvars+="&"+t+"="+r[t]}else{y.flashvars=t+"="+r[t]}}}}f(function(){U(AA,y,AE);if(AA.id==AE){W(AE,true)}})}else{if(w&&!A&&c("6.0.65")&&(h.win||h.mac)){A=true;W(AE,false);f(function(){var AF={};AF.id=AF.altContentId=AE;AF.width=AB;AF.height=AD;AF.expressInstall=w;k(AF)})}}},getFlashPlayerVersion:function(){return{major:h.pv[0],minor:h.pv[1],release:h.pv[2]}},hasFlashPlayerVersion:c,createSWF:function(t,r,q){if(h.w3cdom){return U(t,r,q)}else{return undefined}},removeSWF:function(q){if(h.w3cdom){X(q)}},createCSS:function(r,q){if(h.w3cdom){V(r,q)}},addDomLoadEvent:f,addLoadEvent:R,getQueryParamValue:function(v){var u=K.location.search||K.location.hash;if(v==null){return g(u)}if(u){var t=u.substring(1).split("&");for(var r=0;r<t.length;r++){if(t[r].substring(0,t[r].indexOf("="))==v){return g(t[r].substring((t[r].indexOf("=")+1)))}}}return""},expressInstallCallback:function(){if(A&&M){var q=C(m);if(q){q.parentNode.replaceChild(M,q);if(l){W(l,true);if(h.ie&&h.win){M.style.display="block"}}M=null;l=null;A=false}}}}}();
//--------------------------------------------------
function testString(f_sString)
{
	if (f_sString.length > 0)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function testStringEq(f_sString, f_iLen)
{
	if (f_sString.length == f_iLen)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function testStringGt(f_sString, f_iLen)
{
	if (f_sString.length > f_iLen)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function testStringLt(f_sString, f_iLen)
{
	if (f_sString.length < f_iLen)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function testInt(f_iInteger)
{
	var regInt = /^[0-9]+$/;
	
	if (regInt.test(f_iInteger) == true)
	{
		return true;
	}	
	else
	{
		return false;
	}
}

function testFloat(f_flFloat)
{
	var regFloat = /^[0-9]+(\.[0-9]+)*$/;
	
	if (regFloat.test(f_flFloat) == true)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function testIntGtZero(f_iInteger)
{
	var regInt = /^[0-9]+$/;
	
	if (regInt.test(f_iInteger) == true && f_iInteger > 0)
	{
		return true;
	}	
	else
	{
		return false;
	}
}

function testMinusOne(f_iInteger)
{
	if (f_iInteger != -1)
	{
		return true;
	}	
	else
	{
		return false;
	}
}

function testTime(f_sTime)
{
	var regTime = /^([0-2]?[0-9]):[0-5][0-9](:[0-5][0-9])?$/;
	var iIndex;
	var iValue;
	var sValue = f_sTime;
	
	if (regTime.test(sValue) == true)
	{
		iIndex = sValue.indexOf(":");
		iValue = sValue.substr(0,iIndex);
		
		if (iValue <= 23 && iValue >=0)
		{
			return true;
		}
		else
		{
			return false;
		}	
	}
	else
	{
		return false;
	}
}

function testDate(f_sDate)
{
	var regDate = /^([0-3]?[0-9])\.([0-1]?[0-9])\.[1-9][0-9]{3}$/;
	var iIndex, iIndex2;
	var iMonth,iDay,iYear;
	var arrMonth = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	var sValue = f_sDate;
	
	if (regDate.test(sValue) == true)
	{
		iIndex = sValue.indexOf(".");
		iIndex2 = sValue.indexOf(".",iIndex+1);
		
		iDay = sValue.substr(0,iIndex);
		iMonth = sValue.substring(iIndex+1,iIndex2);
		iYear = sValue.substr(iIndex2+1,sValue.length);		

		if (iMonth < 1 || iMonth > 12)
		{
			return false;		
		}
		
		if (iMonth == 2 && ( ( (iYear % 4) == 0 && (iYear % 100) != 0 ) || (iYear % 400) == 0 ) ) 
		{
			if (iDay < 1 || iDay > 29)
			{
				return false;
			}
		}
		else
		{
			if (iDay < 1 || iDay > arrMonth[iMonth-1])
			{
				return false;
			}
		}		

		return true;

	}
	else
	{
		return false;
	}
}

/* For dates that are formated different to normal dates (i.e. MM.DD.YYYY) */
function testDate2(f_sDate)
{
	var regDate = /^([0-1]?[0-9])\.([0-3]?[0-9])\.[1-9][0-9]{3}$/;
	var iIndex, iIndex2;
	var iMonth,iDay,iYear;
	var arrMonth = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	var sValue = f_sDate;
	
	if (regDate.test(sValue) == true)
	{
		iIndex = sValue.indexOf(".");
		iIndex2 = sValue.indexOf(".",iIndex+1);
		
		iMonth = sValue.substr(0,iIndex);
		iDay = sValue.substring(iIndex+1,iIndex2);
		iYear = sValue.substr(iIndex2+1,sValue.length);		

		if (iMonth < 1 || iMonth > 12)
		{
			return false;		
		}
		
		if (iMonth == 2 && ( ( (iYear % 4) == 0 && (iYear % 100) != 0 ) || (iYear % 400) == 0 ) ) 
		{
			if (iDay < 1 || iDay > 29)
			{
				return false;
			}
		}
		else
		{
			if (iDay < 1 || iDay > arrMonth[iMonth-1])
			{
				return false;
			}
		}		

		return true;

	}
	else
	{
		return false;
	}
}

function compareDate(f_sDate1,f_sDate2)
{
	var sValue1 = f_sDate1;
	var sValue2 = f_sDate2;
	
	iIndex = sValue1.indexOf(".");
	iIndex2 = sValue1.indexOf(".",iIndex+1);
	
	iDay1 = sValue1.substr(0,iIndex);
	iDay1 = (iDay1.length == 2) ? iDay1 : iDay1 = "0" + iDay1 ; 
	iMonth1 = sValue1.substring(iIndex+1,iIndex2);
	iMonth1 = (iMonth1.length == 2) ? iMonth1 : iMonth1 = "0" + iMonth1 ; 
	iYear1 = sValue1.substr(iIndex2+1,sValue1.length);	

	
	iIndex = sValue2.indexOf(".");
	iIndex2 = sValue2.indexOf(".",iIndex+1);
	
	iDay2 = sValue2.substr(0,iIndex);
	iDay2 = (iDay2.length == 2) ? iDay2 : iDay2 = "0" + iDay2 ; 
	iMonth2 = sValue2.substring(iIndex+1,iIndex2);
	iMonth2 = (iMonth2.length == 2) ? iMonth2: iMonth2 = "0" + iMonth2 ; 
	iYear2 = sValue2.substr(iIndex2+1,sValue2.length);		
	
	iDate1 = parseInt(iYear1 + iMonth1 + iDay1);
	iDate2 = parseInt(iYear2 + iMonth2 + iDay2);
	
	if(iDate1 <= iDate2)
	{
		return true
	}
	else
	{
		return false;
	}
}

function testEmail(f_sEmail)
{
	var regEmail = /^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*\.([a-zA-Z]{2,4})$/;
	
	if (regEmail.test(f_sEmail) == true)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function testChPlz(f_iPLZ)
{
	var regPLZ = /^[1-9][0-9]{3}$/;
	
	if (regPLZ.test(f_iPLZ) == true)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function testCHMoney(f_flMoney)
{
	var regMoney = /(^[1-9][0-9]*|^0)(\.[0-9](0|5))?$/;
	
	if (regMoney.test(f_flMoney) == true)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function testEmpty(f_sString)
{
	var regWhiteSpace = /[^ \f\n\r\t]/;
	
	if (regWhiteSpace.test(f_sString))
	{
		return false;
	}
	else
	{
		return true;
	}
}

function testReg(f_sString,f_regString)
{

	regString = new RegExp(f_regString,"gi");
	if (regString.test(f_sString) == true)
	{
		return true;
	}
	else
	{
		return false;
	}
}

//--------------------------------------------------
