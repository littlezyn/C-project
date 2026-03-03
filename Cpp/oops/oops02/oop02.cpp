#include <iostream>
using namespace std;
class car
{
private:
    int speed;
    string brand;

public:
    car(int s, string b)
    {
        brand = b;
        speed = s;
    };
    ~car()
    {
        cout << "destroyed" << endl;
    };

    void drive() { cout <<"Brand is "<< brand << " speed is " << speed<<"."<<endl; };
};
int main(){
    car c1(130,"Toyota");
    c1.drive();
}