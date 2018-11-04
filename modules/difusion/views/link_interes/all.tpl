{extends 'difusion_frontend.tpl'}
{block 'css' append}
<link rel="stylesheet" type="text/css" href="{BASE_URL}public/vendors/cropperjs/dist/cropper.min.css">
<style type="text/css" media="screen">
	#image {
		max-width: 100% !important;
		/*padding: 40px;*/
	}
	.cropper-container {
		/*max-width: 100% !important;*/
	}
	#opciones-imagen {
		margin-bottom: 8px;
	}

  .links_interes_view {
    border-bottom: 1px solid #ddd;
  }
  .links_interes_view .cabecera-discusion a{
    text-decoration: none;
    color: black;
  }
</style>
{/block}
{block 'subcontenido'}
<div class="row" id="vue_container">
	<div class="col-sm-12">
		<div class="row">

	    <div class="col-sm-12">
	        <h2 class="titulo">{$titulo}</h2>
	        <div class="col-lg-12 p-rt-lt-0">
	            <hr class="cursos-hr-title-foro">
	        </div>
	    </div>
		</div>
	</div>
  <div class="row">
    <div class="col-sm-offset-6 col-sm-6">
        <form action="" @submit.prevent="onSubmit_buscar">
                <div class="input-group">
                    <input type="text" class="form-control" data-toggle="tooltip" data-original-title="Buscar" placeholder="Buscar" name="text_busqueda" id="text_busqueda" value="" v-model="buscar">
                    <span class="input-group-btn">
                        <button class="btn  btn-success btn-buscador" for_funcion="workshop"  type="submit" id=""><i class="glyphicon glyphicon-search"></i></button>
                    </span>
                </div>
        </form>
        </div>
  </div>
	<div class="row">
    <div class="col-sm-12" v-for="item in links_interes">
      <link-interes :url="item.url" :titulo="item.titulo" :descripcion="item.descripcion"></link-interes>
    </div>
    <div class="col-sm-12" style="margin: 8px 0px">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
          <a href="#" @click.prevent="onCLick_verMas">{$lenguaje['str_ver_mas']}</a>
      </div>
    </div>
	</div>
</div>
{/block}
{block 'template'}
<template id="link_interes">
  {* <div class="col-sm-12"> *}
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
          <div class="links_interes_view">
              <div class="cabecera-discusion">
                  <a class="link-foro" :href="url">
                      <h4 style="text-align: justify;"><strong>{literal}{{titulo}}{/literal}</strong></h4>
                  </a>
              </div>
              <div style="padding-bottom: 4px;">
                  <p style="text-align: justify;">{literal}{{descripcion}}{/literal}</p>
              </div>
              <div style="padding-bottom: 4px;">
                  <a :href="url">{literal}{{url}}{/literal}</a>
              </div>
              <div class="detalles-act-reciente">
              </div>
          </div>
      </div>

    {* </div> *}
</template>

{/block}
{block 'js' append}
<script type="text/javascript">
	var data_vue = {json_encode($data_vue)};
</script>
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script src="{BASE_URL}public/vendors/cropperjs/dist/cropper.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/vendors/autosize/autosize.min.js" type="text/javascript"></script>
<script type="text/javascript" src="{$_layoutParams.rutas.js}all.js"></script>
{/block}