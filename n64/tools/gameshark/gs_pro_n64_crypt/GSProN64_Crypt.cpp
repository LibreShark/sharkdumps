/*
 *	Programmed by Hanimar, Mar 5, 2000
 *	Feel free to redistribute it.
 *
 *	TABSTOP=4
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "datelenc.h"

static void *loadFromFile(const char *fname, int *pWord);
static int writeToFile(const char *fname, void *image, int nWord);

void Usage(const char *me)
{
	const char *ptr;

	ptr = strrchr(me, '\\');
	if (ptr != NULL) ptr ++;
	else ptr = me;

	fprintf(stderr, "%s Version %s by Code Master (Based off Hanimar)\n", ptr, VERSION_STR);

	fprintf(stderr, "Usage: %s [OPTIONS] <in> <out>\n\n", ptr);
	fputs("OPTIONS are:\n", stderr);
	fputs("\t-e: Encrypts <in>.\n", stderr);

	fputc('\n', stderr);
	exit(EXIT_FAILURE);
}

int main(int argc, char **argv)
{
	const char *infile = NULL;
	const char *outfile = NULL;
	int i;
	const char *ptr;
	enum {
		DECRYPT, ENCRYPT
	} whatToDo = DECRYPT;
	int nWord;

	void *image;

	if (argc < 3) Usage(argv[0]);

	for (i = 1 ; i < argc ; i ++) {
		if (argv[i][0] == '-' || argv[i][0] == '/') {
			for (ptr = &argv[i][1] ; *ptr != '\0' ; ptr ++) {
				switch ((int)*ptr) {
				case 'e':
					whatToDo = ENCRYPT;
					break;
				default:
					fprintf(stderr, "Unknown option - %c\n", *ptr);
					Usage(argv[0]);
					break;
				}
			}
		} else if (infile == NULL) infile = argv[i];
		else if (outfile == NULL) outfile = argv[i];
		else Usage(argv[0]);
	}
	if (outfile == NULL) Usage(argv[0]);
	image = loadFromFile(infile, &nWord);
	if (image == NULL) {
		fprintf(stderr, "Can not load file %s\n", infile);
		exit(EXIT_FAILURE);
	}

	if (whatToDo == DECRYPT) {
		DatelDecrypt(image, nWord);
	} else {
		DatelEncrypt(image, nWord);
	}
	if (writeToFile(outfile, image, nWord) != 0) {
		fprintf(stderr, "Can not write to file %s\n", outfile);
		free(image);
		exit(EXIT_FAILURE);
	}
	free(image);

	return EXIT_SUCCESS;
}

static void *loadFromFile(const char *fname, int *pWord)
{
	FILE *fp;
	long size;
	int nWord;
	void *image;

	fp = fopen(fname, "rb");
	if (fp == NULL) return NULL;

	/* Use stat()? That is not supported by ANSI. */
	fseek(fp, 0, SEEK_END);
	size = ftell(fp);
	fseek(fp, 0, SEEK_SET);
	nWord = (size + 3)/4;

	image = malloc(nWord * 4);
	if (image == NULL) {
		fputs("Cannot allocate memory.\n", stderr);
		fclose(fp);
		return NULL;
	}
	if ((long)fread(image, 1, size, fp) != size) {
		/* ????????? */
	}
	while (size < nWord * 4) ((unsigned char *)image)[size ++] = 0xff;

	fclose(fp);

	*pWord = nWord;
	return image;
}

static int writeToFile(const char *fname, void *image, int nWord)
{
	FILE *fp;
	int ret = 0;

	fp = fopen(fname, "wb");
	if (fp == NULL) return -1;
	if ((long)fwrite(image, 4, nWord, fp) != nWord) ret = -1;
	fclose(fp);

	return ret;
}
