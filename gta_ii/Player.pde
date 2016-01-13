class Player {
  
  PImage[] player = new PImage[3];
  int displayNumber, startTime;
  float x, y;
  int playerSize;
  boolean isMovingRight, isMovingLeft, isMovingUp, isMovingDown;
  boolean canMoveRight, canMoveLeft, canMoveUp, canMoveDown;
  boolean isMoving, isFacingRight, isFacingLeft, isFacingUp, isFacingDown;
  ArrayList<Bullets> bulletsArray = new ArrayList<Bullets>();
  
  Player() {
    for (int i=0; i < 3; i++) {
     player[i] = loadImage(i + ".png");
    }
    displayNumber = 0;
    startTime = millis();
    x = 100;
    y = 100;
    playerSize = 25;
    canMoveRight = true;
    canMoveLeft = true;
    canMoveUp = true;
    canMoveDown = true;
    isMovingRight = false;
    isMovingLeft = false;
    isMovingUp = false;
    isMovingDown = false;
    isMoving = false;
    isFacingRight = true;
    isFacingLeft = false;
    isFacingUp = false;
    isFacingDown = false;
  }
  
  void display() {
    imageMode(CENTER);
    if (isFacingLeft){
      image(player[displayNumber], x, y, playerSize, playerSize);
    }
    if (isFacingRight){
      pushMatrix();
        translate(x, y);
        rotate(radians(180));
        image(player[displayNumber], 0, 0, playerSize, playerSize);        //image(player[displayNumber], -playerSize, -playerSize, playerSize, playerSize); 
      popMatrix();                                                         //Negative co-ordinates so that image appears on correct position since rotations were made,
    }                                                                      //if not ImageMode(CENTER)
    if (isFacingUp){
      pushMatrix();
        translate(x, y);
        rotate(radians(90));
        image(player[displayNumber], 0, 0, playerSize, playerSize);        //image(player[displayNumber], 0, -playerSize, playerSize, playerSize);
      popMatrix();
    }
    if (isFacingDown){
      pushMatrix();
        translate(x, y);
        rotate(radians(-90));
        image(player[displayNumber], 0, 0, playerSize, playerSize);        //image(player[displayNumber], -playerSize, 0, playerSize, playerSize);
      popMatrix();
    }
    
    if (millis() > startTime + 100) {
      if (isMoving == false){
        displayNumber = 2;
      }
      
      if (isMoving){
        if (displayNumber < 2){
          displayNumber++;
        } else {
          displayNumber = 0;
        } 
      }
      
      startTime = millis();
    }
  }
  
  void update() {
    for (int i = 0; i < bulletsArray.size(); i++){
      bulletsArray.get(i).update();
      if (dist(bulletsArray.get(i).originalX, bulletsArray.get(i).originalY, bulletsArray.get(i).location.x, bulletsArray.get(i).location.y) >= 200){
        bulletsArray.remove(i);
      }
      else if (bulletsArray.get(i).location.x >= thePlayerCar.location.x-thePlayerCar.carWidth/2 && bulletsArray.get(i).location.x <= thePlayerCar.location.x+thePlayerCar.carWidth/2 &&
          bulletsArray.get(i).location.y >= thePlayerCar.location.y-thePlayerCar.carHeight/2 && bulletsArray.get(i).location.y <= thePlayerCar.location.y+thePlayerCar.carHeight/2){
        bulletsArray.remove(i);
      }
      else if (bulletsArray.get(i).location.x > width || bulletsArray.get(i).location.x < 0 || bulletsArray.get(i).location.y > height || bulletsArray.get(i).location.y < 0){
        bulletsArray.remove(i);
      }
    }
    checkCollision();
    if (isMoving){
      if (isMovingLeft && canMoveLeft) {
        x-=2;
      }
      if (isMovingRight && canMoveRight) {
        x+=2;
      }
      if (isMovingUp && canMoveUp) {
        y-=2;
      }
      if (isMovingDown && canMoveDown) {
        y+=2;
      }
    }
    x = constrain(x, playerSize/2, width-playerSize/2);          //x = constrain(x, 0, width-playerSize);
    y = constrain(y, playerSize/2, height-playerSize/2);         //y = constrain(y, 0, height-playerSize);
  }
  
  void handleKey(){
    if (key == 'a' || keyCode == LEFT) {
      isMovingLeft = true;
      isFacingLeft = true;
      isFacingRight = false;
      isFacingUp = false;
      isFacingDown = false;
      isMoving = true;
    }
    if (key == 'd' || keyCode == RIGHT) {
      isMovingRight = true;
      isFacingRight = true;
      isFacingLeft = false;
      isFacingUp = false;
      isFacingDown = false;
      isMoving = true;
    }
    if (key == 'w' || keyCode == UP) {
      isMovingUp = true;
      isFacingUp = true;
      isFacingRight = false;
      isFacingLeft = false;
      isFacingDown = false;
      isMoving = true;
    }
    if (key == 's' || keyCode == DOWN) {
      isMovingDown = true;
      isFacingDown = true;
      isFacingRight = false;
      isFacingLeft = false;
      isFacingUp = false;
      isMoving = true;
    }
  }
  
  void handleRelease(){
    if (key == 'a' || keyCode == LEFT) {
      isMovingLeft = false;
    }
    if (key == 'd' || keyCode == RIGHT) {
      isMovingRight = false;
    }
    if (key == 'w' || keyCode == UP) {
      isMovingUp = false;
    }
    if (key == 's' || keyCode == DOWN) {
      isMovingDown = false;
    }
    if (isMovingLeft == false && isMovingRight == false && isMovingUp == false && isMovingDown == false){
      isMoving = false;
    }
  }
  
  void getInCar(){
    x = thePlayerCar.location.x;
    y = thePlayerCar.location.y;
  }
  
  void checkCollision(){
    if (moveUp(x-playerSize/2, x+playerSize/2, y-playerSize/2, y+playerSize/2,                                        //Adding and subtracting since I used ImageMode(CENTER)
        thePlayerCar.location.x-thePlayerCar.carWidth/2, thePlayerCar.location.x+thePlayerCar.carWidth/2,
        thePlayerCar.location.y+thePlayerCar.carHeight/2, thePlayerCar.location.y-thePlayerCar.carHeight/2) == false){
      canMoveUp = false; 
    }
    else if (moveDown(x-playerSize/2, x+playerSize/2, y+playerSize/2, y-playerSize/2,
            thePlayerCar.location.x-thePlayerCar.carWidth/2, thePlayerCar.location.x+thePlayerCar.carWidth/2,
            thePlayerCar.location.y-thePlayerCar.carHeight/2, thePlayerCar.location.y+thePlayerCar.carHeight/2) == false){
      canMoveDown = false;
    }
    else if (moveRight(y-playerSize/2, y+playerSize/2, x+playerSize/2, x-playerSize/2,
            thePlayerCar.location.y-thePlayerCar.carHeight/2, thePlayerCar.location.y+thePlayerCar.carHeight/2,
            thePlayerCar.location.x-thePlayerCar.carWidth/2, thePlayerCar.location.x+thePlayerCar.carWidth/2) == false){
     canMoveRight = false;
    }
    else if (moveLeft(x+playerSize/2, x-playerSize/2, y-playerSize/2, y+playerSize/2,
            thePlayerCar.location.x-thePlayerCar.carWidth/2, thePlayerCar.location.x+thePlayerCar.carWidth/2,
            thePlayerCar.location.y-thePlayerCar.carHeight/2, thePlayerCar.location.y+thePlayerCar.carHeight/2) == false){
     canMoveLeft = false;
    }
    else {
       canMoveDown = true;
       canMoveUp = true;
       canMoveRight = true;
       canMoveLeft = true;
    }
  }
  
  boolean moveUp(float playerLeft, float playerRight, float playerTop, float playerBottom, float playerCarLeft, float playerCarRight, float playerCarBottom, float playerCarTop){
    if (playerLeft < playerCarRight && playerRight > playerCarLeft && playerTop < playerCarBottom && playerBottom > playerCarTop){
       return false;
    }
    else {
      return true; 
    }
  }
  
  boolean moveDown(float playerLeft, float playerRight, float playerBottom, float playerTop, float playerCarLeft, float playerCarRight, float playerCarTop, float playerCarBottom){
    if (playerLeft < playerCarRight && playerRight > playerCarLeft && playerBottom >= playerCarTop && playerTop < playerCarBottom){
       return false;
    }
    else {
      return true; 
    }
  }
  
  boolean moveRight(float playerTop, float playerBottom, float playerRight, float playerLeft, float playerCarTop, float playerCarBottom, float playerCarLeft, float playerCarRight){
    if (playerRight >= playerCarLeft && playerTop < playerCarBottom && playerBottom > playerCarTop && playerLeft < playerCarRight){
       return false;
    }
    else {
      return true; 
    }
  }
  
  boolean moveLeft(float playerRight, float playerLeft, float playerTop, float playerBottom, float playerCarLeft, float playerCarRight, float playerCarTop, float playerCarBottom){
    if (playerLeft <= playerCarRight && playerTop < playerCarBottom && playerBottom > playerCarTop && playerRight > playerCarLeft){
       return false;
    }
    else {
      return true; 
    }
  }
  
  void handleClick(){
    if (thePlayerCar.playerInsideCar == false){
      float angle = atan2(mouseX-x, mouseY-y);
      bulletsArray.add(new Bullets(x, y, -angle+radians(90)));
    }
  }
  
}