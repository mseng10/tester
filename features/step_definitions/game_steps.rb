Given /^I am on the games home page$/ do
  visit games_path
end

When /^I have clicked on the create new game button$/ do
  visit new_game_path
end

Then /^I should be on the create new game page$/ do
  expect(page).to have_content('Please create a new game below!')
end

And /^I create a game with "(.+)" decks, "(.+)" sinks, with "(.+)" and "(.+)", of hand size "(.+)"$/ do |decks, sinks, jokers, shuffled, hand_size|
  # Need to just place inputs for user readability.
  # I dont believe we need to do database checking because the backend will do this.
  # ^This will be tested in Rspec, we just want to assert the user can interact with the page.
  click_button 'Go to Lobby'
end

Then /^I should be on the lobby page$/ do
  expect(page).to have_content("Game ID")
end
