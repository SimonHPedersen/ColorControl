#include <stdio.h>
#include <unistd.h>

#include "I:\BricxCC\API\ev3_lcd.h"
#include "I:\BricxCC\API\ev3_command.h"

int main()
{
  int i;
  LcdInit();
  LcdText(1, 0, 0, "Trifork!");
  Wait(SEC_1);
  LcdExit();
}

