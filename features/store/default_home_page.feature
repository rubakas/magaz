Feature: default home page
  In order to navigate store
  As a store visitor
  I want default home page

Background:
  * store exists
  * customer browsing store domain
  * default collection exists
  * default collection has products in it

Scenario: products from default collection
  * customer visits index page
  * must see products of default collection

Scenario: clickable products from default collection
  * customer visits index page
  * must see products of default collection
  * customer clicks product name
  * must be on product page