#!/usr/bin/env dart

import 'dart:math';

const N = 440000000;

final cache = List<int>.generate(10, (i) => 0 == i ? 0 : pow(i, i).toInt());

bool isMunchausen(final int number, final List<int> powers) {
  int total = 0;
  for (int n = number; n > 0; n ~/= 10) {
    final digit = n.remainder(10);
    total += powers[digit];
    if (number < total) {
      return false;
    }
  }
  return number == total;
}

void main() {
  for (int i = 0; i < N; i++) {
    if (isMunchausen(i, cache)) {
      print(i);
    }
  }
}
