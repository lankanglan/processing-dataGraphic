Table foodTable=null;  //<>//
color highlightColor=#FFFFFF;
float dataTipX=0;
float dataTipY=0;
int dataTipYear=0;
float dataTipPrice=0;
PImage grape = null;
PImage wine = null;

void setup() {
  size(900, 600);
  foodTable = loadTable("ap.data.3.Food.txt", "header,tsv");
  foodTable.trim("series_id");
  grape = loadImage("grape.png");
  wine = loadImage("wine.png");
  noStroke();
}//setup()

void draw() {
  background(0);
  float barWidth =16;
  float x =100;
  int startYear=1996;
  fill(255);
  textSize(20);
  text("WINE AND GRAPES PRICE 1996-2015", 300, 60);//title text
  noStroke();
  fill(255, 255, 0);
  rect(150, 100, 20, 10);
  fill(255);
  textSize(8);
  text("wine", 180, 110);//yellow rectangle for wine
  fill(#5070f2);
  rect(220, 100, 20, 10);
  fill(255);
  text("grape", 250, 110);//blue rectangle for wine
   //<>//
  String seriesId="APU0000720311";
  drawBars(foodTable, seriesId, x, barWidth, startYear);
  seriesId="APU0000711417";
  drawBars(foodTable, seriesId, x+barWidth+36, barWidth, startYear);
  if (dataTipX>0) {
    drawDataTip(dataTipX, dataTipY, dataTipYear, dataTipPrice);
  }
  dataTipX=-1;
  dataTipY=-1;
  drawLine(x);
  fill(255);//vertical rule(price)
  textSize(8);
  text("$"+13, 60, 124);
  text("$"+12, 60, 154);
  text("$"+11, 60, 184);
  text("$"+10, 60, 214);
  text("$"+9, 60, 244);
  text("$"+8, 60, 274);
  text("$"+7, 60, 304);
  text("$"+6, 60, 334);
  text("$"+5, 60, 364);
  text("$"+4, 60, 394);
  text("$"+3, 60, 424);
  text("$"+2, 60, 454);
  text("$"+1, 60, 484);
}
void drawLine(float x) {//horizontal rule(year)
  stroke(255);
  line(x-15, 100, x-15, 500);
  for (int j=120; j<=500; j+=30) {
    line(x-20, j, x-15, j);
  }
}
void drawBars(Table foodTable, String seriesId, float x, float barWidth, int startYear) {
  int i=1;
  int numMonths =12;
  float averagePrice=0;
  for (TableRow row : foodTable.findRows(seriesId, "series_id")) {
    int year = row.getInt("year");
    if (year>=startYear) {
      float price=row.getFloat("value");
      averagePrice += price;
      if (i%numMonths==0) {
        averagePrice/=12;// averagePrice= averagePrice/12
        String month = row.getString("period");
        float h= averagePrice*30;
        float y=height-h-100;

        if ( seriesId=="APU0000720311") {
          fill(255, 255, 0);
          stroke(255); 
          line(x-3, y+h+10, x+barWidth*2, y+h+10);
          line(x+barWidth*2, y+h+10, x+barWidth*2, y+h+5);
          textSize(8);
          text(year, x, y+h+25);
        } else {
          fill(#5070f2);
        }
        noStroke();
        setHighlight(x, y, barWidth, h);
        rect(x, y, barWidth, h);
        dataTip(seriesId, x, y, barWidth, h, year, averagePrice);
        x=x+36;
        averagePrice=0;
      }
      i++;
    }
  }// for loop
}//drawBars
void setHighlight(float x, float y, float barWidth, float h) {
  if (mouseX<x+barWidth && mouseX>x && mouseY<y+h && mouseY>y) {
    fill(highlightColor);
  }
}
void drawDataTip(float x, float y, int year, float price) {          
  fill(#a10000);
  noStroke();
  rect(x, y, 80, 40);
  beginShape();
  vertex(x+30, y+39);
  vertex(x+40, y+47);
  vertex(x+50, y+39);
  endShape();
  fill(255);
  textSize(15);
  text(year, x+5, y+20);
  fill(0);
  textSize(10);
  text("$"+price, x+5, y+35);
}
void dataTip(String seriesId, float x, float y, float barWidth, float h, int year, float price) {
  if (mouseX<x+barWidth && mouseX>x && mouseY<y+h && mouseY>y) {
    if ( seriesId=="APU0000720311") {//wine picture and data
      image(wine, 152, 200, 16, 30);
      noStroke();
      fill(255);
      textSize(10);
      text(year, 180, 210);
      textSize(10);
      text("$"+price, 180, 225);
    } else if ( seriesId=="APU0000711417") {//grape picture and data
      image(grape, 150, 250, 20, 30);
      noStroke();
      fill(255);
      textSize(10);
      text(year, 180, 265);
      textSize(10);
      text("$"+price, 180, 280);
    }
    dataTipX=x-33;
    dataTipY=y-50;
    dataTipYear=year;
    dataTipPrice=price;
  }
}