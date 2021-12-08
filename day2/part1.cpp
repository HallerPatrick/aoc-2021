#include <fstream>
#include <iostream>
#include <string>
#include <vector>

using namespace std;

struct Location {
  int forward;
  int depth;
} location;

int main() {

  location.forward = 0;
  location.depth = 0;

  // Read file "input.txt" into vector
  ifstream file("input.txt");
  string line;
  while (getline(file, line)) {
    // Split string into two parts and take the last part as the number
    string direction = line.substr(0, line.find(" "));
    string number = line.substr(line.find_last_of(" ") + 1);
    int value = std::stoi(number);

    // Compare string to determine which direction to move
    if (direction == "forward") {
      location.forward += value;
    } else if (direction == "down") {
      location.depth += value;
    } else if (direction == "up") {
      location.depth -= value;
    }
  }
  file.close();

  cout << "Final location: " << location.forward << " " << location.depth
       << endl;
  cout << "Final value: " << location.forward * location.depth << endl;
  return 0;
}
