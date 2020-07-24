/*
 * Copyright (c) 2019, Emil Renner Berthing
 * Copyright (c) 2019,2020, Martin Wendt
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. Neither the name of the copyright holder nor the names of its contributors
 *    may be used to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
 * OF SUCH DAMAGE.
 */
#include <stdio.h>

#include "gd32vf103/csr.h"

#include "lib/mtimer.h"
#include "lib/eclic.h"
#include "lib/rcu.h"
#include "lib/gpio.h"
#include "lib/stdio-usbacm.h"

#include "LonganNano.h"
//#include "uart0.h"
#include "display.h"

//#include "mandelfp.h"

//#include "term.h"
#include "mandelframe.h"

extern struct dp_font ter16n;
extern struct dp_font ter16b;
extern struct dp_font ter20n;
extern struct dp_font ter20b;
extern struct dp_font ter24n;
extern struct dp_font ter24b;

#define BLINK (CORECLOCK/4) /* 1 second */

void MTIMER_IRQHandler(void)
{
	uint64_t next;

	gpio_pin_toggle(LED_BLUE);

	next = mtimer_mtimecmp() + BLINK;
	MTIMER->mtimecmp_hi = next >> 32;
	MTIMER->mtimecmp_lo = next;
}

void delay(volatile uint32_t dly)
{
    while(dly--);
}


// Simple 'busy loop' delay method.
__attribute__( ( optimize( "O0" ) ) )
void delay_cycles( uint32_t cyc ) {
  uint32_t d_i;
  for ( d_i = 0; d_i < cyc; ++d_i ) {
    __asm__( "nop" );
  }
}


//=================================================================
int main(void)
{
	/* initialize system clock */
	rcu_sysclk_init();

	/* initialize eclic */
	eclic_init();
	/* enable global interrupts */
	eclic_global_interrupt_enable();

	//uart0_init(CORECLOCK, 115200);
	usbacm_init();

	{
		uint64_t next = mtimer_mtime() + BLINK;
        MTIMER->mtimecmp_hi = next >> 32;
		MTIMER->mtimecmp_lo = next;

	}
	eclic_config(MTIMER_IRQn, ECLIC_ATTR_TRIG_LEVEL, 1);
	//eclic_enable(MTIMER_IRQn);

	RCU->APB2EN |= RCU_APB2EN_PAEN | RCU_APB2EN_PCEN;

	gpio_pin_set(LED_RED);
	gpio_pin_set(LED_GREEN);
	gpio_pin_set(LED_BLUE);
	gpio_pin_config(LED_RED,   GPIO_MODE_OD_2MHZ);
	gpio_pin_config(LED_GREEN, GPIO_MODE_OD_2MHZ);
	gpio_pin_config(LED_BLUE,  GPIO_MODE_OD_2MHZ);

	dp_init();
    dp_on();
    
    gpio_pin_set(LED_BLUE);
    gpio_pin_clear(LED_BLUE); //clear means on
    
    #define BUTTON0 GPIO_PB9
    #define BUTTON1 GPIO_PB8
    #define BUTTON2 GPIO_PB7
    #define BUTTON3 GPIO_PB6
    #define BUTTON4 GPIO_PB5
    
    gpio_pin_config(BUTTON0, GPIO_MODE_IN_PULL);
    gpio_pin_config(BUTTON1, GPIO_MODE_IN_PULL);
    gpio_pin_config(BUTTON2, GPIO_MODE_IN_PULL);
    gpio_pin_config(BUTTON3, GPIO_MODE_IN_PULL);
    gpio_pin_config(BUTTON4, GPIO_MODE_IN_PULL);
    gpio_pin_set(BUTTON0);
    gpio_pin_set(BUTTON1);
    gpio_pin_set(BUTTON2);
    gpio_pin_set(BUTTON3);
    gpio_pin_set(BUTTON4);
    
    int xmin=-20666/2;//-1.26136183;
    int ymin= 6168/2;//0.37648215;
    int scale;
    int stepsize = 100;
    while (1)
    {
        
        if (!gpio_pin_high(BUTTON4)) scale=3; else scale=1;
        
        if (!gpio_pin_high(BUTTON0)) ymin-=stepsize*scale;
        if (!gpio_pin_high(BUTTON1)) ymin+=stepsize*scale;
        if (!gpio_pin_high(BUTTON2)) xmin-=stepsize*scale;
        if (!gpio_pin_high(BUTTON3)) xmin+=stepsize*scale;
        
        //    gpio_pin_clear(LED_BLUE);
        //    gpio_pin_set(LED_BLUE);
        
        //delay_cycles(1000000);
        //delay(10000000);
        //gpio_pin_toggle(LED_BLUE);
        mandelframe(xmin, ymin);
    }   
    
    
    //while (1);
    //mandelfp();
    return 0;
}
