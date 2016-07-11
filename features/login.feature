Feature: As a user I want to be able to login to the app

  Scenario Outline: Attempting login with passcode
    Given I am a user
    And I navigate to the login screen
    When I enter the <passcode entered> passcode
    Then I should be <outcome>

    Examples:
      | passcode entered | outcome                           |
      | correct          | on the home screen                |
      | wrong            | warned that my passcode was wrong |