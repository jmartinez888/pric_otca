<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px; margin-bottom: 30px;">       
        <h2 class="titulo">{$lenguaje.str_agenda}</h2>
        <div class="col-lg-12 p-rt-lt-0">
            <hr class="cursos-hr-title-foro">
        </div> 
        <div class="row">
            <div class="col-md-12">
                <div id="calendar" class="col-centered">
                </div>
            </div>     
        </div>
    </div>
</div>
<script>
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!

    var yyyy = today.getFullYear();
    if (dd < 10) {
        dd = '0' + dd;
    }
    if (mm < 10) {
        mm = '0' + mm;
    }
    var today = yyyy + '-' + mm + '-' + dd;
    defaultDateCalendar = today;
    eventos = JSON.parse(JSON.stringify({$agenda}));
</script>


