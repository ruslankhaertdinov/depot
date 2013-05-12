$(document).ready(function () {
    $('.nav-list li').click(function () {
        $('.nav-list li.active').removeClass('active');
        $(this).addClass('active');
    });
});