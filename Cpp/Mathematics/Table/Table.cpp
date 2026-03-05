#include <iostream> //headerfile for input and output
using namespace std;
int main()
{
    int x;
    while (true) //while loop for better workflow
    {
        cout<<"Enter The number you want the table of '0' or 'string' to Exit: ";
        cin>>x;
        if (x = int(x))
        {
            for (int i = 1; i < 11; i++) //for loop 
            {
                cout << x << " x " << i << " = " << x * i << endl;
            }
        }else
        {
            break;
        }
        
    }
    return 0;
}
//end of the program
//output
/* 
Enter The number you want the table of '0' or 'string' to Exit: 1
1 x 1 = 1
1 x 2 = 2
1 x 3 = 3
1 x 4 = 4
1 x 5 = 5
1 x 6 = 6
1 x 7 = 7
1 x 8 = 8
1 x 9 = 9
1 x 10 = 10
*/