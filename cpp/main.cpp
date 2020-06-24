#include <iostream>
#include <cmath>

using namespace std;

#define MAX 440000000

bool is_munchausen(const int number, const int cache[])
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
        n = n / 10;
    }

    return total == number;
}

void get_cache(int n, int cache[])
{
    cache[0] = 0;
    for (int i = 1; i <= 9; ++i)
    {
        cache[i] = pow(i, i);
    }
}

int main()
{
    int cache[10];
    get_cache(10, cache);

    for (int i = 0; i < MAX; ++i)
    {
        // if ((i > 0) && (i % 1000000 == 0)) {
            // cout << "# " << i << '\n';
        // }
        if (is_munchausen(i, cache)) {
            cout << i << '\n';
        }
    }

    return 0;
}
