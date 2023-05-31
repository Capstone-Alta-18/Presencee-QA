Feature: Products service Alta Shop API

  @AltaShopAPI @ProductsAltaShop @GetAllProducts
  Scenario: User get all products
    Given User call an api "products" with method "GET"
    Then User verify response is match with json schema "allproducts.json"

  @AltaShopAPI @ProductsAltaShop @CreateANewProduct
  Scenario: User create a new product
    Given User call an api "auth/login" with method "POST" with payload below
      | email           | password      |
      | userEmail       | userPassword  |
    Then User verify status code is 200
    And User get auth token
    Given User is create a new product
    Then User verify status code is 200

  @AltaShopAPI @ProductsAltaShop @GetProductByID
  Scenario: User get product by id
    Given User call an api "auth/login" with method "POST" with payload below
      | email           | password      |
      | userEmail       | userPassword  |
    Then User verify status code is 200
    And User get auth token
    Given User get product by id
    Then User verify status code is 200

  @AltaShopAPI @ProductsAltaShop @DeleteAProduct
  Scenario: User delete a product
    Given User call an api "products/11291" with method "DELETE"
    Then User verify status code is 200
    Then User verify response is match with json schema "deleteaproduct.json"

  @AltaShopAPI @ProductsAltaShop @AssignAProductRating
  Scenario: User assign a product rating
    Given User call an api "auth/login" with method "POST" with payload below
      | email           | password      |
      | userEmail       | userPassword  |
    Then User verify status code is 200
    And User get auth token
    Given User is assign a product rating
    Then User verify status code is 200

  @AltaShopAPI @ProductsAltaShop @GetProductRatings
  Scenario: User get product ratings
    Given User call an api "products/11676/ratings" with method "GET"
    Then User verify response is match with json schema "getproductratings.json."

  @AltaShopAPI @ProductsAltaShop @CreateAComment
  Scenario: User create a comment for product
    Given User call an api "auth/login" with method "POST" with payload below
      | email           | password      |
      | userEmail       | userPassword  |
    Then User verify status code is 200
    And User get auth token
    Given User is create a comment for product
    Then User verify status code is 200

  @AltaShopAPI @ProductsAltaShop @GetProductComments
  Scenario: User can get product comments
    Given User call an api "products/11676/comments" with method "GET"
    Then User verify response is match with json schema "getproductcomments.json"