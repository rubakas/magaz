Feature: themes
  In order to add themes to my store
  As a store owner
  I want themes

Background:
  * store exists
  * themes exist
  * browsing theme store domain

Scenario: list of themes at home page
  * visit themestore index page
  * must see themes
  * clicks theme name
  * must be on theme page
