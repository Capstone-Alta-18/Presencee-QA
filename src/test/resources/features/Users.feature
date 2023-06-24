Feature: Users started to use Presencee

  @PresenceeAPI @UsersPresencee @Login
    Scenario: Users login to Presencee
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token

  @PresenceeAPI @UsersPresencee @LoginAdmin
  Scenario: Users login to Presencee
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token

  @PresenceeAPI @UsersPresencee @CreateUser
    Scenario: User trying to signup to Presencee
    Given User call an api "users/signup" with method "POST" with payload below
      | email                | name         | password | telp       | role  |
      | eliasemoses123@gmail.com | Elias Moses   | 123456789 | 082166297200 | admin |
    Then User verify status code is 201

  @PresenceeAPI @UsersPresencee @UpdateUser
    Scenario: User update their information
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "users/" with method "PUT" with payload below
      | email                | name         | password | telp       | role  |
      | eliasemoses123@gmail.com | Elias Moses   | 123456789 | 082166297200  | admin |
    Then User verify status code is 200

  @PresenceeAPI @UsersPresencee @GetPageUsers
    Scenario: User get page users
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User get page users
    Then User verify status code is 200

  @PresenceeAPI @UsersPresencee @GetSingleUser
    Scenario: User get their information by ID
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "users" with method "GET" with payload below
      | path_variable       |
      | 611073315          |
    Then User verify status code is 200
    Then User verify response is match with json schema "getsingleuserID.json"

  @PresenceeAPI @UsersPresencee @DeleteUser
    Scenario: User delete their own information
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "users" with method "DELETE" with payload below
      | path_variable       |
      | 663680983   |
    Then User verify status code is 200
    Then User verify response is match with json schema "deleteuserID.json"