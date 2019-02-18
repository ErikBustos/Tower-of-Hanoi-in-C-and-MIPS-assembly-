/*  Developers: Erik Bustos Montes de Oca
                Bernardo Elizondo Hernández
    Company:    ITESO
*/

#include <stdio.h>
#include <stdlib.h>

int numberOfDisc= 4;
int x = 0;
int *t1;
int *t2;
int *t3;
int * pTo;
int * pFrom;
void printTowers(int * t1, int * t2, int * t3);
void moveDisc(int n, int * from, int * to, int * intermediate); 
void moveValues(int * from, int * to);

int main ()
{
    /*We declare the towers in Dynamic Memory*/
    t1 = malloc(numberOfDisc*sizeof(int));
    t2 = malloc(numberOfDisc*sizeof(int));
    t3 = malloc(numberOfDisc*sizeof(int));    

    int n = numberOfDisc;
    int i = 0;

    /*We initialize the Tower#1 with all the discs and the rest with 0's*/
     for(i = 0; i < numberOfDisc; i++){
         t1[i] = n;
         t2[i] = 0;
         t3[i] = 0;
         n--;
     }

    printf("Original Tower\n");
    printTowers(t1, t2, t3);

    /*We start with our sorting Tower of Hanoi algorithm*/
    moveDisc(numberOfDisc, t1, t3, t2);   
    printf("\n\nTotal Moves: #%d", x);
    return 0;
}

void moveDisc(int n, int * from, int * to, int * intermediate){
    int i = 0;
    
    if(n == 1){  //break point   
        x++;
        printf("-----------Move#%d----------- \n", x);        
        moveValues(from, to);
        printTowers(t1, t2, t3);                
            
    }
    else{
        moveDisc(n-1,from,intermediate,to);  
        x++;
        printf("-----------Move#%d----------- \n", x);   
        moveValues(from, to);
        printTowers(t1, t2, t3); 
        moveDisc(n-1,intermediate,to,from);     
    }
}

/*Function that prints the current state of the towers*/
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

/*Function that moves the pointers of the from and to towers to the last position to 
be able to move the disc*/
void moveValues(int * from, int * to){
    int i;
    /*For that moves the to pointer to the position the new disc is going to be placed*/
    for(i = 0; i < numberOfDisc; i++){
        if(to[i]==0 && i == 0){
            pTo = &to[i];
            break;
        } else if(to[i]==0){
            pTo = &to[i];
            break;
        } else if(i==numberOfDisc-1){
            pTo = &to[i];
        } else {
            continue;
        }
    }

    /*For that moves the from pointer to the last disc*/
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

    /*We set the disc to the To tower and remove it from the From tower*/
    *pTo = *pFrom; 
    *pFrom = 0;         

    /*If the pointer is pointing to the first position of the array, 
    we keep it there, otherwise, we point to a previous memory address*/
    if(pFrom == &from[0]){
        pFrom == &from[0];
    } else {
        pFrom--;
    }
}