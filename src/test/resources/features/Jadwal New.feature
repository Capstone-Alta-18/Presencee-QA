Feature: User can see their Jadwal

  @PresenceeAPI @JadwalPresencee @CreateJadwalNew
  Scenario: User want to create their new jadwal
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@mail.com | 12345  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "jadwal" with method "POST" with payload below
      | matakuliah_id | room_id | sks | jam                       | name          | description | user_id | dosen_id |
      | 1             | 1       | 3   | 2023-06-10T16:40:46+08:00 | Jadwal 1 Test | ngaret      | 3021669592 | 2 |
    Then User verify status code is 201