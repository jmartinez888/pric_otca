<div class="col-lg-12">
    <div class="col-lg-12" style="padding-bottom: 20px; padding-top: 20px">
        <form method="post" action="{BASE_URL}elearning/index/_busqueda_curso">
            <div class="input-group">
                <input class="form-control" name="busqueda" placeholder="Buscar curso" value="{$busqueda}">
                <span class="input-group-btn">
                    <button class="btn btn-group btn-buscar" type="submit">Buscar Cursos</button>
                </span>
            </div><!-- /input-group -->           
        </form>
    </div>

</div>
<!--div-->
{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-10" style="padding: 10px 0 20px 0">
    {if isset($curso) && count($curso) > 0}
        {foreach from=$curso item=o}
            <a href="{BASE_URL}elearning/cursos/curso/{$o.Cur_IdCurso}">
                <div class="col-lg-4" style="margin-bottom: 20px;">

                    <div class="curso-item curso-sombra">
                        <form>
                            <div class="clasificacion">

                                <label><i class="glyphicon glyphicon-star"></i></label>

                                <label><i class="glyphicon glyphicon-star active"></i></label>

                                <label><i class="glyphicon glyphicon-star active"></i></label>

                                <label><i class="glyphicon glyphicon-star active"></i></label>

                                <label><i class="glyphicon glyphicon-star active"></i></label>
                                <span class="contador">&nbsp; 8</span>
                            </div>
                        </form>

                        <!--<span class="glyphicon glyphicon-bookmark ic-decoration"></span>-->
                        {if strlen($o.Cur_UrlBanner) >0 }
                            <img class="curso-item-img" alt="Imagen" src="{BASE_URL}modules/elearning/views/cursos/img/portada/{$o.Cur_UrlBanner}" />
                        {else}
                            <img class="curso-item-img" alt="Imagen" src="{BASE_URL}modules/elearning/views/cursos/img/portada/default.png" />
                        {/if}
                        <div class="col-md-12">
                            <div class="row">
                                <h4 class="col-md-9 curso-item-title">
                                    <strong>{$o.Cur_Titulo}</strong>
                                </h4>
                                <div class="col-md-3 curso-item-mod {if $o.Mod_IdModCurso==1} mooc {else} lms {/if}">{$o.Modalidad}</div>

                                <!--<h4 class="curso-item-title">
                                   <a href="{BASE_URL}elearning/cursos/curso/{$o.Cur_IdCurso}">
                                   <strong>{$o.Cur_Titulo}</strong>
                                  </a>
                                </h4>-->

                            </div>
                            <hr class="cursos-hr">

                            {if $o.Mod_IdModCurso==1}
                                <br>
                                <div class="curso-item-desc">
                                    {substr($o.Cur_Descripcion, 0, 250)}...
                                </div>
                            {else} 
                                <br>           
                                <div class="curso-item-desc">
                                    {substr($o.Cur_Descripcion, 0, 100)}...
                                </div>
                                <br> 
                                <hr class="cursos-hr">
                                <div class="curso-item-lms-tab">
                                    <div><span class="glyphicon glyphicon-calendar"></span>
                                        <strong>&nbsp;Inicio:</strong> {substr($o.Cur_FechaDesde, 0, 10)}</div>
                                    <div><span class="glyphicon glyphicon-file"></span>
                                        <strong>&nbsp;Vacantes:</strong> {$o.Cur_Vacantes}/{$o.Detalle.Matriculados} <strong>Matriculados</strong></div>
                                    <div><span class="glyphicon glyphicon-user"></span>
                                        <strong>&nbsp;Docente:</strong> {$o.Detalle.Docente}</div>
                                </div>
                            {/if}

                            {if $o.Usu_IdUsuario == Session::get("id_usuario")}
                                <a href="{BASE_URL}elearning/gestion/matriculados/{$o.Cur_IdCurso}">
                                    <button class="btn btn-default btn-gestion">Gestión</button>
                                </a>
                            {/if}
                        </div>
                    </div>

         {if $c==1}
          <a href="{BASE_URL}elearning/gestion/anuncios/{$o.Cur_IdCurso}/1">
            <button class="btn btn-default btn-anuncios" {if $o.NoLeidos.NoLeidos>0} style="color:Red;"{/if}><i class="glyphicon glyphicon-bell"></i>{$o.NoLeidos.NoLeidos}/{$o.Total.Totales}</button>
          </a>
        {/if}
                </div>
            </a>
        {/foreach}

    {else}
        <div class="col-lg-10" style="padding: 10px 0 0 0">
            {if strlen($busqueda) >0 }
                <div class="col-lg-12" >No hay resultados para la busqueda: <strong>{$busqueda}</strong></div>
            {else}
                {if isset($usu_curso) && strlen($usu_curso) >0 }
                    <div>{$usu_curso} aun no te has matriculado en ningun curso</div>
                {else}
                    <div>No hay cursos</div>
                {/if}
            {/if}
        </div>
    {/if}     
</div>
