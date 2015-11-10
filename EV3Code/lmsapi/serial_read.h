//Code Courtesy of Samson Bonfante. Latest version as of 9/29/13
#ifndef serial_read_h
#define serial_read_h
#include <fcntl.h>
#include <stdio.h>
#include <sys/mman.h>
#include <unistd.h>
#include "defines.h"
/*Open the serial device for later reading*/
UART *SerialInit();
/*Read the value of a Sensor*/
int ReadSerial(char port, UART *pUart);
/*Close the Sensor, not implemented currently*/
//void SensorClose(int file);
#endif
