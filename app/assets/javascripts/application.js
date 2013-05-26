// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap.min.js
//= require ./bootstrap-affix
//= require ./bootstrap-alert
//= require ./bootstrap-button
//= require ./bootstrap-carousel
//= require ./bootstrap-collapse
//= require ./bootstrap-dropdown
//= require ./bootstrap-modal
//= require ./bootstrap-popover
//= require ./bootstrap-scrollspy
//= require ./bootstrap-tab
//= require ./bootstrap-tooltip
//= require ./bootstrap-transition
//= require ./bootstrap-typeahead
//= require_tree .

$(document).ready(function () {
  $('.carousel').carousel();

  if ($('table.orders').length > 0) {
    $('.card').hide();
  } else {
    $('.card').show();
  }

  if ($('.cart_title').is(':visible')) {
    $('#empty_card_content').hide();
  } else {
    $('#empty_card_content').show();
  }

  $(document).on('click', '.btn_add_product', function () {
    $('#empty_card_content').hide('blind', 500);
  });

  $(".alert").alert();

  $(document).on('mouseenter', '.minus-item', function () {
    $(this).removeClass('icon-white');
  });

  $(document).on('mouseleave', '.minus-item', function () {
    $(this).addClass('icon-white');
  });

  $(document).on('click', '.minus-item', function () {
    var tr = $(this).parents('tr');
    var product_id = $(tr).data('product-id');
    var params = {product_id:product_id, format:'json'};

    $.get('/en/line_items/decrease', params, function (data) {
      var quantity = data.quantity;
      if (quantity > 0) {
        $(tr).find('.quantity').html(data.quantity);
      } else {
        $(tr).remove();
      }

      if ($('.line_item_tr').length < 1) {
        $('#cart').hide();
        $('#empty_card_content').show();
      }
    });
  });
});
