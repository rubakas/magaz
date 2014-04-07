Feature: shopping cart
  In order to select products for purchase
  As a store visitor
  I want shopping cart

Background:
  * store exists
  * customer browsing store domain
  * default collection exists
  * default collection has products in it

Scenario: empty cart
	* customer visits cart page
	* must see empty cart

Scenario: clickable products from default collection
  * customer visits index page
  * must see products of default collection
  * customer clicks product name
  * must be on product page
  * customer adds product to cart
  * must be on cart page
  * must see product in the cart
