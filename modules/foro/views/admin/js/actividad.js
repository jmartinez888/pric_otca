/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).on('ready', function () {

    $("#start_time").datetimepicker({
        dateFormat: 'yy-mm-dd',
        timeFormat: 'H:mm',
        stepHour: 1,
        stepMinute: 5,
        beforeShow: function () {
            setTimeout(function () {
                $('.ui-datepicker').css('z-index', 1050);
            }, 0);
        }
    });
    $("#end_time").datetimepicker({
        dateFormat: 'yy-mm-dd',
        timeFormat: 'H:mm',
        stepHour: 1,
        stepMinute: 5,
        beforeShow: function () {
            setTimeout(function () {
                $('.ui-datepicker').css('z-index', 1050);
            }, 0);
        }
    });
    $('body').on('click', '.bt_start_time', function () {
        $("#start_time").datetimepicker("show");
        $("#start_time").datepicker('widget').css('z-index', 1051);


    });
    $('body').on('click', '.bt_end_time', function () {
        $("#end_time").datetimepicker("show");
        $("#end_time").datepicker('widget').css('z-index', 1051);
    });
    $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,listWeek'

        },
        defaultDate: defaultDateCalendar,
        eventLimit: true,
        selectable: true,
        selectHelper: true,
        select: function (start, end) {
            $('#ModalAdd #myModalLabel_add').show();
            $('#ModalAdd #bt_guardar').show();            
            $('#ModalAdd #myModalLabel_edit').hide();
            $('#ModalAdd #bt_eliminar').hide();
            $('#ModalAdd #bt_editar').hide();
            
            $('#ModalAdd #start_time').val(moment(start).add(8, 'hours').format('YYYY-MM-DD HH:mm'));
            $('#ModalAdd #end_time').val(moment(end).subtract(1, 'days').add(20, 'hours').format('YYYY-MM-DD HH:mm'));
            $('#ModalAdd').modal('show');
        },
        eventClick: function (event) {
            $('#ModalAdd #myModalLabel_add').hide();
            $('#ModalAdd #bt_guardar').hide();  
            $('#ModalAdd #myModalLabel_edit').show();            
            $('#ModalAdd #bt_eliminar').show();
            $('#ModalAdd #bt_editar').show();
            
            $('#ModalAdd #id').val(event.id);
             $('#ModalAdd #hd_id_actividad').val(event.id);
            $('#ModalAdd #tb_titulo').val(event.title);
            $('#ModalAdd #tb_resumen').val(event.resumen);
            $('#ModalAdd #start_time').val(moment(event.start).format('YYYY-MM-DD HH:mm'));
            $('#ModalAdd #end_time').val(moment(event.end).format('YYYY-MM-DD HH:mm'));
            $('#ModalAdd').modal('show');
        },
        events: eventos
    });

});
