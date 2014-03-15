Feature: shopping cart
  In order to purchase goods
  As a shop visitor
  I want shopping cart

Scenario: empty cart
	Given store exists "example"
	Given hostname is "example.magaz.local"
  When I visit page "/cart"
  Then I must see translation "store.carts.show.heading"
  Then I must see translation "store.carts.show.message_empty"
