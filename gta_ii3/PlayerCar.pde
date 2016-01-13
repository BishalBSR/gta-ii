class PlayerCar {
  
  PVector location, velocity, acceleration;
  float friction, maxSpeed, rotationAmount;
  boolean isMovingFront, isMovingBack, isTurnRight, isTurnLeft;
  //boolean isMoving;
  boolean playerInsideCar, playerEnterCar;
  PImage playerCar;
  int carSize;

  PlayerCar() {
    location = new PVector(width/2, height/2);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    rotationAmount = 0;
    friction = 0.9;
    maxSpeed = 5;
    carSize = 80;
    isMovingFront = false;
    isMovingBack = false;
    isTurnRight = false;
    isTurnLeft = false;
    //isMoving = false;
    playerInsideCar = false;
    playerEnterCar = false;
    playerCar = loadImage("playerCar.png");
  }

  void update() {
    //regular update
    velocity.add(acceleration);
    velocity.mult(friction);
    velocity.limit(maxSpeed);
    location.add(velocity);
    //stop acceleration from affecting velocity over and over, by setting to 0
    acceleration.mult(0);
    
    checkPlayerNearby();
    if (playerInsideCar){
      thePlayer.getInCar();
      if (isTurnLeft && isMovingFront) {           //if (isTurnLeft && isMoving) {
        rotationAmount = rotationAmount - 0.025;
      }
      if (isTurnRight && isMovingFront) {          //if (isTurnRight && isMoving) {
        rotationAmount = rotationAmount + 0.025;
      }
      if (isTurnLeft && isMovingBack) {
        rotationAmount = rotationAmount + 0.025;
      }
      if (isTurnRight && isMovingBack) {
        rotationAmount = rotationAmount - 0.025;
      }
      if (isMovingFront) {
        speedUp();
      }
      if (isMovingBack) {
        slowDown();
      }
    }
    
    location.x = constrain(location.x, carSize/2, width-carSize/2);          //location.x = constrain(location.x, 0, width-carSize);
    location.y = constrain(location.y, carSize/2, height-carSize/2);         //location.y = constrain(location.y, 0, height-carSize/2);
  }
  
  void checkPlayerNearby(){
    if (playerEnterCar){
      playerInsideCar = true; 
    }
    else {
      playerInsideCar = false; 
    }
  }

  void display() {
    pushMatrix();
      translate(location.x, location.y);
      rotate(rotationAmount);
      stroke(0);
      fill(175, 125);
      imageMode(CENTER);
      image(playerCar,0, 0, carSize, carSize/2);
    popMatrix();
  }

  //void checkEdges() {
  //  if (location.x > width) {
  //    location.x = 0;
  //  } else if (location.x < 0) {
  //    location.x = width;
  //  }

  //  if (location.y > height) {
  //    location.y = 0;
  //  } else if (location.y < 0) {
  //    location.y = height;
  //  }
  //}

  void speedUp() {
    PVector amount = new PVector(0.1, 0);
    amount.rotate(rotationAmount);
    acceleration = amount;
  }

  void slowDown() {
    PVector amount = new PVector(-0.1, 0);
    amount.rotate(rotationAmount);
    acceleration = amount;
  }

  void handleKey() {
    if (key == 'a' || keyCode == LEFT) {
      isTurnLeft = true;
      isTurnRight = false;
    }
    if (key == 'd' || keyCode == RIGHT) {
      isTurnRight = true;
      isTurnLeft = false;
    }
    if (key == 'w' || keyCode == UP) {
      isMovingFront = true;
      //isMoving = true;
    }
    if (key == 's' || keyCode == DOWN) {
      isMovingBack = true;
      //isMoving = true;
    }
    if (key == 'e' && dist(location.x, location.y, thePlayer.x, thePlayer.y) <= 45){
      playerEnterCar = !playerEnterCar;
    }
  }
  
  void handleRelease(){
     if (key == 'a' || keyCode == LEFT) {
      isTurnLeft = false;
    }
    if (key == 'd' || keyCode == RIGHT) {
      isTurnRight = false;
    }
    if (key == 'w' || keyCode == UP) {
      isMovingFront = false;
      //isMoving = false;
    }
    if (key == 's' || keyCode == DOWN) {
      isMovingBack = false;
      //isMoving = false;
    }
  }
  
}