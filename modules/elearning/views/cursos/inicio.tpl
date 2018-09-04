<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0" style="background-image: url({BASE_URL}modules/elearning/views/cursos/img/encabezado-elearning.jpg); background-repeat: no-repeat;">
    <div class="col-md-5 col-lg-5" style="color: white; font-weight: bold; font-size: 18px;">
        {include file='modules/elearning/views/cursos/menu/descripcion.tpl'}
    </div>
</div>
{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col col-md-10 col-lg-10" style="padding-bottom: 20px; padding-top: 20px">
    <div class="col-xs-12 col-md-12 col-lg-12">
        <form class="form-horizontal" method="post" action="{BASE_URL}elearning/cursos/cursos">
            <div class="form-group">
                <div class="col-sm-6 col-md-3">
                {if Session::get('id_usuario')}
                    <select class="form-control" name="_mis_cursos" id="_mis_cursos">
                        <option value="0" > Todos </option>
                        <option value="1" {if $_mis_cursos == 1} selected="" {/if}> Inscritos </option>
                        {if $_acl->permiso("agregar_usuario")}
                        <option value="2" {if $_mis_cursos == 2} selected="" {/if}> Creados </option>
                        {/if}
                    </select>
                {/if}
                </div>
                <div class="col-sm-6 col-md-3 " id="div-margin-t-10">
                    <select class="form-control" name="_tipo_curso" id="_tipo_curso">
                        <option value="0" > Todos </option>
                        <option value="1" {if $_tipo_curso == 1} selected="" {/if}> MOOC </option>
                        <option value="2" {if $_tipo_curso == 2} selected="" {/if}> LMS </option>
                    </select>
                </div>


                <div class="col-sm-12 col-md-6" id="div-margin-t-10">
                    <div class="input-group">
                        <input class="form-control" name="busqueda" placeholder="Buscar curso" value="{$busqueda}">
                        <span class="input-group-btn">
                            <button class="btn btn-group btn-buscar" type="submit">Buscar Cursos</button>
                        </span>
                    </div>                
                </div>
            </div><!-- /input-group -->           
        </form>        
    </div>
    <div class="col col-xs-12" id="listarCursos">
        {if isset($cursos) && count($cursos) > 0}
            {foreach from=$cursos item=o}
                <div class="col-sm-6 col-md-4" style="margin-bottom: 20px;">
                    {if $o.Inscrito == 1}
                        <button class="btn btn-warning fa fa-user btn-gestion "></button>
                    {/if}
                    {if $o.Usu_IdUsuario == Session::get("id_usuario")}
                        <a href="{BASE_URL}elearning/gestion/matriculados/{$o.Cur_IdCurso}">
                            <button class="btn btn-success fa fa-cogs btn-gestion " style="box-shadow: 0 0 5px 0px black;"></button>
                        </a>
                    {/if}
                    <a href="{BASE_URL}elearning/cursos/curso/{$o.Cur_IdCurso}">
                        <div class="curso-item curso-sombra">

                   <!--  <div class="curso-item curso-sombra">

                        <form> -->

                            <div class="clasificacion">
                                <span class="contador">{$o.Valoraciones}&nbsp; </span>
                                {$foo=1}
                                {for $foo=1 to 5}
                                    {if $foo <= $o.Valor }
                                        <label><i class="fa fa-star active" ></i></label>
                                    {else}
                                        {if $o.Valor == $foo-0.5}
                                            <label><i class="fa fa-star-half-o active" ></i></label>
                                        {else}
                                            <label><i class="fa fa-star"></i></label>
                                        {/if}
                                    {/if}
                                {/for}
                            </div>

                            <!--<span class="glyphicon glyphicon-bookmark ic-decoration"></span>-->
                            {if strlen($o.Cur_UrlBanner) >0 }
                                <img class="curso-item-img" alt="Imagen" src="{BASE_URL}modules/elearning/views/cursos/img/portada/{$o.Cur_UrlBanner}" />
                            {else}
                                <img class="curso-item-img" alt="Imagen" src="{BASE_URL}modules/elearning/views/cursos/img/portada/default.png" />
                            {/if}
                            <div class="col-md-12">
                                <div class="row">
                                    <h4 class="col-xs-9 curso-item-title">
                                        <strong>{$o.Cur_Titulo}</strong>
                                    </h4>
                                    <div class="col-xs-3 curso-item-mod {if $o.Moa_IdModalidad==1} mooc {else} lms {/if}">{$o.Modalidad}</div>
                                </div>
                                <hr class="cursos-hr">
<!-- //desde aqui -->
                        <!-- </form> 

                        <!-<span class="glyphicon glyphicon-bookmark ic-decoration"></span>->
                        {if strlen($o.Cur_UrlBanner) >0 }
                            <img class="curso-item-img" alt="Imagen" src="{BASE_URL}modules/elearning/views/cursos/img/portada/{$o.Cur_UrlBanner}" />
                        {else}
                            <img class="curso-item-img" alt="Imagen" src="{BASE_URL}modules/elearning/views/cursos/img/portada/default.png" />
                        {/if}

                        <div class="col-md-12">
                            <div class="row">

                                {if $o.Usu_IdUsuario == Session::get("id_usuario")}
                                    <a href="{BASE_URL}elearning/gestion/matriculados/{$o.Cur_IdCurso}">
                                        <button class="btn btn-success btn-gestion-jp">Gestión</button>
                                    </a>
                                {/if}

                                <h4 class="col-md-9 curso-item-title">
                                    <strong>{$o.Cur_Titulo}</strong>
                                </h4>
                                <div class="col-md-3 curso-item-mod {if $o.Mod_IdModCurso==1} mooc {else} lms {/if}">{$o.Modalidad}</div>

                                <!-<h4 class="curso-item-title">
                                   <a href="{BASE_URL}elearning/cursos/curso/{$o.Cur_IdCurso}">
                                   <strong>{$o.Cur_Titulo}</strong>
                                  </a>
                                </h4>->

                            </div>
                            <hr class="cursos-hr">

                            {if $o.Mod_IdModCurso==1}
                                <div class="curso-item-desc">
                                    {substr($o.Cur_Descripcion, 0, 250)}...
                                </div>
                            <!-- {else}  -->          

                                <div class="curso-item-desc">
                                    {substr($o.Cur_Descripcion, 0, 135)}...
                                </div>
                                <hr class="cursos-hr">
                                <div class="curso-item-lms-tab">
                                    <div><span class="glyphicon glyphicon-calendar"></span>
                                        <strong>&nbsp;Inicio:</strong> {substr($o.Cur_FechaDesde, 0, 10)}</div>
                                    <div><span class="glyphicon glyphicon-file"></span>
                                        <strong>&nbsp;Vacantes:</strong> {$o.Cur_Vacantes}/{$o.Matriculados} <strong>Matriculados</strong></div>
                                    <div><span class="glyphicon glyphicon-user"></span>
                                        <strong>&nbsp;Docente:</strong> {$o.Docente}</div>
                                </div>

                            </div>

                            <!-- {/if} -->


                        </div>
                    </a>
                    {if $c==1}
                      <a href="{BASE_URL}elearning/gestion/anuncios/{$o.Cur_IdCurso}/1">
                        <button class="btn btn-default btn-anuncios" {if $o.NoLeidos.NoLeidos>0} style="color:Red;"{/if}><i class="glyphicon glyphicon-bell"></i>{$o.NoLeidos.NoLeidos}/{$o.Total.Totales}</button>
                      </a>
                    {/if}
                </div>
            {/foreach}
        {else}
            <div class="col-lg-10" style="padding: 10px 0 0 0">
                {if strlen($busqueda) >0 }
                    <div class="col-lg-12" >No hay resultados para la busqueda: <strong>{$busqueda}</strong></div>
                {else}
                    {if isset($usu_curso) && strlen($usu_curso) > 0 }
                        <div>{$usu_curso} aun no te has matriculado en ningun curso</div>
                    {else}
                        <div>No hay cursos</div>
                    {/if}
                {/if}
            </div>
        {/if}  
    </div>
    <div class="col-xs-12 btn-default">
        {$paginacion|default:""}
    </div>
</div>
