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
	<div  id="vue_content">
		<div  class="col-md-8 col-xs-12 col-sm-8 col-lg-8" >
			{block 'subcontenido'}
			{/block}
		</div>
        <div class="col col-md-4 col-sm-12 col-xs-12 back-color-white" style="padding-top: 29px; border-left: 1px solid #ebeaea; padding-left: 10px;">
            {include 'tab_interes.tpl'}



        </div>

	</div>
{/block}
{block 'js'}
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{$_layoutParams.root}difusion/contenido/vcomponent/interes"></script>
<script type="text/javascript">
	new Vue({
		el: '#vue_content'
	})
</script>

{/block}