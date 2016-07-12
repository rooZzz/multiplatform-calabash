Given(/^I am a user$/) do
  # Set up data model...
end

And(/^I navigate to the login screen$/) do
  LoginController.check_on_screen
end

When(/^I enter the (correct|wrong) passcode$/) do |passcode_type|
  LoginController.enter_passcode(passcode_type)
end

Then(/^I should be warned that my passcode was wrong$/) do
  LoginController.check_for_wrong_passcode
end
