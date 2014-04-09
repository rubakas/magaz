Feature: checkout process
  In order to purchase selected goods
  As a store visitor
  I want checkout process

Background:
  * store exists
  * default collection exists
  * default collection has products in it
  * browsing store domain

Scenario: checkout step one success
  * product successfully added to cart
  * go to checkout
  * input customer email
  * continue to next step

Scenario: checkout step two (success, failure, cancellation)
  * product successfully added to cart
  * go to checkout
  * input customer email
  * continue to next step
  * choose payment
  * finish checkout
