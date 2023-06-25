package starter.stepdefinitions;

import com.github.javafaker.Faker;
import com.github.javafaker.File;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.restassured.response.Response;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.rest.abilities.CallAnApi;
import net.serenitybdd.screenplay.rest.interactions.Delete;
import net.serenitybdd.screenplay.rest.interactions.Get;
import net.serenitybdd.screenplay.rest.interactions.Post;
import net.serenitybdd.screenplay.rest.interactions.Put;

import org.json.simple.JSONObject;
import starter.data.User;


import java.util.List;
import java.util.Locale;
import java.util.Map;

import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchemaInClasspath;


public class PresenceeStepDefinitions {
    String baseURL = "http://testing.biaracmpny.my.id/v1/";
    User user = new User();
    //code untuk memperoleh token dari respons API

    @Then("{actor} verify status code is {int}")
    public void userVerifyStatusCodeIs(Actor actor, int statusCode) {
        Response response = SerenityRest.lastResponse();
        response.then().log().all().statusCode(statusCode);
    }

    @Given("{actor} call an api {string} with method {string} with payload below")
    public void CallAnApi(Actor actor, String path, String method, DataTable table) {
        actor.whoCan(CallAnApi.at(baseURL));

        // Create request body json instance
        JSONObject bodyRequest = new JSONObject();

        // Get headers
        List<List<String>> rowsList = table.asLists(String.class);
        List<String> headerList = rowsList.get(0);

        // Get values
        List<Map<String, String>> rowsMap = table.asMaps(String.class, String.class);
        Map<String, String> valueList = rowsMap.get(0);

        // Loop on every values and set value with key from header to request body
        for (int i = 0; i < valueList.size(); i++) {
            Faker faker = new Faker(new Locale("in=ID"));

            String key = headerList.get(i);

            switch (valueList.get(key)) {
                case "randomEmail": {
                    String randomEmail = faker.internet().emailAddress();
                    bodyRequest.put(key, randomEmail);
                    user.setEmail(randomEmail);
                    break;
                }
                case "randomPassword": {
                    String randomPassword = faker.internet().password();
                    bodyRequest.put(key, randomPassword);
                    user.setPassword(randomPassword);
                    break;
                }
                case "randomFullname": {
                    String randomFullname = faker.name().fullName();
                    bodyRequest.put(key, randomFullname);
                    user.setFullName(randomFullname);
                    break;
                }
                case "user_id": {
                    String randomUserIdString = valueList.get(key);
                    int randomUserId = Integer.parseInt(randomUserIdString);
                    bodyRequest.put(key, 123456);
                    user.setUserId(String.valueOf(randomUserId));
                    break;
                }

                case "randomProductName":
                    bodyRequest.put(key, faker.commerce().productName());
                    break;
                case "randomProductDescription":
                    bodyRequest.put(key, faker.lorem().sentence());
                    break;
                case "userEmail":
                    bodyRequest.put(key, user.getEmail());
                    break;
                case "userPassword":
                    bodyRequest.put(key, user.getPassword());
                    break;
                case "userInformation":
                    bodyRequest.put(key, user.getInformation());
                    break;
                default:
                    if (key.equals("user_id")) {
                        bodyRequest.put(key, Integer.parseInt(valueList.get(key)));
                    } else {
                        bodyRequest.put(key, valueList.get(key));
                    }
                    break;
            }
        }

        switch (method) {
            case "GET":
                if (headerList.get(0).equals("path_variable")) {
                    path = path+"/"+valueList.get("path_variable");
                }
                actor.attemptsTo(Get.resource(path).with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
                break;
            case "POST":
                if (headerList.get(headerList.size()-1).equals("path_variable")) {
                    path = path + "/" + valueList.get("path_variable");
                    bodyRequest.remove("path_variable");
                }
                actor.attemptsTo(Post.to(path).with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
                break;
            case "PUT":
                if (headerList.get(headerList.size()-1).equals("path_variable")) {
                    path = path + "/" + valueList.get("path_variable");
                    bodyRequest.remove("path_variable");
            }
                actor.attemptsTo(Put.to(path).with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
                break;
            case "DELETE":
                if (headerList.get(0).equals("path_variable")) {
                    path = path+"/"+valueList.get("path_variable");
                }
                actor.attemptsTo(Delete.from(path).with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
                break;
            default:
                throw new IllegalStateException("Unknown method");
        }
    }

    @And("{actor} get auth token")
    public void userGetAuthToken(Actor actor) {
        Response response = SerenityRest.lastResponse();
        user.setToken(response.path("token"));
    }
    @Given("{actor} get page users")
    public void userGetPageUsers(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        actor.attemptsTo(Get.resource("users").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @Then("{actor} verify response is match with json schema {string}")
    public void userVerifyResponse(Actor actor, String schema) {
        Response response = SerenityRest.lastResponse();
        response.then().body(matchesJsonSchemaInClasspath(schema));
    }

    @Given("{actor} get page of Matakuliah")
    public void userGetPageOfMatakuliah(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        actor.attemptsTo(Get.resource("matakuliah").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @Given("{actor} get page of single Matakuliah")
    public void userGetPageOfSingleMatakuliah(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        actor.attemptsTo(Get.resource("matakuliah").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @Given("{actor} want to get page jurusan")
    public void userWantToCreateTheirJurusan(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        actor.attemptsTo(Get.resource("jurusan").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @Given("{actor} get page of their room")
    public void userGetTheirRoomPage(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        actor.attemptsTo(Get.resource("room").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @Given("{actor} want to get page mahasiswa")
    public void userWantToGetPageMahasiswa(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        actor.attemptsTo(Get.resource("mahasiswa").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @Given("{actor} want to get page dosen")
    public void userWantToGetPageDosen(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        actor.attemptsTo(Get.resource("dosen").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @Given("{actor} want to get page jadwals")
    public void userWantToGetPageJadwals(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        actor.attemptsTo(Get.resource("jadwals").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @Given("{actor} want to get page absen")
    public void userWantToGetPageAbsen(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        actor.attemptsTo(Get.resource("absens").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @Given("{actor} want to get filter absen")
    public void userWantToGetFilterAbsen(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        actor.attemptsTo(Get.resource("absens").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @And("{actor} upload the image")
    public void userInputTheImage(Actor actor, String image) {
        actor.whoCan(CallAnApi.at(baseURL));

    }

    @Given("{actor} want to get riwayat")
    public void userWantToGetRiwayat(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        actor.attemptsTo(Get.resource("absens/riwayat?page=1&limit=10&absen_id=0&user_id=0&mahasiswa_id=2&jadwal_id=0&created_after=2023-06-02T15:04:05Z&created_before=2023-06-20T15:04:05Z&is_konfirmasi=true").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @Given("{actor} want to get riwayat dashboard")
    public void userWantToGetRiwayatDashboard(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        actor.attemptsTo(Get.resource("absens/dashboard?page=1&limit=10&absen_id=0&user_id=0&mahasiswa_id=0&jadwal_id=0&created_after=2023-06-02T15:04:05Z&created_before=2023-06-20T15:04:05Z&is_konfirmasi=true").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));

    }

    @Given("{actor} want to get filter jadwal")
    public void userWantToGetFilterJadwal(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        actor.attemptsTo(Get.resource("jadwals").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }
}
