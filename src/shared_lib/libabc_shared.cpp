// Copyright (c) 2024 Xiangyu Kong
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

#include <fmt/core.h>
#include <shared_lib/libabc_shared.hpp>

void print_a_plus_b(int a, int b) {
  fmt::print("[Shared] a + b = {}\n", a + b);
}