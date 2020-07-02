#include <fstream>
#include <iostream>
#include <sstream>
#include <string.h>
#include<cmath>
using namespace std;

class Students
{
protected:
	string name;
	int values[20];
	int k = size(values);

public:
	Students(string file, int x[20])
	{
		name = file;
		for (int i = 0; i < k; i++)
		{
			values[i] = x[i];
		}
	}
	Students()
	{
		name = "";
		for (int i = 0; i < k; i++)
		{
			values[i] = 0;
		}
	}
	void setName(string n)
	{
		name = n;
	}
	string getName()
	{
		return name;
	}
	int getValues(int i)
	{
		return values[i];//access each element of the array
	}
	void setValues(int x, int index)
	{
		values[index] = x;
	}
};
int main()
{
	double top_sum=0, bot_sum=0, top_dev=0, bot_dev=0;
	int num = 26;//27 student average
	int sum_Q[20] = { 0 }, dev_Q[20] = { 0};
	
	fstream fin; 
	fin.open("Scores.csv");

	Students test[31];//dynamic array to store values! (Sentinel must find end of file so, so the last 5 indices are always empty!!!!!!)
	string s = "";
	int student = 0, question = 1, cycle = 21, adj = question, current_q;//indexers
	int  x = 0;//value storage
	stringstream converter;

	while (fin.good())
	{
		getline(fin, s, '\n');
		current_q = question % cycle;
		if (current_q == 0)
		{
			question++;//there is no question 0
			student++; 
			current_q = question % cycle;
		}

		converter << s;//store string in converter to convert to int
		converter >> x;//unstore it into an int
		converter = stringstream();//reset converter

		
		if (adj % 6 == 0)
			question--;
		else
		{
			test[student].setValues(x, (current_q - 1));
			sum_Q[current_q - 1] += x;
			if (current_q == 1 || current_q == 4 || current_q == 5 || current_q == 9 || current_q == 10 || current_q == 11 || current_q == 13 || current_q == 16 || current_q == 17 || current_q == 20)
			{
				bot_sum += x;
			}//if its a bottom brain question
			else top_sum += x;//no need to check other conditions, its binary
		}
			question++;
			adj++;
		
	}//write data here so that it can be manipulated elsewhere

	double question_avg[20] = { 0 };
	double question_dev[20] = { 0 };


	double top_avg = 0;
	double bot_avg = 0;

	double topdev =   0 ;
	double botdev =  0 ;

	for (int i = 0; i < 20; i++)
	{
		question_avg[i] = sum_Q[i] /double(num);
	}

	for (int j = 0; j < 20; j++)
	{
		for (int i = 0; i < 26; i++)
		{
			 question_dev[j] += pow((test[i].getValues(j)-question_avg[j]), 2);
		}
		question_dev[j] = sqrt(question_dev[j] / double(num));
		cout << "Question " << j + 1 << endl << "average: " << question_avg[j] << endl << "std. deviation: " << question_dev[j] << endl << endl;
	}
	bot_avg = bot_sum / double(num);
	top_avg = top_sum / double(num);
	for (int i = 0; i < 26; i++)
	{
		for (int j = 0; j < 20; j++)
		{
			int x = j + 1;
			if (x == 1 || x == 4 || x == 5 || x == 9 || x == 10 || x == 11 || x == 13 || x == 16 || x == 17 || x == 20)
			{
				botdev += pow((test[i].getValues(j) - question_avg[j]), 2);
			}
			else
			{
				topdev += pow((test[i].getValues(j) - question_avg[j]), 2);
			}
		}
	}
	
	botdev = sqrt(botdev / double(num));
	topdev = sqrt(topdev / double(num));

	cout << "Top brain average: " << top_avg << endl << "Top brain std. deviation: " << topdev << endl << endl;
	cout << "Bottom brain average: " << bot_avg << endl << "Bottom brain std. deviation: " << botdev << endl << endl;

	int t = 0;
	int b = 0;
	if (top_avg < 23)
		t = 1;
	else if (23 <= top_avg <= 32)
		t = 2;
	else if (33 <= top_avg <= 42)
		t = 3;
	else t = 4;
	if (bot_avg < 23)
		b = 1;
	else if (23 <= bot_avg <= 32)
		b = 2;
	else if (33 <= bot_avg <= 42)
		b = 3;
	else b = 4;

	cout << "The respective Top Brain category and Bottom Brain category for our class is: " << endl << "Top: " << t << endl << "Bottom: " << b << endl << "On average: Mover mode, but context dependent" << endl << "Class stardard deviation implies most students were within three to four top or bottom brain points of each other." << endl << "Most students scored this category or close to this category" << endl;
	system("Pause");
}