#include <stdio.h>
#include "pico/stdlib.h"

void main_asm();


int main() {

    // Jump into the main assembly code subroutine that implements the project
    main_asm();


    // Returning zero indicates everything went okay.
    return 0;
}
