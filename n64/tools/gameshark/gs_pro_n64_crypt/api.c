/*
 *	Programmed by Hanimar, Mar 5, 2000
 *	Feel free to redistribute it.
 *
 *	TABSTOP=4
 */
#include "datelenc.h"

static unsigned int Seeds[] = {

	0x1471332E,
	0x8149432E,
	0x75697B21,
	0x15597883,
	
	0x1C2AD435,
	0x13ADE834,
	0xE2DE18B1,
	0x51BC7835,
	
	0x158732D4,
	0x68D77612,
	0x55424441,
	0xD1F3FE22,
	
	0xAEED7894,
	0x34685312,
	0xA3266563,
	0x452CC12E

};

static void enc_Pass(unsigned int *image, int nWord);

static void dec_Pass(unsigned int *image, int nWord);

/* ENCRYPT */
void DatelEncrypt(void *image, int nWord)
{
	enc_Pass(image, nWord);
	return;
}

/* DECRYPT */
void DatelDecrypt(void *image, int nWord)
{
	dec_Pass(image, nWord);
	return;
}

/*
 *	private functions
 */

static void enc_Pass(unsigned int *image, int nWord)
{
	unsigned int seed;
	int n = 0, i;
	for (i = 0 ; i < nWord ; i ++)
	{
		seed = Seeds[n];
		image[i] += seed & 0xff00;
		image[i] ^= seed;
		if (++ n >= 0x10)
			n = 0;
	}
	return;
}

static void dec_Pass(unsigned int *image, int nWord)
{
	int n = 0, i;
	unsigned int seed;
	for (i = 0 ; i < nWord ; i ++)
	{
		seed = Seeds[n];
		image[i] ^= seed;
		image[i] -= seed & 0xff00;
		if (++ n >= 0x10)
			n = 0;
	}
	return;
}
