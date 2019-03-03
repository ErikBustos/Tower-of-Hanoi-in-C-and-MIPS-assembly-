/*
 * NewTowerOfHanoi.c
 *
 *      DEVELOPERS: Erik Bustos M, Bernardo Elizondo
 *
 */

#include <stdlib.h>
#include <stdio.h>

int numberOfDisc= 3;
int x = 0;
int *t1;
int *t2;
int *t3;

//functions
void printTowers(int * t1, int * t2, int * t3);
void moveDisc(int n, int * from, int * to, int * intermediate);
int pop(int tower[]);
void push(int tower[], int value) ;

int main(){
    /*We declare the towers in Dynamic Memory*/
    t1 = malloc(numberOfDisc*sizeof(int));
    t2 = malloc(numberOfDisc*sizeof(int));
    t3 = malloc(numberOfDisc*sizeof(int));

    int n = numberOfDisc;
    /*We initialize the Tower#1 with all the discs and the rest with 0's*/
     for(int i = 0; i < numberOfDisc; i++){
         t1[i] = n;
         t2[i] = 0;
         t3[i] = 0;
         n--;
     }

     printf("Original Tower\n");
     printTowers(t1, t2, t3);

     moveDisc(numberOfDisc, t1, t3, t2);
     printf("\n\nTotal Moves: #%d number of disc: %d", x, numberOfDisc);
}

void moveDisc(int n, int * from, int * to, int * intermediate){
	if(n==1){ //break point
		x++;
		printf("-----------Move#%d----------- \n", x);

		int temp=pop(from); //pop the top of the tower
		push(to, temp); // put it in the top of the tower
		printTowers(t1, t2, t3);
	}else{
		moveDisc(n-1,from, intermediate, to);
		x++;
		printf("-----------Move#%d----------- \n", x);
		int temp= pop(from);
		push(to,temp);
		printTowers(t1, t2, t3);
		moveDisc(n-1,intermediate, to, from);
	}
}
	//function that pop the top value of the tower
	int pop(int tower[]) {
		int temp = 0;
		int i = numberOfDisc - 1;
		while(i >= 0) {
			if(tower[i] != 0) {
				temp = tower[i];
				tower[i] = 0;
				break;
			}
			i = i - 1;
		}
		return temp;
	}

	//function that push in the top of the tower the value
	void push(int tower[], int value) {
		int i = 0;
		while(i < numberOfDisc) {
			if(tower[i] == 0) {
				tower[i] = value;
				break;
			}
			i = i + 1;
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



