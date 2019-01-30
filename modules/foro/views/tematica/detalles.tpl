{extends file='template.tpl'}
{block 'css'}
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/foro/views/index/css/index.css">
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/foro/views/index/css/jp-index.css">
<style type="text/css" media="screen">
</style>
{/block}
{block "contenido"}
<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
	{include file='modules/foro/views/index/menu/lateral.tpl'}

	<div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;    margin-bottom: 20px;" id="tematica_detalles">
		<div class="col col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <h2 class="titulo">{$tematica->Lit_Nombre}</h2>
            <p class="descripcion-foro">{$tematica->Lit_Descripcion}</p>
        </div>
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12 p-rt-lt-0">
            <hr class="cursos-hr-title-foro">
        </div>

		<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12 p-rt-lt-0 text-right" style="margin-bottom: 15px; ">
			<form class="form-inline" @submit.prevent="onSubmit_filtrarResultados">
				<div class="form-group">
					<input type="text" class="form-control" id="txt_buscar" placeholder="{$lang->get('str_buscar_en')}  {$tematica->Lit_Nombre|lower}" v-model="filter.text">
				</div>
				<div class="form-group">
					<label for="sel_tematica">Opciones</label>
					<select id="sel_tematica" class="form-control" required="required" v-model="filter.funcion">
						<option value="todo">Todos</option>
						{foreach $funciones as $item}
						<option value="{$item->funcion}">{$item->funcion}</option>
						{/foreach}
					</select>
				</div>
				<button class="btn  btn-success btn-buscador" type="submit" id="btn_buscar_foro"><i class="glyphicon glyphicon-search"></i>Buscar</button>
			</form>
		</div>
		<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12 p-rt-lt-0">
			<div class="row">				
				<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
					<recientes
					v-for="items in list_recientes"
					v-bind:foro="items">
						Cargando Datos!...
					</recientes>
				</div>
				<div id="ver_mas"  class="col-md-12 col-xs-12 col-sm-12 col-lg-12 margin-t-10 hidden" v-if="existeData">
					<a class="" href="#" role="button" @click.prevent="onClick_loadRecientes">Ver más...</a>
					<br>
				</div>
				<div id="ver_mas"  class="col-md-12 col-xs-12 col-sm-12 col-lg-12 margin-t-10 hidden" v-if="pagination.active==false">
					No se encontraron resultados!...
				</div>		
			</div>
		</div>
	</div>
</div>
{/block}
{block 'template'}
<template id="recientes">
<div class="row col-md-12 col-xs-12 col-sm-12 col-lg-12 tematica-foro">
	<div>
		<a :href="foro.ref_url" class="link-foro"><h4 style="text-align: justify;"><strong>{literal} {{foro.For_Titulo}} {/literal}</strong></h4></a>
	</div>
	<div>
		<p style="text-align: justify;" v-html="foro.For_Resumen"></p>
	</div>
	<div class="detalles-act-reciente" style="padding-top: 6px; border-bottom: 1px solid rgb(221, 221, 221); padding-bottom: 6px;">
		<span class="badge" style="border-radius: 4px;">
		{literal}
		{{foro.For_Funcion}}
		{/literal}</span>  {literal} {{foro.autor ? foro.autor.Usu_Usuario : 'no_definido'}} {/literal} &nbsp;&nbsp;-&nbsp;&nbsp; {literal} {{foro.format_creacion}} {/literal}  &nbsp;&nbsp;-&nbsp;&nbsp; {literal} {{foro.total_likes}} voto(s) {/literal}&nbsp;&nbsp;-&nbsp;&nbsp; {literal} {{foro.total_miembros}} {/literal} participante(s) &nbsp;&nbsp;-&nbsp;&nbsp;{literal}{{foro.total_comentarios}}{/literal} comentario(s)
	</div>
</div>
</template>
{/block}
