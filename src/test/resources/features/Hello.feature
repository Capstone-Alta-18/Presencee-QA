Feature: Hello as an additional Alta Shop API testing

  @AltaShopAPI @HelloAltaShop @Index
  Scenario: User get message hello
    Given User call an api "hello" with method "GET"
    Then User verify status code is 200
    Then User verify response is match with json schema "index.json"