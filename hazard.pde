class hazard
{
  PImage enemy;
  boolean active;
  float size;
  float xPos, yPos;
  float speed;
  
  public hazard()
  {
    active = true;
    size = 30;
    xPos = width+size/2;
    yPos = random(height);
    speed = random(-1,2);
    enemy = loadImage("UFO.png");
    enemy.resize(75,75);
  }
  void reset()
  {
    active = true;
    size = 30;
    xPos = width+size/2;
    yPos = random(height);
    speed = -1;
    enemy = loadImage("UFO.png");
    enemy.resize(75,75);
  }
  
  //returns true if hazard is off screen
  boolean move()
  {
    xPos -= speed;
    if(xPos < 0)
    {
    return true;
    }
    
    return false;
  }
  
  void drawHazard()
  {
    image (enemy,xPos,yPos);
    speed += 0.05;
  }
}
