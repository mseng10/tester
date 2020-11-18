Feature: Allow new CardGame user to a user profile

  Background: I select the Login/Sign up page

    Given the following users have been added to the database:
      | username  | email               | password  |
      | username1 | username1@gmail.com | password1 |
    And I am on the login page
    When I have clicked on the Sign Up button
    Then I should be on the Sign Up Page

  Scenario: Successful Signup
    When I have opted to Sign-up with username "username2", email "username2@gmail.com" and password "password2"
    Then my account should be successfully created
    And I am on the login page

  Scenario: Unsuccessful Signup due to username
    When I have opted to Sign-up with username "username1", email "username2@gmail.com" and password "password2"
    Then my account should not be successfully created due to the user-id
    And I should be on the Sign Up Page

  Scenario: Unsuccessful Signup due to email
    When I have opted to Sign-up with username "username2", email "username1@gmail.com" and password "password2"
    Then my account should not be successfully created due to the email
    And I should be on the Sign Up Page