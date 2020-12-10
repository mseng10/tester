When /^I have clicked on the forgot password button$/ do
  visit new_password_reset_path
end

When /^I have entered the email: "(.+)"$/ do |email|
  fill_in "ResetPasswordEmail", with: email
end

Then /^I should be on the reset password page$/ do
  expect(page).to have_content('Reset Password')
end

And /^I should see the success message$/ do
  expect(page).to have_content('Password changed successfully!')
end

And /^I should see the failure message$/ do
  expect(page).to have_content("Could not find an account with that email.")
end

And /^I have entered the password: "(.+)"$/ do |password|
  fill_in "resetPassword", with: password
  fill_in "resetPasswordConfirmation", with: password
  # page.fill_in :placeholder => 'Password', with: password
  # page.fill_in :placeholder => 'Password Confirmation', with: password
  # find('resetPassword').set(password)
  # find('resetPasswordConfirmation').set(password)
  click_button 'Change Password'
end