module WelcomeHelper
  def form_error_data(object, field_name)
    if object.errors[field_name].present?
      { errorMessage: object.errors[field_name].first }
    else
      {}
    end
  end
end
