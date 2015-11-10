#include <stdio.h>
#include <unistd.h>

#include "./lmsapi/ev3_lcd.h"
#include "./lmsapi/ev3_command.h"

int main()
{
  int i;
  LcdInit();
  LcdText(1, 0, 100, "Hello World!");
  Wait(SEC_1);
  LcdExit();
}

