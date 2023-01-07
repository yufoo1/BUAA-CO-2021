#include <stdio.h>
#include <math.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <time.h>
#include <limits.h>
#include <float.h>
int matrix[7][7];
int flag[7][7];
int n, m;
int cnt;
int start_point_x, start_point_y;
int end_point_x, end_point_y;
void dfs(int x, int y) {
    if (x == end_point_x && y == end_point_y) {
        cnt++;
    }
    else {
        if (x-1 >= 0 && flag[x-1][y] == 0 && matrix[x-1][y] == 0) {
            flag[x-1][y] = 1;
            dfs(x-1, y);
            flag[x-1][y] = 0;
        }
        if (y-1 >= 0 && flag[x][y-1] == 0 && matrix[x][y-1] == 0) {
            flag[x][y-1] = 1;
            dfs(x, y-1);
            flag[x][y-1] = 0;
        }
        if (x+1 < n && flag[x+1][y] == 0 && matrix[x+1][y] == 0) {
            flag[x+1][y] = 1;
            dfs(x+1, y);
            flag[x+1][y] = 0;
        }
        if (y+1 < m && flag[x][y+1] == 0 && matrix[x][y+1] == 0) {
            flag[x][y+1] = 1;
            dfs(x, y+1);
            flag[x][y+1] = 0;
        }
    }
}



int main () {
    scanf("%d%d", &n, &m);
    int i, j;
    for (i=0; i<n; i++) {
        for (j=0; j<m; j++) {
            scanf("%d", &matrix[i][j]);
        }
    }
    scanf("%d%d%d%d", &start_point_x, &start_point_y, &end_point_x, &end_point_y);
    start_point_x--;
    start_point_y--;
    end_point_x--;
    end_point_y--;
    flag[start_point_x][start_point_y] = 1;
    dfs(start_point_x, start_point_y);
    printf("%d", cnt);
	return 0;
}