#!/usr/bin/env dart

import 'dart:math';

const N = 440000000;

bool is_munchausen(int number, List<int> cache)
{
  int n = number;
  int total = 0;

  while (n > 0)
  {
    int digit = n % 10;
    total += cache[digit];
    if (total > number) {
      return false;
    }
    n = n ~/ 10;    // integer division
  }

  return total == number;
}


List<int> get_cache()
{
  var cache = [0];
  for (int i = 1; i <= 9; ++i) {
    cache.add(pow(i, i));
  }
  return cache;
}

int main()
{
  List<int> cache = get_cache();

  for (int n = 0; n < N; ++n)
  {
    // if ((n > 0) && (n % 1000000 == 0)) {
      // print("# $n");
    // }
    if (is_munchausen(n, cache)) {
      print(n);
    }
  }

  return 0;
}
