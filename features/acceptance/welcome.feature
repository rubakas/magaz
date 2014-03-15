Feature: welcome
  In order to understand the value of the service
  As a guest
  I want welcome

Scenario: welcome page
  Given hostname is "magaz.local"
  When I visit page "/"
  Then I must see "welcome.index.heading" translation
  Then I must see "welcome.index.message" translation





