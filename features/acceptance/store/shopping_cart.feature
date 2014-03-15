Feature: shopping cart
  In order to purchase goods
  As a shop visitor
  I want shopping cart

Background:
	Given store exists "example"
	Given product exists "product_example" in store "example"
	Given hostname is "example.magaz.local"

Scenario: empty cart
  When I visit page "/cart"
  Then I must see text "Shopping cart"
  Then I must see text "Your shopping cart is empty."

Scenario: add product to cart
  When I visit page "/"
  When I click "product_example"
  When I click "Purchase"
  Then I must see text "Shopping cart"
  Then I must see text "product_example"

Scenario: change number of products in cart
  Pending
