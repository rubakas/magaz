Feature: shopping cart
  In order to purchase goods
  As a shop visitor
  I want shopping cart

Background:
	* store exists "example"
	* product exists "product_example" in store "example"
	* hostname is "example.magaz.local"

Scenario: empty cart
  * I visit "/cart"
  * I must see text "Shopping cart"
  * I must see text "Your shopping cart is empty."

Scenario: add product to cart
  * I visit "/"
  * I click "product_example"
  * I click "Purchase"
  * I must see text "Shopping cart"
  * I must see text "product_example"

Scenario: change number of products in cart
  Pending

Scenario: checkout
  Pending