#include <stdio.h>
#include <math.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <time.h>
int a[9][9];
int b[9][9];
int main () {
	int n;
	scanf("%d", &n);
	int i, j, k;
	for (i=0; i<n; i++) {
		for (j=0; j<n; j++) {
			scanf("%d", &a[i][j]);
		}
	}
	for (i=0; i<n; i++) {
		for (j=0; j<n; j++) {
			scanf("%d", &b[i][j]);
		}
	}
	for (i=0; i<n; i++) {
		for (j=0; j<n; j++) {
			int sum = 0;
			for (k=0; k<n; k++) {
				sum += a[i][k] * b[k][j];
			}
			printf("%d ", sum);
		}
		printf("\n");
	}
	return 0;
}

