$(document).ready ->
  new SignInForm(form) for form in $('.script-sign-in-form')
class SignInForm
  constructor: (element)->
    @form=$(element)
    @form.bind('submit', @e_ensure_subdomain_presence)
    $('.script-input-subdomain').trigger('focus') # focus first field

  e_ensure_subdomain_presence: (evt)=>
    evt.preventDefault()
    return false if '' == $('.script-input-subdomain').val()
    action_url = @form.attr('action')
    new_action_url = action_url.replace('REPLACE_ME', $('.script-input-subdomain').val())
    @form.attr('action', new_action_url)
    @form.unbind('submit').submit()
