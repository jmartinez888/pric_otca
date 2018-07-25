<input id="hidden_url" value="{BASE_URL}elearning/" hidden="hidden"/>
{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-10">
    <div class="row">
        <div class="col-lg-12">
            <h3>Calendario de Cursos</h3>
            <hr class="cursos-hr">
        </div>
        <div class="col-lg-12" style="margin-top: 20px">
                <div id="calendario"></div>
        </div>
    </div>

</div>

<script type="text/javascript" src="{BASE_URL}/modules/elearning/views/gestion/js/core/controller.js"></script>
<script type="text/javascript" src="{BASE_URL}/modules/elearning/views/calendario/js/calendario.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        var params = {
          link: "cursos/data_calendario",
          params: {  },
          docente: 0,
          viewDocente: function(div, params){
            //console.log(params);
          }
        };
        var botones = {
          anterior: function(mes, anio){ },
          siguiente: function(mes, anio){ }
        };
        var view = {
          titulo: "Cursos del dia",
          header: function(){ return ""; },
          footer: function(){ return ""; },
          item: function(row){
            console.log(row);
            var result = "";
            result += "<div class='col-lg-12 panel'>";
            result += "<div class='col-lg-6'>" + row.DET + "</div>";
            if(row.ESTADO==1){
              result += "<div class='col-lg-3'>INICIO</div>";
            }else{
              result += "<div class='col-lg-3'>CULMINACIÓN</div>";
            }
            result += "<div class='col-lg-3'><center>";
            result += "<a class='btn btn-success' style='margin-right: 5px' href='" + _root_ + "elearning/cursos/curso/" + row.ID + "'>";
            result += "<span class='glyphicon glyphicon-list-alt'></span></a>";
            result += "<a class='btn btn-success' href='" + _root_ + "elearning/cursos/calendario_curso/" + row.ID + "'>";
            result += "<span class='glyphicon glyphicon-calendar'></span></a>";
            result += "</center></div>";
            result += "</div>";
            return result;
          }
        };
        StartCalendarioPRIC("#calendario", params, botones, view);
    });
</script>
