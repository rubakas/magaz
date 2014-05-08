Feature: themes
  In order to add themes to my store
  As a store owner
  I want themes

Background:
  * themes exist
  * store exists
  * shop admin logged in
  * browsing theme store domain

Scenario: list of themes at home page
  * visit themestore index page
  * must see themes
  * clicks theme name
  * choose to install theme
  * theme must be installed
