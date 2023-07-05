class Sphere
{
  float y;
  float x;
  float speed;
  float size;
  PImage image;
  PShape mySphere;
  String label;
  
  public Sphere(PImage imageParam, String labelParam)
  {
     image = imageParam;
     label = labelParam;
     randomize();
  }
  
  void drawSphere()
  {
    pushMatrix();
    translate(x, y, 0);
    rotateY(-300);
    noStroke();
    textureMode(NORMAL);
    mySphere.setTexture(image);
    shape(mySphere);
    lights();
    popMatrix();
    
    y += speed;
    
    if(y > height + 100)
    {
       randomize();
    }
  }
  
  void randomize()
  {
    y = -100;
    x = random(0, width);
    speed = random(2, 5);
    size = random(50, 100);
    mySphere = createShape(SPHERE, size);
    mySphere.setTextureMode(NORMAL);
    mySphere.setTexture(image);
  }
  
  public String getLabel()
  { 
     int dotIndex = label.indexOf(".");
     String newLabel = label.substring(0, dotIndex);
     return newLabel;
  }
}
