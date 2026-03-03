#include <iostream>
using namespace std;
class school
{
private:
    string brand;

public:
    school(string a) { brand = a; };
    void schoolname() { cout << "School name is " << brand << "," << endl; };
};
class students
{
private:
    int noofstd;

public:
    students(int b) { noofstd = b; };
    void noofstudents() { cout << "No of students are " << noofstd << "," << endl; };
};
class attendence
{
private:
    int attd;

public:
    attendence(int c) { attd = c; };
    void attden() { cout << "Total students presents is " << attd << "." << endl; }
};
class Final : public students, public school, public attendence
{
public:
    Final(string schoolName, int totalStudents, int presentStudents)
        : students(totalStudents), school(schoolName), attendence(presentStudents) {}

    void output()
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
}
