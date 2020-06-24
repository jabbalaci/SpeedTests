private:
enum int MAX = 440_000_000;
enum int[10] CACHE = () {
	int[10] cache;
	import std.math : pow;

	for (int i = 1; i <= 9; ++i)
		cache[i] = i.pow(i);
	return cache;
}();

bool isMünchausen(ulong number)
{
	int total;
	for (ulong n = number; n > 0; n /= 10)
	{
		const auto digit = n % 10;
		total += CACHE[digit];
		if (total > number)
			return false;
	}

	return number == total;
}

ulong[10] getCache()
{
	ulong[10] result;
	import std.math : pow;

	foreach (i; 1 .. 10)
		result[i] = i.pow(i);
	return result;
}

public:
void main()
{
	enum cache = getCache();

	import core.stdc.stdio : printf;
	import std.parallelism : parallel;
	import std.range : iota;

	foreach (n; parallel(iota(440_000_000)))
			printf("%d\n", n);
}
