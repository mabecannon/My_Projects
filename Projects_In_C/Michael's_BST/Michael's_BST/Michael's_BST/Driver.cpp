#include "BST.h"
#include <iostream>
using namespace std;
void endl()
{
	cout << endl;
}


class Student
{
private:
	int score;
	char ID;
public:
	Student()
	{
		score = 0;
		ID = '\0';
	}
	Student(int s, char c)
	{
		score = s;
			ID = c;
	}
	bool operator==(const Student& a)
	{
		return this->ID == a.ID;
	}
	bool operator<(const Student& a)
	{
		return this->ID < a.ID;
	}
	bool operator>(const Student& a)
	{
		return this->ID > a.ID;
	}
	bool operator<=(const Student&& a)
	{
		return this->ID <= a.ID;
	}
	bool operator>=(const Student& a)
	{
		return this->ID >= a.ID;
	}

	int getScore()
	{
		return score;
	}

	char getID()
	{
		return ID;
	}

	void setScore(int s)
	{
		 score = s;
	}

	void setID(char c)
	{
		ID = c;
	}

	friend ostream& operator<<(ostream& os, const Student& st);
};

ostream& operator <<(ostream& os, const Student& st)
{
	os << "ID: " << st.ID << '\t' << "Score:" << st.score;
	return os;
}

int main()
{
	Student A(11, 'A');
	Student B(14, 'B');
	Student C(8, 'C');
	Student D(14, 'D');
	Student E(14, 'E');
	Student F(20, 'F');
	Student G(6, 'G');
	Student H(20, 'H');
	Student I(14, 'I');
	Student J(3, 'J');
	Student K(11, 'K');
	Student L(11, 'L');
	Student M(17, 'M');
	Student N(17, 'N');
	Student O(15, 'O');
	Student P(20, 'P');
	Student Q(20, 'Q');
	Student R(10, 'R');
	Student S(15, 'S');
	Student T(20, 'T');
	Student U(14, 'U');
	Student V(20, 'V');
	Student W(17, 'W');
	Student X(11, 'X');
	Student Y(19, 'Y');
	Student Z(16, 'Z');
	BST<Student> tree;
	tree.Insert(A);//preorder insert
	tree.Insert(B);
	tree.Insert(C);
	tree.Insert(D);
	tree.Insert(E);
	tree.Insert(F);
	tree.Insert(G);
	tree.Insert(H);
	tree.Insert(I);
	tree.Insert(J);
	tree.Insert(K);
	tree.Insert(L);
	tree.Insert(M);
	tree.Insert(N);
	tree.Insert(O);
	tree.Insert(P);
	tree.Insert(Q);
	tree.Insert(R);
	tree.Insert(S);
	tree.Insert(T);
	tree.Insert(U);
	tree.Insert(V);
	tree.Insert(W);
	tree.Insert(X);
	tree.Insert(Y);
	tree.Insert(Z);

	BST<Student> tree2 = tree;

	tree.Display();//In-Order!

	tree.Clear();//Post-Order Clear!

	tree.Display();
	
	Student what(100000, '!');

	cout << "Is student F here: " << tree2.Exists(F);

	endl();

	cout << "Is student ! here: " << tree2.Exists(what);

	endl();

	tree2.Replace(F, what);

	cout << "Let's get rid of Student F, student ! is better!";

	endl();

	cout << "Is student F here: " << tree2.Exists(F);

	endl();

	cout << "Is student ! here: " << tree2.Exists(what);

	endl();

	tree2.Display();

	return 0;
}
