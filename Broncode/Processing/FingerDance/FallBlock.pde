
class stickman {

  //poppetje
  int xPos; //Waar begint poppetje horizontaal
  int xMoveSpeed; //Horizontaal heen en weer snelheid
  int yPos; //Waar begint poppetje verticaal
  int yMoveSpeed; //Verticaal naar beneden bewegen snelheid
  float rescaleAll = 1;
  int neg = -1;
  float rescaleSpeed = 0.01;

  //rotatie
  float rotSin;
  float rotSinSnelh=PI/45; //veranderd de rotatiesnelheid4
  int rotBegin= -80; //waar de rotatie begint
  float rotBereik = 1; //Hoever komt de rotatie

//op welke van de vijf plekken het blokje naar beneden gaat
  stickman (int xPosPar, int xMoveSpeedPar, int yPosPar, int yMoveSpeedPar) {
    if (xPosPar ==0) {
      xPos = width/5;
    } 
    if (xPosPar ==1) {
      xPos = width/5*2;
    }
    if (xPosPar ==2) {
      xPos = width/5*3;
    }
    if (xPosPar ==3) {
      xPos = width/5*4;
    }
    //xMoveSpeed = xMoveSpeedPar; //Horizontaal heen en weer snelheid. Deze wordt niet gebruikt
    yPos= yPosPar; //Waar begint poppetje verticaal
    yMoveSpeed =yMoveSpeedPar; //Verticaal naar beneden bewegen snelheid
  }



  void beweegStickman () {
    //rotSin = rotSin + rotSinSnelh; //Roteren. Wordt niet gebruikt

    //Blokje positie  
    xPos = positie(xPos, xMoveSpeed);
    yPos = positie(yPos, yMoveSpeed); //gaat hierdoor naar beneden
    //xMoveSpeed = kader(xPos, xMoveSpeed, width); //geeft de horizontale een kader waarin het heen en weer kan

    //scalingF ();
    //scale(rescaleAll);
    stickmanCreated(xPos, yPos);
    //stickman(xPos, 200);
  }

  //poppetje
  int positie(int value1, int value2) {
    int resultaat= value1 + value2;
    return resultaat;
  }

  int kader(int xP, int speed, int groot) {
    if (xP > groot || xP <0) {
      speed = speed * -1;
    }
    return speed;
  }

  int voorbijVar() {
    if (yPos<height-100) { //hoogte waar blokje wordt verwijderd
      return 0;
    } else {
      return xPos;
    }
  }

  void scalingF () {
    rescaleAll= rescaleAll + rescaleSpeed;
    if (rescaleAll>2 || rescaleAll<0.2) {
      rescaleSpeed= rescaleSpeed * neg;
    }
  }


  void stickmanCreated (int xP, int yP) {
    rectMode(CENTER);
    imageMode(CENTER);

    //Geeft verschillende kleuren aan de blokjes en maakt het blokje zelf
    if (xPos == width/5) {
      fill(255, 255, 100);
    }
    if (xPos == width/5*2) {
      fill(100, 151, 255);
    }
    if (xPos == width/5*3) {
      fill(255, 100, 100);
    }
    if (xPos == width/5*4) {
      fill(255, 142, 100);
    }
    rect(xP, yP, 50, 50);
  }
}
