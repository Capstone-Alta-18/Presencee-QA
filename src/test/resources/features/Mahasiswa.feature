Feature: User started to use Presencee feature "Mahasiswa"

  @PresenceeAPI @MahasiswaPresencee @CreateMahasiswa
    Scenario: User create Mahasiswa
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "mahasiswa" with method "POST" with payload below
      | name         | email                | nim        | image | phone        | jurusan   | tahun_masuk | ipk  | user_id    |
      | Eliasz Moses| eliaszmoses@gmail.com | 7193220000 | null  | 081364287070 | Akuntansi | 2019        | 3,78 | 563267194 |
    Then User verify status code is 201

  @PresenceeAPI @MahasiswaPresencee @UpdateMahasiswa
    Scenario: User update Mahasiswa
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses123@gmail.com | 123456789  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "mahasiswa" with method "POST" with payload below
      | name         | email                | nim        | image | phone        | jurusan   | tahun_masuk | ipk  | user_id    |
      | Eliasz Moses| eliaszmoses@gmail.com | 7193220000 | null  | 081364287070 | Akuntansi | 2019        | 3,78 | 563267194 |
    Then User verify status code is 201