Feature: User can see their Jadwal

  @PresenceeAPI @JadwalPresencee @CreateJadwal
  Scenario: User want to create their new jadwal
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "jadwals" with method "POST" with payload below
      | matakuliah_id | room_id | sks | jam_mulai                  | jam_selesai                | name     | description          | user_id    | dosen_id |
      | 3             | 1       | 3   | 2023-06-10T16:40:46+08:00 | 2023-06-10T16:40:46+08:00 | Akuntansi | Ini bahasa akuntansi | 1987069877 | 4        |
    Then User verify status code is 201

  @PresenceeAPI @JadwalPresencee @UpdateJadwal
  Scenario: User want to update their jadwal info
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345 |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "jadwals" with method "PUT" with payload below
      | id          | matakuliah_id | room_id | sks | jam_mulai                | jam_selesai               | name          | description | user_id    | dosen_id |
      | 3318838912 | 1             | 1       | 3   | 2023-06-10T16:40:46+08:00 | 2023-06-10T16:40:46+08:00 |Jadwal 1 Test  | Test Jadwal | 3021669592 | 9       |
    Then User verify status code is 200

  @PresenceeAPI @JadwalPresencee @GetSingleJadwal
  Scenario: User want to get single jadwal by ID
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "jadwals" with method "GET" with payload below
      | path_variable  |
      | 2687533409 |
    Then User verify status code is 200

  @PresenceeAPI @JadwalPresencee @GetPageJadwal
  Scenario: User want to get page jadwal
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User want to get page jadwals
    Then User verify status code is 200

  @PresenceeAPI @JadwalPresencee @GetFilterJadwal
  Scenario: User want to get filter jadwal
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User want to get filter jadwal
    Then User verify status code is 200

  @PresenceeAPI @JadwalPresencee @DeleteJadwal
  Scenario: User want to delete jadwal
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "jadwals" with method "DELETE" with payload below
      | path_variable  |
      | 3303930005 |
    Then User verify status code is 200