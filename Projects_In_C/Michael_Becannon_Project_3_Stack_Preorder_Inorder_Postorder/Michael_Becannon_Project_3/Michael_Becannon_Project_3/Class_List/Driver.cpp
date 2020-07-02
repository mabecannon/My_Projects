// Class_List.cpp : This file contains the 'main' function. Program execution begins and ends there.
//This project will take an infix expression: 1+2 and turn it into postfix expression: 12+ and evaluate it
//alternatively, you can turn any postfix expression into an infix expression 
#include <iostream>
#include "Stack.h"
using namespace std;

string postFix(string exp);

int postFixEval(string post);

class Token
{
private: 
	char token;
	int priority;
public: 

	Token()
	{
		token = ' ';
		priority = 0;
	}

	Token(char a)
	{
		token = a;
		if (a == '*' || a == '/' || a == '%')
			priority = 3;
		else if (a == '+' || a == '-')
			priority = 2;
		else if (a == '(')
			priority = 1;
		else priority = 0;
	}

	void setToken(char a)
	{
		token = a; 
		if (a == '*' || a == '/' || a == '%')
			priority = 3;
		else if (a == '+' || a == '-')
			priority = 2;
		else if (a == '(')
			priority = 1;
		else priority = 0;
	}

	char getToken()
	{
		return token;
	}

	int getPriority()
	{
		return priority;
	}
};


int main()
{
	string infix_exp = "2+3-7*9/3";
	cout << infix_exp << " = -16" << endl;
	cout << postFix(infix_exp) << endl;
	cout << postFixEval(postFix(infix_exp)) << endl << endl;


	infix_exp = "((5+5)/(3-2))*4";
	cout << infix_exp << " = 40" << endl;
	cout << postFix(infix_exp) << endl;
	cout << postFixEval(postFix(infix_exp)) << endl << endl;


	string not_postfix_exp = "1+3*7";//INVALID
	cout << "Invalid Postfix Expression:" <<  not_postfix_exp << endl; 
	cout << postFixEval(not_postfix_exp) << endl << endl;


	not_postfix_exp = "+*137";//INVALID
	cout << "Invalid Postfix Expression:" << not_postfix_exp << endl;
	cout << postFixEval(not_postfix_exp) << endl;
}

int postFixEval(string exp)
{
	Token token;
	int val = 0, val1 = 0, val2 = 0;
	Stack<int> values;
	bool post = true; 
	for (unsigned int i = 0; i < exp.length(); i++)
	{
		token.setToken(exp[i]);
			switch (token.getToken())
			{
			case '0': values.push(0); break;
			case '1': values.push(1); break;
			case '2': values.push(2); break;
			case '3': values.push(3); break;
			case '4': values.push(4); break;
			case '5': values.push(5); break;
			case '6': values.push(6); break;
			case '7': values.push(7); break;
			case '8': values.push(8); break;
			case '9': values.push(9); break;
			case '+': 
				if (values.theSize() < 2)
				{
					post = false;
					break;
				}
				val = values.pop() + values.pop();//addition commutes
				values.push(val);
				break;
			case '-': 
				if (values.theSize() < 2)
				{
					post = false;
					break;
				}
				val = val = -values.pop() + values.pop();//the first value to pop IS the subtrahend
				values.push(val);
				break;
			case '*': 
				if (values.theSize() < 2)
				{
					post = false;
					break;
				}
				val = values.pop() * values.pop();//multiplication commutes
				values.push(val);
				break;
			case '/': 
				if (values.theSize() < 2)
				{
					post = false;
					break;
				}
				val = int(double(1)/double(values.pop()) * values.pop());//the first value to pop IS the denominator, recast for valid division
				values.push(val);
				break;
			case '%': 
				if (values.theSize() < 2)
				{
					post = false;
					break;
				}
				val1 = values.pop();
				val2 = values.pop();
				val = val2 % val1;//the first value to pop IS the divisor
				values.push(val);
				break;
			default: 
				post = false; 
				break;
			}
			if (post == false)
			{
				cout << "Not a postfix expression" << endl;
				return -INT32_MAX;
			}//if not a postfix expression, ouputs to user and ends function
	}//returns negative max value if not a postfix expression
	return val;
}

string postFix(string exp)
{


	Token token;
	string post_fix = "";
	Stack<Token> OStack;
	for (unsigned int i = 0; i < exp.length(); i++)
	{
		token.setToken(exp[i]);
		switch (token.getToken())
		{
		case ' ' : break;

		case '(': OStack.push(token); break; 

		case ')': 
			while(token.getToken() != '(')
			{
				token.setToken(OStack.pop().getToken());
				if(token.getToken() != '(')
				post_fix.append(1, token.getToken());
			}
			break;

		case '+':
		case '-':
		case '*':
		case '/':
		case '%':
			OStack.push(token);
			break; 
		case '1':
		case '2':
		case '3':
		case '4': 
		case '5': 
		case '6':
		case '7':
		case '8':
		case '9': 
		case '0':
			post_fix = post_fix.append(1, token.getToken());
			break; 
		}
	}
	while (!(OStack.empty()))
	{
		token.setToken(OStack.pop().getToken());
		if (token.getToken() != '(')
			post_fix.append(1, token.getToken());
	}
	return post_fix;
}
