Player thePlayer;
PlayerCar thePlayerCar;

void setup(){
  size(600, 600);
  thePlayer = new Player();
  thePlayerCar = new PlayerCar();
}

void draw(){
  background(255);
  thePlayer.move();
  thePlayer.display();
  
  thePlayerCar.update();
  thePlayerCar.display();
  //thePlayerCar.checkEdges();
}

void keyPressed() {
  thePlayer.handleKey();
  thePlayerCar.handleKey();
}

void keyReleased(){
  thePlayer.handleRelease();
  thePlayerCar.handleRelease();
}