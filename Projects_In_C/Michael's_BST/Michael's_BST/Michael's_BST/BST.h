#pragma once
#include <iostream>
using namespace std;
template <typename T> class BST
{
private:
	struct Node
	{
		T mData;
		int occurences = 1;
		Node* mLeft;
		Node* mRight;
		Node* mParent;
		Node(const T& d = T{}, Node* l = nullptr, Node* r = nullptr, Node* p = nullptr) :mData{ d }, mLeft{ l }, mRight{ r }, mParent{ p } {}
		Node(T&& d, Node* l = nullptr, Node* r = nullptr, Node* p = nullptr) :mData{ std::move(d) }, mLeft{ l }, mRight{ r }, mParent{ p } {}
	};
	int mSize = 0;
	Node* root = new Node();

	void clear(Node* n)
	{
		if (Empty()) return;
		Node* iter = n;
		if (iter->mLeft != nullptr)
		{
			clear(iter->mLeft);
		}//L
		if (iter->mRight != nullptr)
		{
			clear(iter->mRight);
		}//R
		int o = iter->occurences; 
		Remove(iter->mData);
		o--;
		if (o != 0)
		{
			clear(iter);
		}
		//V
	}//Post-Order 

	void insertMaybeEmptyTree(T data)
	{
		if (root == nullptr)
		{
			root = new Node(data, nullptr, nullptr, nullptr);//THE mega root has no parents
		}
		else Place_Using_Root(root, data);
	}

	void Place_Using_Root(Node* r, T data)
	{
		if (r->mData > data)
		{
			if (r->mLeft == nullptr)
			{
				mSize++;
				r->mLeft = new Node(data, nullptr, nullptr, r);//V
			}
			else Place_Using_Root(r->mLeft, data);//L
		}
		else if (r->mData < data)
		{
			if (r->mRight == nullptr)
			{
				mSize++;
				r->mRight = new Node(data, nullptr, nullptr, r);//V
			}
			else Place_Using_Root(r->mRight, data);//R
		}
		else if (r->mData == data)
		{
			r->occurences++;//increase occurences by 1
		}
	}//Preorder insert the data where it goes, otherwise, increase the occurences

	T remove(T data)
	{
		if (!Empty())
		{
			Node* iter = SearchData(Begin(), data);//a pointer starting at the Node which contains data
			if (iter != nullptr)//if we found our data
			{

				if (iter->occurences != 0)
				{
					iter->occurences--;
				}//don't delete node until all of them are gone!
				if(iter->occurences == 0)
				{
					mSize--;
					Node* iter_parent = iter->mParent;
					if (iter == nullptr)
						return undefined_Behavior();
					else if (iter_parent == nullptr && Size() == 0)
					{
						iter = nullptr;
						return data;
					}
					else if (iter == root)
					{

						if (iter->mLeft == nullptr && iter->mRight == nullptr)//Root without children
						{
							iter = nullptr;
							return data;
						}
						else if (iter->mLeft == nullptr && iter->mRight != nullptr)//Root with one child
						{
							root = iter->mRight;
							root->mParent = nullptr;
							delete iter;
						}
						else if (iter->mLeft != nullptr && iter->mRight == nullptr)
						{
							root = iter->mLeft;
							root->mParent = nullptr;
							delete iter;
						}
						else if (iter->mRight != nullptr && iter->mLeft != nullptr)//children
						{

							Node* iter_Right = iter->mLeft;//Find the smallest larger data for left remove

							while (iter_Right->mRight != nullptr)
							{
								iter_Right = iter_Right->mRight;
							}//Find the largest smaller data
							iter_Right->mLeft = root->mLeft;
							root->mLeft->mParent = iter_Right;
							iter_Right->mRight = root->mRight;
							root->mRight->mParent = iter_Right;
							iter_Right->mParent->mRight = nullptr;
							delete iter;
							root = iter_Right;
							iter_Right->mParent = nullptr;//Only the root has a null parent
							return data;
						}
					}
					else if (iter->mRight == nullptr && iter->mLeft == nullptr)//a leaf!
					{
						if (iter_parent != nullptr)//if root delete fails for some reason, PROTECT THE DATA
						{
							if (iter->mData > iter_parent->mData)
							{
								iter->mParent->mRight = nullptr;//reset to nullptr; OTHER FUNCTIONS USE NULLPTR TO "SEE" AN EMPTY SPACE;
								delete iter;
								return data;

							}
							else if (iter->mData < iter_parent->mData)
							{
								iter->mParent->mLeft = nullptr;
								delete iter;
								return data;
							}
						}
					}
					else if (iter->mRight != nullptr && iter->mLeft == nullptr)//has single child
					{
						if (iter->mData > iter_parent->mData)
						{
							iter_parent->mRight = iter->mRight;
						}
						else
							iter_parent->mLeft = iter->mRight;
						delete iter;//get rid of iter
						return data;
					}
					else if (iter->mRight == nullptr && iter->mLeft != nullptr)//has single child
					{
						if (iter_parent != nullptr)
						{
							if (iter->mData > iter->mParent->mData)
							{
								iter_parent->mRight = iter->mLeft;
							}
							else
								iter_parent->mLeft = iter->mLeft;
							delete iter;//get rid of iter
							return data;
						}
					}
					else if (iter->mRight != nullptr && iter->mLeft != nullptr)//has childern
					{
						Node* iter_Right = iter->mLeft;//Find the smallest larger data for left remove
						if (iter_Right->mRight == nullptr)//if the predecessor(left) child doesn't have a right child that is closer to the removed subroot value, 
														 //then just make the left child the new subroot with null right
						{
							if (iter_Right->mData > iter_parent->mData)//if we're on the Right half of this particular subtree
							{
								iter_Right->mRight = iter->mRight;
								iter->mRight->mParent = iter_Right;//iter_right is the left child of iter, so we don't care about left side
								iter_Right->mParent = iter->mParent;
								delete iter;

								iter_parent->mRight = iter_Right;

								return data;
							}
							else if (iter_Right->mData < iter_parent->mData)//if we're on the left
							{
								iter_Right->mRight = iter->mRight;
								iter->mRight->mParent = iter_Right;
								iter_Right->mParent = iter->mParent;
								delete iter;
								iter_parent->mLeft = iter_Right;

								return data;
							}
						}
						else if (iter->mData > iter_parent->mData)//predecessor has right children 
						{
							while (iter_Right->mRight != nullptr)
							{
								iter_Right = iter_Right->mRight;
							}//Find the largest smaller data
							iter_Right->mLeft = iter->mLeft;
							iter->mLeft->mParent = iter_Right;
							iter_Right->mRight = iter->mRight;
							iter->mRight->mParent = iter_Right;
							iter_Right->mParent->mRight = nullptr;
							iter_Right->mParent = iter->mParent;
							delete iter;

							iter_parent->mRight = iter_Right;
							return data;
						}
						else if (iter->mData < iter_parent->mData)
						{

							while (iter_Right->mRight != nullptr)
							{
								iter_Right = iter_Right->mRight;
							}//Find the largest smaller data
							iter_Right->mLeft = iter->mLeft;
							iter->mLeft->mParent = iter_Right;
							iter_Right->mRight = iter->mRight;
							iter->mRight->mParent = iter_Right;
							iter_Right->mParent->mRight = nullptr;
							iter_Right->mParent = iter->mParent;
							delete iter;
							iter_parent->mLeft = iter_Right;
							return data;
						}
					}
				}
			}
		}
		return undefined_Behavior();
	}//remove a node, otherwise return NULL

	void DisplayNodes(Node* prev)
	{
		if (!Empty())
		{
			Node* iter = prev;
			if (iter->mLeft != nullptr)
				DisplayNodes(iter->mLeft);//L

			cout << iter->mData << endl;//V

			if (iter->mRight != nullptr)
			{
				DisplayNodes(iter->mRight);//R
			}
		}
		else
			cout << "Empty tree" << endl;
	}//iterate through the tree in-order

	Node* SearchData(Node* r, T data)
	{
		if (r->mData > data)
		{
			if (r->mLeft == nullptr) return nullptr;
			else
			{
				r = SearchData(r->mLeft, data);
			}
		}
		else if (r->mData < data)
		{
			if (r->mRight == nullptr) return nullptr;
			else r = SearchData(r->mRight, data);
		}
		return r;
	}//returns nullptr if it cannot find

	bool replace(T dataToBeReplaced, T dataToReplaceIt)
	{
		Node* find = SearchData(Begin(), dataToBeReplaced);
		if (find != nullptr)//if we found the data we want to replace
		{
			if (dataToBeReplaced == dataToReplaceIt)
			{
				return true;//don't replace it if it is itself 
			}
			Remove(dataToBeReplaced);//Get rid of a old data
			Insert(dataToReplaceIt);//Put in the new data! 
			return true;//tree handles where the new data should go
		}
		return false;
	}

	void iterate(Node* iter, BST* copy)
	{
		Node* copyiter = Begin();
		copy->Insert(iter->mData);
		copyiter = copy->SearchData(Begin(), iter->mData);
		copyiter->occurences = iter->occurences;
		if (iter->mLeft != nullptr)
			iterate(iter->mLeft, copy);

		if (iter->mRight != nullptr)
			iterate(iter->mRight, copy);
	}//Copier

	T undefined_Behavior()
	{
		return T{};//return garbage
	}


public:
	BST()
	{
		root = nullptr;
	}

	~BST()
	{
		if (Size() > 0)
		{
			Clear();
			delete root;
		}
	}

	BST(const BST& rhs)
	{
		this->root = nullptr;
		iterate(rhs.root, this);
	}//copy constructor

	BST& operator=(const BST&& rhs)
	{
		BST<T> temp;
		temp.root = nullptr;
		iterate(rhs.root, temp);
		return temp;
	}//copy-assignment 

	void Insert(T data)
	{
		insertMaybeEmptyTree(data);
	}

	void Display()
	{
		DisplayNodes(Begin());
	}

	bool Empty()
	{
		return Size() == 0;
	}

	void Clear()
	{
		clear(Begin());
	}

	int Size()
	{
		return mSize;
	}

	bool Exists(T data)
	{
		return replace(data, data);//if data doesn't exist, returns false, otherwise replaces data with data
	}

	Node* Begin()
	{
		return root;
	}

	T Remove(T data)
	{
		return remove(data);
	}

	bool Replace(T Old, T New)
	{
		return replace(Old, New);
	}

	int Instances(T data)
	{
		Node* n = SearchData(Begin(), data);
		return n->occurences;
	}
};

