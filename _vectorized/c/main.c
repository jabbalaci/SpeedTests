#include <stdio.h>
#include <math.h>
#include <stdbool.h>

#define MAX 440000000
#define M 32

int cache[10];

void is_munchausen(const int number,int b[M])
{
    int n[M];
    int total[M];
    for(int j=0;j<M;j++){
        n[j] = number + j;
        total[j] = 0;
    }
    for(int j=0;j<M;j++)
        total[j] += cache[n[j] % 10];
    for(int i=1;i<9;i++){
        for(int j=0;j<M;j++)
            n[j] /= 10;
        for(int j=0;j<M;j++)
            total[j] += cache[n[j] % 10];
    }
    for(int j=0;j<M;j++)
        b[j] = (number + j) == total[j];
}

void set_cache()
{
    cache[0] = 0;
    for (int i = 1; i <= 9; ++i) {
        cache[i] = pow(i, i);
    }
}

int main()
{
    int b[M];
    set_cache();

    for (int i = 0; i < MAX; i+=M)
    {
        is_munchausen(i,b);
        for(int j=0;j<M;j++)
        {
            if(b[j])
            {
                printf("%d\n",i+j);
            }
        }
    }

    return 0;
}
