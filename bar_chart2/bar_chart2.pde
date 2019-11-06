Table table;
ArrayList<Score> score = new ArrayList<Score>();
ArrayList<Awoifin> awin = new ArrayList<Awoifin>();
ArrayList<Awoifout> awout = new ArrayList<Awoifout>();
ArrayList<Awoifsize> awsize = new ArrayList<Awoifsize>();
int size;
int bar_width=50;
int gap=15;
int lmargin=100;
int dmargin=50;
String[] label = {"Score","Links in","Links out","Links page size"};
Boolean[] label_status = {true,false,false,false};
int labelon=0;
String data;


void setup() {
  size(3000, 1000);
  table = loadTable("GOT.csv","header");
  table.setColumnType("score", Table.FLOAT);
  table.sortReverse("score");
  for (TableRow row : table.rows()) {
    String cleaned_name[] = split(row.getString("common_name"),"(");
    score.add(new Score(cleaned_name[0],row.getFloat("score")));
  }
  size = score.size();
  
  table.setColumnType("awoif_in_degree", Table.FLOAT);
  table.sortReverse("awoif_in_degree");
  for (TableRow row : table.rows()) {
    String cleaned_name[] = split(row.getString("common_name"),"(");
    awin.add(new Awoifin(cleaned_name[0],row.getInt("awoif_in_degree")));
  }
  
  table.setColumnType("awoif_out_degree", Table.FLOAT);
  table.sortReverse("awoif_out_degree");
  for (TableRow row : table.rows()) {
    String cleaned_name[] = split(row.getString("common_name"),"(");
    awout.add(new Awoifout(cleaned_name[0],row.getInt("awoif_out_degree")));
  }
  
  table.setColumnType("awoif_page_size", Table.FLOAT);
  table.sortReverse("awoif_page_size");
  for (TableRow row : table.rows()) {
    String cleaned_name[] = split(row.getString("common_name"),"(");
    awsize.add(new Awoifsize(cleaned_name[0],row.getInt("awoif_page_size")));
  }
}

void draw() {
  String[] name = new String[size];
  Float[] value = new Float[size];
  Float[] barsize = new Float[size];
  background(255, 255, 255);
  textSize(70);
  fill(255,0,0,255);
  textAlign(CENTER);
  text("GOT: who deserves the throne ?",1500,60);
  textSize(30);
  fill(0,0,0,255);
  textLeading(30);
  text("Ranking of the GOT characters depending on their score,\nlinks out and in to other characters and links page size.",1500,110);
  strokeWeight(4);
  for (int i=0; i<4; i++){
    if(label_status[i]){
      fill(125,125,125,255);
      data=label[i];
    } else {
      fill(255,255,255,255);
    }
    rect(200,20+50*i,250,40);
    textAlign(CENTER);
    textSize(30);
    fill(0,0,0,255);
    text(label[i],325,50+50*i);
  }
  int n = (width-2*lmargin)/(bar_width+gap);
  if (label_status[0]){
    for (int i=0; i<size; i++){
      value[i]=score.get(i).getScore();
      barsize[i]=350*value[i];
      name[i]=score.get(i).getName();
    }
  }
  if (label_status[1]){
    for (int i=0; i<size; i++){
      value[i]=awin.get(i).getScore();
      barsize[i]=1.8*value[i];
      name[i]=awin.get(i).getName();
    }
  }
  if (label_status[2]){
    for (int i=0; i<size; i++){
      value[i]=awout.get(i).getScore();
      barsize[i]=3*value[i];
      name[i]=awout.get(i).getName();
    }
  }
  if (label_status[3]){
    for (int i=0; i<size; i++){
      value[i]=awsize.get(i).getScore();
      barsize[i]=value[i]/600;
      name[i]=awsize.get(i).getName();
    }
  }
  for (int i=0; i<n;i++) {
    fill(150,150,150,255);
    if (i==0){
      fill(0,0,0,0);
      stroke(255,215,0,255);
      rect(850,200,600,150);
      stroke(0,0,0,255);
      textAlign(CENTER);
      textSize(50);
      fill(0,0,0,255);
      text(name[i],1150,260);
      textSize(30);
      text(data+": "+value[i],1150,310);
      fill(255,215,0,255);
    }else{
      if (pmouseX>=lmargin+gap+i*(bar_width+gap) && pmouseX<=lmargin+gap+i*(bar_width+gap)+bar_width && pmouseY >= height-dmargin-barsize[i] && pmouseY<=height-dmargin){
        fill(0,0,0,0);
        stroke(255,0,0,255);
        strokeWeight(4);
        rect(1550,200,600,150);
        stroke(0,0,0,255);
        textAlign(CENTER);
        textSize(50);
        fill(0,0,0,255);
        text(name[i],1850,260);
        textSize(30);
        text(data+": "+value[i],1850,310);
        fill(255,0,0,255);
      }
    }
    strokeWeight(0);
    rect(lmargin+gap+i*(bar_width+gap), height-dmargin-barsize[i],bar_width,barsize[i]);
  }
}

void mouseClicked() {
  if (pmouseX<=450 && pmouseX>=200){
    for (int i=0;i<5;i++){
      if (pmouseY>=1+50*i && pmouseY<=1+50*i+40){
        label_status[labelon] = false;
        label_status[i]= true;
        labelon=i;
      }
    }
  }
}

void mouseMoved() {
}

class Score {
  String name;
  Float score;
  
  Score(String tempName, float tempScore){
    name=tempName;
    score=tempScore;
  }
  
  String getName() {return name;}
  float getScore() {return score;}
}

class Awoifsize {
  String name;
  int score;
  
  Awoifsize(String tempName, int tempScore){
    name=tempName;
    score=tempScore;
  }
  
  String getName() {return name;}
  float getScore() {return score;}
}

class Awoifin {
  String name;
  int score;
  
  Awoifin(String tempName, int tempScore){
    name=tempName;
    score=tempScore;
  }
  
  String getName() {return name;}
  float getScore() {return score;}
}

class Awoifout {
  String name;
  int score;
  
  Awoifout(String tempName, int tempScore){
    name=tempName;
    score=tempScore;
  }
  
  String getName() {return name;}
  float getScore() {return score;}
}
