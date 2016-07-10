Feature: As a user I want to be able to login to the app

  Scenario: Logging in using the correct passcode
    Given I am a user
    And I navigate to the login screen
    When I login with the correct passcode
    Then I should be on the home screen