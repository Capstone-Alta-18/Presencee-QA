Feature: User started to use Presencee feature "Dosen"

  @PresenceeAPI @DosenPresencee @CreateDosen
  Scenario: User create dosen
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "dosen" with method "POST" with payload below
      | name         | email                | nip        | image | phone        | user_id    |
      | Eliasz Moses| eliaszmoses@gmail.com | 2001243111| null  | 2001243111 | 563267194 |
    Then User verify status code is 201

  @PresenceeAPI @DosenPresencee @UpdateDosen
  Scenario: User update dosen
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "dosen" with method "POST" with payload below
      | name         | email                | nip        | image | phone      | user_id    |
      | Eliasz Moses| eliaszmoses@gmail.com | 2001243111 | null  | 2001243111 | 563267194 |
    Then User verify status code is 201

  @PresenceeAPI @DosenPresencee @GetPageDosen
  Scenario: User want to see get page of dosen
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User want to get page dosen
    Then User verify status code is 200

  @PresenceeAPI @DosenPresencee @GetSingleDosen
  Scenario: User want to get single dosen by ID
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "dosen" with method "GET" with payload below
      | path_variable  |
      | 7 |
    Then User verify status code is 200

  @PresenceeAPI @DosenPresencee @DeleteDosen
  Scenario: User want to delete dosen
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "dosen" with method "DELETE" with payload below
      | path_variable  |
      | 40 |
    Then User verify status code is 200