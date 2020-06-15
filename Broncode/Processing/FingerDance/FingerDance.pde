import processing.serial.*;

//ButtonPlayer
int PlayerPos = 0;

//arduino lezen
Serial myPort;  // Create object from Serial class
String ButtonPressed;     // Data received from the serial port
float ButtonPressed2;

//score
int scoreVal=0;
score scoreThing;

//counter
int counter;
int amountStick= 30; //amount of blocks

//FallBlock
ArrayList<stickman> enemiesList;

int xPosLeft= 0; //Max links beginlocatie
int xPosRight= 4; //Max rechts beginlocatie
int xMoveSpeed = 0; //Maximale horizontaal heen en weer snelheid
int yPos= -400; //Waar begint poppetje verticaal
int yMove = 6; //Snelheid naar benenden

//Menu
final int MENUSCREEN = 0;
final int GAMESCREEN = 1;
int screenState;

//start button
float xPosStartButton; //adjust in setup
float yPosStartButton; //adjust in setup
float widthStartButton = 200;
float heightStartButton = 100;

//quit button
float xPosQuitButton; //adjust in setup
float yPosQuitButton; //adjust in setup
float widthQuitButton = 180;
float heightQuitButton = 90;

//colors buttons
int buttonColorState;
color startButtonRest = color(60, 200, 130);
color startButtonClick = color(120, 220, 160);
color quitButtonRest = color(100, 160, 140);
color quitButtonClick = color(120, 200, 160);


void setup () {
  size (700, 950);
  rectMode(CENTER);
  noStroke();

  // Arduino lezen: Opent de port dat ik gebruik
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);

  //score
  scoreThing = new score();

  //FallBlock
  enemiesList = new ArrayList<stickman>();
  //for (int i=0; i<3; i=i+1) {
  //  enemiesList.add(new stickman(int(random(xPosLeft, xPosRight)), int(random(-xMoveSpeed, xMoveSpeed)), yPos, yMove));
  //}
  
  //menu
  //start button
  xPosStartButton = width/2;
  yPosStartButton = height/2;
  //quit button
  xPosQuitButton = width/2;
  yPosQuitButton = height/3*2;
  
}

void draw() {
  //Welk scherm wordt weergegeven
  if (screenState == MENUSCREEN) {
    drawMenu();
  } else if (screenState == GAMESCREEN) {
    drawGame();
  } else {
    println("Something went wrong!");
  }
  
  //arduino lezen
  while ( myPort.available() > 0) {  // If data is available,
    ButtonPressed = myPort.readStringUntil('\n');         // read it and store it in ButtonPressed
    if (ButtonPressed != null) {
      ButtonPressed2 = float(ButtonPressed); //van float naar int. Nu geeft ButtenPressed2 aan welke knop wordt ingedrukt
      println(ButtonPressed2); //print it out in the console
      //text(ButtonPressed2, 20, 20);
    }
  }
}

void drawMenu () {
  background(120, 160, 180);   
  textSize(30);
  textAlign(CENTER);

  //start button
  fill(buttonColorState); // color of the start button
  rect(xPosStartButton,yPosStartButton,widthStartButton,heightStartButton);//the rect of the start button
  fill(0);
  text("START", xPosStartButton,yPosStartButton+8);  
  
  //quit button
  fill(quitButtonRest);
  rect(xPosQuitButton,yPosQuitButton,widthQuitButton,heightQuitButton);//the rect of the start button
  fill(0);
  text("Quit", xPosQuitButton,yPosQuitButton+8);  
  
  
  //Dit geeft geeft een "You won" of "You lost" in het menu
  fill(0); //kleur van "You won" of "You lost"
  if(scoreVal<0){
    text("You lost :(", width/2, height/4);
  }
  
  if(scoreVal>=30){
  text("You won!", width/2, height/4);
  }
  
  //hover over start button maar werkt niet
  //if(mouseX>xPosStartButton-(widthStartButton/2) && mouseX <xPosStartButton+(widthStartButton/2) && mouseY>yPosStartButton-(heightStartButton/2) && mouseY <yPosStartButton+(heightStartButton/2)){
  // buttonColorState = startButtonClick;
  // }
  
  //click the start button. This starts the game
  if(mousePressed && mouseX>xPosStartButton-(widthStartButton/2) && mouseX <xPosStartButton+(widthStartButton/2) 
  && mouseY>yPosStartButton-(heightStartButton/2) && mouseY <yPosStartButton+(heightStartButton/2)|| ButtonPressed2 == 2)
  {
  println("The mouse is pressed and over the button");
  scoreVal = 0;
  buttonColorState = startButtonClick;
  screenState = GAMESCREEN;
  }else {
     buttonColorState = startButtonRest;  
  }
  //  //hover over start button
  //if(mouseX>xPosStartButton-(widthStartButton/2) && mouseX <xPosStartButton+(widthStartButton/2) && mouseY>yPosStartButton-(heightStartButton/2) && mouseY <yPosStartButton+(heightStartButton/2)){
  // buttonColorState = startButtonClick;
  // }
  
  //click the quit button to quit the game
  if(mousePressed && mouseX>xPosQuitButton-(widthQuitButton/2) && mouseX <xPosQuitButton+(widthQuitButton/2) 
  && mouseY>yPosQuitButton-(heightQuitButton/2) && mouseY <yPosQuitButton+(heightQuitButton/2)|| ButtonPressed2 == 2)
  {
  println("Quit button is pressed");
  buttonColorState = startButtonClick;
  exit();
  }



}

void drawGame () { 
  background(12, 66, 81);   
  textAlign(LEFT);

  //counter
  counter = counter + 1;

  //score
  scoreThing.scoredraw (); //zet de code van de score in de game

  //Als je wint of verliest ga je terug naar het menu
  println(scoreVal);
  if (scoreVal <= -10 || scoreVal >= 30){
    screenState = MENUSCREEN; //<>//
  }

  if (counter>amountStick) {
    counter = 0;
    enemiesList.add(new stickman(int(random(xPosLeft, xPosRight)), int(random(-xMoveSpeed, xMoveSpeed)), yPos, yMove)); //<>//
  }


  //ButtonPlayer. Geeft de visuele feedback en de positie als je een knopje indrukt op de arduino
  if (ButtonPressed2 ==2) {
    PlayerPos = width/5;
    rect(width/5, height-100, 50,50);
  } else if (ButtonPressed2 ==3) {
    PlayerPos = width/5*2;
    rect(width/5*2, height-100, 50,50);
  } else if (ButtonPressed2 ==1) {
    PlayerPos = width/5*3;
    rect(width/5*3, height-100, 50,50);
  } else if (ButtonPressed2 ==4) {
    PlayerPos = width/5*4;
    rect(width/5*4, height-100, 50,50);
  } else {
    PlayerPos = 0;
  }

//println(ButtonPressed2);
//println(PlayerPos);

  //FallBlock. Hier komt de code van de speler en het blokjes die vallen bij elkaar. 
  int voorbij = 0;
  int waarX;
  for (int i=0; i<enemiesList.size(); i=i+1) { //vallende blokjes die toegevoegd worden
    stickman tempEnemy = enemiesList.get(i);
    tempEnemy.beweegStickman ();
    voorbij = tempEnemy.voorbijVar();
    waarX = tempEnemy.xPos;
    if (voorbij != 0) {
      int visuelePositie = waarX; //visuele positie van vallende blokjes
      int playerLinks = PlayerPos-85;//visuele positie
      int playerRechts = PlayerPos+85;//visuele positie
      //println(waarX);
      enemiesList.remove(i); //blokjes worden onderaan verwijderd
      if (visuelePositie > playerLinks && visuelePositie < playerRechts) { //als je een blokje raakt
        println("raak");
        scoreVal = scoreVal + 1;// een punt erbij 
      } else {//dit gebeurt er als je mist
        println("mis");
        scoreVal = scoreVal - 2;//twee punten aftrek
      }
    }
  }
}
