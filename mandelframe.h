#include <stdint.h>
#include "display.h"
struct linebuf
{
	uint8_t buf[2*160*80];
};

void mandelframe();
