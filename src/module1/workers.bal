import ballerina/io;
//import ballerina/runtime;
public function main() {
    io:println("Worker execution started");

    int[] arr = [1,2,3,4];
    execWorks(arr);
    //var rsl = wait {w1};
    //_ = wait {w1};    
    io:println("Worker execution finished");
}

function execWorks(int[] arr){
    fork {
        worker w1 {
            //io:println(arr);
            int n = 5;
            //n = <- w2;
            int sum = 0;
            foreach var i in 1...n {
                sum += i;
                io:println("W1 : sum of first ",i , " - : - " , n, " positive numbers = ", sum);
            }
        }
        
        worker w2 {
            //int i = 0;
            //i -> w1;  
            int n = 5;
            int sum = 0;
            foreach var i in 1...n {
                sum += i * i;
                io:println("W2 : sum of squares of first ", i, " - : - " , n ,
                    " positive numbers = ", sum);
            }
        }
    }

}