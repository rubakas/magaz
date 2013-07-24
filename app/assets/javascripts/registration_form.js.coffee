console.log('loaded');
$(document).ready ->
  console.log('loaded 2');
  new RegistarationForm(form) for form in $('.script-registration-form')
class RegistarationForm
  constructor: (element)->
    console.log('constructor');
    @form=$(element)
    @show_data_error_message(field) for field in @form.find('.script-field')

  show_data_error_message: (field)=>
    error_message=$(field).find('input').data('errormessage');
    if (error_message)
      $(field).find('.script-error-label').text(error_message).removeClass('hidden')