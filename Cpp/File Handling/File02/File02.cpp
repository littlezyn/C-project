#include<iostream> //header file for input and output
#include<fstream> //header file for file handling
#include<string> //header file for string
using namespace std;
int main(){
    ofstream fout("sample.txt"); //ofstream for write
    fout<<"Enter whatever you want: ";
    fout.close(); //closing the file 

    string text;
    ifstream fin("sample.txt"); //ifstream for read 
    getline(fin , text);
    cout<<text<<endl;
    fin.close(); //closing the file
    return 0;
}
//end of the program 
//you can see the outputr in sample.txt