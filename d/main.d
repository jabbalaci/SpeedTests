import std.stdio;
import std.math;

const int MAX = 440_000_000;


bool is_munchausen(const int number, const int[] cache)
{
    int n = number;
    int total = 0;

    while (n > 0)
    {
        const int digit = n % 10;
        total += cache[digit];
        if (total > number) {
            return false;
        }
        n = n / 10;
    }

    return total == number;
}

void get_cache(int n, int[] cache)
{
    cache[0] = 0;
    for (int i = 1; i <= 9; ++i)
    {
        cache[i] = pow(i, i);
    }
}

int main()
{
    int[10] cache;
    get_cache(10, cache);

    for (int i = 0; i < MAX; ++i)
    {
        // if ((i > 0) && (i % 1_000_000 == 0)) {
            // writefln("# %s", i);
        // }
        if (is_munchausen(i, cache)) {
            i.writeln;
        }
    }

    return 0;
}
