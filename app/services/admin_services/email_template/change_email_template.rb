class AdminServices::EmailTemplate::ChangeEmailTemplate
  attr_reader :success, :email_template, :errors
  alias_method :success?, :success

  def initialize(id: nil, shop_id: nil, params: {title: nil, body: nil})
    @email_template = Shop.find(shop_id).email_templates.find(id)
    @params = params
  end

  def run
    @email_template.assign_attributes(@params)

    if @email_template.valid?
      @success = true
      @email_template.save
    else
      @success = false
      @errors = @email_template.errors
    end
    self
  end
end
