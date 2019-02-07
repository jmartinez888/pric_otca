var _post = null;
var _Per_IdPermiso_ = 0;
var contador = 0;
var selected= '';
var hidden='';
var estilo= '';
var fuente='';
// var color='';
$(document).on('ready', function () {   
    $('#form3').validator().on('submit', function (e) {
    if (e.isDefaultPrevented()) {

    } else {

    }
    });

    $('#ckbNombre').change(function() {
        if ($(this).is(':checked')) 
            $("#arrastrable1").attr("style",$("#estiloAlumno").val());

        else
            $("#arrastrable1").attr("style","display:none;");
    });

    $('#ckbCurso').change(function() {
        if ($(this).is(':checked')) 
            $("#arrastrable2").attr("style",$("#estiloCurso").val());

        else
            $("#arrastrable2").attr("style","display:none;");
    });

    $('#ckbDuracion').change(function() {
        if ($(this).is(':checked')) 
            $("#arrastrable3").attr("style",$("#estiloHoras").val());

        else
            $("#arrastrable3").attr("style","display:none;");
    });

    $('#ckbFecha').change(function() {
        if ($(this).is(':checked')) 
            $("#arrastrable4").attr("style",$("#estiloFecha").val());

        else
            $("#arrastrable4").attr("style","display:none;");
    });

    $('#ckbCodigo').change(function() {
        if ($(this).is(':checked')) 
            $("#arrastrable5").attr("style",$("#estiloCodigo").val());

        else
            $("#arrastrable5").attr("style","display:none;");
    });

    $(".printer").bind("click",function() {
        $(".PrintArea").printArea();
    });

    $("#printButton").click(function(){
        var mode = 'iframe'; //popup
        var close = mode == "popup";
        var options = { mode : mode, popClose : close};
        $("div.printableArea").printArea( options );
    });
    
    $('body').on('click', '.pagina', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    });
    $('body').on('change', '.s_filas', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    });

    var paginacion = function (pagina, nombrelista, datos,total_registros) {
        var pagina = {'pagina':pagina,'filas':$("#s_filas_"+nombrelista).val(),'total_registros':total_registros};
        
        $.post(_root_ + 'elearning/certificado/_paginacion_' + nombrelista + '/' + datos, pagina, function (data) {
            $("#" + nombrelista).html('');
            $("#cargando").hide();
            $("#" + nombrelista).html(data);
        });
    }  
    
    $("body").on('click', ".idioma_s", function () {
        var id = $(this).attr("id");
        var idIdioma = $("#hd_" + id).val();
        gestionIdiomas($("#idRol").val(), $("#idIdiomaOriginal").val(), idIdioma);
    });

    $('#confirm-delete').on('show.bs.modal', function(e) { 
        var bookId = $(e.relatedTarget).data('book-id'); 
         $(e.currentTarget).find("#texto_").html(bookId);
    }); 

    //PERMISOS
    $("body").on('click', "#buscarcertificado", function () { 
        $("#cargando").show();       
        buscarPermiso($("#palabracertificado").val());
    }); 

    $("body").on('click', "#buscarcertificadootros", function () { 
        $("#cargando").show();       
        buscarOtros($("#palabracertificado").val());
    }); 

    $('body').on('click', '#arrastrable1', function () {
    // $("#arrastrable1").click(function(){
        selected = "#arrastrable1";
        estilo = $(selected).attr("style");
        $("input[name=color]").val(rgba2hex( $(selected).css("color") ));
        var tamaño = $(selected).css("font-size");
        var array = tamaño.split('p');
        $("input[name=tamaño]").val(array[0]);
        // Ancho
        // alert(document.getElementById("arrastrable1").style.width);
        var ancho = document.getElementById("arrastrable1").style.width;
        $("input[name=ancho]").val(ancho.substr(0,2));
        // document.getElementById("arrastrable1").style.width = "80%";
        // $("input[name=ancho]").val($("#arrastrable1").css("width"));
        hidden = "#estiloAlumno";
    });

    $('body').on('click', '#arrastrable2', function () {
    // $("#arrastrable2").click(function(){
        selected= "#arrastrable2";
        estilo= $("#arrastrable2").attr("style");
         $("input[name=color]").val(rgba2hex( $("#arrastrable2").css("color") ));
        var tamaño=$("#arrastrable2").css("font-size");
        var array=tamaño.split('p');
        $("input[name=tamaño]").val(array[0]);
        var ancho = document.getElementById("arrastrable2").style.width;
        $("input[name=ancho]").val(ancho.substr(0,2));
        hidden="#estiloCurso";
    });

    $('body').on('click', '#arrastrable3', function () {
    // $("#arrastrable3").click(function(){
        selected= "#arrastrable3";
        estilo= $("#arrastrable3").attr("style");
         $("input[name=color]").val(rgba2hex( $("#arrastrable3").css("color") ));
        var tamaño=$("#arrastrable3").css("font-size");
        var array=tamaño.split('p');
        $("input[name=tamaño]").val(array[0]);
        var ancho = document.getElementById("arrastrable3").style.width;
        $("input[name=ancho]").val(ancho.substr(0,2));
        hidden="#estiloHoras";
    });

    $('body').on('click', '#arrastrable4', function () {
    // $("#arrastrable4").click(function(){
        selected = "#arrastrable4";
        estilo = $("#arrastrable4").attr("style");
        $("input[name=color]").val(rgba2hex( $("#arrastrable4").css("color") ));
        var tamaño = $("#arrastrable4").css("font-size");
        var array = tamaño.split('p');
        $("input[name=tamaño]").val(array[0]);
        var ancho = document.getElementById("arrastrable4").style.width;
        $("input[name=ancho]").val(ancho.substr(0,2));
        hidden = "#estiloFecha";
    });

    $('body').on('click', '#arrastrable5', function () {
    // $("#arrastrable4").click(function(){
        selected = "#arrastrable5";
        estilo = $("#arrastrable5").attr("style");
        $("input[name=color]").val(rgba2hex( $("#arrastrable5").css("color") ));
        var tamaño = $("#arrastrable5").css("font-size");
        var array = tamaño.split('p');
        $("input[name=tamaño]").val(array[0]);
        var ancho = document.getElementById("arrastrable5").style.width;
        $("input[name=ancho]").val(ancho.substr(0,2));
        hidden = "#estiloCodigo";
    });

    $('body').on('change', 'input[name=color]', function () {
    // $("input[name=color]").change(function(){
        // alert($('input[name=color]').val());
        $(selected).attr("style",estilo+"color:"+$(this).val()+";");
        estilo=estilo+"color:"+$(this).val()+";";
        $(hidden).val(estilo);
    });

    $('body').on('change', 'input[name=tamaño]', function () {
    // $("input[name=tamaño]").change(function(){
        // alert($('input[name=tamaño]').val());
        $(selected).attr("style",estilo+"font-size:"+$(this).val()+"px;");
        estilo=estilo+"font-size:"+$(this).val()+"px;";
        $(hidden).val(estilo);
    });

    $('body').on('change', 'input[name=ancho]', function () {
    // $("input[name=ancho]").change(function(){
        // alert($('input[name=ancho]').val());
        $(selected).attr("style",estilo+"width:"+$(this).val()+"%;");
        estilo=estilo+"width:"+$(this).val()+"%;";
        $(hidden).val(estilo);
    });

    $('body').on('change', '#img', function (e) {
    // $('#img').change(function(e) {
        addImage(e); 
    });
});

function addImage(e){
    var file = e.target.files[0],
    imageType = /image.*/;

    if (!file.type.match(imageType))
    return;

    var reader = new FileReader();
    reader.onload = fileOnload;
    reader.readAsDataURL(file);
}
  
function fileOnload(e) {
    var result = e.target.result;
    $('#cuadro1').attr("style","background-image: url('"+result+"'); background-size: 100%; -moz-background-size: 100%; -o-background-size: 100%; -webkit-background-size: 100%; -khtml-background-size: 100%;  height:21cm; position: relative;");
}

function change_ancho(key_press) {

    $(selected).attr("style",estilo+"width:"+$("#ancho").val()+"%;");
    estilo = estilo+"width:"+$(this).val()+"%;";
    $(hidden).val(estilo);
    key_press.preventDefault();
}

function change_tamano(key_press) {
    $(selected).attr("style",estilo+"font-size:"+$("#tamaño").val()+"px;");
    estilo = estilo+"font-size:"+$(this).val()+"px;";
    $(hidden).val(estilo);
    key_press.preventDefault();
}

function buscarPermiso(criterio) {
    $("#cargando").show();
    $.post(_root_ + 'elearning/certificado/_buscarcertificado',
    {
        palabra:criterio
        
    }, function (data) {
        $("#listarcertificados").html('');
        $("#cargando").hide();
        $("#listarcertificados").html(data);
    });
}

function buscarOtros(criterio) {
    $("#cargando").show();
    $.post(_root_ + 'elearning/certificado/_buscarcertificadootros',
    {
        palabra:criterio
        
    }, function (data) {
        $("#listarcertificados").html('');
        $("#cargando").hide();
        $("#listarcertificados").html(data);
    });
}

// function gestionIdiomas(idrol, idIdiomaOriginal, idIdioma) {
//     $("#cargando").show();
//     $.post(_root_ + 'acl/index/gestion_idiomas_rol',
//         {
//             idrol: idrol,        
//             idIdioma: idIdioma,
//             idIdiomaOriginal: idIdiomaOriginal
//         }, function (data) {
//         $("#gestion_idiomas_rol").html('');
//         $("#cargando").hide();
//         $("#gestion_idiomas_rol").html(data);
//         $('form').validator();
//     });

//     // function rgb2hex(rgb){
//     //  rgb = rgb.match(/^rgb((d+),s*(d+),s*(d+))$/);
//     //  return "#" +
//     //   ("0" + parseInt(rgb[1],10).toString(16)).slice(-2) +
//     //   ("0" + parseInt(rgb[2],10).toString(16)).slice(-2) +
//     //   ("0" + parseInt(rgb[3],10).toString(16)).slice(-2);
//     // }
// }

function start_as(e) {
    e.dataTransfer.effecAllowed = 'move'; // Define el efecto como mover (Es el por defecto)
    e.dataTransfer.setData("Data", e.target.id); // Coje el elemento que se va a mover
    e.dataTransfer.setDragImage(e.target, 0, 0); // Define la imagen que se vera al ser arrastrado el elemento y por donde se coje el elemento que se va a mover (el raton aparece en la esquina sup_izq con 0,0)
    e.target.style.opacity = '0.4'; 

    //  if(e.target.id=="arrastrable1"){
    //     selected= "#arrastrable1";
    //     estilo= $("#arrastrable1").attr("style");
    //     $("input[name=color]").val(rgba2hex( $("#arrastrable1").css("color") ));
    //     var tamaño=$("#arrastrable1").css("font-size");
    //     var array=tamaño.split('p');
    //     $("input[name=tamaño]").val(array[0]);
    //     var ancho=$("#arrastrable2").width();
    //     var anchoPadre=$("#cuadro1").width();
    //     $("input[name=ancho]").val(ancho/anchoPadre*100);
    //     hidden="#estiloAlumno";
    //  }
    // else if(e.target.id=="arrastrable2"){
    //      selected= "#arrastrable2";
    //     estilo= $("#arrastrable2").attr("style");
    //     $("input[name=color]").val(rgba2hex( $("#arrastrable2").css("color") ));
    //     var tamaño=$("#arrastrable1").css("font-size");
    //     var array=tamaño.split('p');
    //     $("input[name=tamaño]").val(array[0]);
    //     $("input[name=ancho]").val(10);
    //     hidden="#estiloCurso";
    //  }
    //  else if(e.target.id=="arrastrable3"){
    //     selected= "#arrastrable3";
    //     estilo= $(selected).attr("style");
    //      $("input[name=color]").val(rgba2hex( $(selected).css("color") ));
    //     var tamaño=$(selected).css("font-size");
    //     var array=tamaño.split('p')
    //     $("input[name=tamaño]").val(array[0]);
    //     hidden="#estiloHoras";
    //  }
    //  else if(e.target.id=="arrastrable4"){
    //     selected= "#arrastrable4";
    //     estilo= $(selected).attr("style");
    //      $("input[name=color]").val(rgba2hex( $(selected).css("color") ));
    //     var tamaño=$(selected).css("font-size");
    //     var array=tamaño.split('p')
    //     $("input[name=tamaño]").val(array[0]);
    //     hidden="#estiloFecha";
    //  }
}

function end_as(e){
    e.target.style.opacity = ''; // Pone la opacidad del elemento a 1           
    e.dataTransfer.clearData("Data");
    
    if(e.target.id=="arrastrable1"){
        selected = "#arrastrable1";
        estilo = $("#arrastrable1").attr("style");
        $("input[name=color]").val(rgba2hex( $("#arrastrable1").css("color") ));
        var tamaño=$("#arrastrable1").css("font-size");
        var array = tamaño.split('p');
        $("input[name=tamaño]").val(array[0]);
        var ancho = document.getElementById("arrastrable1").style.width;
        $("input[name=ancho]").val(ancho.substr(0,2));
        // var ancho = $("#arrastrable1").width();
        // var anchoPadre=$("#cuadro1").width();
        // $("input[name=ancho]").val((ancho*100)/anchoPadre);
        $("#estiloAlumno").val(estilo);
    } 
    else if(e.target.id=="arrastrable2"){
         selected= "#arrastrable2";
        estilo= $("#arrastrable2").attr("style");
        $("input[name=color]").val(rgba2hex( $("#arrastrable2").css("color") ));
        var tamaño=$("#arrastrable2").css("font-size");
        var array=tamaño.split('p');
        $("input[name=tamaño]").val(array[0]);
        var ancho = document.getElementById("arrastrable2").style.width;
        $("input[name=ancho]").val(ancho.substr(0,2));
        $("#estiloCurso").val(estilo);
    }
    else if(e.target.id=="arrastrable3"){
        selected= "#arrastrable3";
        estilo= $(selected).attr("style");
         $("input[name=color]").val(rgba2hex( $(selected).css("color") ));
        var tamaño=$(selected).css("font-size");
        var array=tamaño.split('p')
        $("input[name=tamaño]").val(array[0]);
        var ancho = document.getElementById("arrastrable3").style.width;
        $("input[name=ancho]").val(ancho.substr(0,2));
        $("#estiloHoras").val(estilo);
    }
    else if(e.target.id=="arrastrable4"){
        selected= "#arrastrable4";
        estilo= $(selected).attr("style");
        $("input[name=color]").val(rgba2hex( $(selected).css("color") ));
        var tamaño=$(selected).css("font-size");
        var array=tamaño.split('p')
        $("input[name=tamaño]").val(array[0]);
        var ancho = document.getElementById("arrastrable4").style.width;
        $("input[name=ancho]").val(ancho.substr(0,2));
        $("#estiloFecha").val(estilo);
    }
    else if(e.target.id=="arrastrable5"){
        selected= "#arrastrable5";
        estilo= $(selected).attr("style");
        $("input[name=color]").val(rgba2hex( $(selected).css("color") ));
        var tamaño=$(selected).css("font-size");
        var array=tamaño.split('p')
        $("input[name=tamaño]").val(array[0]);
        var ancho = document.getElementById("arrastrable5").style.width;
        $("input[name=ancho]").val(ancho.substr(0,2));
        $("#estiloCodigo").val(estilo);
    }
}

function enter_as(e) {
    // e.target.style.border = '3px dotted #555'; 
}

function leave_as(e) {
    // e.target.style.border = ''; 
}

function over_as(e) {
    var elemArrastrable = e.dataTransfer.getData("Data"); // Elemento arrastrado
    var id = e.target.id; // Elemento sobre el que se arrastra
    
    // return false para que se pueda soltar
    if (id == 'cuadro1'){
        return false; // Cualquier elemento se puede soltar sobre el div destino 1
    }

    if ((id == 'cuadro2') && (elemArrastrable != 'arrastrable3')){
        return false; // En el cuadro2 se puede soltar cualquier elemento menos el elemento con id=arrastrable3
    }   

    if (id == 'cuadro3')
        return false;

    if (id == 'papelera')
        return false; // Cualquier elemento se puede soltar en la papelera
        
}


/**
* 
* Mueve el elemento
*
**/
function drop_as(e){

    var elementoArrastrado = e.dataTransfer.getData("Data"); // Elemento arrastrado
    e.target.appendChild(document.getElementById(elementoArrastrado));
    e.target.style.border = '';  // Quita el borde
    tamContX = $('#'+e.target.id).width();
    tamContY = $('#'+e.target.id).height();

    tamElemX = $('#'+elementoArrastrado).width();
    tamElemY = $('#'+elementoArrastrado).height();

    posXCont = $('#'+e.target.id).position().left;
    posYCont = $('#'+e.target.id).position().top;

    // Posicion absoluta del raton
    x = e.layerX;
    y = e.layerY;

    // Si parte del elemento que se quiere mover se queda fuera se cambia las coordenadas para que no sea asi
    if (posXCont + tamContX <= x + tamElemX){
        x = posXCont + tamContX - tamElemX;
    }

    if (posYCont + tamContY <= y + tamElemY){
        y = posYCont + tamContY - tamElemY;
    }

    document.getElementById(elementoArrastrado).style.position = "absolute";
    document.getElementById(elementoArrastrado).style.left = x + "px";
    document.getElementById(elementoArrastrado).style.top = y + "px";
}

/**
* 
* Elimina el elemento que se mueve
*
**/
function eliminar_as(e){
    var elementoArrastrado = document.getElementById(e.dataTransfer.getData("Data")); // Elemento arrastrado
    elementoArrastrado.parentNode.removeChild(elementoArrastrado); // Elimina el elemento
    e.target.style.border = '';   // Quita el borde
}

/**
* 
* Clona el elemento que se mueve
*
**/

function clonar_as(e){
    var elementoArrastrado = document.getElementById(e.dataTransfer.getData("Data")); // Elemento arrastrado

    elementoArrastrado.style.opacity = ''; // Dejamos la opacidad a su estado anterior para copiar el elemento igual que era antes

    var elementoClonado = elementoArrastrado.cloneNode(true); // Se clona el elemento
    elementoClonado.id = "ElemClonado" + contador; // Se cambia el id porque tiene que ser unico
    contador += 1;  
    elementoClonado.style.position = "static";  // Se posiciona de forma "normal" (Sino habria que cambiar las coordenadas de la posición)  
    e.target.appendChild(elementoClonado); // Se añade el elemento clonado
    e.target.style.border = '';   // Quita el borde del "cuadro clonador"
}

// var pos1=document.getElementById("boton1");
// var ele=document.getElementById("arrastrable1");
// var ele2=document.getElementById("arrastrable2");
//         pos1.onclick=function(){
//             var posleft=ele.offsetLeft;
//             var postop=ele.offsetTop;
//             var posleft2=ele2.offsetLeft;
//             var postop2=ele2.offsetTop;
//             alert("Left: "+posleft+"px - Top: "+postop+"px");}


function rgba2hex( color_value ) {
    if ( ! color_value ) return false;
    var parts = color_value.toLowerCase().match(/^rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+(?:\.\d+)?))?\)$/),
        length = color_value.indexOf('rgba') ? 3 : 2; // Fix for alpha values
    delete(parts[0]);
    for ( var i = 1; i <= length; i++ ) {
        parts[i] = parseInt( parts[i] ).toString(16);
        if ( parts[i].length == 1 ) parts[i] = '0' + parts[i];
    }
    return '#' + parts.join('').toUpperCase(); // #F7F7F7
}

