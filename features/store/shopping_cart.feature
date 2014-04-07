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

Scenario: change quantity of products in cart
  * customer visits index page
  * must see products of default collection
  * customer clicks product name
  * must be on product page
  * customer adds product to cart
  * must be on cart page
  * must see product in the cart
  * customer changes quanity of product to 42
  * must be on cart page
  * must see product in the cart with quantity 42

Scenario: place order
	* customer visits index page
  * must see products of default collection
  * customer clicks product name
  * must be on product page
  * customer adds product to cart
  * must be on cart page
  * must see product in the cart
  * customer changes quanity of product to 42
  * must be on cart page
  * must see product in the cart with quantity 42
  * customer chooses to checkout	
  * must see checkout page

