import ballerina/http;
import ballerina/log;
//import ballerinax/java.jdbc;
//import ballerina/io;
import ballerina/config;
//import ballerina/jsonutils;
import ballerina/io;
import wso2/sfdc46;

//import ballerina/lang.'map;

//import ballerina/lang;

// By default, Ballerina exposes an HTTP service via HTTP/1.1.
service hello on new http:Listener(9090) {

    
    // Resource functions are invoked with the HTTP caller and the
    // incoming request as arguments.
    resource function sayHello(http:Caller caller, http:Request req) {
        // Send a response back to the caller.

        log:printInfo("EP_URL : " + config:getAsString("EP_URL"));


        log:printInfo("ACCESS_TOKEN : " + config:getAsString("ACCESS_TOKEN"));
        log:printInfo("CLIENT_ID : " + config:getAsString("CLIENT_ID"));
        log:printInfo("CLIENT_SECRET : " + config:getAsString("CLIENT_SECRET"));
        log:printInfo("REFRESH_TOKEN : " + config:getAsString("REFRESH_TOKEN"));
        log:printInfo("REFRESH_URL : " + config:getAsString("REFRESH_URL")); 

        var results =  sfdcConnection();

        //if (cities is table<worldCity>)
        //{
            //var jsonConversionRet = typedesc<json>.constructFrom(selectRet);
            //var jsonFromList = 'typedesc<json>.
         //   var jsonConversionRet = typedesc<json>.constructFrom(cities);
            
        //}


        // Log the `error` in case of a failure.
        var result = caller->respond(<@untainted> <json> results);
        //var result = jsonConversionRet.

        if (result is error) {
            log:printError("Error sending response", result);
        }
    }

    resource function getGPId(http:Caller caller, http:Request request) {
        
        http:Response res = new();

        string _emailId = request.getQueryParamValue("email").toString();
        io:println("Incoming email is : ", _emailId);

        var results = getGreatPlainsIDBasedOnEmail( <@untainted > _emailId);
        
        if (results.toString().toJsonString().length() <= 0){
            results = {
                status : "failed"
            };
            res.statusCode = 404;
        }

        res.setJsonPayload( <@untainted>  <json>  results);
        var respond = caller->respond(res);

    }

    // resource function getCities(http:Caller caller, http:Request request) {

    //     var citiesResult = db->select("select ID, Name,CountryCode, District, Population from city  limit 10;", worldCity);
    //     json cityJson= null;

    //     var cc = request.getQueryParamValues("cc");
    //     io:println(cc);

    //     http:Response  res = new;
        
    //     if (citiesResult is table<worldCity>) {
            
    //         cityJson = jsonutils:fromTable(citiesResult);
    //         io:println("JSON Data: ");
    //         //io:println(cityJson.toJsonString());
    //         res.setJsonPayload(cityJson);
    //     }
    //     else {
    //         error err = citiesResult;
    //         io:println("error from query: ", err.detail());
    //     }
        
    //     var results = caller->respond(res);
    // }
    
    
    resource function getCanvasAccounts(http:Caller caller, http:Request request) {

        http:Client canvasClient = new("https://floridatech.test.instructure.com/api/v1/");
        
        http:Request req = new;
        http:Response res = new;
        req.addHeader("Authorization","Bearer 10878~AlzZd");
        req.addHeader("Content-Type","application/json");

        var accountsResp = canvasClient->get("/accounts/1/courses", req);
        //var acccounts ;
        json responseOut;
        

        if (accountsResp is http:Response){

            //io:println(accountsResp.statusCode);
            
            var acccounts = accountsResp.getJsonPayload();
            json[] jAccounts = <json[]> acccounts;
            json[] jAccountsRep =[];
            json newAccount;

             //io:println(acccounts.toString());

             if (acccounts is json)
             {
                res.setJsonPayload( <@untainted> acccounts);
                int len = jAccounts.length();
                 
                foreach var item in jAccounts {
                    io:println("Item Name------ ", item.name);
                    newAccount= {
                        id : <int> item.id,
                        name : item.name.toString()
                    };
                    jAccountsRep.push(newAccount);
                }
            }

            res.setJsonPayload(jAccountsRep);

            io:println("HTTP Status codes: ", accountsResp.statusCode);
            //io:println("JSON Resonse", accountsResp.getJsonPayload().toString());
        }
        else{

        }

        var s = caller->respond(res);
    }

}

function getGreatPlainsIDBasedOnEmail( string _emailId) returns @tainted json | error? {

    log:printInfo("Getting GP ID based on Email.. : " + _emailId) ;

    sfdc46:Client sfd = new(sfdcConfig);

    sfdc46:SoqlResult sfResp = check sfd->getQueryResult("select  Id, GP_ID__pc FROM Account where PersonEmail = '" + _emailId + "' limit 1");
    
    //json[] jAccountsRep =[];
    json newAccount={};

    if (sfResp.done) {
        json queryResults = check json.constructFrom(sfResp);
        json[] jAccounts = <json[]> queryResults.records;

        io:println("GP ID: ", queryResults.toJsonString());
        foreach var accnt in jAccounts {
            newAccount = {
                id : accnt.Id.toString(),
                gpId : accnt.GP_ID__pc.toString()
            };
            //jAccountsRep.push(newAccount);
        }
    }
    return  newAccount;
}


function sfdcConnection() returns @tainted json | error? {

        log:printInfo("Inside SFDC Function..");    
        sfdc46:Client sfClient = new(sfdcConfig);

        //sfdc46:SoqlResult sfResponse = sfClient->getQueryResult("select name from Account limit 10");
        var queryRecieved = "select name from Account limit 10";
        //json|wso2/sfdc46:SoqlResult sfResponse = sfClient->getQueryResult(<@untainted>queryRecieved);
        
        sfdc46:SoqlResult sfResponse = check sfClient->getQueryResult(<@untainted> queryRecieved);


        json queryResult = check json.constructFrom(sfResponse);

        //sfdc46:HttpResponseHandlingError = sfClient->getQueryResult("select name from Account limit 10");
        //sfdc46: :SoqlResult|sfdc46:ConnectorError response = sfClient->getQueryResult("select name from Account limit 10");

        log:printInfo(sfResponse.toString());
        
        io:println(queryResult.toJsonString());

        return queryResult;
        
        // if (sfResponse is error){
        //     log:printInfo("Issue with sfdc");
        // }
        // else {            
        //     io:println(sfResponse.
        //     log:printError( "SFDC Error: " ); //+ sfResponse.detail()?.message.toString() );
        // }
        
    }