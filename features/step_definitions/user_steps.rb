When /^I have clicked on the login button$/ do
  click_on 'Login'
end

Then /^I should be on the login page$/ do
  expect(page).to have_content('Login')
end

Given /the following users have been added to the database:/ do |users_table|
  size = User.all.size
  users_table.hashes.each do |user|
    User.create_user({:username => user[:username],
                :email => user[:email],
                :password => BCrypt::Password.create(user[:password])})
  end
  expect(User.all.size).to equal(size+1)
end

When /^I have opted to login with username "(.+)" and password "(.+)"$/ do |username, password|
  fill_in "loginUser", with: username
  fill_in "loginPassword", with: password
  click_on "login_submit"
end

Then /^I should be on the games home page$/ do
  expect(page).to have_content('Please join or create a game.')
end

And /^I should see "(.*?)" button$/ do |button_type|
  expect(page).to have_content(button_type.to_s)
end

Given /^I am on the login page$/ do
  visit login_path
end

When /^I have clicked on the Sign Up button$/ do
  click_on 'Sign-up'
end

Then /^I should be on the Sign Up Page$/ do
  expect(page).to have_content('Sign Up')
end

When /^I have opted to Sign-up with username "(.+)", email "(.+)" password "(.+)" and password confirmation "(.+)"$/ do |username, email, password, password2|
  fill_in "signupUser", with: username
  fill_in "signupEmail", with: email
  fill_in "signupPassword", with: password
  fill_in "signuppasswordConfirmation", with: password2
  click_button 'Create my account'
end

Then /^my account should be successfully created$/ do
  expect(page).to have_content('Your account has been created.')
end

Then /^my account should not be successfully created due to the user-id$/ do
  expect(page).to have_content('Sorry, this user-id is taken. Please try again')
end

Then /^my account should not be successfully created due to the email$/ do
  expect(page).to have_content('Sorry, email is already registered to an account. Please try a different one.')
end

Then /^my account should not be successfully created due to the passwords$/ do
  expect(page).to have_content('Sorry, the passwords you have entered do not match. Please try again.')
end

Then /^my account should be successfully logged in$/ do
  expect(page).to have_content('Successful login! You are logged in')
end

Then /^my account should not be successfully logged in$/ do
  expect(page).to have_content('Invalid user-id/password combination.')
end

When /^I have opted to Logout my account$/ do
  click_button 'Log Out'
end

Then /^my account should be successfully logged out$/ do
  expect(page).to have_content('Logged out of user')
end