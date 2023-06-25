Feature: User can upload their Image

  @PresenceeAPI @UploadPresencee @Upload
  Scenario: User want to create Upload image
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    And User call an api "upload/" with method "POST"
    Then User verify status code is 200