// import ballerina/io;
// import ballerinax/java;
 

// public function main() {

// string str = "ahdhd,hghg,gjrgjr,gjrg,hgrg";

// handle rec = java:fromString(str);

// string delimeter = ",";

// handle del = java:fromString(delimeter);
 

// handle arr = split(rec, del);
 

// io:println(java:getArrayElement(arr, 0));

// io:println(java:getArrayElement(arr, 2));

// }
 

// function split(handle receiver, handle delimeter) returns handle = @java:Method {

//     //[name: "split"],

// class: "java.lang.String"

// } external;



// import ballerinax/java;
// import ballerina/io;
 
// function createRandomUUID() returns handle = @java:Method {
//     name: "randomUUID",
//     class: "java.util.UUID"
// } external;
 
// public function main() {
//     var uuid = createRandomUUID();
//     io:println(uuid);
// }
