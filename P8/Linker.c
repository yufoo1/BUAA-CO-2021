#include <stdio.h>
#include <math.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <time.h>
int main () {
	FILE *text = fopen("text.txt", "r");
	FILE *ktext = fopen("ktext.txt", "r");
	FILE *code = fopen("code.txt", "w");
	char *buff;
	int ret;
	buff = (char *) malloc (sizeof (char) * 1024);
	int text_line_cnt = 0;
	int i;
	for (i=0; i<1120; i++) {
		ret = fread(buff, 1, 9, text);
		if (ret != 0 && buff[0] != 0) {
			fwrite(buff, ret, 1, code);
		}
		else {
			fwrite("00000000\n", 9, 1, code);
		}
	}
	while (1) {
		ret = fread(buff, 1, 9, ktext);
		if (ret != 0 && buff[0] != 0) {
			fwrite(buff, ret, 1, code);
		}
		else {
			break;
		}
	}
	
	fclose(text);
	fclose(ktext);
	fclose(code);
	return 0;
}

