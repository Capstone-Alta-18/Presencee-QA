Feature: User can see their Jadwal

  @PresenceeAPI @JadwalPresencee @CreateJadwal
  Scenario: User want to create their new jadwal
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "jadwals" with method "POST" with payload below
      | matakuliah_id | room_id | sks | jam                       | name          | description | user_id | dosen_id |
      | 14             | 1       | 3   | 2023-06-10T16:40:46+08:00 | Agama | Ini matkul agama     | 404377324 | 9 |
    Then User verify status code is 201

  @PresenceeAPI @JadwalPresencee @UpdateJadwal
  Scenario: User want to update their jurusan info
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345 |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "jadwals" with method "PUT" with payload below
      | id  | matakuliah_id | room_id | sks | jam                       | name          | description | user_id | dosen_id |
      | 2512299123 | 14             | 1       | 3   | 2023-06-10T16:40:46+08:00 | Agama | Ini matkul agama     | 404377324 | 9 |
    Then User verify status code is 200

  @PresenceeAPI @JadwalPresencee @GetSingleJadwal
  Scenario: User want to get single jurusan
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "jadwals" with method "GET" with payload below
      | path_variable  |
      | 2512299123 |
    Then User verify status code is 200

  @PresenceeAPI @JadwalPresencee @GetPageJurusan
  Scenario: User want to get page jurusan
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User want to get page jadwals
    Then User verify status code is 200

  @PresenceeAPI @JadwalPresencee @GetFilterJurusan
  Scenario: User want to get single jurusan
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "jadwals" with method "GET" with payload below
      | path_variable  |
      | 7 |
    Then User verify status code is 200

  @PresenceeAPI @JadwalPresencee @DeleteJadwal
  Scenario: User want to delete jurusan
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "jurusan" with method "DELETE" with payload below
      | path_variable  |
      | 3 |
    Then User verify status code is 200