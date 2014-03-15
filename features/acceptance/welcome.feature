Feature: welcome
  In order to understand the value of the service
  As a guest
  I want welcome page

Scenario: welcome page
  Given hostname is "magaz.local"
  When I visit page "/"
  Then I must see translation "welcome.index.heading"
  Then I must see translation "welcome.index.message"





