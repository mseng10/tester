Feature: Allow a user to reset his/her password

  Background: I clicked the 'Forgot Password' button

    Given the following users have been added to the database:
      | username  | email         | password  |
      | username1 | hey@gmail.com | password1 |
    And I am on the login page
    Then I should be on the login page
    When I have clicked on the forgot password button
    Then I should be on the forgot password page

    Scenario: Successfully reset password
      When I have entered the email: "hey@gmail.com"