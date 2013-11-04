$(document).ready ->
  new AdminSignInForm(form) for form in $('.script-admin-sign-in-form')
class AdminSignInForm
  constructor: (element)->
    @form=$(element)
    $('.script-input-email').trigger('focus') # focus first field