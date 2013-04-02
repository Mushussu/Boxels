#include <Stepper.h>

#define STEPS 200

Stepper stepper(STEPS, 8, 9);

void setup() {
  stepper.setSpeed(60); // Max 150 tours / minute
}

void loop() {
  stepper.step(1000);
  delay(1000);
    stepper.step(-1000);
  delay(1000);
}
