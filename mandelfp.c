
//==============================================================================
// code below by Martin Wendt, all else part of gd32vf103inator
// except for minor additions to display.c/.h -> dp_imagefill565()
#include "mandelfp.h"
#include "snip1.h"
#include "myasm.h"
#define FIXSIZE 13
#define mul(a,b) ((((int)a)*(b))>>FIXSIZE)
#define fixpt(a) ((int)(((a)*(1<<FIXSIZE))))
#define SCREEN_WIDTH   160
#define SCREEN_HEIGHT  80
__attribute__((noinline))
void mandelfp()
{
float xmin,ymin,xmax,ymax,xs,ys;
int x0,y0,p,q,xn;
int i,x,y,z;
const int maxiter = 30;
//all of this below could already
//perform in fixpt space!
xmin=-1.26136183;
xmax=-1.24763480;
ymin= 0.37648215;
ymax= 0.38676353;
int s=-1;

struct linebuf linebuf;

while (1)
{
    s=s*-1;
for (z=0;z<200;z++)
{ 
    xmin-=z/10000.0f*s;
    xmax+=z/10000.0f*s;
    ymin-=z/10000.0f*s;
    ymax+=z/10000.0f*s;
    xs=(xmax-xmin)/SCREEN_WIDTH;
    ys=(ymax-ymin)/SCREEN_HEIGHT;
   
    for (y=0;y<SCREEN_HEIGHT;y++) {
      q=(int)(fixpt(ymin+y*ys));
      for (x=0;x<SCREEN_WIDTH;x++) {                        
        p=(int)(fixpt(xmin+x*xs));
        
            xn=0;
            x0=0;
            y0=0;
            i=0;
            while ((mul(xn,xn)+mul(y0,y0))<(4<<FIXSIZE) && ++i<maxiter)  
            {
                //xn=mul((x0+y0),(x0-y0)) +p; 
                //xn=mul(myasm(x0,y0),(x0-y0)) +p;           
                xn=myasm(x0,y0,p);
                //xn+=+p;
                y0=mul(fixpt(2),mul(x0,y0)) +q;
                x0=xn;
                
            }
            if (i==maxiter) i=1;
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
