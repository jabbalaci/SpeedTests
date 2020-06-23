private:
bool isMünchausen(ulong number, ulong[10] cache)
{
	int total;
	for (ulong n = number; n > 0; n /= 10)
	{
		const auto digit = n % 10;
		total += cache[digit];
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
	{
		// if ((n > 0) && n % 1_000_000 == 0)
			// printf("# %d\n", n);
		if (isMünchausen(n, cache))
			printf("%d\n", n);
	}
}
