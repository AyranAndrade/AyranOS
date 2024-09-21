#include "interruption.h"

void turnOnInterruption() {
  asm volatile("sti");
}

void turnOffInterruption() {
  asm volatile("cli");
}