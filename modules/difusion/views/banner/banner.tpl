{extends 'difusion_frontend.tpl'}
{block 'css' append}
{/block}
{block 'subcontenido'}
<div class="row" id="index_banner">
  <div class="col-sm-12">
      <h2 class="titulo">{$titulo}</h2>
      <div class="col-lg-12 p-rt-lt-0">
          <hr class="cursos-hr-title-foro">
      </div>
      <div class="col-lg-12">
          <div class="col-md-10 col-lg-10">
            <form @submit.prevent="onSubmit_buscar">
              <div class="input-group col-md-offset-2">
                  <input type="text" class="form-control" data-toggle="tooltip" data-original-title="{$lenguaje['str_buscar']}" placeholder="{$lenguaje['str_buscar']}" name="text_busqueda" id="text_busqueda" v-model="buscar">
                  <span class="input-group-btn">
                      <button class="btn  btn-success btn-buscador" for_funcion="query" ajax="lista_buscar_query" type="submit" id="buscar_foro"><i class="glyphicon glyphicon-search"></i></button>
                  </span>
              </div>
            </form>
          </div>
          <a type="button" href="{$_layoutParams.root}difusion/banner/create" class="btn btn-success btn-sm pull-right" style="margin-right: 15px;" title="{$lenguaje['str_nuevo']}">{$lenguaje['str_nuevo']}</a>
      </div>
  </div>
  <div class="col-sm-12" style="margin-top: 8px">
		<div class="row">

  			<div v-for="item in banners" class="col-sm-6 col-md-4"  :id="'container-banner-' + item.id">
          <difusion-banners :banner="item"></difusion-banners>
  		  </div>
      <div class="clearfix"></div>
      <div class="col-sm-12">
        <nav aria-label="...">
          <ul class="pager">
            <li :class="{literal}{previous: true, disabled: disable.prev}{/literal}"><a href="#" @click.prevent="onClick_pagePrev"><span aria-hidden="true">&laquo;</span>&nbsp;{$lenguaje['str_anterior']}</a></li>
            <li :class="{literal}{next: true, disabled: disable.next}{/literal}"><a href="#" @click.prevent="onClick_pageNext">{$lenguaje['str_siguiente']}&nbsp;<span aria-hidden="true">&raquo;</span></a></li>
          </ul>
        </nav>
      </div>
		</div>
  </div>
</div>

{/block}

{block 'js' append}
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script src="{$_layoutParams.root}difusion/banner/vcomponent/vbanner"></script>
<script type="text/javascript" src="{$_layoutParams.rutas.js}index.js"></script>
{/block}