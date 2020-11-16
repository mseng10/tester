Feature: Allow CardGame user to create a user game

  Background: I select the Login/Sign up page

    Given the following users have been added to the database:
      | username  | password  |
      | username1 | password1 |
    And I am on the login page
    Then I should be on the login page

  Scenario: Successful Login
    When I have opted to login with username "username1" and password "password1"
    Then my account should be successfully logged in
    And I should be on the games home page

  Scenario: Unsuccessful Login with username
    When I have opted to login with username "username" and password "password1"
    Then my account should not be successfully logged in
    And I should be on the login page

  Scenario: Unsuccessful Login with password
    When I have opted to login with username "username1" and password "password"
    Then my account should not be successfully logged in
    And I should be on the login page
