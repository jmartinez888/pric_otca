<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;">       
        <h3 class="titulo-view titulo"><strong>Agenda</strong> </h3>        
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


