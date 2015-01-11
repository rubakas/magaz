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
  var hidden_multipass = $(this).find('.js-checkouts_hidden_field_multipass');
  var hidden_auto_fulfill = $(this).find('.js-checkouts_hidden_field_auto_fulfill');

  hidden_multipass.css({'display':'none'});
  
  var auto_fulfill_order_line = $('.js-field_after_order_paid .js-auto_fulfill_orders');
  var auto_fulfill_gift_cards = $('.js-field_after_order_paid .js-auto_fulfill_gift_cards');
  var do_not_auto_fulfill = $('.js-field_after_order_paid .js-do_not_fulfill');
  
  var disabled = $('.js-field_account_choice .js-disabled');
  var required = $('.js-field_account_choice .js-required');
  var optional = $('.js-field_account_choice .js-optional');
  
  $('.js-field_account_choice').click(function() {
    if(optional.is(':selected') || required.is(':selected')){
      hidden_multipass.slideDown();
    }
    if(hidden_multipass.is(':visible') && disabled.is(':selected')){
      hidden_multipass.slideUp();
      $(hidden_multipass).find('.js-checkout_enable_multipass_checkbox').prop('checked',false);
    }
  });
  $('.js-field_after_order_paid').click(function() {
    if(auto_fulfill_order_line.is(':selected') && !(hidden_auto_fulfill.is(':visible'))){
      hidden_auto_fulfill.slideDown();
    }
    if(hidden_auto_fulfill.is(':visible') && (auto_fulfill_gift_cards.is(':selected')) || do_not_auto_fulfill.is(':selected')){
      hidden_auto_fulfill.slideUp();
      $(hidden_auto_fulfill).find('.js-checkout_auto_fulfill_orders_checkbox').prop('checked',false);
    }
  });
  /*Payment*/
  $('.js-payments_hidden_field_authorize_and_charge, .js-payments_hidden_field_authorize').css({'display':'none'});

  var authorize_and_charge = $('.js-field_with_authorization_methods .js-authoriz_and_charge');
  var authorize = $('.js-field_with_authorization_methods .js-authorize');
  var select_authorization_method = $('.js-field_with_authorization_methods .js-select_method');
  
  var hidden_field_authorize = $(this).find('.js-payments_hidden_field_authorize');
  var hidden_field_authorize_and_charge = $(this).find('.js-payments_hidden_field_authorize_and_charge');
  
  $('.js-field_with_authorization_methods').click(function(){
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
