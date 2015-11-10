#include <string.h>
#include "ev3_lcd.h"
#include "ev3_command.h"
#include "serial_read.h"

int main()
{
  LcdInit();
  LcdClearDisplay();
  int i;
  int j;
  UART *pUart;
  char out[100];
  pUart=SerialInit();
  if(pUart == 0)
  {
    LcdText(1,0,0,"Error Opening Sensor");
    Wait(1000);
    return EXIT_FAILURE;
  }
  for(j = 0;j<50;j++)
  {
    LcdClearDisplay();
    LcdText(1,0,0,"UART Value: ");
    i = ReadSerial(1,pUart);
    sprintf(out,"%d",i);
    LcdText(1,105,0,out);
    sleep(1);
    Wait(SEC_1);
  }
  LcdExit();
  return EXIT_SUCCESS;
}

