#pragma once
#pragma once
#include<iostream>
using namespace std;
template <typename T> class Class_List
{
private:
	struct node
	{
	public:
		T mData;
		node* mPrev = nullptr;
		node* mNext = nullptr;
		node(const T& d = T{}, node* p = nullptr, node* n = nullptr) :mData{ d }, mPrev{ p }, mNext{ n } {}
		node(T&& d, node* p = nullptr, node* n = nullptr) :mData{ std::move(d) }, mPrev{ p }, mNext{ n } {}
	};
	node* mHead = new node();
	node* mTail = new node();
	int mSize;

public:
	Class_List()
	{
		mHead->mNext = mTail;
		mTail->mPrev = mHead;
		mSize = 0;
	}
	~Class_List()
	{
		Clear();
		delete mHead;
		delete mTail;
	}

	Class_List(const Class_List& rhs)
	{
		mHead->mNext = mTail;
		mTail->mPrev = mHead;
		mSize = 0;
		node* iter = rhs.mHead;
		while (iter->mNext != rhs.mTail)
		{
			this->InsertBack(iter->mNext->mData);
			iter = iter->mNext;
		}
	}

	Class_List& operator=(const Class_List& rhs)
	{
		const node* iter = rhs.mHead;
		while (iter->mNext != rhs.mTail)
		{
			this->InsertBack(iter->mNext->mData);
			iter = iter->mNext;
		}
		return *this;
	}

	int Size()
	{
		return mSize;
	}

	node* Begin()
	{
		return mHead;
	}

	T getData(int index)
	{
		node* iter = mTail->mPrev;
		while (index > 0)
		{
			if (iter->mPrev == mHead)
			{
				cout << "Data wasn't found. Undefined.";
				return UndefinedBehavior();
			}
			iter = iter->mPrev;
			index--;
		}
		return iter->mData;
	}//purely for extracting the whole list; pass in mSize

	void InsertFront(T tData)
	{
		node* current = new node(tData);
		current->mNext = mHead->mNext;
		current->mPrev = mHead;
		mHead->mNext->mPrev = current;
		mHead->mNext = current;
		mSize++;
	}

	void InsertBack(T tData)
	{
		node* current = new node(tData);
		current->mPrev = mTail->mPrev;
		current->mNext = mTail;
		mTail->mPrev->mNext = current;
		mTail->mPrev = current;
		mSize++;
	}

	int InsertDataBefore(T tData, T succeed)
	{

		node* tFloating = new node(tData);
		node* iter = Begin()->mNext;//Don't care about head node, our node will not be before head node
		while ((iter->mData != succeed))
		{
			if (iter->mNext == NULL)
				return -1;
			else
				iter = iter->mNext;
		}
		tFloating->mNext = iter->mPrev->mNext;
		tFloating->mPrev = iter->mPrev;
		iter->mPrev->mNext = tFloating;
		iter->mPrev = tFloating;
		T val = iter->mData;
		mSize++;
		return 0;
	}//Inserts at the FIRST index this data is found, returns 0 if found, returns -1 if not found

	T getFront()
	{
		return mHead->mNext->mData;
	}

	T RemoveFront()
	{
		if (mHead->mNext != mTail)
		{
			node* tCurrent = mHead->mNext;
			tCurrent->mPrev->mNext = tCurrent->mNext;
			tCurrent->mNext->mPrev = tCurrent->mPrev;
			T tData = tCurrent->mData;
			delete tCurrent;
			mSize--;
			return tData;
		}
		else
		{
			cout << "Nothing to delete. Undefined." << endl;
			return UndefinedBehavior();
		}
	}//Delete first node after mHead

	T RemoveBack()
	{
		if (mHead->mNext != mTail)
		{
			node* tCurrent = mTail->mPrev;
			tCurrent->mPrev->mNext = mTail;
			mTail->mPrev = tCurrent->mPrev;
			T tData = tCurrent->mData;
			delete tCurrent;
			mSize--;
			return tData;
		}
		else
		{
			cout << "Nothing to delete; Undefined." << endl;
			return UndefinedBehavior();
		}
	}//Delete first node after mHead

	T RemoveData(T tData)
	{
		T temp;
		if (mHead->mNext != mTail)
		{
			node* iter = mTail->mPrev;
			while (iter->mData != tData)
			{
				if (iter->mPrev == NULL)
				{
					cout << "Nothing to delete. Undefined." << endl;
					return UndefinedBehavior();
				}
				iter = iter->mPrev;
			}
			iter->mPrev->mNext = iter->mNext;
			iter->mNext->mPrev = iter->mPrev;
			mSize--;
			temp = iter->mData;
			delete iter;
			return temp;
		}
		else
		{
			cout << "Nothing to delete. Undefined." << endl;
			return UndefinedBehavior();
		}
	}//Removes at the FIRST index this data is found, returns 0 if found, returns -1 if not found

	void Clear()
	{
		while (!(this->Empty()))
		{
			this->RemoveFront();
		}
	}

	bool Empty()
	{
		if (mSize == 0) return true;
		return false;
	}

	void DisplayData()
	{
		if (mHead->mNext != mTail)
		{
			node* iter = mHead->mNext;
			while (iter != mTail)
			{
				cout << iter->mData << " ";
				iter = iter->mNext;
			}
		}
	}
	T UndefinedBehavior()
	{
		return mHead->mData;
	}
	
};