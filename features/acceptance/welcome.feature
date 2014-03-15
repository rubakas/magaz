Feature: welcome
  In order to understand the value of the service
  As a guest
  I want welcome page

Background:
	* hostname is "magaz.local"


Scenario: welcome page
  * I visit "/"
  * I must see text "Welcome to Magaz"
  * I must see text "Everything you need to start selling online &mdash; today"





