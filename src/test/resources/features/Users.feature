Feature: Users started to use Presencee

  @PresenceeAPI @UsersPresencee @Login
    Scenario: Users login to Presencee
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | dewabiara11gmail.com | 123456  |
    Then User verify status code is 200
    And User get auth token

  @PresenceeAPI @UsersPresencee @CreateUser
    Scenario: User trying to signup to Presencee
    Given User call an api "users/signup" with method "POST" with payload below
      | email                | name         | password | telp       | role  |
      | dewabiara11gmail.com | Dewa Biara   | 123456 | 0932352345   | admin |
    Then User verify status code is 201

  @PresenceeAPI @UsersPresencee @UpdateUser
    Scenario: User update their information
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | dewabiara11gmail.com | 123456  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "users/" with method "PUT" with payload below
      | email                | name         | password | telp       | role  |
      | dewabiara11gmail.com | Dewa Biara   | 123456 | 0932352345   | admin |
    Then User verify status code is 200

  @PresenceeAPI @UsersPresencee @GetPageUsers
    Scenario: User get page users
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | dewabiara11gmail.com | 123456  |
    Then User verify status code is 200
    And User get auth token
    Given User get page users
    Then User verify status code is 200

  @PresenceeAPI @UsersPresencee @GetSingleUser
    Scenario: User get their information by ID
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | dewabiara11gmail.com | 123456  |
    Then User verify status code is 200
    And User get auth token
    Given User get their information by ID
    Then User verify status code is 200