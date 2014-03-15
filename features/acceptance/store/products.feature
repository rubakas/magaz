Feature: products
  In order to navigate shop
  As a shop visitor
  I want browse shop items

Background:
	* store exists "example"
	* product exists "product_example" in store "example"
	* hostname is "example.magaz.local"

Scenario: index page
	* I visit "/"
	* I must see text "product_example"

Scenario: product page
	* I visit "/"
	* I must see text "product_example"
	* I click "product_example"
	# * I must be at "/products/product_example"
	* I must see text "product_example"