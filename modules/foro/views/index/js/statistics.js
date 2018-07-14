/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var data_comments = [];
$.each(data_char, function(k, v) {     
      data_comments.push([v.Com_FechaM,Number(v.Com_CantidadComentario)]);        
    });

Highcharts.chart('container', {
    chart: {
        type: 'line'
    },
    title: {
        text: 'Comentarios por mes'
    }, 
    xAxis: {
       type:"category"
    },
    yAxis: {
        title: {
            text: '# Comentarios'
        }
    },
    plotOptions: {
        line: {
            dataLabels: {
                enabled: true
            },
            enableMouseTracking: false
        }
    },
    series: [{
        name: 'Comentario_x_mes',
        data: data_comments
    }]
});

var data_pais = [];
// Prevent logarithmic errors in color calulcation
$.each(data_members, function (k, v) {
    data_pais.push({'code3':v.Pai_Siglas,'name':v.Pai_Nombre,'value':Number(v.Pai_CantidadUsuarios)});        
});

// Initiate the chart
Highcharts.mapChart('container_map', {
    chart: {
        map: 'custom/world'
    },
    title: {
        text: 'Miembros por país'
    },
    legend: {
        title: {
            text: 'Cantidad de miembros',
            style: {
                color: (Highcharts.theme && Highcharts.theme.textColor) || 'black'
            }
        }
    },
    mapNavigation: {
        enabled: false,
        buttonOptions: {
            verticalAlign: 'bottom'
        }
    },
    tooltip: {
        backgroundColor: 'none',
        borderWidth: 0,
        shadow: false,
        useHTML: true,
        padding: 0,
        pointFormat: '<span class="f32"><span class="flag {point.properties.hc-key}">' +
                '</span></span> {point.name}<br>' +
                '<span style="font-size:30px">{point.value} Miembros</span>',
        positioner: function () {
            return {x: 0, y: 250};
        }
    },
    colorAxis: {
        min: 1,
        max: 1000,
        type: 'logarithmic'
    },
    series: [{
            data: data_pais,
            joinBy: ['iso-a3', 'code3'],
            name: 'Cantidad de miembros',
            states: {
                hover: {
                    color: '#a4edba'
                }
            }
        }]
});

$(document).on('ready', function () {
        regitrar_comentario();
});

function regitrar_comentario(id_foro, id_usuario, descripcion, id_padre) {
    //$("#cargando").show();
    var files={};
    jQuery.each($("[name=attach_"+id_padre+"]"), function (i, file) {
        files[$(file).attr("id")]={"name":$(file).val(),"size":$(file).attr("f-size"),"type":$(file).attr("f-type")};
    })

    $.post(_root_ + 'foro/index/_getEstadistcaGeneral',function (data) {
        std_general=JSON.parse(data);
        $("#sta-gnr-m").html(std_general.Est_CantidadMiembros);
        $("#sta-gnr-t").html(std_general.Est_CantidadForo);
        $("#sta-gnr-c").html(std_general.Est_CantidadComentario);
        $("#sta-gnr-v").html(std_general.Est_CantidadVisita);
        $(".d-stat-load").hide();
        $(".d-stat-hide").removeClass("d-stat-hide");
                
        //$("#cargando").hide();                
    });

}