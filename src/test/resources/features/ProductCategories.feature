Feature: Product categories at Alta Shop

  @AltaShopAPI @ProductCategoriesAltaShop @CreateACategory
  Scenario: User create a new category
    Given User call an api "auth/login" with method "POST" with payload below
      | email           | password      |
      | userEmail       | userPassword  |
    Then User verify status code is 200
    And User get auth token
    Given User is create a new category
    Then User verify status code is 200

  @AltaShopAPI @ProductCategoriesAltaShop @GetCategoryByID
  Scenario: User get product category by ID
    Given User call an api "auth/login" with method "POST" with payload below
      | email           | password      |
      | userEmail       | userPassword  |
    Then User verify status code is 200
    And User get auth token
    Given User get product category by ID
    Then User verify status code is 200

  @AltaShopAPI @ProductCategoriesAltaShop @GetAllCategories
  Scenario: User get all product categories
    Given User call an api "categories" with method "GET"
    Then User verify response is match with json schema "getallcategories.json"

  @AltaShopAPI @ProductCategoriesAltaShop @DeleteACategory
  Scenario: User get all product categories
    Given User call an api "categories/11312" with method "DELETE"
    Then User verify response is match with json schema "deleteacategory.json"