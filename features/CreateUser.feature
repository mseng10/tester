Feature: Allow new CardGame user to a user profile

  Background: I select the Login/Sign up page

    Given the following users have been added to the database:
      | username  | password  |
      | username1 | password1 |
    And I am on the login page
    When I have clicked on the Sign Up button
    Then I should be on the Sign Up Page

  Scenario: Successful Signup
    When I have opted to Sign-up with username "username2" and password "password2"
    Then my account should be successfully created
    And I am on the login page

  Scenario: Unsuccessful Signup
    When I have opted to Sign-up with username "username1" and password "password2"
    Then my account should not be successfully created
    And I should be on the Sign Up Page