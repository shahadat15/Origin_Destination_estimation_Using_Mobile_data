#include <stdio.h>
#include <stdlib.h>
#include<fstream.h>
#include <math.h>
#include <iostream>

#define TOWER_NUMBER 1360 // total number of tower
#define TOT_LINE 34//17099415 // total number of call entry in a day
#define USER_NUMBER 12//2873667 // no of user

short T_S[TOWER_NUMBER];

int odmatrix[1361][1361] = {NULL}; // od marix which will will calculate

FILE *data_source, * result;

/********************************Mobile Phone Data*****************************/
_int32 capacity = 0, user = 0;

typedef struct USER_NODE
	{
         int time; 
         short tower_number;	
         struct USER_NODE * next_call;
        }USER_NODE;
typedef struct USER_QUEUE
	{
         int number_of_calls;
         USER_NODE * first_call;
        }USER_QUEUE;

USER_QUEUE USERS[USER_NUMBER] = {NULL};
USER_NODE * p;
/********************************Mobile Phone Data*****************************/

int main ()
{
	_int32 userID =0 ,  user=0,  total_OD=0;
	int  time= 0,tower_number=0, date=0, temp_f=0, i=0, j=0,tower=0, user_number=1, usr=0;


printf("Mobile Phone Data...\n");


/* Data read from file*/

data_source=fopen("test.csv","r"); //input file contails call records data
capacity=0;

fscanf(data_source, "%d %d %d %d\n", &userID, &temp_f, &time, &tower_number);
		capacity++;
		user = userID;
		tower = tower_number;
	                        //printf("tower number %d\n",tower_number); //print 			
USERS[(user)].first_call = NULL;
		USERS[(user)].first_call=(USER_NODE *)malloc(sizeof(USER_NODE));
       	p=USERS[(user)].first_call;
              
			p->time=time;
	              p->tower_number=tower;
			p->next_call=(USER_NODE *)malloc(sizeof(USER_NODE));
              	p=p->next_call;
			USERS[(user)].number_of_calls++;

      	
	
	while(capacity<(TOT_LINE))
			{
	
		fscanf(data_source, "%d %d %d %d\n", &userID, &temp_f, &time, &tower_number);
	
		capacity++;
		
		if (userID == user)
		{
			p->time=time;
	              p->tower_number=tower_number;
			p->next_call=(USER_NODE *)malloc(sizeof(USER_NODE));
              	p=p->next_call;
			USERS[(user)].number_of_calls++;
			tower = tower_number;
		}
       	else 
{
		p=NULL;
		
		/* od estimation */

		int last_time = 0; //720000;
		int last_tower = 0; //1200;

		
		i= user;
		p=USERS[(i)].first_call;
		//printf("%d\n", USERS[i].first_call); //print 
		for(j=0;j<USERS[(i)].number_of_calls;j++)
		{
		if((j>0) && (((((p->time)-last_time))<= 72000000) && ((((p->time)-last_time))>=00)) && ((p->tower_number)!=last_tower)) /*&& (p->time)/3600<=15 && (p->time)/3600>=10 && (last_time)/3600<=15 && (last_time)/3600>=10 && (p->time-last_time)<=3600*/
		{
		odmatrix[last_tower][(p->tower_number)]+= 1;
		
		if (usr==user) 
		{

		}
		else
		{
			user_number++;
			usr = user;
		}

		//printf("%d %d\n", last_tower,(p->tower_number));//print
		}
		last_tower=(p->tower_number);
		last_time=(p->time);
		p=(p->next_call);
		}
		
		/* od estimation */
		
		p=NULL;
		user = userID;
tower = tower_number;		
USERS[(user)].first_call = NULL;
USERS[(user)].number_of_calls = NULL;

		USERS[(user)].first_call=(USER_NODE *)malloc(sizeof(USER_NODE));
       	p=USERS[(user)].first_call;
              
			p->time=time;
	              p->tower_number=tower_number;
			p->next_call=(USER_NODE *)malloc(sizeof(USER_NODE));
              	p=p->next_call;
			USERS[(user)].number_of_calls++;	
		}
	}
fclose(data_source);

ofstream myfile;
myfile.open ("OD_C.csv");
myfile<<"OD_Matrix: \n";
    
for(int k=1;k<1361;k++)
{
for (int l=1;l<1361;l++)
    {
	myfile<<odmatrix[k][l]<< ",	"; //Outputs array to txtFile /*k<<":"<<l<<"="<<*/
	total_OD = total_OD + odmatrix[k][l];
    }

myfile<<endl;
}

printf("%d\n", total_OD);
printf("%d\n", capacity);
printf("%d\n", user);
printf("%d\n", userID);
printf("%d\n", user_number);
return 0;

}