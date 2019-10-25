// import ballerina/task;
// import ballerina/io;
// import ballerina/time;

// public function main() {
    
//     readExcel();

//     int intervalMillis = 600000;

//     task:Scheduler timer = new({
//         intervalInMillis : intervalMillis,
//         initialDelayInMillis: 600000
//     });

//     var t1Attach = timer.attach(service1);

//     if (t1Attach is error) {
//         io:println(t1Attach.detail());
//         return;
//     }

//     var timerStart = timer.start();
//     if (timerStart is error){
//         io:println(timerStart.detail());
//     }

// }

// service service1 = service {
//     resource function onTrigger() {
//         io:println( time:toString(time:currentTime()) ,  " - Timer triggered....");
//     }
// };

