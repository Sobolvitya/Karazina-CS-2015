#include <iostream> 
#include <string>
#include <exception>

// This is an example of class inheritance in c++
using namespace std; 


class Animal{
private:
    //The mechanics of storing a name is concealed from the end user.
	string nm;
protected:
    //  Animal is abstract class, that is why we do not allow to initialize call its constructor from outside
    //of its descendants, i.e. that is why the constructor is protected    
	Animal(string nm): nm(nm){};    
public:    
    // The mechanics of assigning and retrieving a name is similar for all animals,
    //that is why it is declared in the basic class and is not virtual.
	string name() {return this->nm;}; 
	virtual string type() = 0;	
    
    // This function does not depend on the object itself, rather it corresponds to some
    //general manipulations with Animal class. That is why it is static.
	static bool eats(Animal* a, Animal* b);
};

class Crocodile: public Animal  {
	virtual string type() {return "Crocodile";};
public:
    //Constructor of Crocodile simply calls the constructor of its superclass Animal
	Crocodile(string nm):  Animal(nm) {}; 
};

class Jaguar: public Animal  {
	virtual string type() {return "Jaguar";};
public:
	Jaguar(string nm):  Animal(nm) {};
};

	bool Animal::eats(Animal* a, Animal* b){
       //  Dynamic cast stands there for type checking
       //What we do here is ask: whether a is actually Jaguar and b is actually Crocodile,
       //despite both of them declared as Animal
		if (dynamic_cast<Jaguar*>(a) && dynamic_cast<Crocodile*>(b)) return true;
		return false;
	};

int main()
{
	int N = 2;
    //  Dynamic allocation of an array of abstract Animals. In fact, first Animal is initialized to be Crocodile,
    //and the second to be Jaguar.    
	Animal** animals = new Animal*[N];
	animals[0] = new Crocodile ("Gena");
	animals[1] = new Jaguar ("Gosha");

	for (int i=0; i<N; i++){
		cout << "Animal " << i+1 << ": " << animals[i]->type() << " " << animals[i]->name() << "\n";
	};

	cout << "\n";
	for (int i=0; i<N; i++){
	for (int j=0; j<N; j++){
		cout << animals[i]->name();
        // Notice that we call eats not for some object, but just for class Animal, that is because it is declared static.
		if (Animal::eats(animals[i], animals[j]) ) {cout << " eats ";} else {cout << " does not eat ";}; 
		cout << animals[j]->name()<< "\n";
	};};

	cin.get();

	for (int i=0; i<N; i++){delete animals[i];};
	delete animals;
	return 0; 
}