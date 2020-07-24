
//==============================================================================
// code below by Martin Wendt, all else part of gd32vf103inator
// except for minor additions to display.c/.h -> dp_imagefill565()
#include "mandelframe.h"
#include "snip1.h"
#include "myasm.h"
#define FIXSIZE 13
#define mul(a,b) ((((int)a)*(b))>>FIXSIZE)
#define fixpt(a) ((int)(((a)*(1<<FIXSIZE))))
#define SCREEN_WIDTH   160
#define SCREEN_HEIGHT  80
__attribute__((noinline))
void mandelframe(int xmin, int ymin)
{
//float xmin,ymin,xmax,ymax,xs,ys;
int x0,y0,p,q,xn;
int i,x,y;
const int maxiter = 32;//6;
int xs,ys;
//all of this below could already
//perform in fixpt space!
int xwidth = 225*40/2;//20666-20441;
int ywidth = 225*40/2;//6337-6168;
//int xmin=-20666;//-1.26136183;
//int xmax=-20441;//-1.24763480;
//int ymin= 6168;//0.37648215;
//int ymax= 6337;//0.38676353;
int xmax = xmin + xwidth;
int ymax = ymin + ywidth;


struct linebuf linebuf;

//while (1)
{
  //  s=s*-1;
{ 
    xs=(xmax-xmin)*32/SCREEN_WIDTH;
    ys=(ymax-ymin)*32/SCREEN_HEIGHT;
   
    for (y=0;y<SCREEN_HEIGHT;y++) {
      q= ymin+(y*ys)/32;
      for (x=0;x<SCREEN_WIDTH;x++) {                        
        p = xmin+(x*xs)/32;
        
            xn=0;
            x0=0;
            y0=0;
            i=0;
            while ((mul(xn,xn)+mul(y0,y0))<(65536/4) && ++i<maxiter)  
            {
                xn=mul((x0+y0),(x0-y0)) +p; 
                //xn=mul(myasm(x0,y0),(x0-y0)) +p;           
                //xn=myasm(x0,y0,p);
                //xn+=+p;
                y0=mul(32768/2,mul(x0,y0)) +q;
                x0=xn;
                
            }
            //if (i==maxiter) i=1;
            {
                //linebuf.buf[y*160+x]=i*111;
                linebuf.buf[y*160*2+x*2]=i;
                linebuf.buf[y*160*2+x*2+1]=i*2;
            }  
        }
      }
    dp_imagefill565(linebuf.buf);
    
    
}
} 
}
