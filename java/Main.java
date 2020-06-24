import java.lang.Math;

public class Main {
    private final static int LIMIT = 440_000_000;
    private final int[] cache = this.get_cache();

    private boolean is_munchausen(final int number) {
        int n = number;
        int total = 0;

        while (n > 0) {
            final int digit = n % 10;
            total += cache[digit];
            if (total > number) {
                return false;
            }
            n = n / 10;
        }
        return total == number;
    }

    private int[] get_cache() {
        int[] cache = new int[10];
        cache[0] = 0;
        for (int i = 1; i <= 9; ++i) {
            cache[i] = (int)Math.pow(i, i);
        }
        return cache;
    }

    private void start() {
        for (int i = 0; i < LIMIT; ++i) {
            // if ((i > 0) && (i % 1_000_000 == 0)) {
            // System.out.println("# " + i);
            // }
            if (is_munchausen(i)) {
                System.out.println(i);
            }
        }
    }

    public static void main(final String[] args) {
        final Main m = new Main();
        m.start();
    }
}
