Feature: User started to use Presencee feature "Absen"

  @PresenceeAPI @AbsenPresencee @CreateAbsen
  Scenario: User create absen
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "absens" with method "POST" with payload below
      | user_id    | mahasiswa_id | jadwal_id | time_attemp               | matakuliah       | status | description         | location  | image     | is_konfirmasi |
      | 2500849527 | 13           | 1        |  2023-06-10T16:40:46+00:00 | Bahasa Indonesia | Sakit | Orang ini hadir guys | Indonesia | H3H3H3H3 | true           |
    Then User verify status code is 201

  @PresenceeAPI @AbsenPresencee @UpdateAbsen
  Scenario: User update absen
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "absens" with method "PUT" with payload below
      | id         | user_id    | mahasiswa_id | jadwal_id | time_attemp               | matakuliah       | status | description         | location  | image     | is_konfirmasi |
      | 3453170871 | 2500849527 | 13           | 1        |  2023-06-10T16:40:46+00:00 | Bahasa Indonesia | Sakit | Orang ini hadir guys | Indonesia | H3H3H3H3 | true           |
    Then User verify status code is 201

  @PresenceeAPI @AbsenPresencee @GetSingleAbsen
  Scenario: User want to get single absen
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "absens" with method "GET" with payload below
      | path_variable  |
      | 1816083000 |
    Then User verify status code is 200

  @PresenceeAPI @AbsenPresencee @GetPageAbsen
  Scenario: User want to see get page of absen
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User want to get page absen
    Then User verify status code is 200