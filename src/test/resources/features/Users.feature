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
    Scenario: User update his/her information
    Given User call an api "users/" with method "PUT" with payload below
      | email                 | name         | password | telp       | role  |
      | dewabiara11@gmail.com | Dewa Biara   | 123456   | 0932352345 | admin |
