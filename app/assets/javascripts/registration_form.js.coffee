$(document).ready ->
  new RegistarationForm(form) for form in $('.script-registration-form')
class RegistarationForm
  constructor: (element)->
    @form=$(element)
    @validation_url=@form.data('validationUrl')
    @show_data_error_message(field) for field in @form.find('.script-field')
    #bind events
    $('.script-input-name').bind('blur',@e_validate_name)
    $('.script-input-email').bind('blur',@e_validate_email)
    $('.script-input-password').bind('blur',@e_validate_password)
  
  e_validate_name: (evt)=>
    @validate_field('name',evt); 

  e_validate_email: (evt)=>
    @validate_field('email',evt);       

  e_validate_password: (evt)=>
    @validate_field('password',evt);    

  validate_field:(field_name,evt)=>
    $.ajax(@validation_url,{
      method:'POST',
      data:@form.serialize(),
      dataType:'json'
      success:(data)=>
        error_message = data[field_name]?.join(', ') || null;
        $(evt.target).data('errormessage', error_message);
        field=$(evt.target).closest('.script-field');
        @show_data_error_message(field);      
    })
  show_data_error_message: (field)=>
    error_message=$(field).find('input').data('errormessage');
    $error_label=$(field).find('.script-error-label');
    if (error_message&&error_message!='')
      $error_label.text(error_message).removeClass('hidden');
    else
      $error_label.addClass('hidden');
    
