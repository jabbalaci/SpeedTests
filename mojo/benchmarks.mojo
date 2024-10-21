"""An execution time (monotonic clock) benchmarked implementation.

One of the main value adding proposals of Mojo is the possibility to implement
according to compile time known variables. If a system has a certain instruction
set, or a certain cache line width, you could choose an optimal codepath or go
through a generic implementation, all with no overhead at runtime.

For example, you could have a piece of code that can run on consumer grade
hardware or a server. Most (recent) server CPUs have 512 width SIMD instructions
so the SIMD implementation will probably be faster than the others, but for a
consumer grade CPU it might not be the case. So you can do:
```mojo
from sys.info import simdbitwidth

fn use_simd_impl():
    ...

fn use_default_generic_impl():
    ...

fn main():
    @parameter
    if simdbitwidth() >= 512:
        use_simd_impl()
    else:
        use_default_generic_impl()
```

Benchmark results:
- CPU: Intel® Core™ i7-7700HQ
- Mojo: `mojo 24.5.0`

```text
----- var cache -----

--------------------------------------------------------------------------------
Benchmark results
--------------------------------------------------------------------------------
name,met (ms),iters
"List[index]",3306.2916476666669,3
"List[uint64]",3533.3548193333336,3
"List[uint32]",3256.7370993333334,3
"InlineArray[index]",3223.3666903333337,3
"InlineArray[uint64]",3447.278017666667,3
"InlineArray[uint32]",3449.9183376666665,3
"SIMD[index]",5220.6791823333333,3
"SIMD[uint64]",5209.1415980000002,3
"SIMD[uint32]",3860.0218596666668,3
---------------------

----- alias cache -----

--------------------------------------------------------------------------------
Benchmark results
--------------------------------------------------------------------------------
name,met (ms),iters
"List[index]",28006.380496333335,3
"List[uint64]",28363.006493333334,3
"List[uint32]",27395.122398000003,3
"InlineArray[index]",5484.9695549999997,3
"InlineArray[uint64]",3462.5887930000004,3
"InlineArray[uint32]",4037.6705256666664,3
"SIMD[index]",5387.3749506666672,3
"SIMD[uint64]",5371.1989166666672,3
"SIMD[uint32]",3916.1251316666662,3
---------------------

----- inside var cache -----

--------------------------------------------------------------------------------
Benchmark results
--------------------------------------------------------------------------------
name,met (ms),iters
"List[index]",28413.25831933333,3
"List[uint64]",30761.969798999999,3
"List[uint32]",28177.727659666667,3
"InlineArray[index]",5459.2123620000002,3
"InlineArray[uint64]",3462.447690333333,3
"InlineArray[uint32]",4035.450746,3
"SIMD[index]",5111.6211929999999,3
"SIMD[uint64]",5151.4636873333338,3
"SIMD[uint32]",3914.5738259999998,3
---------------------

----- inside alias cache -----

--------------------------------------------------------------------------------
Benchmark results
--------------------------------------------------------------------------------
name,met (ms),iters
"List[index]",155608.87565066668,3
"List[uint64]",157538.04243100001,3
"List[uint32]",156715.50045933333,3
"InlineArray[index]",3792.5845283333333,3
"InlineArray[uint64]",3877.5342996666664,3
"InlineArray[uint32]",3235.4407679999999,3
"SIMD[index]",5114.5434186666671,3
"SIMD[uint64]",5112.5602126666663,3
"SIMD[uint32]",3797.3388070000001,3
---------------------

total elapsed minutes:  88.0
```
"""

from benchmark import Bench, BenchConfig, BenchId, Bencher, keep
from collections import InlineArray
from time import perf_counter


fn is_munchausen_list[
    D: DType
](number: Scalar[D], cache: List[Scalar[D]]) -> Bool:
    n = number
    total = Scalar[D](0)

    while n > 0:
        digit = n % 10
        total += cache.unsafe_get(int(digit))  # no bounds checks
        if total > number:
            return False
        n //= 10
    return total == number


fn is_munchausen_list[D: DType](number: Scalar[D]) -> Bool:
    var cache = get_cache_list[D]()
    n = number
    total = Scalar[D](0)

    while n > 0:
        digit = n % 10
        total += cache.unsafe_get(int(digit))  # no bounds checks
        if total > number:
            return False
        n //= 10
    return total == number


fn is_munchausen_list[D: DType, aliased: Bool](number: Scalar[D]) -> Bool:
    alias cache = get_cache_list[D]()
    n = number
    total = Scalar[D](0)

    while n > 0:
        digit = n % 10
        total += cache.unsafe_get(int(digit))  # no bounds checks
        if total > number:
            return False
        n //= 10
    return total == number


fn is_munchausen_array[
    D: DType
](number: Scalar[D], cache: InlineArray[Scalar[D], 10]) -> Bool:
    n = number
    total = Scalar[D](0)

    while n > 0:
        digit = n % 10
        total += cache.unsafe_get(int(digit))  # no bounds checks
        if total > number:
            return False
        n //= 10
    return total == number


fn is_munchausen_array[D: DType](number: Scalar[D]) -> Bool:
    var cache = get_cache_array[D]()
    n = number
    total = Scalar[D](0)

    while n > 0:
        digit = n % 10
        total += cache.unsafe_get(int(digit))  # no bounds checks
        if total > number:
            return False
        n //= 10
    return total == number


fn is_munchausen_array[D: DType, aliased: Bool](number: Scalar[D]) -> Bool:
    alias cache = get_cache_array[D]()
    n = number
    total = Scalar[D](0)

    while n > 0:
        digit = n % 10
        total += cache.unsafe_get(int(digit))  # no bounds checks
        if total > number:
            return False
        n //= 10
    return total == number


fn is_munchausen_simd[D: DType](number: Scalar[D], cache: SIMD[D, 16]) -> Bool:
    vec = SIMD[D, 16]()

    @parameter
    for i in range(10):
        vec[i] = cache[int((number // (10**i)) % 10)]  # no bounds checks

    return vec.reduce_add() == number


fn is_munchausen_simd[D: DType](number: Scalar[D]) -> Bool:
    var cache = get_cache_simd[D]()
    vec = SIMD[D, 16]()

    @parameter
    for i in range(10):
        vec[i] = cache[int((number // (10**i)) % 10)]  # no bounds checks

    return vec.reduce_add() == number


fn is_munchausen_simd[D: DType, aliased: Bool](number: Scalar[D]) -> Bool:
    alias cache = get_cache_simd[D]()
    vec = SIMD[D, 16]()

    @parameter
    for i in range(10):
        vec[i] = cache[int((number // (10**i)) % 10)]  # no bounds checks

    return vec.reduce_add() == number


fn get_cache_list[D: DType]() -> List[Scalar[D]]:
    ca = List[Scalar[D]](capacity=10)
    ca.unsafe_set(0, 0)

    @parameter
    for i in range(1, 10):
        ca.unsafe_set(i, i**i)  # no bounds checks
    return ca


fn get_cache_array[D: DType]() -> InlineArray[Scalar[D], 10]:
    ca = InlineArray[Scalar[D], 10](0)

    @parameter
    for i in range(1, 10):
        ca[i] = i**i  # bound checked at compile time so there is no overhead
    return ca


fn get_cache_simd[D: DType]() -> SIMD[D, 16]:
    ca = SIMD[D, 16](0)

    @parameter
    for i in range(1, 10):
        ca[i] = i**i  # no bounds checks
    return ca


@always_inline
@parameter
fn bench_fn[D: DType, uid: Int, version: Int]():
    alias N = 440_000_000

    @parameter
    if uid == 0 and version == 0:
        var cache = get_cache_list[D]()
        for n in range(N):
            if is_munchausen_list[D](n, cache):
                keep(n)
    elif uid == 1 and version == 0:
        var cache = get_cache_array[D]()
        for n in range(N):
            if is_munchausen_array[D](n, cache):
                keep(n)
    elif uid == 2 and version == 0:
        var cache = get_cache_simd[D]()
        for n in range(N):
            if is_munchausen_simd[D](n, cache):
                keep(n)
    elif uid == 0 and version == 1:
        alias cache = get_cache_list[D]()
        for n in range(N):
            if is_munchausen_list[D](n, cache):
                keep(n)
    elif uid == 1 and version == 1:
        alias cache = get_cache_array[D]()
        for n in range(N):
            if is_munchausen_array[D](n, cache):
                keep(n)
    elif uid == 2 and version == 1:
        alias cache = get_cache_simd[D]()
        for n in range(N):
            if is_munchausen_simd[D](n, cache):
                keep(n)
    elif uid == 0 and version == 2:
        for n in range(N):
            if is_munchausen_list[D](n):
                keep(n)
    elif uid == 1 and version == 2:
        for n in range(N):
            if is_munchausen_array[D](n):
                keep(n)
    elif uid == 2 and version == 2:
        for n in range(N):
            if is_munchausen_simd[D](n):
                keep(n)
    elif uid == 0 and version == 3:
        for n in range(N):
            if is_munchausen_list[D, aliased=True](n):
                keep(n)
    elif uid == 1 and version == 3:
        for n in range(N):
            if is_munchausen_array[D, aliased=True](n):
                keep(n)
    else:
        for n in range(N):
            if is_munchausen_simd[D, aliased=True](n):
                keep(n)


fn main() raises:
    alias DTypes = (DType.index, DType.uint64, DType.uint32)
    """Types to benchmark. `DType.index` adjusts to the host biggest int."""

    var start = perf_counter()

    @parameter
    for v in range(4):
        m = Bench(BenchConfig(num_repetitions=1))

        print("")
        if v == 0:
            print("----- var cache -----")
        elif v == 1:
            print("----- alias cache -----")
        elif v == 2:
            print("----- inside var cache -----")
        elif v == 3:
            print("----- inside alias cache -----")

        @parameter
        for i in range(3):
            container = "List" if i == 0 else (
                "InlineArray" if i == 1 else "SIMD"
            )

            @parameter
            for j in range(DTypes.__len__()):  # yes this is ugly, WIP
                alias D = DTypes.get[j, DType]()
                b_id = BenchId(container + "[" + str(D) + "]")
                m.bench_function[Bencher.iter[bench_fn[D, i, v]]](b_id)

        m.dump_report()
        print("---------------------", end="\n\n")

    print("total elapsed minutes: ", (perf_counter() - start) // 60)
