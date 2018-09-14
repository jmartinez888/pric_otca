<style type="text/css">
  .contador{
  color: #393939;
}

.clasificacion {
  /*display: inline-block;*/
  /*font-size: 115%;*/
  background: rgba(240,240,240,.8);
  padding: 5px 10px 0px 10px;
  /*position: absolute;*/
  /*top: 0px;*/
  /*right: 0px;*/
  border-radius: 5px;
  margin: 0px;
  /*direction: rtl;*/
  /*unicode-bidi: bidi-override;*/
}
.active {
  color: orange;
}
.icon-alumnos{
    border-left: 1px solid;
    padding-left: 10px;
    margin-left: 5px;
}
.titulo{
    margin-bottom: 8px;
}

/*.btn-sm{
  padding: 3px 5px;
}*/
.btn-group-sm>.btn, .btn-sm {
    padding: 4px 8px;
    font-size: 16px;
    line-height: unset;
    font-weight: bold;
}
</style>  
<div class="container">
    {if  isset($usuario) && count($usuario)}
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10 col-xs-offset-0 col-sm-offset-0 col-md-offset-1 col-lg-offset-1 toppad" >
            <div class="panel panel-default ">
                <div class="panel-heading " >
                    <h3 class="panel-title"><i class="glyphicon glyphicon-user"></i>&nbsp;&nbsp;<strong>Perfil de Usuario {$usuario.Usu_Usuario|default:""}</strong>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-3 col-lg-3 " align="center">
                            <div class="user-panel" >
                                <!-- <img  class=" glyphicon glyphicon-user ">  -->
                                <div class=" image">
                                    <img src="{$_layoutParams.root_clear}/views/layout/backend/img/user2-160x160.jpg" class="img-circle" style="  max-width: 160px;" alt="User Image">
                                </div>                            
                            </div>
                        </div>
                        <div class=" col-md-9 col-lg-9 "> 
                            <table class="table table-user-information">
                                <tbody>
                                    <tr>
                                        <td class="text-bold">{$lenguaje.label_nombre} : </td>
                                        <td>{$usuario.Usu_Nombre}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-bold">{$lenguaje.label_apellidos} : </td>
                                        <td>{$usuario.Usu_Apellidos}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-bold">{$lenguaje.label_direccion} : </td>
                                        <td>{$usuario.Usu_Direccion}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-bold">{$lenguaje.label_dni} : </td>
                                        <td>{$usuario.Usu_DocumentoIdentidad}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-bold">{$lenguaje.label_telefono} : </td>
                                        <td>{$usuario.Usu_Telefono}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-bold">{$lenguaje.label_institucion} : </td>
                                        <td>{$usuario.Usu_InstitucionLaboral}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-bold">{$lenguaje.label_cargo} : </td>
                                        <td>{$usuario.Usu_Cargo}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-bold">{$lenguaje.label_correo} : </td>
                                        <td>{$usuario.Usu_Email}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-bold">{$lenguaje.label_usuario} : </td>
                                        <td>{$usuario.Usu_Usuario}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-bold">{$lenguaje.label_fecha_usuario} : </td>
                                        <td>{$usuario.Usu_Fecha}</td>
                                    </tr> 
                                </tbody>
                            </table>      
                        </div>
                    </div>
                    <div class="row">
                        <div class=" col-md-12 text-bold h3 "> 
                            Mis Cursos
                        </div>
                        <div class=" col-md-12 "> 
                            {if isset($cursos) && count($cursos)}
                            <div class="table-responsive" style="width: 100%">
                                <table class="table" id="tblMisCursos">
                                    
                                    {foreach from=$cursos item=c}
                                        <tr>
                                            <td>
                                              <div class="col-xs-2" style="border-right: 1px solid #c1bcbc; "><img class="img-banner " style="border: 1px solid #c1bcbc;" src="{BASE_URL}modules/elearning/views/cursos/img/portada/{$c.Cur_UrlBanner}" />
                                                {if $c.Moa_IdModalidad == 1}
                                                <div class="col-xs-12 text-center " style=" background: #EF5350; color: white; font-weight: bold; font-size: 10px;">MOOC</div>
                                                {/if}
                                                {if $c.Moa_IdModalidad == 2}
                                                <div class="col-xs-12 text-center " style="background: #2196F3; color: white; font-weight: bold; font-size: 10px;">LMS</div>
                                                {/if}
                                              </div> 
                                              <div class="col-xs-10" >
                                                  <div class="col col-xs-12 titulo"> 
                                                    <a href="{BASE_URL}elearning/cursos/curso/{$c.Cur_IdCurso}" class="text-primary h3" style="text-transform: uppercase;">{$c.Cur_Titulo}</a>
                                                  </div>
                                                  <div class="col col-xs-12"> 
                                                    <a href="{BASE_URL}elearning/cursos/ficha/{$c.Cur_IdCurso}" class="text-success"><i class="glyphicon glyphicon-user"></i> {$c.Docente} </a>                                
                                                  </div>
                                                  <div class="col col-xs-12"> 
                                                    <div class="col-xs-5 clasificacion h5">
                                                        <span class="contador">{$c.Valoraciones}&nbsp; </span>
                                                        {$foo=1}
                                                        {for $foo=1 to 5}
                                                            {if $foo <= $c.Valor }
                                                                <label><i class="fa fa-star active" ></i></label>
                                                            {else}
                                                                {if $c.Valor == $foo-0.5}
                                                                    <label><i class="fa fa-star-half-o active" ></i></label>
                                                                {else}
                                                                    <label><i class="fa fa-star"></i></label>
                                                                {/if}
                                                            {/if}
                                                        {/for}
                                                        <i class="fa fa-users icon-alumnos"> {$c.Matriculados} {if $c.Matriculados == 1} Alumno {else} Alumnos {/if} </i>
                                                    </div>
                                                  </div>
                                              </div> 
                                            </td>
                                        </tr>
                                    {/foreach}
                                </table>
                            </div>
                            {else}
                              {if strlen($busqueda) }
                                No hay resultados para: {$busqueda}
                              {else}
                                No tienes cursos
                              {/if}
                            {/if}      
                        </div>
                    </div>
                </div>
                <div class="panel-footer ">                    
                    <a style="background-color: #FFF" href="{$_layoutParams.root}usuarios/perfil/editarPerfil/{$usuario.Usu_IdUsuario}" data-original-title="Editar su Usuario" data-toggle="tooltip" type="button" class="btn btn-default " ><i class="glyphicon glyphicon-edit"></i></a>
                </div>          
            </div>
        </div>
    </div>
    {else}
        {$lenguaje.no_registros}
    {/if}
</div>