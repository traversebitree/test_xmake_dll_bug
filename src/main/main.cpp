#include <iostream>
#include <shared_lib/libabc_shared.hpp>


using namespace std;

int main(int argc, char **argv) {
  cout << "[Shared] hello world!" << endl;
  print_a_plus_b(3, 4);
  return 0;
}
