#include <iostream>

using namespace std;

void print_a_plus_b(int a, int b);

int main(int argc, char **argv) {
  cout << "[Shared] hello world!" << endl;
  print_a_plus_b(3, 4);
  return 0;
}
