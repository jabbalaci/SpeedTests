enum MAX = 440_000_000;
enum int[10] CACHE = () {
    int[10] cache;
    import std.math : pow;

    for (int i = 1; i <= 9; ++i)
        cache[i] = i.pow(i);
    return cache;
}();

@nogc bool isMunchausen(const int number)
{
    int total;

    for (int n = number; n > 0; n /= 10)
    {
        const int digit = n % 10;
        total += CACHE[digit];
        if (total > number)
            return false;
    }

    return total == number;
}

int main()
{
    string buf;
    buf.reserve(24);
    import std.conv : to;

    foreach (i; 0 .. MAX + 1)
        if (i.isMunchausen())
            buf ~= to!string(i) ~ "\n";

    import std.stdio : write;

    write(buf);

    import core.stdc.stdlib : EXIT_SUCCESS;

    return EXIT_SUCCESS;
}
