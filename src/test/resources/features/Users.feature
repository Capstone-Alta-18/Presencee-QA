Feature: Users started to use Presencee

  @PresenceeAPI @UsersPresencee @Login
    Scenario: Users login to Presencee
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token

  @PresenceeAPI @UsersPresencee @LoginAdmin
  Scenario: Users login as admin to Presencee
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token

  @PresenceeAPI @UsersPresencee @CreateUser
    Scenario: User trying to signup to Presencee
    Given User call an api "users/signup" with method "POST" with payload below
      | email                    | name           | password | telp         | role  |
      | eliasemoses123@gmail.com | Elias Moses   | 123456789 | 082166297200 | admin |
    Then User verify status code is 201

  @PresenceeAPI @UsersPresencee @UpdateUser
    Scenario: User update their information
    Given User call an api "users/login" with method "POST" with payload below
      | email                    | password         |
      | eliasemoses123@gmail.com | 123456789        |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "users" with method "PUT" with payload below
      | email                    | name           | password | telp         | role   | path_variable |
      | eliasemoses123@gmail.com | Elias Moses   | 123456789 | 082166297200 | admin | 3978709925 |
    Then User verify status code is 200

  @PresenceeAPI @UsersPresencee @GetPageUsers
  Scenario: User want to see get page of users
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User want to get page users
    Then User verify status code is 200

  @PresenceeAPI @UsersPresencee @GetSingleUsers
    Scenario: User get single users by ID
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "users" with method "GET" with payload below
      | path_variable       |
      | 2528456496          |
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
      | 753383101 |
    Then User verify status code is 200
    Then User verify response is match with json schema "deleteuserID.json"