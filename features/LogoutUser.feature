Feature: Allow new CardGame user to a user profile

  Background: I select the Login/Sign up page

    Given the following users have been added to the database:
      | username  | password  |
      | username1 | password1 |
    And I am on the login page
    When I have opted to login with username "username1" and password "password1"
    Then my account should be successfully logged in

  #TODO: Maybe fix
  Scenario: Successful Logout
    When I have opted to Logout my account
    Then I am on the login page
