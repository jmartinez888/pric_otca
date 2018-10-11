{extends file='template.tpl'}
{block 'css'}
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/foro/views/index/css/index.css">
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/foro/views/index/css/jp-index.css">
<style type="text/css" media="screen">
</style>
{/block}
{block "contenido"}
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0" style="background-image: url(http://local.github/pric_otca/modules/foro/views/index/img/encabezado-foro.jpg); background-repeat: no-repeat;">
	<div class="col-md-5 col-lg-5" style="color: #333; font-weight: bold; font-size: 18px;">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<h1 class="titulo">{$tematica->Lit_Nombre}</h1>
			<div class="col-lg-12 p-rt-lt-0">
				<hr class="cursos-hr-title-foro2">
			</div>
			<p class="descripcion-foro">{$tematica->Lit_Descripcion}</p>
		</div>
	</div>
</div>
<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
	{include file='modules/foro/views/index/menu/lateral.tpl'}
	<div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;" id="tematica_detalles">
		<div class="col-md-12" style="margin-bottom: 15px; margin-top: 10px;">
			<form class="form-inline" @submit.prevent="onSubmit_filtrarResultados">
				<div class="form-group">
					<input type="text" class="form-control" id="txt_buscar" placeholder="{$lenguaje['str_buscar_en']} {$tematica->Lit_Nombre|lower}" v-model="filter.text">
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
				<button class="btn  btn-success btn-buscador" type="submit" id="btn_buscar_foro"><i class="glyphicon glyphicon-search"></i> Buscar</button>
			</form>
		</div>
		<div class="col-md-8">
			<div class="row">
				<div class="col-lg-12"><br></div>
				<div class="col-md-12">
					<h3 class="subtitle-foro">Actividad reciente</h3>
				</div>
				<div class="col-lg-12">
					<hr class="cursos-hr-title-foro">
				</div>
				<div class="col-lg-12">
					<recientes
					v-for="items in list_recientes"
					v-bind:foro="items"
					></recientes>
				</div>
				<div class="col-lg-12" v-if="existeData">
					<a class="" href="#" role="button" @click.prevent="onClick_loadRecientes">Ver más...</a>
					<br>
				</div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="row">
				<div class="col-md-12">
					<h3 class="subtitle-foro">Agenda</h3>
				</div>
				<div class="col-lg-12">
					<hr class="cursos-hr-title-foro">
				</div>
				<div class="col-md-12">
					<div class="tab-pane fade in active show agenda-container">
						<div class="contenedor-link-agenda">
							<a href="#" class="link-tabs-jsoft" style="padding-top: 30px;">
								<div class="row ">
									<div class="col-md-4 fecha-agenda">
										<div class="text-uppercase" style="font-size: 13px;">vier</div>
										<div style="font-size: 21px;"><strong>29</strong></div>
										<div class="text-uppercase" style="font-size: 13px;">octubre 2018</div>
									</div>
									<div class="col-md-8">
										<div class="card-block px-3">
											<h4 class="card-title" style="font-size: 17px;">segundo Workshop</h4>
											<p class="card-text" style="font-size: 13px;">
												<i class="glyphicon glyphicon-time"></i>
											05.10.2018 13:10</p>
										</div>
									</div>
								</div>
							</a>
						</div>
						<div class="contenedor-link-agenda">
							<a href="#" class="link-tabs-jsoft" style="padding-top: 30px;">
								<div class="row ">
									<div class="col-md-4 fecha-agenda">
										<div class="text-uppercase" style="font-size: 13px;">vier</div>
										<div style="font-size: 21px;"><strong>29</strong></div>
										<div class="text-uppercase" style="font-size: 13px;">octubre 2018</div>
									</div>
									<div class="col-md-8">
										<div class="card-block px-3">
											<h4 class="card-title" style="font-size: 17px;">nuevo workshop</h4>
											<p class="card-text" style="font-size: 13px;">
												<i class="glyphicon glyphicon-time"></i>
											05.10.2018 13:10</p>
										</div>
									</div>
								</div>
							</a>
						</div>
						<div class="contenedor-link-agenda">
							<a href="#" class="link-tabs-jsoft" style="padding-top: 30px;">
								<div class="row ">
									<div class="col-md-4 fecha-agenda">
										<div class="text-uppercase" style="font-size: 13px;">vier</div>
										<div style="font-size: 21px;"><strong>29</strong></div>
										<div class="text-uppercase" style="font-size: 13px;">octubre 2018</div>
									</div>
									<div class="col-md-8">
										<div class="card-block px-3">
											<h4 class="card-title" style="font-size: 17px;">tyutyutyu</h4>
											<p class="card-text" style="font-size: 13px;">
												<i class="glyphicon glyphicon-time"></i>
											05.10.2018 11:10</p>
										</div>
									</div>
								</div>
							</a>
						</div>
						<div class="contenedor-link-agenda">
							<a href="#" class="link-tabs-jsoft" style="padding-top: 30px;">
								<div class="row ">
									<div class="col-md-4 fecha-agenda">
										<div class="text-uppercase" style="font-size: 13px;">vier</div>
										<div style="font-size: 21px;"><strong>29</strong></div>
										<div class="text-uppercase" style="font-size: 13px;">octubre 2018</div>
									</div>
									<div class="col-md-8">
										<div class="card-block px-3">
											<h4 class="card-title" style="font-size: 17px;">asd</h4>
											<p class="card-text" style="font-size: 13px;">
												<i class="glyphicon glyphicon-time"></i>
											05.10.2018 11:10</p>
										</div>
									</div>
								</div>
							</a>
						</div>
						<div class="contenedor-link-agenda">
							<a href="#" class="link-tabs-jsoft" style="padding-top: 30px;">
								<div class="row ">
									<div class="col-md-4 fecha-agenda">
										<div class="text-uppercase" style="font-size: 13px;">vier</div>
										<div style="font-size: 21px;"><strong>29</strong></div>
										<div class="text-uppercase" style="font-size: 13px;">octubre 2018</div>
									</div>
									<div class="col-md-8">
										<div class="card-block px-3">
											<h4 class="card-title" style="font-size: 17px;">xzcxcz</h4>
											<p class="card-text" style="font-size: 13px;">
												<i class="glyphicon glyphicon-time"></i>
											05.10.2018 11:10</p>
										</div>
									</div>
								</div>
							</a>
						</div>
						<a href="#" class="mas-jsoft">VER MÁS</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
{/block}
{block 'template'}
<template id="recientes">
<div class="row col-lg-12 tematica-foro">
	<div>
		<a :href="foro.ref_url" class="link-foro"><h4 style="text-align: justify;"><strong>{literal} {{foro.For_Titulo}} {/literal}</strong></h4></a>
	</div>
	<div>
		<p style="text-align: justify;" v-html="foro.For_Resumen"></p>
	</div>
	<div class="detalles-act-reciente" style="padding-top: 6px; border-bottom: 1px solid rgb(221, 221, 221); padding-bottom: 6px;">
		<span class="badge" style="border-radius: 4px;">{literal} {{foro.For_Funcion}} {/literal}</span>  {literal} {{foro.autor ? foro.autor.Usu_Nombre + ' ' + foro.autor.Usu_Apellidos  : 'no_definido'}} {/literal} &nbsp;&nbsp;-&nbsp;&nbsp; {literal} {{foro.format_creacion}} {/literal}  &nbsp;&nbsp;-&nbsp;&nbsp; 0 voto(s) &nbsp;&nbsp;-&nbsp;&nbsp; {literal} {{foro.total_miembros}} {/literal} miembro(s) &nbsp;&nbsp;-&nbsp;&nbsp;{literal}{{foro.total_comentarios}}{/literal} comentario(s)
	</div>
</div>
</template>
{/block}