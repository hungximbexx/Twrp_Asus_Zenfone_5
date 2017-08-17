/*
 * unpack.c
 *
 * Copyright 2012 Emilio López <turl@tuxfamily.org>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 *
 *
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/stat.h>

#ifdef __APPLE__
  #include <libkern/OSByteOrder.h>

  #define htobe16(x) OSSwapHostToBigInt16(x)
  #define htole16(x) OSSwapHostToLittleInt16(x)
  #define be16toh(x) OSSwapBigToHostInt16(x)
  #define le16toh(x) OSSwapLittleToHostInt16(x)

  #define htobe32(x) OSSwapHostToBigInt32(x)
  #define htole32(x) OSSwapHostToLittleInt32(x)
  #define be32toh(x) OSSwapBigToHostInt32(x)
  #define le32toh(x) OSSwapLittleToHostInt32(x)

  #define htobe64(x) OSSwapHostToBigInt64(x)
  #define htole64(x) OSSwapHostToLittleInt64(x)
  #define be64toh(x) OSSwapBigToHostInt64(x)
  #define le64toh(x) OSSwapLittleToHostInt64(x)
#include <sys/types.h>
#else
#include <endian.h>
#endif  /* __APPLE__ */

#include "bootheader.h"

#define ERROR(...) do { fprintf(stderr, __VA_ARGS__); return 1; } while(0)

int main(int argc, char *argv[])
{
	char *origin;
	char *bzImage;
	char *ramdisk;
	char *cmdline;
	FILE *forigin;
	FILE *fbzImage;
	FILE *framdisk;
	FILE *fcmdline;
	uint32_t bzImageLen;
	uint32_t ramdiskLen;
	uint32_t cmdlineLen = CMDLINE_SIZE;
	uint32_t missing;
	char buf[BUFSIZ];
	size_t size;

	if (argc != 5)
		ERROR("Usage: %s <image to unpack> <bzImage out> <ramdisk out> <cmdline out>\n", argv[0]);

	origin = argv[1];
	bzImage = argv[2];
	ramdisk = argv[3];
	cmdline = argv[4];

	forigin = fopen(origin, "r");
	fbzImage = fopen(bzImage, "w");
	framdisk = fopen(ramdisk, "w");
	fcmdline = fopen(cmdline, "w");

	if (!forigin || !bzImage || !framdisk || !fcmdline)
		ERROR("ERROR: failed to open origin or output images\n");

	/* Read cmdline from the image to unpack */
	if (fseek(forigin, CMDLINE_START, SEEK_SET) == -1)
		ERROR("ERROR: failed to seek on image\n");

	missing = cmdlineLen;
	while (missing > 0) {
		size = fread(buf, 1, ((missing > BUFSIZ) ? BUFSIZ : missing), forigin);
		if (size != 0) {
			fwrite(buf, 1, size, fcmdline);
			missing -= size;
		}
	}

	/* Read bzImage length from the image to unpack */
	if (fseek(forigin, CMDLINE_END, SEEK_SET) == -1)
		ERROR("ERROR: failed to seek on image\n");

	if (fread(&bzImageLen, sizeof(uint32_t), 1, forigin) != 1)
		ERROR("ERROR: failed to read bzImage length\n");
	else
		bzImageLen = le32toh(bzImageLen);

	/* Read ramdisk length from the image to unpack */
	if (fseek(forigin, (CMDLINE_END+sizeof(uint32_t)), SEEK_SET) == -1)
		ERROR("ERROR: failed to seek on image\n");

	if (fread(&ramdiskLen, sizeof(uint32_t), 1, forigin) != 1)
		ERROR("ERROR: failed to read ramdisk length\n");
	else
		ramdiskLen = le32toh(ramdiskLen);

	/* Copy bzImage */
	if (fseek(forigin, sizeof(struct bootheader), SEEK_SET) == -1)
		ERROR("ERROR: failed to seek when copying bzImage\n");

	missing = bzImageLen;
	while (missing > 0) {
		size = fread(buf, 1, ((missing > BUFSIZ) ? BUFSIZ : missing), forigin);
		if (size != 0) {
			fwrite(buf, 1, size, fbzImage);
			missing -= size;
		}
	}

	/* Copy ramdisk */
	if (fseek(forigin, (sizeof(struct bootheader)+bzImageLen), SEEK_SET) == -1)
		ERROR("ERROR: failed to seek when copying ramdisk\n");

	missing = ramdiskLen;
	while (missing > 0) {
		size = fread(buf, 1, ((missing > BUFSIZ) ? BUFSIZ : missing), forigin);
		if (size != 0) {
			fwrite(buf, 1, size, framdisk);
			missing -= size;
		}
	}

	return 0;
}
