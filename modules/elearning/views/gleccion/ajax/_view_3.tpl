{extends 'index_elearning.tpl'}
{block 'css' append}
<style>
  .radioalt{
    margin-top: 20px !important;
    margin-left: -10px !important;
  }
  .nav-tabs > .active{
    font-weight: bold;
  }
  .nav-tabs > li.active > a{
    color: #009640 !important;
  }
</style>
{/block}

{block 'subcontenido'}
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
<div class="col-lg-12">
  <ul class="nav nav-tabs">
    <li role="presentation" class="active" id="item_titulo"><a href="#">TÍTULO</a></li>
    <li role="presentation" class="" id="item_examen"><a href="#">EXÁMEN</a></li>
  </ul>
</div>
{include file='modules/elearning/views/gleccion/menu/lec_titulo.tpl'}

{if $curso.Moa_IdModalidad == 2}
  {include file='modules/elearning/views/gleccion/menu/lec_calendario.tpl'}
{/if}

<div class="modal " id="msj-invalido" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Acción no Disponible</h4>
            </div>
            <div class="modal-body">
                <p>Solo esta permitido tener un examen habilitado por cada leccion, por favor deshabilite todos los examenes relacionado a esta lección par poder agregar un nuevo examen.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Aceptar</button>
            </div>
        </div>
    </div>
</div>
{/block}

{block 'js' append}
<script type="text/javascript" src="{$_url}gleccion/js/_view_3.js"></script>
{/block}
