Feature: User want to know their room

  @PresenceeAPI @RoomPresencee @CreateRoom
  Scenario: User want to create their room
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "room" with method "POST" with payload below
    | name | location | code |
    | Room 7 | Building D | 30 |
    Then User verify status code is 201

  @PresenceeAPI @RoomPresencee @UpdateRoom
  Scenario: User want to update their room
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "room" with method "PUT" with payload below
      | name | location | code | path_variable |
      | Room 7 | Building D | 50 | 2 |
    Then User verify status code is 200

  @PresenceeAPI @RoomPresencee @GetPageRoom
  Scenario: User get page of their room
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User get page of their room
    Then User verify status code is 200

  @PresenceeAPI @RoomPresencee @GetSingleRoom
  Scenario: User get page of their room by id
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "room" with method "GET" with payload below
      | path_variable |
      | 2 |
    Then User verify status code is 200

  @PresenceeAPI @RoomPresencee @DeleteRoom
  Scenario: User delete room that not use anymore
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "room" with method "DELETE" with payload below
      | path_variable |
      | 3 |
    Then User verify status code is 200
