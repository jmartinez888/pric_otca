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
          <a type="button" href="{$_layoutParams.root}difusion/indicadores/create" class="btn btn-success btn-sm pull-right" style="margin-right: 15px;" title="{$lenguaje['str_nuevo']}">{$lenguaje['str_nuevo']}</a>
      </div>
  </div>
  <div class="col-sm-12" style="margin-top: 8px">
    {* <div class="col-sm-6">
        <div class="row">

            <div class="media">
                <div class="media-left">
                    <a href="#">
                        <img alt="64x64" class="media-object" data-src="holder.js/64x64" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iNjQiIGhlaWdodD0iNjQiIHZpZXdCb3g9IjAgMCA2NCA2NCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+PCEtLQpTb3VyY2UgVVJMOiBob2xkZXIuanMvNjR4NjQKQ3JlYXRlZCB3aXRoIEhvbGRlci5qcyAyLjYuMC4KTGVhcm4gbW9yZSBhdCBodHRwOi8vaG9sZGVyanMuY29tCihjKSAyMDEyLTIwMTUgSXZhbiBNYWxvcGluc2t5IC0gaHR0cDovL2ltc2t5LmNvCi0tPjxkZWZzPjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+PCFbQ0RBVEFbI2hvbGRlcl8xNjZlMDVlNmI4OSB0ZXh0IHsgZmlsbDojQUFBQUFBO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1mYW1pbHk6QXJpYWwsIEhlbHZldGljYSwgT3BlbiBTYW5zLCBzYW5zLXNlcmlmLCBtb25vc3BhY2U7Zm9udC1zaXplOjEwcHQgfSBdXT48L3N0eWxlPjwvZGVmcz48ZyBpZD0iaG9sZGVyXzE2NmUwNWU2Yjg5Ij48cmVjdCB3aWR0aD0iNjQiIGhlaWdodD0iNjQiIGZpbGw9IiNFRUVFRUUiLz48Zz48dGV4dCB4PSIxMy4xNzk2ODc1IiB5PSIzNi41Ij42NHg2NDwvdGV4dD48L2c+PC9nPjwvc3ZnPg==" data-holder-rendered="true" style="width: 64px; height: 64px;">
                    </a>
                </div>
                <div class="media-body">
                    <h4 class="media-heading">Media heading</h4> Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin commodo. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.
                </div>
            </div>
        </div>
    </div> *}




        <div class="row">

            <div v-for="item in indicadores" class="col-sm-6 col-md-4"  :id="'container-indicador-' + item.id">
              <difusion-indicador :indicador="item"></difusion-indicador>
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
<script src="{$_layoutParams.root}difusion/indicadores/vcomponent/vindicador"></script>
<script type="text/javascript" src="{$_layoutParams.rutas.js}index.js"></script>
{/block}