#include <stdio.h>
#include <unistd.h>

#include "./lmsapi/ev3_lcd.h"
#include "./lmsapi/ev3_command.h"

int main()
{
  int i;
  LcdInit();
  LcdText(1, 10, 10, "TRIFORK!!!!");
  Wait(SEC_1);
  LcdExit();
}

void setCameraAngle(int a)
{

}
