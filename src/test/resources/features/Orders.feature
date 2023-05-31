Feature: User doing an order at Alta Shop

  @AltaShopAPI @OrdersAltaShop @CreateANewOrder
  Scenario: User create a new order
    Given User call an api "auth/login" with method "POST" with payload below
      | email           | password      |
      | userEmail       | userPassword  |
    Then User verify status code is 200
    And User get auth token
    Given User is create a new order
    Then User verify status code is 200

  @AltaShopAPI @OrdersAltaShop @GetAllOrder
  Scenario: User get all order
    Given User call an api "auth/login" with method "POST" with payload below
      | email           | password      |
      | userEmail       | userPassword  |
    Then User verify status code is 200
    And User get auth token
    Given User get all order
    Then User verify status code is 200

  @AltaShopAPI @OrdersAltaShop @GetAllOrderByID
  Scenario: User get all order by ID
    Given User call an api "auth/login" with method "POST" with payload below
      | email           | password      |
      | userEmail       | userPassword  |
    Then User verify status code is 200
    And User get auth token
    Given User get all order by ID
    Then User verify status code is 200