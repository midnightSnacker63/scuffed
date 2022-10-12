/**********************\
 |     cheems space     |
 |      adventure       |
 |          ;)          |
 |                      |
 |   by: Joshua Poppy   |
 |                      |
 |                      |
 \**********************/
float xPos = 100, yPos;
float ySpeed;
int size = 60;
int score=100;
int enemyCount = 1;
int lives= 3;
int hitFrames;
//boolean flicker = false;
float angle;

PImage doge;
PImage sky;

ArrayList<hazard> baddys = new ArrayList<hazard>();
int nextBadGuyCounter = 10000;
int nextLifeCounter = 30000;

void setup()
{

  size(900, 400);
  yPos=height/2;
  sky = loadImage("spaces.png");
  doge = loadImage("doge.png");
  doge.resize(60, 60);
  sky.resize(width, height);

  textSize(30);
  baddys.add(new hazard());
}
void draw()
{
  background(0);
  imageMode(CORNER);
  image(sky, 0, 0);
  imageMode(CENTER);
  //player
  translate(xPos, yPos);
  rotate(angle);
  if (hitFrames % 5 == 0 )
  {
    image(doge, 0, 0);
  }
  rotate(-angle);
  translate(-xPos, -yPos);
  /*fill(200,50,0,50);
   ellipse(xPos,yPos,75,75);*/
  fill(255);
  //score = score + 1;
  //HUD
  for(int i = 0;i< lives; i ++)
  {
    fill(200,0,0,100);
    noStroke();
    rect(50+i*40,height-115,40,30);
  }
  if(lives >= 22)
  {
  for(int i = 0;i< lives-22; i ++)
  {
    fill(200,0,0,100);
    noStroke();
    rect(50,i*30,40,30);
  }
  }
  fill(255);
  text("score;"+score, 50, height-30);
  text("enemy count :" + enemyCount, 50, height-60);
  text("health;"+lives, 50, height-90);
  //gravity
  yPos -= ySpeed;
  ySpeed -= 0.05;
  //invincible frame
  if (hitFrames > 0)
  {
    hitFrames--;
  }
  if (angle > 0)
  {
    angle -= (2*PI)/100;
  }
  for (int i = 0; i<baddys.size(); i++)
  {
    if ( baddys.get(i).move() )
    {
      baddys.get(i).reset();
    }

    baddys.get(i).drawHazard();
    // you were hit
    if (hitFrames == 0 && wasHit(xPos, yPos, size-10, baddys.get(i)))
    {
      lives = lives -1;
      baddys.remove(i);
      enemyCount = enemyCount-1;
      hitFrames=100;
      angle = 2*PI;
    }
  }
  if (lives == 0)
  {
    //noLoop();
    text("you ded lol", width/2.5, height/2.25, 300, 300);
  }
  if (nextBadGuyCounter < millis() )//spawns new bad guys
  {
    nextBadGuyCounter = millis() + 10000;
    baddys.add(new hazard());
    enemyCount += 1;
    println(enemyCount);
    score = score + 100;
  }
  //stops from going off screen
  if (yPos < 0 )
  {
    yPos = 1;
    ySpeed = 0;
  }
  if (yPos > height)
  {
    yPos = height-1;
    ySpeed = 0;
  }
  if (nextLifeCounter < millis())
  {
    nextLifeCounter = millis() + 30000;
    lives=lives+1;
  }
}
//check for collisions
boolean wasHit( float playerX, float playerY, float playerSize, hazard h )
{
  if ( dist( playerX, playerY, h.xPos, h.yPos) <= (playerSize + h.size)/2 )
  {
    return true;
  } else
  {
    return false;
  }
}
/*boolean fieldHit()
 {
 
 }*/

void keyPressed()
{
  ySpeed += 0.5;
  //kill button
  if(key == 'k')
  {
   lives = 0;
  }
  //add more lives
  if(key == 'l')
  {
   lives++;
  }
  if(key == 'z')
  {
    baddys.add(new hazard());
    enemyCount+=1;
  }
}
void keyReleased()
{
}

void mousePressed()
{
  ySpeed += 1.5;
}
void mouseReleased()
{
}
