using System;
using static System.Console;

namespace cs
{
    class Program
    {
        private const int LIMIT = 440_000_000;
        private int[] cache;

        public Program() {
            this.cache = this.GetCache();
        }

        private int[] GetCache() {
            int[] cache = new int[10];
            cache[0] = 0;
            for (int i = 1; i <= 9; ++i) {
                cache[i] = (int)Math.Pow(i, i);
            }
            return cache;
        }

        private bool IsMunchausen(int number) {
            int n = number;
            int total = 0;

            while (n > 0) {
                int digit = n % 10;
                total += cache[digit];
                if (total > number) {
                    return false;
                }
                n = n / 10;
            }
            return total == number;
        }

        private void start() {
            for (int i = 0; i < LIMIT; ++i) {
                if (IsMunchausen(i)) {
                    WriteLine(i);
                }
            }
        }

        public static void Main(string[] args) {
            Program p = new Program();
            p.start();
        }
    }
}
