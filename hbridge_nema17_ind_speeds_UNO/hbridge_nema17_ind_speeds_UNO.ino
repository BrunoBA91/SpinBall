#include <AccelStepper.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

// Variables for the motors
char c;
int Speed = 0;
char motor = "";
bool rot[4];
const int stepsPerRevolution = 200;  // # Steps per revolution for NEMA Stepper Motors

// Instantiate the stepper library on its respective pins:
AccelStepper motorA(AccelStepper::FULL4WIRE, A0,A1,A2,A3);
AccelStepper motorB(AccelStepper::FULL4WIRE, 2,3,4,5);
AccelStepper motorC(AccelStepper::FULL4WIRE, 6,7,8,9);
AccelStepper motorD(AccelStepper::FULL4WIRE, 10,11,12,13);

void setup() {
  // Initialize the serial port:
  Serial.begin(9600);
  // Initialize the variables
  bool rot[4] = {false,false,false,false};
  // Setting the pins of the motors to low as well as initializing some parameters:
  // Motor A //
  digitalWrite(A0, LOW); digitalWrite(A1, LOW); digitalWrite(A2, LOW); digitalWrite(A3, LOW);
  motorA.setAcceleration(1000); motorA.moveTo(1000000000);
  // Motor B //
  digitalWrite(2, LOW); digitalWrite(3, LOW); digitalWrite(4, LOW); digitalWrite(5, LOW);
  motorB.setAcceleration(1000); motorB.moveTo(1000000000);
  // Motor C //
  digitalWrite(6, LOW); digitalWrite(7, LOW); digitalWrite(8, LOW); digitalWrite(9, LOW);
  motorC.setAcceleration(1000); motorC.moveTo(1000000000);
  // Motor D //
  digitalWrite(10, LOW); digitalWrite(11, LOW); digitalWrite(12, LOW); digitalWrite(13, LOW);
  motorD.setAcceleration(1000); motorD.moveTo(1000000000);
}

void loop() {
  while( !Serial.available() ) {
    if (rot[0]) { motorA.run(); } 
    //if (rot[1]) { motorB.run(); }
    //if (rot[2]) { motorC.run(); }
    //if (rot[3]) { motorD.run(); }
  }
  
  // We only reach here if Serial.available()
  c = Serial.read();
  if (c == '!')
  {
    if (motor == 'A'){ rot[0] = true; motorA.setMaxSpeed(Speed*(10.0/3)); }
    //if (motor == 'B'){ rot[1] = true; motorB.setMaxSpeed(Speed*(10.0/3)); }
    //if (motor == 'C'){ rot[2] = true; motorC.setMaxSpeed(Speed*(10.0/3)); }
    //if (motor == 'D'){ rot[3] = true; motorD.setMaxSpeed(Speed*(10.0/3)); }

    if (Speed == 0)
     { 
      // We stop the motor rotation depending on the character we receive
      if (motor == 'A'){ rot[0] = false; DigitalPinsLow(A0,A1,A2,A3);}
      //if (motor == 'B'){ rot[1] = false; DigitalPinsLow(2,3,4,5);}
      //if (motor == 'C'){ rot[2] = false; DigitalPinsLow(6,7,8,9);}
      //if (motor == 'D'){ rot[3] = false; DigitalPinsLow(10,11,12,13);}
     } 
  }
  else if (c == 'A' | c == 'B') { motor = c; Speed = 0; }
  else if (c >= '0' & c <= '9') { Speed = 10*Speed + (c - '0'); }
  else{
    // Serial.println("Error");
  }
}

void DigitalPinsLow(int a, int b, int c, int d){
  digitalWrite(a, LOW); digitalWrite(b, LOW); digitalWrite(c, LOW); digitalWrite(d, LOW);
}
