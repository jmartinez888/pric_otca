<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0" style="background-image: url({BASE_URL}modules/elearning/views/cursos/img/encabezado-elearning.jpg); background-repeat: no-repeat; background-size: auto 100%; min-height: 415px;">
    <div class="col-xs-12 col-md-6 col-sm-9 col-lg-5" style="color: white; font-weight: bold; font-size: 18px;">
        {include file='modules/elearning/views/cursos/menu/descripcion.tpl'}
    </div>
</div>
{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-sm-12 col-md-9 col-lg-10" style="padding-bottom: 20px; padding-top: 20px">
    <div class="col-xs-12 col-md-12 col-lg-12">
        <form class="form row" method="post" action="{BASE_URL}elearning/cursos/cursos">
            <div class="col-sm-6 col-md-3">
                <div class="form-group">
                {if Session::get('id_usuario')}
                    <select class="form-control" name="_mis_cursos" id="_mis_cursos">
                        <option value="0" > {$lang->get('str_todos')} </option>
                        <option value="1" {if $_mis_cursos == 1} selected="" {/if}> {$lang->get('str_inscritos')} </option>
                        {if $_acl->permiso("agregar_usuario")}
                        <option value="2" {if $_mis_cursos == 2} selected="" {/if}> {$lang->get('str_creados')} </option>
                        {/if}
                    </select>
                {/if}
                </div>
            </div>
            <div class="col-sm-6 col-md-3 " id="">
                <div class="form-group">
                <select class="form-control" name="_tipo_curso" id="_tipo_curso">
                    <option value="0" > {$lang->get('str_todos')} </option>
                    {if isset($modalidades) && count($modalidades) }
                        {foreach from=$modalidades item=m}
                        <option value="{$m.Con_Valor}" {if $m.Con_Valor == $_tipo_curso} selected="" {/if}> {$m.Con_Descripcion} </option>
                        {/foreach}
                    {/if}
                </select>
                </div>
            </div>


            <div class="col-sm-12 col-md-6" id="">
                <div class="form-group">
                    <div class="input-group">
                        <input class="form-control" name="busqueda" placeholder="{$lang->get('elearning_cursos_buscar_curso')}" value="{$busqueda}">
                        <span class="input-group-btn">
                            <button class="btn btn-group btn-buscar" type="submit">{$lang->get('elearning_cursos_buscar_cursos')}</button>
                        </span>
                    </div>
                </div>
            </div>

        </form>
    </div>
    <div class="col col-xs-12" id="listarCursos">
        {if isset($cursos) && count($cursos) > 0}
            {foreach from=$cursos item=o}
                <div class="col-sm-6 col-md-6 col-lg-4" style="margin-bottom: 20px;" title="{$o.Cur_Titulo}">
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


                            <!--<span class="glyphicon glyphicon-bookmark ic-decoration"></span>-->
                            {if strlen($o.Cur_UrlBanner) >0 }
                                <div class="container-item-image">
                                    <div>
                                        <img class="curso-item-img" alt="Imagen" src="{BASE_URL}files/elearning/cursos/img/portada/{$o.Cur_UrlBanner}" />
                                    </div>
                                    <div class="col-xs-3 curso-item-mod {if $o.Moa_IdModalidad==1} mooc {/if} {if $o.Moa_IdModalidad==2} lms {/if} {if $o.Moa_IdModalidad==3} pres {/if}">{$o.Modalidad|truncate:5:"."}</div>
                                </div>
                            {else}
                                <div class="container-item-image"><div>
                                    <div>
                                        <img class="curso-item-img" alt="Imagen" src="{BASE_URL}files/elearning/cursos/img/portada/default.jpg" />
                                    </div>
                                    <div class="col-xs-3 curso-item-mod {if $o.Moa_IdModalidad==1} mooc {/if} {if $o.Moa_IdModalidad==2} lms {/if} {if $o.Moa_IdModalidad==3} pres {/if}">{$o.Modalidad|truncate:5:"."}</div>
                                </div>
                            {/if}

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
                            <div class="col-md-12">
                                <div class="row">
                                    <h4 class="col-xs-12 curso-item-title">
                                        <strong>{str_limit($o.Cur_Titulo, 89)}</strong>
                                    </h4>
                                    {* <div class="col-xs-3 curso-item-mod {if $o.Moa_IdModalidad==1} mooc {/if} {if $o.Moa_IdModalidad==2} lms {/if} {if $o.Moa_IdModalidad==3} pres {/if}">{$o.Modalidad|truncate:5:"."}</div> *}
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
                                    <strong>{str_limit($o.Cur_Titulo, 89)}</strong>
                                </h4>
                                <div class="col-md-3 curso-item-mod {if $o.Mod_IdModCurso==1} mooc {else} lms {/if}">{$o.Modalidad}</div>

                                <!-<h4 class="curso-item-title">
                                   <a href="{BASE_URL}elearning/cursos/curso/{$o.Cur_IdCurso}">
                                   <strong>{str_limit($o.Cur_Titulo, 89)}</strong>
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
                                        <strong>&nbsp;{$lang->get('str_inicio')}:</strong> {substr($o.Cur_FechaDesde, 0, 10)}</div>
                                    <div><span class="glyphicon glyphicon-file"></span>
                                        <strong>&nbsp;{$lang->get('str_vacantes')}:</strong> {$o.Cur_Vacantes}/{$o.Matriculados} <strong>{$lang->get('str_matriculados')}</strong></div>
                                    <div><span class="glyphicon glyphicon-user"></span>
                                        <strong>&nbsp;{$lang->get('str_docente')}:</strong> {$o.Docente}</div>
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
                    <div class="col-lg-12" >{$lang->get('elearning_cursos_no_hay_resultado')}: <strong>{$busqueda}</strong></div>
                {else}
                    {if isset($usu_curso) && strlen($usu_curso) > 0 }
                        <div>{$usu_curso} {$lang->get('elearning_cursos_no_matriculado_curso')}</div>
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
