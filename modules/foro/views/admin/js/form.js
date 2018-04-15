var _post = null;
$(document).on('ready', function () {
    $(".cb_select_fecha").attr('checked',false);
    $('textarea#text_descripcion').ckeditor();
    $('body').on('change', '.files_form', function () {
        load_files_form($(this)[0].files, $($($(($($(this).parent()).parent()).parent()).parent()).parent()).find(".load_files"));
        $(this).val("");
    });
    $('body').on('click', '.file_close', function () {
        id_padre = $($($(this).parent()).parent()).attr("id");
        $($(this).parent()).remove();
        if ($("#" + id_padre).html().trim() == "") {
            $("#" + id_padre).removeClass("d-block")
            $("#" + id_padre).addClass("d-none")
            set_input_hdd_files_form();
        }
    });
    $('body').on('click', '.bt_start_time', function () {
        $("#start_time").datetimepicker("show");
    });
    $('body').on('click', '.bt_end_time', function () {
        $("#end_time").datetimepicker("show");
    });
    $('body').on('click', '.bt_clear_start_time', function () {
        $("#start_time").val("");
    });
    $('body').on('click', '.bt_clear_end_time', function () {
        $("#end_time").val("");
    });
    $('body').on('change', '.cb_select_fecha', function () {
        div = $(this).attr("div_time");
        if ($(this).is(':checked'))
        {
            $("#" + div).show();
            if(div=="start_date_div"){
                $("#start_time").val(startDate);
            }else{
                $("#end_time").val(endDate);
            }
        }
        else
        {
            $("#" + div).hide();
            if(div=="start_date_div"){
                $("#start_time").val("");
            }else{
                $("#end_time").val("");
            }
        }
    });
    $("#start_time").datetimepicker({
        dateFormat: 'dd-mm-yy',
        timeFormat: 'H:mm',
        stepHour: 1,
        stepMinute: 5
    });
    $("#end_time").datetimepicker({
        dateFormat: 'dd-mm-yy',
        timeFormat: 'H:mm',
        stepHour: 1,
        stepMinute: 5
    });   
});
function load_files_form(file, div_conte) {
    var formData = new FormData();
    $(div_conte).removeClass("d-none");
    $(div_conte).addClass("d-block");
    var add_div = $(div_conte).html();
    jQuery.each(file, function (i, file) {
        id = 'file-' + i;
        formData.append(id, file);
        str_size = "";
        fileSizeInBytes = file["size"]
        // Convert the bytes to Kilobytes (1 KB = 1024 Bytes)
        fileSizeInKB = fileSizeInBytes / 1024;
        if (fileSizeInKB < 1) {
            str_size = fileSizeInKB.toFixed(3) + " K"
        } else {
            fileSizeInMB = fileSizeInKB / 1024;
            str_size = fileSizeInMB.toFixed(3) + " M"
        }
        // Convert the KB to MegaBytes (1 MB = 1024 KBytes)

        add_div += div_file(file["name"], str_size, id, $(div_conte).attr("id_padre"));
    });
    $(div_conte).html(add_div);
    $.ajax({
        url: _root_ + 'foro/index/_load_file_coment',
        type: 'POST',
        data: formData,
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function (data) {
            $(".file_loading").removeClass("on");
            $(".file_loading").addClass("off");
            result = JSON.parse(data);
            jQuery.each(result, function (i, file) {
                id_file = file["id"];
                $("#" + id_file).val(file["name"]);
                $("#" + id_file).attr("f-size", file["size"]);
                $("#" + id_file).attr("f-type", file["type"]);
            });
            set_input_hdd_files_form();
        }
    });
}

function div_file(titulo, peso, id) {
    div = "<div class='files' tabindex='-1' id='' >";
    div += "<input id='" + id + "' name='attach_form' type='hidden' value='' checked=''>";
    div += "<div class='file_titulo'>" + titulo + "</div>";
    div += "<div class='file_size'>(" + peso + ")</div>";
    div += "<div class='file_loading on'></div>";
    div += "<div  role='button' class='file_close' tabindex='-1'></div>"
    div += "</div>";
    return div;
}

function set_input_hdd_files_form() {
    var files = {};
    jQuery.each($("[name=attach_form]"), function (i, file) {
        files[$(file).attr("id")] = {"name": $(file).val(), "size": $(file).attr("f-size"), "type": $(file).attr("f-type")};
    })
    att_files = JSON.stringify(files);
    $("#hd_file_form").val(att_files);
}

