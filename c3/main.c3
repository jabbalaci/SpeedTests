import std::io;

macro cache_setup()
{
    int[10] $x;
    $for var $i = 1; $i <= 9; $i++:
        $x[$i] = 1;
        $for var $j = 0; $j < $i; $j++:
            $x[$i] *= $i;
	$endfor
    $endfor
    return $x;
}

const int MAX = 440000000;
const int[10] CACHE = cache_setup();

fn bool is_munchausen(int number)
{
    int n = number;
    int total = 0;

    while (n > 0) {
        int digit = n % 10;
        total += CACHE[digit];
        if (total > number) return false;
        n /= 10;
    }

    return total == number;
}

fn void main()
{
    for (int i = 0; i < MAX; i++) {
        if (is_munchausen(i)) io::printn(i);
    }
}

