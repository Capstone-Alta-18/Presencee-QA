Feature: User can see their "Matakuliah"

  @PresenceeAPI @MatakuliahPresencee @CreateMatakuliah
    Scenario: User create their Matakuliah
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "matakuliah" with method "POST" with payload below
      | name       | date                 |
      | Mathematics | 2023-06-05T10:00:00Z |
    Then User verify status code is 201

  @PresenceeAPI @MatakuliahPresencee @UpdateMatakuliah
  Scenario: User update their Matakuliah
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "matakuliah" with method "PUT" with payload below
      | name     | email             | nip        | phone        | image | user_id   | path_variable |
      | Sunandar | sunan10@gmail.com | 934898498  | 08576768787  |  null    | 1644697485 | 6           |
    Then User verify status code is 200

  @PresenceeAPI @MatakuliahPresencee @GetPageMatakuliah
  Scenario: User can get page of their Matakuliah
    Given User call an api "users/login" with method "POST" with payload below
      | email                 | password |
      | eliasemoses@mail.com | 12345     |
    Then User verify status code is 200
    And User get auth token
    Given User get page of Matakuliah
    Then User verify status code is 200

  @PresenceeAPI @MatakuliahPresencee @GetSingleMatakuliah
  Scenario: User can get page by filling Matakuliah
    Given User call an api "users/login" with method "POST" with payload below
      | email                 | password |
      | eliasemoses@mail.com | 12345     |
    Then User verify status code is 200
    And User get auth token
    Given User get page of single Matakuliah
    Then User verify status code is 200

  @PresenceeAPI @MatakuliahPresencee @DeleteMatakuliah
  Scenario: User delete their subject in Matakuliah
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "matakuliah" with method "DELETE" with payload below
      | path_variable |
      | 4             |
    Then User verify status code is 200