#include <stdio.h>
#include <math.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <time.h>
int ans[255];
int cnt; 
int main () {
	int n;
	scanf("%d", &n);
	int i, j;
	ans[0] = 1;
	int tmp;
	int add;
	for (i=2; i<=n; i++) {
		add = 0;
		for (j=0; j<i; j++) {
			tmp = ans[j] * i + add;
			ans[j] = tmp % 10000;
			add = tmp / 10000;
		}
	}
	int flag = 0;
	for (i=254; i>=0; i--) {
		if (flag == 0 && ans[i] == 0) {
		}
		else {
			if(flag == 0) printf("%d", ans[i]);
			else printf("%04d", ans[i]);
			flag = 1;	
		}
	}
	printf("\ncnt: %d", cnt);
	return 0;
}
