//this is a simple file to test the cokus.cpp mersenne twister code.

//free code with no guarantee. No restrictions on usage
//written by: Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )

#define uint32 unsigned long
#define SMALL_INT char
#define SMALL_INT_CLASS mxCHAR_CLASS
extern void seedMT(uint32 seed);
extern uint32 randomMT(void);

#include "stdio.h"
#include "math.h"

//generate lots of random number and check if they are within the limits
//else cry about it

int main(void) {
    int j, k;
    
    // you can seed with any uint32, but the best are odds in 0..(2^32 - 1)
    
    seedMT(4357);
    uint32 MAX=pow(2, 32)-1;

// print the first 2,002 random numbers seven to a line as an example
//    for(j=0; j<2002; j++)
//        printf(" %10lu%s", (unsigned long) randomMT(), (j%7)==6 ? "\n" : "");
    
    double test_val;
    for(k=0;k<100;k++)
        for(j=0; j<2000002; j++) {
            test_val = ((double)randomMT()/(double)MAX);
            if (test_val>=1.0){
                printf("Problem");
                return(0);
            }
            //printf(" %f%s", test_val , (j%7)==6 ? "\n" : "");
        }
    printf("Success");
    return(1);
}
