{extends 'template.tpl'}
{block 'css'}
	<style>
	    .header {
	        background-color: rgba(0,0,0, .3);
	        height: 80px;
	    }
	    .sidebar-left {
	        padding-top: 40px;
	        width: 100%;
	        padding-right: 0px;
	    }
	    .side-menu li {

	        /*padding: 10px 20px;*/
	        cursor: pointer;
	        background-color: #ffffff;
	        margin-bottom: 10px;
	        font-size: 15px;
	        text-align: left;
	        height: auto;
	        overflow: hidden;
	        border-left: 5px solid #355D3A;
	        -moz-box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.6);
	        -webkit-box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.6);
	        box-shadow: 3px 3px 10px rgba(100, 100, 100, 0.6);
	    }
	    .side-menu li a {
	    	color: #222;
	    	padding: 10px 20px;
	    	display:block;
	    }
	    .side-menu2:hover{
	        -moz-box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.9);
	        -webkit-box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.9);
	        box-shadow: 3px 3px 10px rgba(100, 100, 100, 0.9);
	        /*background-color: red;*/
	    }
	    .side-menu2.active {
	    	-moz-box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.9);
	      -webkit-box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.9);
	       box-shadow: 3px 3px 10px rgba(100, 100, 100, 0.9);
	    }
	    .side-menu2.submenu2 {
	    	padding-left: 12px;
	    }
	    .contenedor {
	        padding-top: 10px ;
	        background-color: #ffffff;
	        margin: 0px 0px 30px;
	        box-shadow: 0 0 15px 1px #9e9e9e;

	    }

	    .sidebar-left li {
	        display: list-item;
	        text-align: -webkit-match-parent;
	    }

	    a.nounderline:link { text-decoration: none; }
	    a.nounderline:hover { text-decoration: none; }

	    .sidebar-left ul{
	        padding-left: 0px !important;
	    }

	    .cursos-hr-title-foro {
	        margin-top: 0px;
	        padding: 0.2px;
	        border-top: 1px solid #3c763d;
	    }
	    .p-rt-lt-0 {
	        padding-right: 0px;
	        padding-left: 0px;
	    }
	</style>
{/block}
{block 'contenido'}
	<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
		<div class="col-md-2 col-xs-12 col-sm-4 col-lg-2" style="padding-left: 0px !important">
	    <div class="sidebar-left">
	        <div class="side-menu">
	            <ul role="" class="">
	            	<li class=" side-menu2">
	                	<a href="{$_layoutParams.root}difusion/contenido" aria-controls="contenido"  class="nounderline"><span>Contenido</span></a>

	            	</li>
	            	<li class="side-menu2 submenu2">
	                <a href="{$_layoutParams.root}difusion/evento" aria-controls="evento"  class="nounderline"><span>Evento</span></a>
	            	</li>

	            	<li class="side-menu2 submenu2">
	                <a href="{$_layoutParams.root}difusion/datos" aria-controls="datos"  class="nounderline"><span>Datos</span></a>
	            	</li>
	            	<li class="side-menu2 submenu2">
	                <a href="{$_layoutParams.root}difusion/tipo" aria-controls="tipo"  class="nounderline"><span>Tipo</span></a>
	            	</li>
	            	<li class=" side-menu2">
	                	<a href="{$_layoutParams.root}difusion/banner" aria-controls="banner"  class="nounderline"><span>Banner</span></a>
	            	</li>
	            	<li class=" side-menu2">
	                	<a href="{$_layoutParams.root}difusion/cifras" aria-controls="cifras"  class="nounderline"><span>Datos y cifras</span></a>
	            	</li>
	            	<li class=" side-menu2">
	                	<a href="{$_layoutParams.root}difusion/link_interes" aria-controls="link_interes"  class="nounderline"><span>Links de interes</span></a>
	            	</li>
	            </ul>

	        </div>
	    </div>
		</div>
		<div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" >
			{block 'subcontenido'}
			{/block}
		</div>

	</div>
{/block}
{block 'js'}
<script type="text/javascript">
$('.side-menu a').map((item, v) => {
	if (v.href == location.href)
		$(v).parent().addClass('active')
})
</script>
{/block}