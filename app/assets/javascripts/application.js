// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require turbolinks
//= require_tree .
//= require twitter/bootstrap
$(document).ready(function(){
  /*Checkout*/
  var hidden_multipass = $('.col-xs-9').find('.hidden_field_multipass');
  var hidden_auto_fulfill = $('.col-xs-9').find('.hidden_field_auto_fulfill');
  
  hidden_multipass.css({'display':'none'});
  
  var auto_fulfill_order_line = $('#shop_after_order_paid [value="Automatically fulfill the orders line items."]');
  var auto_fulfill_gift_cards = $('#shop_after_order_paid [value="Automatically fulfill only the gift cards of the order."]');
  var do_not_auto_fulfill = $('#shop_after_order_paid [value="Do not automatically fulfill any of the orders line items."]');
  
  var disabled = $('#shop_account_type_choice [value="Account are disabled"]');
  var required = $('#shop_account_type_choice [value="Account are required"]');
  var optional = $('#shop_account_type_choice [value="Account are optional"]');
  
  $('#shop_account_type_choice').click(function() {
    if(optional.is(':selected') || required.is(':selected')){
      hidden_multipass.slideDown();
    }
    if(hidden_multipass.is(':visible') && disabled.is(':selected')){
      hidden_multipass.slideUp();
      $(hidden_multipass).find(':checkbox').prop('checked',false);
    }
  });
  $('#shop_after_order_paid').click(function() {
    if(auto_fulfill_order_line.is(':selected') && !(hidden_auto_fulfill.is(':visible'))){
      hidden_auto_fulfill.slideDown();
    }
    if(hidden_auto_fulfill.is(':visible') && (auto_fulfill_gift_cards.is(':selected')) || do_not_auto_fulfill.is(':selected')){
      hidden_auto_fulfill.slideUp();
      $(hidden_auto_fulfill).find(':checkbox').prop('checked',false);
    }
  });
  /*Payment*/
  $('.col-xs-9 .hidden_field_authorize_and_charge, .hidden_field_authorize').css({'display':'none'});

  var authorize_and_charge = $('#shop_authoriz_settings [value="Authorize and charge the customers credit card."]');
  var authorize = $('#shop_authoriz_settings [value="Authorize the customers credit card."]');
  var select_authorization_method = $('#shop_authoriz_settings option:first');

  var hidden_field_authorize = $('.col-xs-9').find('.hidden_field_authorize');
  var hidden_field_authorize_and_charge = $('.col-xs-9').find('.hidden_field_authorize_and_charge');
  $('#shop_authoriz_settings').click(function(){
    if(select_authorization_method.is(':selected')){
      hidden_field_authorize_and_charge.slideUp();
      hidden_field_authorize.slideUp();      
    }
    if(authorize_and_charge.is(':selected')){
      hidden_field_authorize_and_charge.slideDown();
      hidden_field_authorize.slideUp();
    }
    if(authorize.is(':selected')){
      hidden_field_authorize.slideDown();
      hidden_field_authorize_and_charge.slideUp();
    }
  });
});
