Feature: checkout process
  In order to purchase selected goods
  As a store visitor
  I want checkout process

Background:
  * store exists
  * default collection exists
  * default collection has products in it
  * browsing store domain

Scenario: checkout step one (success, failure, cancellation)
  * product successfully added to cart
  * go to checkout
  * input customer email
  * input customer billing address
  * input customer shipping address
  * continue to next step

Scenario: checkout step two (success, failure, cancellation)
  * product successfully added to cart
  * go to checkout
  * checkout step one finished successfully
  * input payment information
  * continue to complete purchase  
