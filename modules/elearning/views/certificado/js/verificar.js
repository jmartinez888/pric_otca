/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).on('ready', function () {
    $('body').on('click', '#verificar_certificado', function () {
       document.location.href = _root_ + 'elearning/certificado/verificar/'+$("#txt_codigo").val()
        });
});