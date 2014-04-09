Feature: default home page
  In order to navigate store
  As a store visitor
  I want default home page

Background:
  * store exists
  * default collection exists
  * default collection has products in it
  * browsing store domain

Scenario: clickable products from default collection
  * visit shop index page
  * must see products of default collection
  * customer clicks product name
  * must be on product page