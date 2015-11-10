#include "serial_read.h"

UART* SerialInit()
{
 int file;
 //Open the device file
 if((file = open(UART_DEVICE_NAME, O_RDWR | O_SYNC)) == -1)
 {
  perror("Failed to open device");
  return 0;                                               /*File error! Serial might be open somehow.*/
 }
 //The next line will put the serial data in memory. UART is a nicely formatted Struct to make it easy to get specific parts of the serial data stream
 UART * pUart  =  (UART*)mmap(0, sizeof(UART), PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, file, 0);
 if (pUart == MAP_FAILED)
 {
  perror("Failed to map device");
  return 0;                                               /*Memory Mapping error.*/
 }
 return pUart;
}
//In ReadSerial, we take in a port number and the serial stream in memory, pointed to by pUart.
//We use the nice format of the struct to return the raw value of the sensor at the requested port.
//For more information on the UART struct, look at defines.h
int ReadSerial(char port, UART * pUart) {return (unsigned char)(pUart->Raw[(port-1)][pUart->Actual[(port-1)]][0]);}

/*void SensorClose(int file)
{
 close(file);                                  //Finished with the stream so we close it up
}*/
