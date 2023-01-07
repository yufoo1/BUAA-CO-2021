#include <stdio.h>
#include <math.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <time.h>
int f[11][11];
int h[11][11];
int main () {
	int m1, n1;
	scanf("%d%d", &m1, &n1);
	int m2, n2;
	scanf("%d%d", &m2, &n2);
	int i, j, k, l;
	for (i=0; i<m1; i++) {
		for (j=0; j<n1; j++) {
			scanf("%d", &f[i][j]);
		}
	}
	for (i=0; i<m2; i++) {
		for (j=0; j<n2; j++) {
			scanf("%d", &h[i][j]);
		}
	}
	for (i=0; i<m1-m2+1; i++) {
		for (j=0; j<n1-n2+1; j++) {
			int sum = 0;
			for (k=0; k<m2; k++) {
				for (l=0; l<n2; l++) {
					sum += f[i+k][j+l] * h[k][l];
				}
			}
			printf("%d " , sum);
		}
		printf("\n");
	}
	return 0;
}

