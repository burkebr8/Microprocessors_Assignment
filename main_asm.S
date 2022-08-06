@
@ Assembler program to linearly represent using a bargraph the value
@ on a potentiometer connected to an RP2040 microcontroller
@
@

.global main_asm             @ Provide program starting address to linker
main_asm:


.EQU GPIO_OUT1, 2
.EQU GPIO_OUT2, 3
.EQU GPIO_OUT3, 4
.EQU GPIO_OUT4, 5
.EQU GPIO_OUT5, 6
.EQU GPIO_OUT6, 7
.EQU GPIO_OUT7, 8
.EQU GPIO_OUT8, 9
.EQU GPIO_OUT9, 10
.EQU GPIO_OUT10, 11

.EQU GPIO_IN1, 26


@ Initialising all 11 GPIO pins as well as setting the pin as an input/output pin

MOV R0, #GPIO_OUT1
BL gpio_init
MOV R0, #GPIO_OUT1
BL gpiosetout

MOV R0, #GPIO_OUT2
BL gpio_init
MOV R0, #GPIO_OUT2
BL gpiosetout

MOV R0, #GPIO_OUT3
BL gpio_init
MOV R0, #GPIO_OUT3
BL gpiosetout

MOV R0, #GPIO_OUT4
BL gpio_init
MOV R0, #GPIO_OUT4
BL gpiosetout

MOV R0, #GPIO_OUT5
BL gpio_init
MOV R0, #GPIO_OUT5
BL gpiosetout

MOV R0, #GPIO_OUT6
BL gpio_init
MOV R0, #GPIO_OUT6
BL gpiosetout

MOV R0, #GPIO_OUT7
BL gpio_init
MOV R0, #GPIO_OUT7
BL gpiosetout

MOV R0, #GPIO_OUT8
BL gpio_init
MOV R0, #GPIO_OUT8
BL gpiosetout

MOV R0, #GPIO_OUT9
BL gpio_init
MOV R0, #GPIO_OUT9
BL gpiosetout

MOV R0, #GPIO_OUT10
BL gpio_init
MOV R0, #GPIO_OUT10
BL gpiosetout

MOV R0, #GPIO_IN1
BL adc_gpio_init
MOV R0, #GPIO_IN1
BL gpiosetin

@ drive all pins simultaneously to be off
MOV R1, gpio_put_all(#0)


loop:
MOV R1, #GPIO_IN1 @ store the value read from the potentiometer in R1
MOV R2, #1023 @ load the value 1023 which represents the precision of the potentiometer into R2
UDIV R3, R1, R2 @ divide the output from the potentiometer by the max potentiometer value to scale the result

LDR R4, #10

MOVS R4, R4 @ to set the condition code flags

while:
      BEQ endwh
      CMP R3, R4 @ check if current LED from 1-10 is less than the latest data from the potentiometer
            BGE elsel @ start else statement
            SUB R4, #1 @ the value 1 is subtracted from the R4 register as the while loop decrements
            blt gpio_put(R4, #1) @ the LED must be turned on as the current LED represents the LED lower than the measured value's LED
            B endifl:
            elsel: gpio_put(R4, #0) @ the LED must be turned off as the current LED represents the LED higher than the measured value's LED
            endifl:
      B while
endwh:


B       loop

.data

      .align  4 @ necessary alignment
