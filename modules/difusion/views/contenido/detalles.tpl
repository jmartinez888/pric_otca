{extends 'template.tpl'}
{block 'css'}
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/difusion/views/contenido/css/jp-ficha-difusion.css">
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/difusion/views/contenido/css/base.css">
<style type="text/css">
	.category-caption h2.main-caption{
    	background-color: #ccc;
	}

    .active2{
    	background: #373941 !important;
		border-left: 4px solid #8BC34A !important;
		color: #fff !important;
		font-weight: normal !important;
    }
</style>
{/block}
{block 'contenido'}
<div id="difusion_contenido">


        <div class="col-lg-8">
            <div class="row category-caption">
                <div class="col-lg-12">
                    <h2 class="pull-left active2">{$difusion->tipo->ODit_Tipo}</h2>
                </div>
            </div>

            <div class="row">
                <article class="col-lg-12 col-md-12">
                    <div class="picture">
                        <div class="category-image">
                            <img src="{BASE_URL}files/difusion/contenido/{$difusion->ODif_IdDifusion}/{$difusion->ODif_BannerUrl}" class="img-responsive" style="width: 100%">
                        </div>
                    </div>

                    <div class="detail ">
                        <div class="info">
                            <span class="date">
                                <i class="fa fa-calendar-o"> {$difusion->ODif_FechaPublicacion}</i>
                            </span>
                        </div>
                    </div>

                    <div class="caption">{$difusion->ODif_Titulo}</div>
                    <div class="text">
                        {$difusion->ODif_Contenido}
                    </div>
                    <hr>


                    <div class="col-lg-8 p-rt-lt-0" style="font-size: 12px;">
                            <div class="col-lg-12 p-rt-lt-0">
                                <div class="" style="width: fit-content;line-height: 250%;">
                                    <i class="glyphicon glyphicon-tags" style="font-size: 20px; color: #777; text-align: center; vertical-align: middle;"></i>&nbsp;&nbsp;
                                    {foreach $difusion->getPalabrasClaves() as $palabras}
                                        <a class="regresar-tematica" href="{$_layoutParams.root}difusion/contenido/buscar/{$palabras}">{$palabras}</a>
                                    {/foreach}
                                    </div>
                                <br>

                            </div>
                    </div>
                    <div class="col-lg-4 p-rt-lt-0" style="">
                        <a class="pull-right regresar-tematica2" href="{$_layoutParams.root}foro/tematica/detalles/{$difusion->tematica->Lit_IdLineaTematica}" style="color: white;">
                            <i class="glyphicon glyphicon-star" style="text-align: center; vertical-align: middle; margin-bottom: 3px;"></i>
                            Temática: {$difusion->tematica->Lit_Nombre}
                        </a>
                    </div>
                    <div class="clearfix"></div>
                    <hr>
                    <div class="col-sm-12">
                        <div class="source"><b>Fuente</b>
                            <ul>
                            {foreach $difusion->referencias as $ref}
                                    <li>

                            <a href="{$ref->ODir_Url}" class="" target="_blank">{$ref->ODir_Titulo} </a>
                            {* {$ref->ODir_Titulo} <a href="{$ref->ODir_Url}" class="btn btn-success btn-sm " target="_blank">Ir a Noticia</a> *}
                                    </li>

                            {/foreach}
                            </ul>
                        </div>
                    </div>

                    <hr>

                </article>
            </div>
        </div>
        <div class="col col-md-4 col-sm-12 col-xs-12 back-color-white" style="padding-top: 29px; border-left: 1px solid #ebeaea; padding-left: 10px;">
            {include 'tab_interes.tpl'}

            <hr>
            <ul class="nav nav-tabs jsoft-tabs bg-verde">
                <li class="active" ><a class=""  data-toggle="tab" href="#evento_interes">{$lenguaje['str_contenido_relacionado']}</a></li>
            </ul>
            <div class="tab-content content-interes">
                <div id="evento_interes" class="tab-pane fade  active in scroll">
                    {foreach $difusion->getRelacionado() as $item}
                        <interes id="{$item->ODif_IdDifusion}"></interes>
                    {/foreach}
                    <a href="{$_layoutParams.root}difusion/contenido/{$difusion->ODif_IdDifusion}/relations" class="col-md-12 col-sm-12 col-xs-12 ver-mas">{$lenguaje['str_ver_mas']}</a>
                </div>


            </div>
        </div>

</div>
{/block}
{block 'template'}
<template id="difusion">
    <div></div>
</template>
{/block}
{block 'js'}
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{$_layoutParams.root}difusion/contenido/vcomponent/interes"></script>
<script>
    const detalle = {
        template: '#difusion'
    };
    new Vue({
        el: '#difusion_contenido',
        data: function () {
            return {
                fecha: 'asd',
                difusion: {$difusion->toJson()}
            }
        },
        components: {
            detalle
        }
    })
</script>
{/block}