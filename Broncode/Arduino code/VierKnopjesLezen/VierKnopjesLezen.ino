int buttonPush;

void setup() {
  Serial.begin(9600);
  //  pinMode(2, INPUT);
  //  pinMode(3, INPUT);
  //  pinMode(4, INPUT);
  //  pinMode(5, INPUT);
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
  pinMode(A2, INPUT);
  pinMode(A3, INPUT);
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);

}

void loop() {
  //int buttonState1 = digitalRead(2);
  //int buttonState2 = digitalRead(3);
  //int buttonState3 = digitalRead(4);
  //int buttonState4 = digitalRead(5);
  int pressState1 = analogRead(A0);
  int pressState2 = analogRead(A1);
  int pressState3 = analogRead(A2);
  int pressState4 = analogRead(A3);

  ////prints all buttons
  //Serial.println(buttonState1);
  //Serial.println(buttonState2);
  //Serial.println(buttonState3);
//  Serial.println(buttonState4);
//  Serial.println(pressState1);
//  Serial.println(pressState2);
//  Serial.println(pressState3);
//  Serial.println(pressState4);

  if (pressState1 > 50) {
    buttonPush = 1;
    digitalWrite(5, HIGH);
  } else {
    digitalWrite(5, LOW);
  }  if (pressState2 > 50) {
    buttonPush = 2;
    digitalWrite(2, HIGH);
  } else {
    digitalWrite(2, LOW);
  }  if (pressState3 > 50) {
    buttonPush = 3;
    digitalWrite(4, HIGH);
  } else {
    digitalWrite(4, LOW);
  }  if (pressState4 > 100) {
    buttonPush = 4;
    digitalWrite(3, HIGH);
  } else {
    digitalWrite(3, LOW);
  }  if (pressState1 < 100 && pressState2 < 100 && pressState3 < 100 && pressState4 < 100) {
    buttonPush = 0;
  }

    Serial.println(buttonPush);
  delay(100);
}
