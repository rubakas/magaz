Feature: default home page
  As a store visitor
  I want default home page
  In order to navigate store

Background:
  * store exists
  * default collection exists
  * default collection has products in it

Scenario: products from default collection
  * customer visits index page
  * must see products of default collection