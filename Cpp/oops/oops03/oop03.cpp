#include <iostream> //header file for input or output
using namespace std;
class school 
{
private:
    string brand;

public:
    school(string a) { brand = a; };
    void schoolname() { cout << "School name is " << brand << "," << endl; }; //it will gonna print the scholl name
};
class students
{
private:
    int noofstd;

public:
    students(int b) { noofstd = b; };
    void noofstudents() { cout << "No of students are " << noofstd << "," << endl; }; //taking the input of no of students
};
class attendence
{
private:
    int attd;

public:
    attendence(int c) { attd = c; };
    void attden() { cout << "Total students presents is " << attd << "." << endl; } //no of students attends the class
};
class Final : public students, public school, public attendence
{
public:
    Final(string schoolName, int totalStudents, int presentStudents) //the final thing is vibecoded line 33 to 34.
        : students(totalStudents), school(schoolName), attendence(presentStudents) {}

    void output() //it will gonna print the whole thing 
    {
        schoolname();
        noofstudents();
        attden();
    }
};

int main()
{
    Final a("ABC School", 500, 430);
    a.output();
    return 0;
}
//end of the program
//the output will be
/*
School name is ABC School,
No of students are 500,
Total students presents is 430.
*/