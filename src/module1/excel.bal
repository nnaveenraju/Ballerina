// import ballerina/io;
// // import ballerinax/java;

// // function createRandomUUID() returns handle = @java:Method {
// //     name: "randomUUID",
// //     class: "org.apache.poi"
// // } external;


// type CSVFile record {
//     string name;
//     int age;
// };

// function readExcel() {

//     io:println("In excel file read....");
//     string strFile = "file.csv";
//     error | io:ReadableCSVChannel  rc = io:openReadableCsvFile(strFile);

//     if (rc is error){
//         io:println(rc.detail());
//     }else{
//         while (rc.hasNext()) {

//             var rcd  = rc.getNext();

//             if (rcd is string[]) {
//                 io:println("Name : ", rcd[0].toString());
//                 io:println("Age : ", rcd[1]);
//                 // foreach var item in rcd {
//                 //     io:println(item.toString());
//                 // }
//             }else{
//                 io:println("Error reading file");
//             }
            

//             io:println(rc.toString());

//         }
//     }
//     //io:ReadableCSVChannel rCsvChannel = check io:openReadableCsvFile(srcFileName);

// }