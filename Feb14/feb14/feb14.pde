PVector house;
float houseSize;
Mouse m;
Food food;
PVector forceF; // Attractive force from food to mouse

void setup() {
  size(600,600);
  m = new Mouse(random(width),random(height));
  houseSize = width/5;
  house = new PVector(width/2,height/2);
  food = new Food();
}
void draw() {
  background(255);
  
  fill(175,200);
  rectMode(CENTER);
  rect(house.x, house.y, houseSize, houseSize);
  food.update();
  m.update();
  m.display();
}
class Mouse {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float maxForce;
  float maxSpeed;
  float life;
  float hunger;
  float lifeDecreaseRate;
  float timePassed;

  Mouse(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    location = new PVector(x,y);
    mass = 5;
    maxSpeed = 5;
    maxForce = 0.1;
    life = 100;
    hunger = 0;
    lifeDecreaseRate = 1;
    timePassed = 2;
  }

  void update() {
    if (life > 0){
      
      velocity.add(acceleration);
      velocity.limit(maxSpeed);
      location.add(velocity);
      acceleration.mult(0);
      lifeAndHunger();
      
      if (hunger >= 50 && food.foodPresent){ //mouse doesn't take risk of going out until it gets hungry
        forceF= food.attract(m);
        m.applyForce(forceF);
      } else{
        goTo(house);
      }
      
      if (hunger >= 80){  //Life starts to decrease at greater rate when hunger level is greater than 80 
        lifeDecreaseRate = 5;
      } else {
        lifeDecreaseRate = 1;
      }
    }
  }
  
  void lifeAndHunger() {
     //every second life is decreasing and hunger is increasing
    if ((millis()/1000) >= timePassed){ 
      timePassed = (millis()/1000)+1;
      if (life <0){
        life = 0;
      } else{
        life -= lifeDecreaseRate;
      }
      
      if (hunger >= 100){
        hunger = 100;
      }
      else{
        hunger += 5;
      }
    }
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void goTo(PVector house) {
    PVector _velocity = PVector.sub(house,location);
    float distance = _velocity.mag();
    _velocity.normalize();
    if (distance < 100) {
      //if less distance is remaining, speed starts to decrease according to the distance from the destination
      float speed = map(distance,0,100,0,maxSpeed); //maps speed from 0-100 range to 0-maxSpeed range in order to slow down the speed with respect to distance.
      _velocity.mult(speed);
    } else {
      _velocity.mult(maxSpeed);
    }
    PVector force = PVector.sub(_velocity,velocity); //difference between current velocity and required velocity (_velocity) gives the correct force towards destination
    force.limit(maxForce);
    applyForce(force);
}

  void display() {
    fill (75, 60, 57);

    // Copy of code for triangle from lecture notes
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading());
    triangle(0, 5, 0, -5, 20, 0);
    popMatrix();
    
    if (hunger > 80){
      fill(255,0,0);
    }
    else {
      fill(0);
    }
    
    text("Life Left: "+ int(m.life), 200, 100);
    text("Hunger: "+ int(m.hunger), 200, 120);
  
  }
}


class Food {
  PVector location;
  boolean foodPresent;
  float lastEatTime;
  
  Food() {
    spawnNew();
    foodPresent = true;
    lastEatTime = 0;
  }
  
  PVector attract(Mouse m) {
    PVector _velocity = PVector.sub(location,m.location);
    float distance = _velocity.mag();
    _velocity.normalize();
    
    if (distance < 100) {
      float speed = map(distance,0,100,0,m.maxSpeed);
      _velocity.mult(speed);
    } else {
      _velocity.mult(m.maxSpeed);
    }
 
    PVector force = PVector.sub(_velocity,m.velocity);
    force.limit(m.maxForce);
    
    return force;
  }
  
  void spawnNew() {
    float x = random(width);
    float y = random(height);
    while ((x<=width/2+50 && x>=width/2-50) && (y<=height/2+50 && y>=height/2-50)){ //making sure food doesn't spawn inside mouse's house
      x = random(width);
      y = random(height);
    }
    location = new PVector(x,y);
  }

  //if food is eaten, hunger is reset and time is noted.
  void isEaten(){
    if ((m.location.x<=location.x+5 && m.location.x>=location.x-5) && (m.location.y<=location.y+5 && m.location.y>=location.y-5)){
      spawnNew();
      foodPresent = false;
      m.hunger = 0;
      lastEatTime = (millis()/1000);
    }
  }
  
  void update(){
    isEaten();
    if (!foodPresent){ //When food is eaten, the noten time is compared with millis so after random amount of time new food is displayed and can be eaten by mouse (using foodPresent variable).
      if ((millis()/1000)-lastEatTime >= random(20,30)){
        foodPresent = true;
      }
    }
    else{
      display();
    }
  }

  void display() {
    noStroke();
    fill(255, 170, 51);
    rectMode(CENTER);
    rect(location.x,location.y,10,10);
  }
}
