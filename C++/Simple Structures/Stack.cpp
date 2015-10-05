//ѕример создани€ стека с использованием классов 
#include <iostream> 
#include <string>
#include <exception> 


using namespace std; 

class Container{
public:
	virtual int pop() = 0;
	virtual void push(int a) = 0;
};

class Stack: public Container{
private:
	static const int LEN = 10;
	int storage [LEN];
	int pos;
public:
	Stack(): pos(-1) {};
	int pop() {
		if (pos>=0){
			pos--;
			return storage[pos+1];
		} else {
			throw exception("No elements to pop");
		}
	};
	void push (int a);
};

void Stack::push(int a)
	{
		pos++;
		storage[pos] = a;
	};

int main()
{
	Container* cont = new Stack();
	try{
		cont->push(1);
		cout << cont->pop() << '\n';
		cout << cont->pop() << '\n';
	} catch (exception& e) {
		cout << e.what();
	}
	cin.get(); 
	delete cont;
	return 0; 
}