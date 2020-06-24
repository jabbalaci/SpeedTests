#include <iostream>
#include <cmath>

constexpr auto MAX{int{440'000'000}};

int cache[10];

void set_cache()
{
    cache[0] = 0;
    for (int i = 1; i <= 9; ++i) {
        cache[i] = pow(i, i);
    }
}

auto is_munchausen(const int number) -> bool
{
    auto total{0};

    for (auto n{number}; n > 0; n /= 10)
    {
        auto digit{n % 10};
        total += cache[digit];
        if (total > number) {
            return false;
        }
    }

    return total == number;
}

auto main() -> int
{
    set_cache();

    for (int i = 0; i < MAX; ++i) {
        if (is_munchausen(i)) {
            std::cout << i << '\n';
        }
    }
}
