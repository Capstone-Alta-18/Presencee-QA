Feature: User started to use Presencee feature "Mahasiswa"

  @PresenceeAPI @MahasiswaPresencee @CreateMahasiswa
    Scenario: User create Mahasiswa
    Given User call an api "users/login" with method "POST" with payload below
      | email       | password         |
      | eliasemoses@gmail.com | 12345678  |
    Then User verify status code is 200
    And User get auth token
    Given User call an api "mahasiswa" with method "POST" with payload below
      | name         | email                | nim        | image | phone        | jurusan   | tahun_masuk | ipk  | user_id    |
      | Eliasz Moses| eliasemoses@gmail.com | 7193220000 | null  | 081264288080 | Akuntansi | 2019        | 3.87 | 2627144884 |
    Then User verify status code is 201