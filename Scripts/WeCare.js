
$(function () {

    $('[id$="TxtDob"]').datetimepicker({
        format: 'dd/MM/yyyy hh:mm:ss',
        language: 'en', 
        pick12HourFormat: true
    });
});
