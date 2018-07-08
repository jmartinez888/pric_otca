<div id="item-chat-busqueda" style="display: none">
	<strong><div style="color: green">BUSQUEDA</div></strong>
</div>
{foreach from=$chats item=i}
	<div class="item-chat" tag="{$i.ID1}" retag="{$i.ID2}" search="{$i.TITULO}{$i.SUBTITULO}"
		titulo="{$i.TITULO}" subtitulo="{$i.SUBTITULO}" tipo="{$i.TIPO}">
		<img class="item-chat-item" src="{BASE_URL}modules/elearning/views/message/img/{( ($i.TIPO==1) ? 't1.png':'t2.png')}"/>
		<div class="item-chat-titulo1">{substr($i.TITULO, 0, 20)}{if strlen($i.TITULO) > 20}...{/if}</div>
		<div class="item-chat-fecha">{$i.FECHA}</div>
		{if isset($i.NOVISTO) && $i.NOVISTO > 0 }
			<span class="label label-primary label-news">{$i.NOVISTO}</span>
		{/if}
	</div>
{/foreach}
