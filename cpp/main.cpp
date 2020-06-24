#include <array>
#include <iostream>
#include <cmath>

constexpr auto MAX{int{440'000'000}};

template <class T, size_t N = 10>
[[nodiscard]] constexpr auto get_cache() -> std::array<T, N>
{
    auto cache{std::array<T, N>{}};
    for (size_t i{0}; i < N; ++i)
        cache[i] = pow(i, i);
    return cache;
}

template <class T, size_t N = 10>
[[nodiscard]] auto is_munchausen(const T number, const std::array<T, N> &cache) -> bool
{
    auto total{0};
    for (auto n{number}; n > 0; n /= 10)
    {
        auto digit{n % 10};
        total += cache[digit];
        if (total > number)
            return false;
    }
    return total == number;
}

auto main() -> int
{
    const auto cache{get_cache<int>()}; // can't FFI to cmath at constexpr
    std::ios_base::sync_with_stdio(false);
    for (int i = 0; i < MAX; ++i)
        if (is_munchausen(i, cache))
            std::cout << i << '\n';
}
