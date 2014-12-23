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
  $('.col-xs-9 .hidden_field_link, .hidden_field_paypal, .hidden_field_pro_UK,.hidden_field_dwolla, .hidden_field_bitpay, .hidden_field_coinbase, .hidden_field_gocoin, .hidden_field_manual, .hidden_field_authorize_and_charge, .hidden_field_authorize').css({'display':'none'});

  var hidden_field_paypal = $('.col-xs-9').find('.hidden_field_paypal');
  var hidden_field_link = $('.col-xs-9').find('.hidden_field_link');
  var hidden_field_pro_UK = $('.col-xs-9').find('.hidden_field_pro_UK');

  var select_paypal= $('#shop_paypal_methods option:first');
  var paypal = $('#shop_paypal_methods [value="PayPal Express Checkout"]');
  var flow_link = $('#shop_paypal_methods [value="PayPalflow Link"]');
  var pro_US = $('#shop_paypal_methods [value="PayPal Payments Pro(US)"]');
  var website_pro_CA = $('#shop_paypal_methods [value="PayPal Website Payments Pro(CA)"]');
  var website_pro_UK = $('#shop_paypal_methods [value="PayPal Website Payments Pro(UK)"]'); 
  
  $('#shop_paypal_methods').click(function(){
    if(paypal.is(':selected') || pro_US.is(':selected') || website_pro_CA.is(':selected')){
      hidden_field_paypal.slideDown();
    } 
    if(hidden_field_paypal.is(':visible') && (flow_link.is(':selected') || website_pro_UK.is(':selected'))){
      hidden_field_paypal.slideUp(); 
    }
    if(flow_link.is(':selected')){
      hidden_field_link.slideDown();
    }
    if(hidden_field_link.is(':visible')  && (paypal.is(':selected') || pro_US.is(':selected') || website_pro_CA.is(':selected')  || website_pro_UK.is(':selected'))){
      hidden_field_link.slideUp();
    }
    if(website_pro_UK.is(':selected') && !(hidden_field_pro_UK.is(':visible'))){
      hidden_field_pro_UK.slideDown();
    }
    if(hidden_field_pro_UK.is(':visible') && (paypal.is(':selected') || flow_link.is(':selected') || pro_US.is(':selected') || website_pro_CA.is(':selected'))){
      hidden_field_pro_UK.slideUp();  
    }
    if(select_paypal.is(':selected')){
      hidden_field_pro_UK.slideUp(); 
      hidden_field_paypal.slideUp();
      hidden_field_link.slideUp();
    }
  });
  var select_additional_methods= $('#shop_additional_methods option:first');
  var dwolla = $('#shop_additional_methods [value="Dwolla"]');
  var bitpay = $('#shop_additional_methods [value="BitPay"]');
  var coinbase = $('#shop_additional_methods [value="Coinbase"]');
  var gocoin = $('#shop_additional_methods [value="GoCoin"]');

  var hidden_field_dwolla = $('.col-xs-9').find('.hidden_field_dwolla');
  var hidden_field_bitpay = $('.col-xs-9').find('.hidden_field_bitpay');
  var hidden_field_coinbase = $('.col-xs-9').find('.hidden_field_coinbase');
  var hidden_field_gocoin = $('.col-xs-9').find('.hidden_field_gocoin');
    
  $('#shop_additional_methods').click(function(){
    if(select_additional_methods.is(':selected')){
      hidden_field_dwolla.slideUp();
      hidden_field_bitpay.slideUp();
      hidden_field_coinbase.slideUp();
      hidden_field_gocoin.slideUp();
    }
    if(dwolla.is(':selected')){
      hidden_field_dwolla.slideDown();
      hidden_field_bitpay.slideUp();
      hidden_field_coinbase.slideUp();
      hidden_field_gocoin.slideUp();
    }
    if(bitpay.is(':selected')){
      hidden_field_bitpay.slideDown();
      hidden_field_dwolla.slideUp();
      hidden_field_coinbase.slideUp();
      hidden_field_gocoin.slideUp();
    }
    if(coinbase.is(':selected')){
      hidden_field_coinbase.slideDown();
      hidden_field_bitpay.slideUp();
      hidden_field_dwolla.slideUp();
      hidden_field_gocoin.slideUp();
    }
    if(gocoin.is(':selected')){
      hidden_field_gocoin.slideDown();
      hidden_field_bitpay.slideUp();
      hidden_field_dwolla.slideUp();
      hidden_field_coinbase.slideUp();
    }
  });
  var select_custom_methods = $('#shop_custom_methods option:first');
  var cash_on_delivery = $('#shop_custom_methods [value="Cash on Delivery(COD)"]');
  var money_order = $('#shop_custom_methods [value="Money Order"]');
  var bank_deposit = $('#shop_custom_methods [value="Bank Deposit"]')
  var custom_payment_method = $('#shop_custom_methods [value="Custom payment method"]')

  var hidden_field_manual = $('.col-xs-9').find('.hidden_field_manual');
  $('#shop_custom_methods').click(function(){
    if(cash_on_delivery.is(':selected') || money_order.is(':selected') || bank_deposit.is(':selected') || custom_payment_method.is(':selected')){
      hidden_field_manual.slideDown();   
      if(cash_on_delivery){
      }
    }
    if(select_custom_methods.is(':selected')){
      hidden_field_manual.slideUp();
    }
  });
  var authorize_and_charge = $('#shop_authoreze_settings [value="Authorize and charge the customers credit card."]');
  var authorize = $('#shop_authoreze_settings [value="Authorize the customers credit card."]');
  
  var hidden_field_authorize = $('.col-xs-9').find('.hidden_field_authorize');
  var hidden_field_authorize_and_charge = $('.col-xs-9').find('.hidden_field_authorize_and_charge');
  $('#shop_authoreze_settings').click(function(){
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
