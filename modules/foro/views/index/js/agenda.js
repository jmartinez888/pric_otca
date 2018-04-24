/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).on('ready', function () {


    $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,listWeek'

        },
        defaultDate: defaultDateCalendar,  
        selectHelper: true,   
        events: eventos
    });

});
