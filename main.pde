import ddf.minim.*;

Minim minim;
AudioPlayer catPlayer;
AudioPlayer dogPlayer;
AudioPlayer chimpPlayer;
AudioPlayer clickPlayer;
AudioPlayer endGamePlayer;

String[] characters = {"dog.jpg", "cat.jpg", "chimp.jpg"};
PImage[] images = new PImage[3];

ArrayList<Sphere> characterList = new ArrayList<Sphere>();

boolean isClicking = false;

int numberOfSpheres = 30;
int offset = 50;
int score = 0;
int timesClicked = 0;
int timer = 60;
int frameCounter = 0;
int cursorSize = 100;

String target;
String targetDisplay;

void setup()
{
   fullScreen(P3D);
   // size(1920, 1080, P3D);
   frameRate(60);
   noStroke();
   
   minim = new Minim(this);
   catPlayer = minim.loadFile("cat-sound.mp3");
   dogPlayer = minim.loadFile("dog-sound.mp3");
   chimpPlayer = minim.loadFile("chimp-sound.mp3");
   clickPlayer = minim.loadFile("click-sound.mp3");
   endGamePlayer = minim.loadFile("game-over.mp3");
   
   setTarget();
   
   for(int i = 0; i < characters.length; i++)
   {
      images[i] = loadImage(dataPath(characters[i]));
   }
   
   int randomIndex;
   for (int i = 0; i < numberOfSpheres; i++)
   {
     randomIndex = int(random(characters.length));
     characterList.add(new Sphere(images[randomIndex], characters[randomIndex]));
   }
}

void draw()
{
  if(!checkIfLabelExists(characterList, target))
  {
     setTarget(); 
  }
  
  background(0);
  drawShoot();
  drawScore();
  noFill();
  for(Sphere sphere : characterList)
  {
    sphere.drawSphere();
  }
  
  if(mousePressed && !isClicking)
  {
     isClicking = true;
     for(Sphere s : characterList)
     {
         if((mouseX < s.x + offset && mouseX > s.x - offset && mouseY < s.y + offset && mouseY > s.y - offset))
         {
              if(target.equals(s.getLabel()))
              {
                 score += 50;
              }
              else
              {
                 score -= 50; 
              }
              s.randomize();
              timesClicked++;
              if(timesClicked > 2)
              {
                 timesClicked = 0;
                 setTarget(); 
              }
              clickPlayer = minim.loadFile("click-sound.mp3");
              clickPlayer.play();
              break;
         }
     }
  }
  timer();
}

void mouseReleased()
{
   isClicking = false; 
}

void drawShoot()
{
   textSize(84);
   text("Catch: " + targetDisplay, width / 2 - 175, height - 15);  
}

void drawScore()
{
    textSize(84);
    text("Score: " + score, 0, height - 15);
}

boolean checkIfLabelExists(ArrayList<Sphere> myList, String label)
{
   for(Sphere sphere : myList)
   {
      if(sphere.getLabel().equals(label))
      {
         return true;
      }
   }
   return false;
}

void setTarget()
{
  catPlayer = minim.loadFile("cat-sound.mp3");
  dogPlayer = minim.loadFile("dog-sound.mp3");
  chimpPlayer = minim.loadFile("chimp-sound.mp3");
  
  String tempTarget = characters[int(random(3))];
  int dotIndex = tempTarget.indexOf(".");
  target = tempTarget.substring(0, dotIndex);
  targetDisplay = target.substring(0, 1).toUpperCase() + target.substring(1, target.length());
  if(target.equals("cat"))
  {
     catPlayer.play();
  }
  else if(target.equals("dog"))
  {
     dogPlayer.play(); 
  }
  else if(target.equals("chimp"))
  {
     chimpPlayer.play(); 
  }
}

void endGame()
{
   catPlayer.mute();
   dogPlayer.mute();
   chimpPlayer.mute();
   clickPlayer.mute();
   endGamePlayer.play();
   background(0);
   textSize(84);
   fill(255, 0, 0, 255);
   text("GAME OVER!", width/2 - 200, height/2 - 100);
   text("Final Score: " + score, width/2 - 200, height/2 + 100);
   noLoop();
}

void timer()
{
  frameCounter++;
  
  if(frameCounter == 60)
  {
     timer--;
     frameCounter = 0;
  }
  
  String timerDisplay = checkDigits(timer);
  
  textSize(84);
  text("00:" + timerDisplay, width - 250, height - 15);
  
  if (timer <= 0) 
  {
    endGame();
  }
}

String checkDigits(int number)
{
   String modifiedTimer = "";
   if(String.valueOf(number).length() == 1)
   {
     modifiedTimer = "0" + number;
     return modifiedTimer;
   }
   return String.valueOf(number);
}
