Feature: Allow CardGame user to create a new game

  Background: I select the Login/Sign up page

    Given the following users have been added to the database:
      | username  | password  |
      | username1 | password1 |
    And I am on the login page
    Then I should be on the login page
    When I have opted to login with username "username1" and password "password1"
    Then my account should be successfully logged in
    And I should be on the games home page
    And There is a game already started with the ID: "9000"

  Scenario: Successfully join game lobby
    When I have entered the game ID: "9000"
    Then I should be on the lobby page

  Scenario: Unsuccessfully join game lobby
    When I have entered the game ID: "9001"
    And I should be on the games home page

  Scenario: Unsuccessfully join game lobby
    When I have entered the game ID: " "
    And I should be on the games home page
