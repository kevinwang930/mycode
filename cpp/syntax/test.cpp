#include <iostream>
#include<string>

int main()
{
      // declaring variables:
  
  // process:
  int a=5;               // initial value: 5
  int b(3);              // initial value: 3
  int c{2};              // initial value: 2
  int result;            // initial value undetermined
  std::string mystring {"This is a string"};

  a = a + b;
  result = a - c;

  // print out the result:
  std::cout << result <<std::endl;
  std::cout << mystring;

    int age;
    std::cin >> age;
    std::cout << "I am " <<age<<" years old"<<std::endl;
  // terminate the program:
  return 0;

    
}
