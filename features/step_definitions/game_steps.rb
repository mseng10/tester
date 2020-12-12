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
  # expect(page).to have_content("Game ID")
end

And /^There is a game already started with the ID: "(.+)"$/ do |id|
  Cardgame.create!(game_id: id)
end

When /^I have entered the game ID: "(.+)"$/ do |id|
  fill_in "join_game_textbox", with: id
  # click_button 'Join Game!'
end

When /^I select the start game button$/ do
  click_button 'Start Game'
end

Then /^I should be on the started game page$/ do
  expect(page).to_not have_content("Game ID")
end

When /^I select the end game button$/ do
  click_button "end_game_button", visible: true
end

When /^I select the reset game button$/ do
  click_button "end_game_button", visible: true
end
