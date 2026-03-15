#include <iostream> //headerfile for input or output
using namespace std;
class car
{
private:
    int speed;
    string brand;

public:
    car(int s, string b) //constructor
    {
        brand = b;
        speed = s;
    };
    ~car() //destroyer
    {
        cout << "destroyed" << endl;
    };

    void drive() { cout <<"Brand is "<< brand << " speed is " << speed<<"."<<endl; };
};
int main(){
    car c1(130,"Toyota");
    c1.drive();
    return 0;
}
//end of the program.
// at the end both constructor and destroyer will run,
//out will be,
/*
Brand is Toyota speed is 130.
destroyed
*/