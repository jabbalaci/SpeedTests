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

The benchmark results in my machine (Intel® Core™ i7-7700HQ):
Total elapsed time: 36 minutes

```text
----- alias cache -----

--------------------------------------------------------------------------------
Benchmark results
--------------------------------------------------------------------------------
name,met (ms),iters
"List[index]",5565.264568333333,3
"List[uint64]",3591.7140870000003,3
"List[uint32]",4151.1825573333335,3
"InlineArray[index]",5150.8213533333337,3
"InlineArray[uint64]",5153.0647436666668,3
"InlineArray[uint32]",3843.8006373333333,3
"SIMD[index]",32043.235577666666,3
"SIMD[uint64]",32029.279429333332,3
"SIMD[uint32]",31481.690623333332,3
---------------------

----- inside var cache -----

--------------------------------------------------------------------------------
Benchmark results
--------------------------------------------------------------------------------
name,met (ms),iters
"List[index]",5125.1768590000001,3
"List[uint64]",5870.164615333334,3
"List[uint32]",4137.7386486666664,3
"InlineArray[index]",176018.54730166667,3
"InlineArray[uint64]",174528.69400766667,3
"InlineArray[uint32]",175283.42724133332,3
"SIMD[index]",3878.4162293333334,3
"SIMD[uint64]",3979.1113519999999,3
"SIMD[uint32]",3347.5661883333337,3
---------------------

----- inside alias cache -----

--------------------------------------------------------------------------------
Benchmark results
--------------------------------------------------------------------------------
name,met (ms),iters
"List[index]",5652.6210193333327,3
"List[uint64]",6159.4229459999997,3
"List[uint32]",4458.5344809999997,3
"InlineArray[index]",6134.4724230000002,3
"InlineArray[uint64]",6057.491078,3
"InlineArray[uint32]",4401.9903913333337,3
"SIMD[index]",5775.0725300000004,3
"SIMD[uint64]",6060.4906896666662,3
"SIMD[uint32]",4408.5160473333335,3
---------------------
```
"""

from benchmark import Bench, BenchConfig, BenchId, Bencher, keep
from collections import InlineArray


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
    elif uid == 3 and version == 0:
        alias cache = get_cache_list[D]()
        for n in range(N):
            if is_munchausen_list[D](n, cache):
                keep(n)
    elif uid == 0 and version == 1:
        alias cache = get_cache_array[D]()
        for n in range(N):
            if is_munchausen_array[D](n, cache):
                keep(n)
    elif uid == 1 and version == 1:
        alias cache = get_cache_simd[D]()
        for n in range(N):
            if is_munchausen_simd[D](n, cache):
                keep(n)
    elif uid == 2 and version == 1:
        for n in range(N):
            if is_munchausen_list[D](n):
                keep(n)
    elif uid == 3 and version == 1:
        for n in range(N):
            if is_munchausen_array[D](n):
                keep(n)
    elif uid == 0 and version == 2:
        for n in range(N):
            if is_munchausen_simd[D](n):
                keep(n)
    elif uid == 1 and version == 2:
        for n in range(N):
            if is_munchausen_list[D, aliased=True](n):
                keep(n)
    elif uid == 2 and version == 2:
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
