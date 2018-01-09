#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <wiringPi.h>
#include <time.h>

// input PIN (wg wiringPi: https://pinout.xyz/pinout/wiringpi)
#define input 24
#define shPress "./pressed.sh"
#define output 25
#define interruptDeBounce 350

unsigned long lastInterrupt = 0;
unsigned long pressDown = 0;

void Pressed(void)
{
    unsigned long interrupt = millis();

    if (interrupt - lastInterrupt > interruptDeBounce)
    {
       system(shPress);
    }

    lastInterrupt = interrupt;
}

int main(void)
{
	if (wiringPiSetup() < 0)
	{
		fprintf(stderr, "Unable to setup wiringPi: %s\n", strerror(errno));
		return 1;
	}

	pinMode(output, OUTPUT);
	pinMode(input, INPUT);
	digitalWrite(output, HIGH);

	if (wiringPiISR(input, INT_EDGE_BOTH, &Pressed) < 0)
	{
		fprintf(stderr, "Unable to setup ISR: %s\n", strerror(errno));
		return 1;
	}

	for (;;)
	{
		delay(1000);
	}

	return 0;
}
