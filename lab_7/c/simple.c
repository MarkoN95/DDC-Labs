#include <stdio.h>

int main(void) {
  int A = 10;
  int B = 20;
  int sum = 0;

  for(int i = A; i <= B; i++) {
    sum += i;
  }

  printf("sum: %d\n", sum);

  return 0;
}
