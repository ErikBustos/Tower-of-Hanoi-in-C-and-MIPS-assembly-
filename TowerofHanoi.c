/*  Developers: Erik Bustos Montes de Oca
                Bernardo Elizondo Hernández
    Company:    ITESO
*/

#include <stdio.h>
#include <stdlib.h>

int instruction_count=0;
int numberOfDisc= 3;
void printTowers(int * t1, int * t2, int * t3, int n);
void moveDisc(int n, int * from, int * to, int * intermediate, int * pFrom, int * pTo, int * pInter, int * copia, int * t1, int * t2, int * t3); 

int main ()
{

    int *t1 = malloc(numberOfDisc*sizeof(int));
    int *t2 = malloc(numberOfDisc*sizeof(int));
    int *t3 = malloc(numberOfDisc*sizeof(int));    

    int *p1;
    int *p2;
    int *p3; 
    int *copia;

    int x = numberOfDisc;
    int i = 0;

     for(i = 0; i < numberOfDisc; i++){
         t1[i] = x;
         t2[i] = 0;
         t3[i] = 0;
         x--;
     }

    p1 = &t1[numberOfDisc - 1];
    p2 = &t2[0];
    p3 = &t3[0];

    printf("p1: %d, p2: %d, p3: %d\n", *p1, *p2, *p3);

    printTowers(t1, t2, t3, numberOfDisc);

    moveDisc(numberOfDisc, t1, t3, t2, p1, p2, p3, copia, t1, t2, t3);    
    printf("Number of moves: %d\n", instruction_count);

    printTowers(t1, t2, t3, numberOfDisc);

   
    return 0;
}

void moveDisc(int n, int * from, int * to, int * intermediate, int * pFrom, int * pTo, int * pInter, int * copia, int * t1, int * t2, int * t3){
    instruction_count++;
    int i = 0;
    if(n == 1){  //break point   
        printf("Fue igual a 1\n");
        printf("Move disc %d from %c to %c \n" ,n, from, to);
        pTo[0] = pFrom[0]; 
        pFrom[0] = 0;

        for(i = 0; i < numberOfDisc; i++){
            if(to[i]==0 && i == 0){
                pTo = &to[i];
            } else if(to[i]==0){
                pTo = &to[i-1];
            } else {
                pTo = &to[i];
            }
        }

        for(i = 0; i < numberOfDisc; i++){
            if(from[i]==0 && i == 0){
                pFrom = &from[i];
            } else if(to[i]==0){
                pFrom = &from[i-1];
            } else {
                pFrom = &from[i];
            }
        }
        /*
        pTo[n] = pFrom[n];
        rom[n] = 0;  */
        printTowers(t1, t2, t3, numberOfDisc);      
    }
    else{
        copia = pInter;
        pInter = pTo;
        pTo = copia;
        moveDisc(n-1,from,intermediate,to, pFrom, pTo, pInter, copia, t1, t2, t3);
        printf("Move disc %d from %c to %c \n" ,n, from, to);
        for(i = 0; i < numberOfDisc; i++){
            if(to[i]==0 && i == 0){
                pTo = &to[i];
            } else if(to[i]==0){
                pTo = &to[i-1];
            } else {
                pTo = &to[i];
            }
        }

        for(i = 0; i < numberOfDisc; i++){
            if(from[i]==0 && i == 0){
                pFrom = &from[i];
            } else if(to[i]==0){
                pFrom = &from[i-1];
            } else {
                pFrom = &from[i];
            }
        }
        printTowers(t1, t2, t3, numberOfDisc); 
        copia = pFrom;
        pFrom = pInter;
        pInter = copia;
        moveDisc(n-1,intermediate,to,from, pFrom, pTo, pInter, copia, t1, t2, t3); 
        for(i = 0; i < numberOfDisc; i++){
            if(to[i]==0 && i == 0){
                pTo = &to[i];
            } else if(to[i]==0){
                pTo = &to[i-1];
            } else {
                pTo = &to[i];
            }
        }

        for(i = 0; i < numberOfDisc; i++){
            if(from[i]==0 && i == 0){
                pFrom = &from[i];
            } else if(to[i]==0){
                pFrom = &from[i-1];
            } else {
                pFrom = &from[i];
            }
        }       
    }
    
    /*
    
    instruction_count++;
    if(n == 1){  //break point   
        printf("Fue igual a 1\n");
        printf("Move disc %d from %c to %c \n" ,n, from, to);
        t3[n] = t1[n];
        t1[n] = 0;  
        printTowers(t1, t2, t3, numberOfDisc);      
    }
    else{
        moveDisc(n-1,from,intermediatte,to, t1, t2, t3);
        printf("Move disc %d from %c to %c \n" ,n, from, to);
        moveDisc(n-1,intermediatte,to,from, t1, t2, t3);
        
    }
    */
}

void printTowers(int * t1, int * t2, int * t3, int n){
    int i = 0;

    printf("Torre #1: ");
    for(i = 0; i < n; i++){
        printf("%d ", t1[i]);
    }

    printf("\nTorre #2: ");
    for(i = 0; i < n; i++){
        printf("%d ", t2[i]);
    }

    printf("\nTorre #3: ");
    for(i = 0; i < n; i++){
        printf("%d ", t3[i]);
    }
    printf("\n");
}