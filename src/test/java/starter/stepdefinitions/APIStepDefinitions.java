package starter.stepdefinitions;

import com.github.javafaker.Faker;
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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import starter.data.User;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchemaInClasspath;

public class APIStepDefinitions {
    String baseURL = "https://altashop-api.fly.dev/api/";
    User user = new User();
    //code untuk memperoleh token dari respons API


    @Given("{actor} call an api {string} with method {string}")
    public void callAPI(Actor actor, String path, String method) {
        actor.whoCan(CallAnApi.at(baseURL));

        switch (method) {
            case "GET":
                actor.attemptsTo(Get.resource(path));
                break;
            case "POST":
                actor.attemptsTo(Post.to(path));
                break;
            case "PUT":
                actor.attemptsTo(Put.to(path));
                break;
            case "DELETE":
                actor.attemptsTo(Delete.from(path));
                break;
            default:
                throw new IllegalStateException("Unknown method");
        }
    }

    @Then("{actor} verify response is match with json schema {string}")
    public void userVerifyResponseIsMatchWithJsonSchema(Actor actor, String schema) {
        Response response = SerenityRest.lastResponse();
        response.then().body(matchesJsonSchemaInClasspath(schema));
    }

    @Then("{actor} verify status code is {int}")
    public void userVerifyStatusCodeIs(Actor actor, int statusCode) {
        Response response = SerenityRest.lastResponse();
        response.then().statusCode(statusCode).log().all();
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
                    bodyRequest.put(key, valueList.get(key));
                    break;
            }
        }

        switch (method) {
            case "GET":
                actor.attemptsTo(Get.resource(path));
                break;
            case "POST":
                actor.attemptsTo(Post.to(path).with(request -> request.body(bodyRequest).log().all()));
                break;
            case "PUT":
                actor.attemptsTo(Put.to(path).with(request -> request.body(bodyRequest)));
                break;
            case "DELETE":
                actor.attemptsTo(Delete.from(path));
                break;
            default:
                throw new IllegalStateException("Unknown method");
        }
    }

    @Given("{actor} get other users information")
    public void getOtherUsersInformation(Actor actor) {

        actor. whoCan(CallAnApi.at(baseURL));
        actor.attemptsTo(Get.resource("auth/info")
                        .with(request -> request.header("Authorization", "Bearer " + user.getToken()).log().all()));
    }

    @Given("{actor} is create a new product")
    public void userIsCreateANewProduct(Actor actor) {
        Faker faker = new Faker(new Locale("in=ID"));
        actor.whoCan(CallAnApi.at(baseURL));

        JSONObject bodyRequest = new JSONObject();

        List<Integer> listCategories = new ArrayList<>();
        listCategories.add(0,1);



        bodyRequest.put("name", faker.commerce().productName());
        bodyRequest.put("description", faker.lorem().sentence());
        bodyRequest.put("price", 200);
        bodyRequest.put("categories",listCategories);

        actor.attemptsTo(Post.to("products").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @And("{actor} get auth token")
    public void userGetAuthToken(Actor actor) {
        Response response = SerenityRest. lastResponse();
        user.setToken(response.path("data"));
    }

    @Given("{actor} get product by id")
    public void userGetProductById(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();

        actor.attemptsTo(Get.resource("products/13393").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @Given("{actor} is assign a product rating")
    public void userIsAssignAProductRating(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));

        JSONObject bodyRequest = new JSONObject();

        bodyRequest.put("count", 4);

        actor.attemptsTo(Post.to("products/13393/ratings").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));

    }

    @Given("{actor} is create a comment for product")
    public void userIsCreateACommentForProduct(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));

        JSONObject bodyRequest = new JSONObject();

        bodyRequest.put("content", "the games are great including Gran Turismo 7 but sadly GT4 is much better");

        actor.attemptsTo(Post.to("products/11676/comments").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @Given("{actor} is create a new order")
    public void userIsCreateANewOrder(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        JSONArray jsonArrayWrapper = new JSONArray();

        bodyRequest.put("product_id",2);
        bodyRequest.put("quantity",1);
        System.out.println(bodyRequest);
        System.out.println(jsonArrayWrapper);
        jsonArrayWrapper.add(bodyRequest);

        actor.attemptsTo(Post.to("orders").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(jsonArrayWrapper).log().all()));
    }

    @Given("{actor} get all order")
    public void userGetAllOrder(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        JSONArray jsonArrayWrapper = new JSONArray();
        System.out.println(jsonArrayWrapper);
        jsonArrayWrapper.add(bodyRequest);

        actor.attemptsTo(Get.resource("orders").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(jsonArrayWrapper).log().all()));
    }

    @Given("{actor} get all order by ID")
    public void userGetAllOrderByID(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();
        JSONArray jsonArrayWrapper = new JSONArray();
        System.out.println(jsonArrayWrapper);
        jsonArrayWrapper.add(bodyRequest);

        actor.attemptsTo(Get.resource("orders/10252").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(jsonArrayWrapper).log().all()));
    }

    @Given("{actor} is create a new category")
    public void userIsCreateANewCategory(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();

        bodyRequest.put("name", "gaming");
        bodyRequest.put("description", "for gaming purposes");

        actor.attemptsTo(Post.to("categories").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));

    }

    @Given("{actor} get product category by ID")
    public void userGetProductCategoryByID(Actor actor) {
        actor.whoCan(CallAnApi.at(baseURL));
        JSONObject bodyRequest = new JSONObject();

        actor.attemptsTo(Get.resource("categories/12563").with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));

    }


}
