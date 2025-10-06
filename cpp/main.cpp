#include <cstdint>
#include <print>
#include <utility>

constexpr uint32_t MAX = 440'000'000;

constexpr inline void is_munchausen(uint32_t number)
{
    constexpr int cache[10] = {
        0,
        1,
        4,
        27,
        256,
        3125,
        46656,
        823543,
        16777216,
        387420489,
    };

    uint32_t total = 0;

    for (uint32_t n = number;;)
    {
        if (n < 10) {
            if (total + cache[n] == number) {
                std::println("{}", number);
            }
            return;
        }
        uint32_t d = n / 10;
        total += cache[n - 10 * d];
        if (total > number) return;
        n = d;
    }
    std::unreachable();
}

auto main() -> int
{
    for (uint32_t i = 0; i < MAX; ++i) {
        is_munchausen(i);
    }
}