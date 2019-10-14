int nball=30;
int d = 30;
ArrayList<Ball> ball = new ArrayList<Ball>();

void setup() {
  size(1000, 1000);
  background(0, 0, 255);
  for (int i=1;i<=nball;i=i+1) {
    ball.add(new Ball(int(d/2+random(width-d)),int(d/2+random(height-d)),30));}
}

void draw() {
  background(0, 0, 255);
  for (int i=0;i<nball;i=i+1) {
     (ball.get(i)).moveBall();
     (ball.get(i)).display();
     for (int j=0; j<nball; j=j+1) {
       if (i!=j){
         float Xa = (ball.get(i)).getX();
         float Xb = (ball.get(j)).getX();
         float Ya = (ball.get(i)).getY();
         float Yb = (ball.get(j)).getY();
         if (sqrt(sq(Xa-Xb) + sq(Ya-Yb)) < 60) {
           strokeWeight(6);
           line(Xa,Ya,Xb,Yb);
           if (sqrt(sq(Xa-Xb) + sq(Ya-Yb)) < d) {
             float Vxa, Vya,Vxb,Vyb,alpha;
             PVector Va,Vb,AB,Va_to_b,Vb_to_a;
             Vxa = (ball.get(i)).getVx();
             Vya = (ball.get(i)).getVy();
             Vxb = (ball.get(j)).getVx();
             Vyb = (ball.get(j)).getVy();
             Va = new PVector (Vxa,Vya);
             Vb = new PVector (Vxb,Vyb);
             AB = new PVector (Xb-Xa,Yb-Ya);
             alpha = AB.heading();
             float [] Va_rot = (Va.rotate(-alpha)).array();
             float [] Vb_rot = (Vb.rotate(-alpha)).array();
             Va.rotate(alpha);
             Vb.rotate(alpha);
             Va_to_b = new PVector (Va_rot[0],0);
             Vb_to_a = new PVector (Vb_rot[0],0);
             Va_to_b.rotate(alpha);
             Vb_to_a.rotate(alpha);
             Va.add(Vb_to_a);
             Va.sub(Va_to_b);
             Vb.add(Va_to_b);
             Vb.sub(Vb_to_a);
             float [] Vain = Va.array();
             float [] Vbin = Vb.array();
             (ball.get(i)).setVx(Vain[0]);
             (ball.get(i)).setVy(Vain[1]);
             (ball.get(j)).setVx(Vbin[0]);
             (ball.get(j)).setVy(Vbin[1]);
             (ball.get(i)).moveBall();
             (ball.get(i)).display();
             (ball.get(j)).moveBall();
             (ball.get(j)).display();
           }
         }
       }
     }
   }
}

class Ball {
  float posX;
  float posY;
  float Vx=-3+random(6);
  float Vy=-3+random(6);

  Ball(float tempPosX, float tempPosY, int tempD) {
    posX = tempPosX;
    posY = tempPosY;
    d = tempD;
  }
  
  void setX(float inX) {posX = inX;}
  void setY(float inY) {posY = inY;}
  void setVx(float inVx) {Vx = inVx;}
  void setVy(float inVy) {Vy = inVy;}
  
  float getX() {return posX;}
  float getY() {return posY;}
  float getVx() {return Vx;}
  float getVy() {return Vy;}

  void moveBall() {
    if (posX >= height - d/2 || posX <= d/2) {
      Vx = -Vx;
    }
    if (posY >= width - d/2 || posY <= d/2) {
      Vy = -Vy;
    }   
    posX += Vx;
    posY += Vy;
  }

  void display() {
    strokeWeight(4);
    circle(posX, posY, d);
  }
}
