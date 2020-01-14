#include <stdint.h>
#include "display.h"
struct linebuf
{
	uint8_t buf[320*80];
};

void mandelfp();
