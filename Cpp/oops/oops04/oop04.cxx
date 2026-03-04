#include <iostream> //headerfile for input and output
using namespace std;
class car
{
private:
    string brand;

public:
    car(string a) { brand = a; };
    void carname() { cout << "The brand name is " << brand << "," << endl; }; // it will gonna print the car brand
};
class customer
{
private:
    string name;

public:
    customer(string b) { name = b; };
    void cus() { cout << "Thanks for renting the car " << name << "," << endl; }; // Thanking the customer
};
class renting
{
private:
    int amount;

public:
    renting(int c) { amount = c; };
    void total() { cout << "The total amount to be paid is " << amount << "." << endl; }; // the total amount to be paid
};
class Final : public renting, public car, public customer
{
public:
    Final(string carname, string customername, int amountobepaid) // it will make the input easier
        : car(carname), customer(customername), renting(amountobepaid)
    {
    }

    void output()
    {
        carname();
        cus();
        total();
    };
};
int main()
{
    Final a("Toyota", "Jonh", 60000);
    a.output();
}
// end of the program
// output
/*
The brand name is Toyota,
Thanks for renting the car Jonh,
The total amount to be paid is 60000.
*/