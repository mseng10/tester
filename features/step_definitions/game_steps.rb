Given /^I am on the games home page$/ do
  visit games_path
end

When /^I have clicked on the create new game button$/ do
  visit new_game_path
end

Then /^I should be on the create new game page$/ do
  expect(page).to have_content('Please create a new game below!')
end