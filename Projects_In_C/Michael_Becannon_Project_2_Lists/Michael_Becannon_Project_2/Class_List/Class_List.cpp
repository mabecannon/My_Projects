// Class_List.cpp : This file contains the 'main' function. Program execution begins and ends there.
//
#include <iostream>
#include "Class_List.h"
using namespace std;

/*
Because template class is declared in .h file, member functions cannot be defined here,
they are already defined the template class
*/

class Course
{
private:
	string mCourse_Name;
	double mGrade;
	double mUnits;
public:

	Course()
	{
		mCourse_Name = "";
		mGrade = 0;
		mUnits = 0;
	}

	Course(string name, double grade, double unit)
	{
		mCourse_Name = name;
		mGrade = grade;
		mUnits = unit;
	}

	Course(const Course& rhs)
	{
		this->mGrade = rhs.mGrade;
		this->mCourse_Name = rhs.mCourse_Name;
		this->mUnits = rhs.mUnits;
	}

	Course& operator=(const Course& rhs)
	{
		this->mGrade = rhs.mGrade;
		this->mCourse_Name = rhs.mCourse_Name;
		this->mUnits = rhs.mUnits;
		return *this;
	}

	bool operator !=(Course A)
	{
		return !(this->getGrade() == A.getGrade() && this->getUnits() == A.getUnits() && this->getName() == A.getName());
	}
	string getName()
	{
		return mCourse_Name;
	}

	double getGrade()
	{
		return mGrade;
	}

	string getLetter()
	{
		if (mGrade > 3.5) return "A";
		else if (3.5 >= mGrade && mGrade > 3)return "A-";
		else if (3 >= mGrade && mGrade > 2.5) return "B";
		else if (2.5 >= mGrade && mGrade > 2) return "B-";
		else if (2 >= mGrade && mGrade > 1.5) return "C";
		else if (1.5 >= mGrade && mGrade > 1) return "C-";
		else if (1 >= mGrade && mGrade > .5) return "D";
		else return "F";
	}

	double getUnits()
	{
		return mUnits;
	}
};
class GPA_Estimator
{
private:

	Class_List<Course> mClasses;

public:


	GPA_Estimator(const Class_List<Course> foo)
	{
		mClasses = foo;
	}

	double GPA_calculation()
	{
		double num = 0;
		double denom = 0;
		for (int i = 0; i < mClasses.Size(); i++)
		{
			num += mClasses.getData(i).getUnits() * mClasses.getData(i).getGrade();
			denom += mClasses.getData(i).getUnits();
		}
		return num / denom;
	}

	int Size()
	{
		return mClasses.Size();
	}

	void Replace(Course old, Course replacement)
	{
		mClasses.InsertDataBefore(replacement, old);
		mClasses.RemoveData(old);
	}

	Course remove(Course c)
	{
		return mClasses.RemoveData(c);
	}

	Course removeFront()
	{
		return mClasses.RemoveFront();
	}

	void insertBack(Course c)
	{
		mClasses.InsertBack(c);
	}

	Class_List<Course> getList()
	{
		return mClasses;
	}

	void DisplayClass()
	{
		Course temp;
		for (int i = 0; i < mClasses.Size(); i++)
		{ 
			temp = mClasses.RemoveFront();
			cout << "Class: " << temp.getName() << "\tUnits: " << temp.getUnits() << "\tGrade: " << temp.getLetter() << endl;
			mClasses.InsertBack(temp);
		}
	}
};
int main()
{
	Class_List<Course> test;

	double i = 0;
	Course ECE1101("ECE1101", 4, 3);
	Course ECE1310("ECE1310", 4, 3);
	Course ECE2101("ECE2101", 3.5, 3);
	Course ECE2200("ECE2200", 4, 3);
	Course ECE2300("ECE2300", 3.5, 3);
	Course ECE2310("ECE2310", 4, 3);
	Course MAT1140("MAT1140", 4, 4);
	Course MAT1150("MAT1150", 4, 4);
	Course MAT2140("MAT2140", 3, 4);
	Course bad("Michael's Made Up Class", 0, 5);
	test.InsertBack(ECE1101);
	test.InsertBack(ECE1310);
	test.InsertBack(ECE2101);
	test.InsertBack(ECE2200);
	test.InsertBack(ECE2300);
	test.InsertBack(ECE2310);
	test.InsertBack(MAT1140);
	test.InsertBack(MAT1150);
	test.InsertBack(MAT2140);
	test.InsertBack(bad);
	GPA_Estimator gpa(test);

	gpa.DisplayClass();

	cout << endl << "Michael's GPA is: " << gpa.GPA_calculation() << endl << endl << endl;

	Course worst("", 4, 5);
	Course temp;
	for (int i = 0; i < gpa.Size(); i++)
	{
		temp = gpa.removeFront();
		if (temp.getGrade() < worst.getGrade())
			worst = temp;
		gpa.insertBack(temp);
	}


	temp = gpa.remove(worst);

	gpa.DisplayClass();

	cout << endl << "Michael's GPA is: " << gpa.GPA_calculation() << endl << endl << endl;
	Course replacement(worst.getName(), 4, 5);

	gpa.insertBack(replacement);

	gpa.DisplayClass();

	cout << endl << "Michael's GPA is: " << gpa.GPA_calculation() << endl << endl << endl;

};
