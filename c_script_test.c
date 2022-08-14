#include<stdio.h>     
#include<unistd.h>

int main(void)            
{
    printf("C code is now running");
    fflush(stdout);
    sleep(1);
    printf("\rC code is now running.");
    fflush(stdout);
    sleep(1);
    printf("\rC code is now running..");
    fflush(stdout);
    sleep(1);
    printf("\rC code is now running...");
    fflush(stdout);
    sleep(1);
    printf("\rCode is done");
    fflush(stdout);
    printf("\n");
    return 0;
}
