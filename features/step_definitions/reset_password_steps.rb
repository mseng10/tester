When /^I have clicked on the forgot password button$/ do
  visit new_password_reset_path
end

Then /^I should be on the forgot password page$/ do
  expect(page).to have_content('Reset Password')
end

When /^I have entered the email: "(.+)"$/ do |email|
  fill_in "ResetPasswordEmail1", with: email
  click_button 'Reset password'
end