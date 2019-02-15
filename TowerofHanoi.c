#include <stdio.h>

int instruction_count=0;
void moveDisc(int n, char from, char to, char intermediatte); 

int main ()
{
    int numberOfDisc= 6;
     moveDisc(numberOfDisc,'A','C','B');    
     printf("number of moves: %d", instruction_count);
    return 0;
}

void moveDisc(int n, char from, char to, char intermediatte){
    instruction_count++;
    if(n == 1){  //break point   
        printf("Move disc %d from %c to %c \n" ,n, from, to);
    }
    else{
        moveDisc(n-1,from,intermediatte,to);
        printf("Move disc %d from %c to %c \n" ,n, from, to);
        moveDisc(n-1,intermediatte,to,from);
        
    }
}