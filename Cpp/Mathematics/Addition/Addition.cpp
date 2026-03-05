#include <iostream> //headerfile for input or output
using namespace std;
int add(int a, int b) //function for addition
{
    return a + b;
}
int main() //main function
{
    int a, b;
    cout << "Enter first number: ";
    cin >> a;
    cout << "Enter second number: ";
    cin >> b;
    cout<<"The sum of "<<a<<" and "<<b<<" is "<< add(a, b)<<"."<<endl;
    return 0;
}
//end of the program
//output
/* 
Enter first number: 1
Enter second number: 2
The sum of 1 and 2 is 3.
*/