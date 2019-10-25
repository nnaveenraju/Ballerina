import ballerinax/java.jdbc;
import wso2/sfdc46;
import ballerina/config;


jdbc:Client db = new({
    url: "jdbc:mysql://localhost:3306/world",
    username: "root",
    password: "admin",
    poolOptions: {
        maximumPoolSize: 5
    }
});


sfdc46:SalesforceConfiguration sfdcConfig = {
    baseUrl: config:getAsString("EP_URL"),
    clientConfig: {
    accessToken: config:getAsString("ACCESS_TOKEN"),
    credentialBearer: "AUTH_HEADER_BEARER", // Values allowed: AUTH_HEADER_BEARER|POST_BODY_BEARER|NO_BEARER
    refreshConfig: {
        clientId: config:getAsString("CLIENT_ID"),
        clientSecret: config:getAsString("CLIENT_SECRET"),
        refreshToken: config:getAsString("REFRESH_TOKEN"),
        refreshUrl: config:getAsString("REFRESH_URL")
    }
    //,
    //secureSocketConfig: {
    //    trustStore: {
    //        path: config:getAsString("TRUSTSTORE_PATH"),
    //        password: config:getAsString("TRUSTSTORE_PASSWORD")
    //    }
    //}
    }
};

