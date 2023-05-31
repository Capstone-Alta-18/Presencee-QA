Feature: Authentication of Alta Shop API

  @AltaShopAPI @AuthenticationAltaShop @Register
  Scenario: User doing registration at Alta Shop
    Given User call an api "auth/register" with method "POST" with payload below
      | email       | password         | fullname           |
      | randomEmail | randomPassword  | randomFullName      |
    Then User verify status code is 200

  @AltaShopAPI @AuthenticationAltaShop @Login
  Scenario: User login to Alta Shop
    Given User call an api "auth/login" with method "POST" with payload below
      | email           | password      |
      | userEmail       | userPassword  |
    Then User verify status code is 200
    And User get auth token

  @AltaShopAPI @AuthenticationAltaShop @GetUserInformation
  Scenario: User can get user information
    Given User call an api "auth/login" with method "POST" with payload below
      | email           | password      |
      | userEmail       | userPassword  |
    Then User verify status code is 200
    And User get auth token
    Given User get other users information
