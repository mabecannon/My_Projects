#pragma once
#include "Class_List.h"
template<typename T> class Stack
{

	/*STACK TOP IS THE HEAD NODE's mNEXT OF THE LIST!!!!!!!!!!!!!!!!!!*/
private: 
	Class_List <T> stack;
	int size;
public: 
	Stack()
	{
		size = 0;
	}
	bool empty()
	{
		return stack.Empty();
	}
	T Stack_Top()
	{
		return stack.getFront();
	}
	void push(T data)
	{
		stack.InsertFront(data);//FILO
	}
	T pop()
	{
		return stack.RemoveFront();//FILO
	}
	int theSize()
	{
		return stack.Size();
	}
	void display()
	{
		stack.DisplayData();
	}

	T UndefinedBehavior()
	{
		return stack.UndefinedBehavior();
	}
};