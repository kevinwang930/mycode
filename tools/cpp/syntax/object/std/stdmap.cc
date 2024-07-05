#include <iostream>
#include <map>
#include <string>
#include <string_view>

using namespace std;

void print_map(std::string comment, const std::map<std::string, int> &m)
{
    std::cout << comment;
    for (auto it = m.begin();it!=m.end();++it) 
    {
        std::cout << it->first << " = " << it->second << "; ";
    }
    std::cout << "\n";
}

int main()
{
    // Create a map of three strings (that map to integers)
    std::map<std::string, int> m{
        {"CPU", 10},
        {"GPU", 15},
        {"RAM", 20},
    };

    print_map("Initial map: ", m);

    m["CPU"] = 25; // update an existing value
    m["SSD"] = 30; // insert a new value

    print_map("Updated map: ", m);

    auto search = m.find("CPU");
    if (search != m.end())
    {
        std::cout << "Found " << search->first << " " << search->second << '\n';
    }
    else
    {
        std::cout << "Not found\n";
    }
}