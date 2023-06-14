Feature: User can see their Jurusan

  @PresenceeAPI @JurusanPresencee @CreateJurusan
  Scenario: User want to create their jurusan
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "jurusan" with method "POST" with payload below
      | name       | fakultas               |
      | Accounting | Faculty of Economics  |
    Then User verify status code is 201

  @PresenceeAPI @JurusanPresencee @UpdateJurusan
  Scenario: User want to update their jurusan info
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789 |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "jurusan" with method "PUT" with payload below
      | name       | fakultas         | path_variable |
      | Economics | Faculty of Economy | 1            |
    Then User verify status code is 200

  @PresenceeAPI @JurusanPresencee @GetPageJurusan
  Scenario: User want to get page jurusan
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User want to get page jurusan
    Then User verify status code is 200

  @PresenceeAPI @JurusanPresencee @GetSingleJurusan
  Scenario: User want to get page jurusan
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "jurusan" with method "GET" with payload below
      | path_variable  |
      | 1 |
    Then User verify status code is 200

  @PresenceeAPI @JurusanPresencee @DeleteJurusan
  Scenario: User want to delete jurusan
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "jurusan" with method "DELETE" with payload below
      | path_variable  |
      | 3 |
    Then User verify status code is 200