const CACHE = Array.from({ length: 10 }, (_, i) => i === 0 ? 0 : Math.pow(i, i));

let _isMunchausen = (number: number) => {
  let total = 0,
      digit = 0,
      n = number;

  while (n > 0) {
    digit = n % 10;
    total += CACHE[digit];

    if (total > number) {
        return false;
    }

    n = Math.floor(n / 10);
  }

  return total === number;
};

for (let i = 0; i < 440000000; i++) {
  if (_isMunchausen(i)) {
      console.log(i);
  }
}
