{extends 'difusion_frontend_all.tpl'}
{block 'css' append}
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/difusion/views/contenido/css/jp-ficha-difusion.css">
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/difusion/views/contenido/css/base.css">
<style type="text/css" media="screen">
	.category-caption h2.main-caption{
  	background-color: #ccc;
	}
	.active2{
  	background: #373941 !important;
		border-left: 4px solid #8BC34A !important;
		color: #fff !important;
		font-weight: normal !important;
  }
  .pagination {
	  clear: both;
	  padding: 0;
	}

	article a {
    color: black;
  }


</style>
{/block}

{block 'subcontenido'}
<div class="row category-caption">
    <div class="col-lg-12">
        <h2 class="pull-left active2">{$titulo_base} {if isset($palabras)}: {$palabras}{/if}</h2>
    </div>

</div>

<div class="row">
	{if $no_existe}
	<div class="col-sm-12">
		<h2>{$lenguaje['str_elemento_no_encontrado']}</h2>
	</div>
	{else}

	{* <div class="row thumb-list"> *}
		{foreach $rows as $item}
			<article class="col-lg-4 col-md-4 col-sm-4 col-xs-6 col-xxs-12">
				<div class="picture">
					<div class="thumbnail-pic zoom-hover">
						<a href="{$_layoutParams.root}difusion/contenido/{$item->ODif_IdDifusion}">
							<img src="{$_layoutParams.root_clear}files/difusion/contenido/{$item->ODif_IdDifusion}/{$item->ODif_BannerUrl}" class="w-100">
						</a>
					</div>
				</div>
				<div class="detail">
					<div class="info">
						<span class="date"><i class="fa fa-calendar-o"></i> {$item->ODif_FechaPublicacion->format('j F, Y')}</span>
						{* <span class="date"><i class="fa fa-calendar-o"></i> 03 de Julio, 2018</span> *}
					</div>
					<div class="small-caption">
						<a href="{$_layoutParams.root}difusion/contenido/{$item->ODif_IdDifusion}">{$item->ODif_Titulo}</a>
					</div>
				</div>
			</article>
		{/foreach}
	{/if}
	{* </div> *}
	{if !$no_existe}
	<div class="clearfix"></div>

	<div class="col-sm-12">
		{$pages}
	</div>
	{/if}
</div>
{/block}

{block 'js' append}
{/block}