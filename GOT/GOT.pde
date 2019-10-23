Table table;
ArrayList<Ball> ball = new ArrayList<Ball>();
ArrayList<String> name = new ArrayList<String>();
ArrayList<String> titles = new ArrayList<String>();
String[] check;
Boolean ser_status = false;
Boolean prince_status = false;
Boolean king_status = false;
Boolean lord_status = false;
int s;


void setup() {
  size(2000, 1500);
  table = loadTable("GOT.csv","header");
  for (TableRow row : table.rows()) {
    String cat = row.getString("category");
    String book = row.getString("books");
    if (book.equals("[1, 2, 3, 4, 5]")==true && cat.equals("appears")==true){
      String com_name = row.getString("common_name");
      String titre = row.getString("titles");
      Float score = row.getFloat("score");
      Float size = 15 + score * 60;  
      ball.add(new Ball(size/2+random(width-size),size/2+random(height-size),size));
      name.add(new String(com_name));
      titles.add(new String(titre));
    }
  }
}

void draw() {
  background(255, 255, 255);
  textSize(30);
  for (int i=0;i<ball.size();i=i+1) {
    float X = (ball.get(i)).getX();
    float Y = (ball.get(i)).getY();
    float D = (ball.get(i)).getd();
    fill(0,0,0,0);
    if (prince_status) {
      check = match(titles.get(i), "'Prince");
      if(check!=null){
        fill(255,0,0,255);
        textAlign(CENTER);
        text(name.get(i),X,Y-10-D/2);
      }
    }
    if (ser_status) {
      check = match(titles.get(i), "'Ser");
      if(check!=null){
        fill(0,255,0,255);
        textAlign(CENTER);
        text(name.get(i),X,Y-10-D/2);
      }
    }
    if (lord_status) {
      check = match(titles.get(i), "'Lord");
      if(check!=null){
        fill(255,0,255,255);
        if(ser_status){
          check = match(titles.get(i), "'Ser");
          if(check!=null){
            s=millis()/500;
            if (s % 2 ==1){
              fill(255,0,255,255);
            } else{
              fill(0,255,0,255);
            }
          }
        }
        textAlign(CENTER);
        text(name.get(i),X,Y-10-D/2);
      }
    }
    if (king_status) {
      check = match(titles.get(i), "'King");
      if(check!=null){
        fill(0,0,255,255);
        textAlign(CENTER);
        text(name.get(i),X,Y-10-D/2);
      }
      check = match(titles.get(i), "'Queen");
      if(check!=null){
        fill(0,0,255,255);
        textAlign(CENTER);
        text(name.get(i),X,Y-10-D/2);
      }
    }
    (ball.get(i)).moveBall();
    (ball.get(i)).display(); 
   }
  if (prince_status){
    fill(125,125,125,255);
  } else{
    fill(255,255,255,255);
  }
  rect(1,1, 250, 50);
  if (ser_status){
    fill(125,125,125,255);
  } else{
    fill(255,255,255,255);
  }
  rect(275,1, 75, 50);
  if (king_status){
    fill(125,125,125,255);
  } else{
    fill(255,255,255,255);
  }
  rect(375,1, 200, 50);
  if (lord_status){
    fill(125,125,125,255);
  } else{
    fill(255,255,255,255);
  }
  rect(600,1, 100, 50);
  textAlign(LEFT);
  fill(255,0,0,255);
  text("Prince/Princess",15,40);
  fill(0,255,0,255);
  text("Ser",290,40);
  fill(0,0,255,255);
  text("King/Queen",390,40);
  fill(255,0,255,255);
  text("Lord",615,40);
}

class Ball {
  float d;
  float posX;
  float posY;
  float Vx=-3+random(6);
  float Vy=-3+random(6);

  Ball(float tempPosX, float tempPosY, float tempD) {
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
  float getd() {return d;}

  void moveBall() {
    if (posX >= width - d/2 || posX <= d/2) {
      Vx = -Vx;
      posX += Vx; // afin d'éviter blocage dans le mur
    }
    if (posY >= height - d/2 || posY <= d/2) {
      Vy = -Vy;
      posY += Vy;
    }   
    posX += Vx;
    posY += Vy;
  }

  void display() {
    strokeWeight(4);
    circle(posX, posY, d);
  }
}

void mouseClicked() {
  if (pmouseY<=51){
    if (pmouseX<=251){
      prince_status = !prince_status;
    }
    if (pmouseX>=275 && pmouseX<=350){
      ser_status = !ser_status;
    }
    if (pmouseX>=375 && pmouseX<=575){
      king_status = !king_status;
    }
    if (pmouseX>=600 && pmouseX<=700){
      lord_status = !lord_status;
    }
  }
}
