Then /^email must be sent to "(.*?)"$/ do |address|
  @email = ActionMailer::Base.deliveries.first
  assert_equal address, @email.to.first
end