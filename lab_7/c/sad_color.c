#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int abs_diff_color(int r1, int g1, int b1, int r2, int g2, int b2) {
  int abs_diff = abs(r1 - r2) + abs(g1 - g2) + abs(b1 - b2);
  return abs_diff;
}

int main(void) {
  int c1[3] = { 3, 5, 7 };
  int c2[3] = { 11, 13, 17 };

  int abs_diff = abs_diff_color(c1[0], c1[1], c1[2], c2[0], c2[1], c2[2]);

  printf("abs_diff: %d\n", abs_diff);

  return 0;
}
