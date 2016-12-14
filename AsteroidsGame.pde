SpaceShip bob = new SpaceShip();
ArrayList<Asteroid> two = new ArrayList<Asteroid>(); 
ArrayList<Bullet> to = new ArrayList<Bullet>();
boolean go = true;
int x=0;
int y=11;
 public void keyPressed()
    {
      if  (keyCode==RIGHT)
      {
        bob.rotate(10);
      }
      if(keyCode==LEFT)
      {
        bob.rotate(-10);
      }
      
      if(keyCode==UP)
      {
        
          bob.BigL(1);
      } 
      if(keyCode==DOWN)
      {

        bob.setX((int)(Math.random()*width));
        bob.setY((int)(Math.random()*height));
        bob.setDirectionX(0);
        bob.setDirectionY(0);
        bob.setPointDirection((int)(Math.random()*360));
      }
      if(keyCode==32)
      {
        to.add(x, new Bullet(bob));
        x++;
      }
    } 
Star[] one =new Star[250];

//ArrayList<Asteroid> two = new ArrayList<Asteroid>(); 
//ArrayList<Bullet> to = new ArrayList<Bullet>();

public void setup() 
{
  size(1000,800);
  for(int i=0; i<one.length; i++)
  {
    one[i]= new Star();
  }
  for(int j=0; j<11; j++)
  {
    two.add(j, new Asteroid());
  }
  
}                         
public void draw() 
{

  if(go==true)
  {
  background(0); 
  bob.show();
  bob.move();
  
  for(int i=0; i<one.length; i++)
  {
    one[i].show();
  }
  for(int j=0; j<two.size(); j++)
  {
    two.get(j).show();
    two.get(j).move();
    two.get(j).rotate(1);
  }
  for(int z=0; z<to.size(); z++)
  {
    to.get(z).show();
    to.get(z).move();
  }
  for(int r=0; r<two.size(); r++)
  {
    for(int k = 0; k < to.size() ; k++){
      if( dist(two.get(r).getX() , two.get(r).getY() , to.get(k).getX() , to.get(k).getY() ) < 35){
        two.remove(r);
        to.remove(k);
        to.add(k,new Bullet(bob));
        y--;
        if(y==0)
        {
          go=false;
        }
        break; 
      }
    }
  }
  } 


  if(go==false)
  {
    background(0);
    textSize(60);
    text("YOU WIN", 375, 200);
    noFill();
    stroke(255);
    rect(100,300,810,400);
    textSize(20);
    text("After destroying all of the robots a ship came out and thanked you for your deeds.", 105,320,100);
    text("You later decided that you would become someone who helps people for a living.", 105,360,100);
    text("You set off again. This time without autopilot, and look for people who need help", 105,400,100);
    text("for the rest of your life. You get paid pretty well too.", 105,420,100);



  }
}

class SpaceShip extends Floater  
{   
    public SpaceShip(){
      corners=4; 
      int[] xS = {-8,16,-8,-2};
      int[] yS = {-8,0,8,0};
      xCorners = xS;
      yCorners = yS;
      myColor = color(255,255,255);
      myCenterX = 400;
      myCenterY = 300;
      myDirectionX = 0;
      myDirectionY = 0;
      myPointDirection =0;
      
    }
    public void setX(int x){myCenterX=x;}
    public int getX(){return (int)myCenterX;}
    public void setY(int y){ myCenterY=y;}
    public int getY(){return (int)myCenterY;}
    public void setDirectionX(double x){myDirectionX=x;}
    public void setDirectionY(double y){myDirectionY=y;}
    public double getDirectionX(){return myDirectionX;}
    public double getDirectionY(){return myDirectionY;}
    public void setPointDirection(int degrees){myPointDirection=degrees;}
    public double getPointDirection(){return myPointDirection;}
    void BigL(double drank)
    {
      //convert the current direction the floater is pointing to radians    
      double dRadians =myPointDirection*(Math.PI/180);     
      //change coordinates of direction of travel    
      myDirectionX += ((drank) * Math.cos(dRadians));    
      myDirectionY += ((drank) * Math.sin(dRadians));

      if(Math.sqrt(myDirectionX*myDirectionX+myDirectionY*myDirectionY) >3)
      {
        myDirectionX += -((drank) * Math.cos(dRadians));    
        myDirectionY += -((drank) * Math.sin(dRadians));
      }
    }

}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);     
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));
           
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
         
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

class Star
{
  private float mysX;
  private float mysY;
  public Star()
  {
    mysX=(float)Math.random()*width;
    mysY=(float)Math.random()*height;
  }

  public void show()
  {
    fill(255);
    ellipse(mysX,mysY,5,5);
  }
  
}

class Asteroid extends Floater
{
  private double rSpeed;
  Asteroid(){
      corners=8; 
      int[] xS = {-32,-8,8,32,32,8,-8,-32}; 
      int[] yS = {32,40,40,16,-16,-40,-40,-16};
      xCorners = xS;
      yCorners = yS;
      //Color = color(102,51,0);
      myColor = color(50 );
      myCenterX=(float)Math.random()*width;
      myCenterY=(float)Math.random()*height;
      myDirectionX = Math.random()*2;
      myDirectionY = Math.random()*2;
      myPointDirection =0;
      rSpeed= Math.random()*8-4;
  } 
  public void setX(int x){myCenterX=x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){ myCenterY=y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX=x;}
  public void setDirectionY(double y){myDirectionY=y;}
  public double getDirectionX(){return myDirectionX;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection=degrees;}
  public double getPointDirection(){return myPointDirection;}
  public double getrSpeed(){return rSpeed;}
  public void show(){
    //noFill();
    stroke(myColor); 
    fill(myColor);   
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
    stroke(0);
    fill(255,0,0);
    ellipse((float)myCenterX,(float)myCenterY,10,10);
  }  
    public void rotate (double nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  
}

class Bullet extends Floater
{
  Bullet(SpaceShip theShip){
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    double dRadians =myPointDirection*(Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + theShip.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + theShip.getDirectionY();
    
  }
  public void setX(int x){myCenterX=x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){ myCenterY=y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX=x;}
  public void setDirectionY(double y){myDirectionY=y;}
  public double getDirectionX(){return myDirectionX;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection=degrees;}
  public double getPointDirection(){return myPointDirection;}

  void show(){
    fill(255);
    noStroke();
    ellipse((int)myCenterX, (int)myCenterY, 5, 5);
  }

  void move()
  {
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;    
  }
}


