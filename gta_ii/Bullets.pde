class Bullets {
  
  PVector location, velocity, acceleration;
  float originalX, originalY, rotationAmount, bulletMaxSpeed;
  int bulletSize;
  
  Bullets(float x, float y, float _rotationAmount){
    bulletSize = 10;
    bulletMaxSpeed = 7.5;
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    rotationAmount = _rotationAmount;
    originalX = location.x;
    originalY = location.y;
  }
  
  void update(){
    shoot();
    velocity.add(acceleration);
    velocity.limit(bulletMaxSpeed);
    location.add(velocity);
    acceleration.mult(0);
    display();
  }
  
  void display(){
    fill(0);
    ellipse(location.x, location.y, bulletSize, bulletSize);
  }
  
  void shoot(){
    PVector amount = new PVector(0.75, 0);
    amount.rotate(rotationAmount);
    acceleration = amount;
  }
  
}