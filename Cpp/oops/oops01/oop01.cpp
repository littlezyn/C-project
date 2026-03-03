#include<iostream>
using namespace std;
class Data
{
public:
    int age;
    string name;

    void Bark(){
        cout<<name<<" Bark "<<endl;
    }
};
int main(){
    Data d;
    d.name = "lie";
    d.Bark();
    return 0;
}