<input id="hidden_url" value="{BASE_URL}elearning/" hidden="hidden"/>
<div class="col-lg-12">
  	{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  	<div class="col-lg-10" style="margin-top: 20px">
      <div class="col-lg-12">
        <center><h4>Calendario de Cursos</h4></center>
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
          titulo: "",
          header: function(){ return ""; },
          footer: function(){ return ""; },
          item: function(row){
            console.log(row);
            return "";
          }
        };
        StartCalendarioPRIC("#calendario", params, botones, view);
    });
</script>
