#!/usr/bin/env dart

import 'dart:math';

const N = 440000000;

bool isMunchausen(int number, List<int> cache) {
  var n = number;
  var total = 0;

  while (n > 0) {
    var digit = n % 10;
    total += cache[digit];
    if (total > number) {
      return false;
    }
    n = n ~/ 10; // integer division
  }

  return total == number;
}

List<int> getCache() {
  var cache = [0];
  for (var i = 1; i <= 9; ++i) {
    cache.add(pow(i, i).toInt());
  }
  return cache;
}

void main() {
  List<int> cache = getCache();

  for (var i = 0; i < N; ++i) {
    if (isMunchausen(i, cache)) {
      print(i);
    }
  }
}
