Feature: shopping cart
  In order to select products for purchase
  As a store visitor
  I want shopping cart

Background:
  * store exists
  * default collection exists
  * default collection has products in it
  * browsing store domain

Scenario: empty cart
	* customer visits cart page
	* must see empty cart

Scenario: add product to cart
  * product successfully added to cart

Scenario: change quantity of products in cart
  * product successfully added to cart
  * customer changes quanity of product to 42
  * must be on cart page
  * must see product in the cart with quantity 42

Scenario: place order
	* product successfully added to cart
  * customer changes quanity of product to 42
  * must be on cart page
  * must see product in the cart with quantity 42
  * customer chooses to checkout	
  * must see checkout page

