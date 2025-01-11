private:
enum ulong MAX = 440_000_000;
enum ulong[10] CACHE = () {
	ulong[10] cache;
    import std.math : pow;

	for (ulong i = 1; i <= 9; ++i) {
		cache[i] = i.pow(i);
	}

	return cache;
}();

bool isMunchausen(ulong number)
{
	ulong total;
	for (ulong n = number; n > 0; n /= 10)
	{
		const auto digit = n % 10;
		total += CACHE[digit];
		if (total > number)
			return false;
	}

	return number == total;
}

public:
void main()
{
	import core.stdc.stdio : printf;
	import std.parallelism : parallel;
	import std.range : iota;

	foreach (n; parallel(iota(MAX))) {
		if (isMunchausen(n)) {
			printf("%ld\n", n);
		}
	}
}

