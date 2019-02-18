/*  Developers: Erik Bustos Montes de Oca
                Bernardo Elizondo Hernández
    Company:    ITESO
*/

#include <stdio.h>
#include <stdlib.h>

int instruction_count=0;
int numberOfDisc= 6;
int x = 0;
int *t1;
int *t2;
int *t3;
int * pTo;
int * pFrom;
int * pInter;
void printTowers(int * t1, int * t2, int * t3);
void moveDisc(int n, int * from, int * to, int * intermediate); 
void moveValues(int * from, int * to, int * intermediate);

int main ()
{

    t1 = malloc(numberOfDisc*sizeof(int));
    t2 = malloc(numberOfDisc*sizeof(int));
    t3 = malloc(numberOfDisc*sizeof(int));    

    int x = numberOfDisc;
    int i = 0;

     for(i = 0; i < numberOfDisc; i++){
         t1[i] = x;
         t2[i] = 0;
         t3[i] = 0;
         x--;
     }

    printf("Original Tower\n");
    printTowers(t1, t2, t3);

    moveDisc(numberOfDisc, t1, t3, t2);       
    return 0;
}

void moveDisc(int n, int * from, int * to, int * intermediate){
    instruction_count++;
    int i = 0;
    
    if(n == 1){  //break point   
        x++;
        printf("-----------Move#%d----------- \n", x);        
        moveValues(from, to, intermediate);
        printTowers(t1, t2, t3);                
            
    }
    else{
        moveDisc(n-1,from,intermediate,to);  
        x++;
        printf("-----------Move#%d----------- \n", x);   
        moveValues(from, to, intermediate);
        printTowers(t1, t2, t3); 
        moveDisc(n-1,intermediate,to,from);     
    }
}

void printTowers(int * t1, int * t2, int * t3){
    int i = 0;

    printf("Torre #1: ");
    for(i = 0; i < numberOfDisc; i++){
        printf("%d ", t1[i]);
    }

    printf("\nTorre #2: ");
    for(i = 0; i < numberOfDisc; i++){
        printf("%d ", t2[i]);
    }

    printf("\nTorre #3: ");
    for(i = 0; i < numberOfDisc; i++){
        printf("%d ", t3[i]);
    }
    printf("\n");
}

void moveValues(int * from, int * to, int * intermediate){
    int i;
    for(i = 0; i < numberOfDisc; i++){
            if(to[i]==0 && i == 0){
                pTo = &to[i];
                break;
            } else if(to[i]==0){
                pTo = &to[i-1];
                break;
            } else if(i==numberOfDisc-1){
                pTo = &to[i];
            } else {
                continue;
            }
        }

        for(i = 0; i < numberOfDisc; i++){
            if(from[i]==0 && i == 0){
                pFrom = &from[i];
                break;
            } else if(from[i]==0){
                pFrom = &from[i-1];
                break;
            } else if(i==numberOfDisc-1) {
                pFrom = &from[i];
            } else {
                continue;
            }          
        }

        for(i = 0; i < numberOfDisc; i++){
            if(intermediate[i]==0 && i == 0){
                pInter = &intermediate[i];
                break;
            } else if(intermediate[i]==0){
                pInter = &intermediate[i-1];
                break;
            } else if(i==numberOfDisc-1) {
                pInter = &intermediate[i];
            } else {
                continue;
            }          
        }

        if(to[0] != 0){
            pTo++;
        } 

        *pTo = *pFrom; 
        *pFrom = 0; 
        

        if(pFrom == &from[0]){
            pFrom == &from[0];
        } else {
            pFrom--;
        }
}