#ifndef _DATEL_ENCRYPT_BY_HANIMAR_H_
#define _DATEL_ENCRYPT_BY_HANIMAR_H_
/*
 *	Programmed by Hanimar, Mar 5, 2000
 *	Feel free to redistribute it.
 *
 *	This program encrypts/decrypts .enc file used by Datel's 
 *	Action Replay Utilities.
 *
 *	Caution:
 *		This program requires that
 *			'int' must be 4 bytes long.
 *			CPU runs as Little-Endian.
 *	History:
 *		I've Got PS2:)	2000-03-04
 *		Version 0.3:	2000-03-05
 */

#define VERSION		0.3
#define VERSION_STR	"0.30"

/*
 *	APIs
 */
#ifdef __cplusplus
extern "C" {
#endif

/*
 *	DatelEncrypt() encrypts 'image'.
 *	nWord: byte/4
 */
void DatelEncrypt(void *image, int nWord);
/*
 *	DatelDecrypt() decrypts 'image'.
 *	nWord: byte/4
 */
void DatelDecrypt(void *image, int nWord);

#ifdef __cplusplus
}
#endif

#endif /* _DATEL_ENCRYPT_BY_HANIMAR_H_ */
