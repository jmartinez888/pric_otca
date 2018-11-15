{extends 'template.tpl'}
{block "css" append}
<style type="text/css">
#enlaces img{
      max-width: 100%; 
}

#raizaMenu {
padding-top: 10px;
}
@media (min-width: 1200px){
}
@media(max-width: 991px){
#raizaMenu ul{
height: 40px !important;
}
}
#raizaMenu ul{
list-style: none;
width: 100%;
height: 20px;
padding: 0px 10px;
}
#raizaMenu li{
top: 3px;
margin: 0px 2px;
float: left;
}
#raizaMenu li .actual{
color: #444f4a;
}
#raizaMenu a{
margin: 0px 3px;
color: #03a506;
}
.alert-info {
color: #31708f !important;
background-color: #d9edf7 !important;
border-color: #bce8f1;
}
.sharepost .share h4{
display: inline-block;
}
.sharepost .icon {
font-size: 20px;
padding-top: 2px;
width: 28px;
height: 32px;
text-align: center;

}
.sharepost ul li a {
color: #fff;
}
.sharepost .email {
background-color: #71655d
}
.sharepost .facebook {
background-color: #3c599f;
}
.sharepost .twitter {
background-color: #40b0ff;
}
.sharepost .google-plus {
background-color: #ce4438;
}
#publicacion_relevante, #publicacion_reciente, #evento_interes, #dato_interes, #agenda {
    max-height: none !important;
    }
</style>
{/block}
{block "contenido"}
<div class="container margin-b-10" id="difusion_contenido">
  <div class="row">
    <div class="col-xs-12 col-sm-8 col-md-offset-0 col-md-8 col-lg-offset-0 col-lg-8"> 
    <div class="row"> 
       <div id="raizaMenu" clas="col-xs-12 col-sm-12 col-md-12 col-lg-12">
          {if (isset($menuRaiz) && !empty($menuRaiz[0][0]))}
          <ul clas="col-xs-3 col-sm-3 col-md-2 col-lg-2">
            <li>
              <a href="{$_layoutParams.root}">{$lenguaje["label_inicio"]} </a>
            </li>
            {foreach from=$menuRaiz item=mr}
            {$mr[0]}
            {/foreach}
          </ul>
          {else}
          <ul clas="col-xs-3 col-sm-3 col-md-2 col-lg-2">
            <li>
              <a href="{$_layoutParams.root}">{$lenguaje["label_inicio"]} </a>
            </li>
          </ul>
          {/if}
        </div>
        <section class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
          <!--<div id="carousel" style="transform: translateZ(-288px) rotateY(-320deg);">-->
          <div id="enlaces" >
            {if !empty($datos)}
            {$datos.Pag_Contenido}
            {else}
            <h3>
            {$lenguaje["page_item_page_no_fount"]}
            </h3>
            {/if}
          </div>
          <hr>
          <div class="sharepost no-print">
            <ul class="list-inline">
              <li class="share">
                <i class="fa fa-share-alt"></i>
                <h4><b>{$lenguaje["page_item_compartir"]}</b></h4>
              </li>
              <li class="email">
                <div class="icon">
                  <a href="mailto:?subject=ORA - {$datos.Pag_Nombre}&amp;body={$lenguaje['page_item_share_email']} {$_layoutParams.root}page/item/{$datos.Pag_IdPagina}" target="_blank">
                    <i class="fa fa-envelope"></i>
                  </a>
                </div>
              </li>
              <li class="facebook">
                <div class="icon">
                  <a href="https://www.facebook.com/sharer/sharer.php?u={$_layoutParams.root}page/item/{$datos.Pag_IdPagina}" target="_blank" title="Facebook">
                    <i class="fa fa-facebook"></i>
                  </a>
                </div>
              </li>
              <li class="twitter">
                <div class="icon">
                  <a href="https://twitter.com/home?status={$_layoutParams.root}page/item/{$datos.Pag_IdPagina}" target="_blank" title="Twitter">
                    <i class="fa fa-twitter"></i>
                  </a>
                </div>
              </li>
              <li class="google-plus">
                <div class="icon">
                  <a href="https://plus.google.com/share?url={$_layoutParams.root}page/item/{$datos.Pag_IdPagina}" target="_blank" title="Google+">
                    <i class="fa fa-google-plus"></i>
                  </a>
                </div>
              </li>
            </ul>
            <div class="clearfix">
            </div>
          </div>
        </section>     
    </div> 
       
    </div>
    <div class="col-md-4 col-sm-4 col-xs-12 col-lg-4 back-color-white margin-t-10">
      {include 'tab_interes.tpl'}
    </div>
  </div>
</div>
{/block}
{block 'js' append}
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{$_layoutParams.root}difusion/contenido/vcomponent/interes"></script>
<script>
new Vue({
el: '#difusion_contenido'
})
</script>
{/block}