import netP5.*;
import oscP5.*;
import java.util.*;
import processing.io.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

public String plist = "";
int boxOffset = 3;

int switchnum;

boolean count_bool = true;

color blue = color(0, 0, 255);
color yellow = color(255, 255, 0);

int GPIOpinButton0 = 17;
int GPIOpinButton1 = 23;
int GPIOpinButton2 = 24;
int GPIOpinButton3 = 26;

String[] num1 = {"5", "41", "32", "311", "2111", "221"};

public StringBuilder userpermutation = new StringBuilder("[A, B, C, X, X]");

float size;

//PImage img;

PFont fontbig;
PFont fontsmall;

String OscSchedule[] = new String[2000];

int SchNum = -1;


IntList newpermutation= new IntList(1, 2, 3, 0, 0 );
IntList oldpermutation= new IntList();
int[] metapatterncount = {0, 0, 0, 0, 0, 0};

public IntList group1 = new IntList(0, 1, 2, 3);
public IntList group2 = new IntList();
public IntList group3= new IntList();



OscMessage firstpermutation = new OscMessage("/firstpermutation");
IntList receivedValues = new IntList();

int count = 0;

boolean timer = false;
float timer_count = 0;
boolean delayBool = false;
public  OscMessage reset = new OscMessage("/reset");


void setup() {

  //pins
  GPIO.pinMode(GPIOpinButton0, GPIO.INPUT_PULLUP);
  GPIO.pinMode(GPIOpinButton1, GPIO.INPUT_PULLUP);
  GPIO.pinMode(GPIOpinButton2, GPIO.INPUT_PULLUP);
  GPIO.pinMode(GPIOpinButton3, GPIO.INPUT_PULLUP);

  oscP5 = new OscP5(this, 1510);
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);

  oscP5.plug(this, "permutationchangeWrite", "/permutationchange");
  oscP5.plug(this, "metapatterncountWrite", "/metapatterncount");

  frameRate(60);
  fullScreen();
  //size(800,480);
  //size(1024,600);

  heightOffset = height/140.0;
  heightOffset2 = height/182.0;

  switchnum = 6;


  fontbig = createFont("myriad.ttf"
    , 36, true);

  // img = loadImage("interface.jpg");


  size = fittedText("[A, B, C, X, X]", fontbig, width/4.35);

  // imageMode(CORNER);
  //image(img, 0, 0, width, height);
  textSize(size);
}

float heightOffset;
float heightOffset2;

int iter = 1;

void draw() {

  if (delayBool == true) {

    delay(5000);
    delayBool = false;

    while (count == 0) {
      oscP5.send(firstpermutation, myRemoteLocation);
      println("firstpermutation after reset:");
      for (int i=0; i<=SchNum; i++) {
        OscRoute(OscSchedule[i]);
      }
      SchNum=-1;
    }
  }


  //image(img, 0, 0, width, height);
  for (int i=0; i<=SchNum; i++) {
    OscRoute(OscSchedule[i]);
  }
  SchNum=-1;



  //////////////////////////////////////////
  if (timer == true) {




    timer_count = timer_count + 1.0/frameRate;
  };

  if (timer_count > 10.0) {



    noStroke();
    fill(yellow);
    rect((width/2.0), 0, (width/2.0)/2.0, height/8.0);
    fill(blue);

    rect((width/2.0) +(width/2.0)/2.0, 0, (width/2.0)/2.0, height/8.0);

    rect((width/2.0), height/8.0, (width/2.0)/2.0, height/8.0);
    rect((width/2.0) +(width/2.0)/2.0, height/8.0, (width/2.0)/2.0, height/8.0);
    rect((width/2.0), (height/8.0)*2, (width/2.0)/2.0, height/8.0);
    rect((width/2.0) +(width/2.0)/2.0, (height/8.0)*2, (width/2.0)/2.0, height/8.0);
    rect((width/2.0), (height/8.0)*3, (width/2.0)/2.0, height/8.0);
    rect((width/2.0) +(width/2.0)/2.0, (height/8.0)*3, (width/2.0)/2.0, height/8.0);
    rect((width/2.0), (height/8.0)*4, (width/2.0)/2.0, height/8.0);
    rect((width/2.0) +(width/2.0)/2.0, (height/8.0)*4, (width/2.0)/2.0, height/8.0);
    rect((width/2.0), (height/8.0)*5, (width/2.0)/2.0, height/8.0);
    rect((width/2.0) +(width/2.0)/2.0, (height/8.0)*5, (width/2.0)/2.0, height/8.0);
    rect((width/2.0), (height/8.0)*6, (width/2.0)/2.0, height/8.0);
    rect((width/2.0) +(width/2.0)/2.0, (height/8.0)*6, (width/2.0)/2.0, height/8.0);
    rect((width/2.0), (height/8.0)*7, (width/2.0)/2.0, height/8.0);

    textAlign(CENTER, CENTER);

    String x = userpermutation.toString();
    text(x, (width/2.0)+(((width/2.0)/2.0)/2.0), ((height/8.0)/2.0) -heightOffset);

    x = x.replace('X', '0');
    x = x.replace('A', '1');
    x = x.replace('B', '2');
    x=  x.replace('C', '3');






    timer = false;
    timer_count = 0;
    switchnum = 6;


    metapatterncount = new int[] {0, 0, 0, 0, 0, 0};
    oldpermutation= new IntList();
    group1 = new IntList(0, 1, 2, 3);
    group2 = new IntList();
    group3= new IntList();
    count = 0;






    IntList i = new IntList(Integer.parseInt(x.substring(1, 2)), Integer.parseInt(x.substring(4, 5)), Integer.parseInt(x.substring(7, 8)), Integer.parseInt(x.substring(10, 11)), Integer.parseInt(x.substring(13, 14)));

    plist = "";
    firstpermutation = new OscMessage("/firstpermutation");
    firstpermutation.add(i.array());
    println("firstpermutation before reset:" + i);
    plist = str(i.get(0)) + str(i.get(1))+ str(i.get(2))+ str(i.get(3)) + str(i.get(4));
    newpermutation = i;
    numfunc(i);


    fill(blue);


    textAlign(CENTER, CENTER);

    rect(0, (height/8)+((height/9.955903643445904)*6), width/8.0, height/11.01556637222976);
    rect(width/8.0, (height/8)+((height/9.955903643445904)*6), width/8.0, height/11.01556637222976);
    rect(width/8.0*2, (height/8)+((height/9.955903643445904)*6), width/8.0, height/11.01556637222976);
    rect(width/8.0*3, (height/8)+((height/9.955903643445904)*6), width/8.0, height/11.01556637222976);

    fill(yellow);

    text("A", (0 +width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("B", (width/8.0) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("C", (width/8.0*2) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("X", (width/8.0*3) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6)) +((height/11.01556637222976)/2.0)   -heightOffset);

    fill(blue);

    rect(0, (height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976), width/8.0, height/11.01556637222976);
    rect(width/8.0, (height/8)+((height/9.955903643445904)*6)+ (height/11.01556637222976), width/8.0, height/11.01556637222976);
    rect(width/8.0*2, (height/8)+((height/9.955903643445904)*6)+ (height/11.01556637222976), width/8.0, height/11.01556637222976);
    rect(width/8.0*3, (height/8)+((height/9.955903643445904)*6)+ (height/11.01556637222976), width/8.0, height/11.01556637222976);

    fill(yellow);

    text("A", (0 +width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("B", (width/8.0) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("C", (width/8.0*2) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("X", (width/8.0*3) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976)) +((height/11.01556637222976)/2.0)   -heightOffset);

    fill(blue);

    rect(0, (height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2), width/8.0, height/11.01556637222976);
    rect(width/8.0, (height/8)+((height/9.955903643445904)*6)+ ((height/11.01556637222976)*2), width/8.0, height/11.01556637222976);
    rect(width/8.0*2, (height/8)+((height/9.955903643445904)*6)+ ((height/11.01556637222976)*2), width/8.0, height/11.01556637222976);
    rect(width/8.0*3, (height/8)+((height/9.955903643445904)*6)+ ((height/11.01556637222976)*2), width/8.0, height/11.01556637222976);

    fill(yellow);

    text("A", (0 +width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("B", (width/8.0) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("C", (width/8.0*2) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("X", (width/8.0*3) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2)) +((height/11.01556637222976)/2.0)   -heightOffset);



    fill(blue);



    rect(0, (height/8.0), width/2.0, height/9.955903643445904);
    rect(0, (height/8)+(height/9.955903643445904), width/2.0, height/9.955903643445904);
    rect(0, (height/8)+((height/9.955903643445904)*2), width/2.0, height/9.955903643445904);
    rect(0, (height/8)+((height/9.955903643445904)*3), width/2.0, height/9.955903643445904);
    rect(0, (height/8)+((height/9.955903643445904)*4), width/2.0, height/9.955903643445904);
    rect(0, (height/8)+((height/9.955903643445904)*5), width/2.0, height/9.955903643445904);

    textAlign(RIGHT, CENTER);
    fill(yellow);
    text(metapatterncount[0], width/2.965, ((height/8.0)+(height/9.955903643445904)/2.0) -heightOffset);
    text(metapatterncount[1], width/2.965, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) -heightOffset);
    text(metapatterncount[2], width/2.965, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) -heightOffset);
    text(metapatterncount[3], width/2.965, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
    text(metapatterncount[4], width/2.965, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
    text(metapatterncount[5], width/2.965, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);
    noFill();

    textAlign(LEFT, CENTER);
    text("5", width/66.0, ((height/8.0)+(height/9.955903643445904)/2.0) -heightOffset);
    text("4", width/66.0, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) -heightOffset);
    text("3", width/66.0, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) -heightOffset);
    text("3", width/66.0, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
    text("2", width/66.0, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
    text("2", width/66.0, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);

    text("1", width/14.2, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) -heightOffset);
    text("2", width/14.2, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) -heightOffset);
    text("1", width/14.2, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
    text("1", width/14.2, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
    text("2", width/14.2, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);

    text("1", width/7.902, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
    text("1", width/7.902, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
    text("1", width/7.902, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);

    text("1", width/5.48, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);

    textSize(size/2.0);
    text("&", width/20.82, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) + heightOffset);
    text("&", width/20.82, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) + heightOffset);
    text("&", width/20.82, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) + heightOffset);
    text("&", width/20.82, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) + heightOffset) ;
    text("&", width/20.82, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) + heightOffset);

    text("&", width/9.68, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) + heightOffset);
    text("&", width/9.68, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) + heightOffset);
    text("&", width/9.68, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) + heightOffset);

    text("&", width/6.28, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) + heightOffset);


    textSize(size);

    textAlign(RIGHT, CENTER);
    text("/4", width/2.064, ((height/8.0)+(height/9.955903643445904)/2.0) -heightOffset);
    text("/60", width/2.064, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) -heightOffset);
    text("/120", width/2.064, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) -heightOffset);
    text("/240", width/2.064, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
    text("/240", width/2.064, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
    text("/360", width/2.064, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);


    fill(yellow);
    rect((width/2.0) +(width/2.0)/2.0, (height/8.0)*7, (width/2.0)/2.0, height/8.0);
    fill(blue);
    text("1/1024", width - width/33.2, height-(((height/14.2))));


    reset = new OscMessage("/reset");

    reset.add(true);

    oscP5.send(reset, myRemoteLocation);


    count_bool = false;
    delayBool = true;
  } else {

    //println(switchnum);

    if (count == 0 && count_bool == true ) {
      OscSchedule = new String[2000];
      plist = "";
      println("here");
      firstpermutation = new OscMessage("/firstpermutation");
      println(userpermutation.toString());
      String x = userpermutation.toString();

      count_bool = false;

      x = x.replace('X', '0');
      x = x.replace('A', '1');
      x = x.replace('B', '2');
      x=  x.replace('C', '3');

      IntList i = new IntList(Integer.parseInt(x.substring(1, 2)), Integer.parseInt(x.substring(4, 5)), Integer.parseInt(x.substring(7, 8)), Integer.parseInt(x.substring(10, 11)), Integer.parseInt(x.substring(13, 14)));
      firstpermutation.add(i.array());
      plist = str(i.get(0)) + str(i.get(1))+ str(i.get(2))+ str(i.get(3)) + str(i.get(4));
      println("firstpermutation count zero" + i);
      oscP5.send(firstpermutation, myRemoteLocation);
      numfunc(i);
    };


    background(blue);


    //pins
    if (GPIO.digitalRead(GPIOpinButton0) == GPIO.LOW) {
      timer = true;
      if (iter > 14) {
        iter = 1;
      };
      userpermutation.setCharAt(iter, char(65));
      iter = iter+ 3;
      // background(0);
      textSize(size);
      textAlign(CENTER, CENTER);

      while (GPIO.digitalRead(GPIOpinButton0) == GPIO.LOW) {
      };
    };
    if (GPIO.digitalRead(GPIOpinButton1) == GPIO.LOW) {
      timer = true;
      if (iter > 14) {
        iter = 1;
      };
      userpermutation.setCharAt(iter, char(66));
      iter = iter+ 3;
      // background(0);
      textSize(size);
      textAlign(CENTER, CENTER);

      while (GPIO.digitalRead(GPIOpinButton1) == GPIO.LOW) {
      };
    };
    if (GPIO.digitalRead(GPIOpinButton2) == GPIO.LOW) {
      timer = true;
      if (iter > 14) {
        iter = 1;
      };
      userpermutation.setCharAt(iter, char(67));
      iter = iter+ 3;
      //background(0);
      textSize(size);
      textAlign(CENTER, CENTER);

      while (GPIO.digitalRead(GPIOpinButton2) == GPIO.LOW) {
      };
    };
    if (GPIO.digitalRead(GPIOpinButton3) == GPIO.LOW) {
      timer = true;
      if (iter > 14) {
        iter = 1;
      };
      userpermutation.setCharAt(iter, char(88));
      iter = iter+ 3;
      //background(0);
      textSize(size);
      textAlign(CENTER, CENTER);

      while (GPIO.digitalRead(GPIOpinButton3) == GPIO.LOW) {
      };
    };


    rectMode(CORNER);
    //  fill(255,255,255);
    textAlign(CENTER, CENTER);

    noFill();
    rect(0, 0, width/2.0, height/8.0);
    fill(yellow);
    // fill(0,0,0);
    text(userpermutation.toString(), (width/2.0)/2.0, ((height/8.0)/2.0) -heightOffset);




    stroke(yellow);
    noFill();

    strokeWeight(5.0);
    beginShape();
    vertex(width/14.8, 0);
    vertex(width/14.8, ((height/8.0)/2.0));
    vertex(width/14.8 + width/27.6, ((height/8.0)/2.0) );
    endShape();


    beginShape();
    vertex(width/2.525, ((height/8.0)/2.0));
    vertex(width/2.525 + width/19.2, ((height/8.0)/2.0) );
    endShape();

    noStroke();
    fill(yellow);
    beginShape();
    vertex(width/2.525 + width/19.4, ((height/8.0)/2.0)+height/70.0);
    vertex(width/2.525 + width/19.4, ((height/8.0)/2.0)-height/70.0 );
    vertex(width/2.525 + width/14.2, ((height/8.0)/2.0) );
    endShape();

    noFill();




    rect(0, (height/8.0), width/2.0, height/9.955903643445904);
    rect(0, (height/8)+(height/9.955903643445904), width/2.0, height/9.955903643445904);
    rect(0, (height/8)+((height/9.955903643445904)*2), width/2.0, height/9.955903643445904);
    rect(0, (height/8)+((height/9.955903643445904)*3), width/2.0, height/9.955903643445904);
    rect(0, (height/8)+((height/9.955903643445904)*4), width/2.0, height/9.955903643445904);
    rect(0, (height/8)+((height/9.955903643445904)*5), width/2.0, height/9.955903643445904);

    textAlign(RIGHT, CENTER);
    fill(yellow);
    text(metapatterncount[0], width/2.965, ((height/8.0)+(height/9.955903643445904)/2.0) -heightOffset);
    text(metapatterncount[1], width/2.965, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) -heightOffset);
    text(metapatterncount[2], width/2.965, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) -heightOffset);
    text(metapatterncount[3], width/2.965, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
    text(metapatterncount[4], width/2.965, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
    text(metapatterncount[5], width/2.965, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);
    noFill();

    textAlign(LEFT, CENTER);
    text("5", width/66.0, ((height/8.0)+(height/9.955903643445904)/2.0) -heightOffset);
    text("4", width/66.0, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) -heightOffset);
    text("3", width/66.0, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) -heightOffset);
    text("3", width/66.0, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
    text("2", width/66.0, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
    text("2", width/66.0, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);

    text("1", width/14.2, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) -heightOffset);
    text("2", width/14.2, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) -heightOffset);
    text("1", width/14.2, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
    text("1", width/14.2, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
    text("2", width/14.2, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);

    text("1", width/7.902, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
    text("1", width/7.902, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
    text("1", width/7.902, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);

    text("1", width/5.48, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);

    textSize(size/2.0);
    text("&", width/20.82, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) + heightOffset);
    text("&", width/20.82, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) + heightOffset);
    text("&", width/20.82, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) + heightOffset);
    text("&", width/20.82, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) + heightOffset) ;
    text("&", width/20.82, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) + heightOffset);

    text("&", width/9.68, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) + heightOffset);
    text("&", width/9.68, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) + heightOffset);
    text("&", width/9.68, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) + heightOffset);

    text("&", width/6.28, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) + heightOffset);


    textSize(size);

    textAlign(RIGHT, CENTER);
    text("/4", width/2.064, ((height/8.0)+(height/9.955903643445904)/2.0) -heightOffset);
    text("/60", width/2.064, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) -heightOffset);
    text("/120", width/2.064, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) -heightOffset);
    text("/240", width/2.064, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
    text("/240", width/2.064, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
    text("/360", width/2.064, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);


    //println(switchnum);

    switch(switchnum) {
    case 0:
      fill(yellow);
      rect(0, (height/8.0), width/2.0, height/9.955903643445904);
      fill(blue);
      textAlign(RIGHT, CENTER);
      text(metapatterncount[0], width/2.965, ((height/8.0)+(height/9.955903643445904)/2.0) -heightOffset);
      textAlign(LEFT, CENTER);
      text("5", width/66.0, ((height/8.0)+(height/9.955903643445904)/2.0) -heightOffset);
      textAlign(RIGHT, CENTER);
      text("/4", width/2.064, ((height/8.0)+(height/9.955903643445904)/2.0) -heightOffset);
      break;

    case 1:
      fill(yellow);
      rect(0, (height/8)+(height/9.955903643445904), width/2.0, height/9.955903643445904);
      fill(blue);
      textAlign(RIGHT, CENTER);
      text(metapatterncount[1], width/2.965, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) -heightOffset);
      textAlign(LEFT, CENTER);
      text("4", width/66.0, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) -heightOffset);
      text("1", width/14.2, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) -heightOffset);
      textSize(size/2.0);
      text("&", width/20.82, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) + heightOffset);
      textSize(size);
      textAlign(RIGHT, CENTER);
      text("/60", width/2.064, (height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) -heightOffset);
      break;
    case 2:
      fill(yellow);
      rect(0, (height/8)+((height/9.955903643445904)*2), width/2.0, height/9.955903643445904);
      fill(blue);
      textAlign(RIGHT, CENTER);
      text(metapatterncount[2], width/2.965, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) -heightOffset);
      textAlign(LEFT, CENTER);
      text("3", width/66.0, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) -heightOffset);
      text("2", width/14.2, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) -heightOffset);
      textSize(size/2.0);
      text("&", width/20.82, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) + heightOffset);
      textSize(size);
      textAlign(RIGHT, CENTER);
      text("/120", width/2.064, (height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) -heightOffset);
      break;
    case 3:
      fill(yellow);
      rect(0, (height/8)+((height/9.955903643445904)*3), width/2.0, height/9.955903643445904);
      textAlign(RIGHT, CENTER);
      fill(blue);
      text(metapatterncount[3], width/2.965, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
      textAlign(LEFT, CENTER);
      text("3", width/66.0, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
      text("1", width/14.2, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
      text("1", width/7.902, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
      textSize(size/2.0);
      text("&", width/20.82, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) + heightOffset);
      text("&", width/9.68, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) + heightOffset);
      textSize(size);
      textAlign(RIGHT, CENTER);
      text("/240", width/2.064, (height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
      break;
    case 4:
      fill(yellow);
      rect(0, (height/8)+((height/9.955903643445904)*4), width/2.0, height/9.955903643445904);
      fill(blue);
      textAlign(RIGHT, CENTER);
      text(metapatterncount[4], width/2.965, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
      textAlign(LEFT, CENTER);
      text("2", width/66.0, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
      text("1", width/14.2, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
      text("1", width/7.902, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
      text("1", width/5.48, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
      textSize(size/2.0);
      text("&", width/20.82, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) + heightOffset) ;
      text("&", width/9.68, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) + heightOffset);
      text("&", width/6.28, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) + heightOffset);
      textSize(size);
      textAlign(RIGHT, CENTER);
      text("/240", width/2.064, (height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
      break;
    case 5:
      fill(yellow);
      rect(0, (height/8)+((height/9.955903643445904)*5), width/2.0, height/9.955903643445904);
      fill(blue);
      textAlign(RIGHT, CENTER);
      text(metapatterncount[5], width/2.965, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);
      textAlign(LEFT, CENTER);
      text("2", width/66.0, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);
      text("2", width/14.2, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);
      text("1", width/7.902, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);
      textSize(size/2.0);
      text("&", width/20.82, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) + heightOffset);
      text("&", width/9.68, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) + heightOffset);
      textSize(size);
      textAlign(RIGHT, CENTER);
      text("/360", width/2.064, (height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);
      break;
    }




    fill(yellow);
    noFill();

    textAlign(CENTER, CENTER);

    rect(0, (height/8)+((height/9.955903643445904)*6), width/8.0, height/11.01556637222976);
    rect(width/8.0, (height/8)+((height/9.955903643445904)*6), width/8.0, height/11.01556637222976);
    rect(width/8.0*2, (height/8)+((height/9.955903643445904)*6), width/8.0, height/11.01556637222976);
    rect(width/8.0*3, (height/8)+((height/9.955903643445904)*6), width/8.0, height/11.01556637222976);

    text("A", (0 +width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("B", (width/8.0) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("C", (width/8.0*2) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("X", (width/8.0*3) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6)) +((height/11.01556637222976)/2.0)   -heightOffset);


    rect(0, (height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976), width/8.0, height/11.01556637222976);
    rect(width/8.0, (height/8)+((height/9.955903643445904)*6)+ (height/11.01556637222976), width/8.0, height/11.01556637222976);
    rect(width/8.0*2, (height/8)+((height/9.955903643445904)*6)+ (height/11.01556637222976), width/8.0, height/11.01556637222976);
    rect(width/8.0*3, (height/8)+((height/9.955903643445904)*6)+ (height/11.01556637222976), width/8.0, height/11.01556637222976);

    text("A", (0 +width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("B", (width/8.0) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("C", (width/8.0*2) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("X", (width/8.0*3) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976)) +((height/11.01556637222976)/2.0)   -heightOffset);


    rect(0, (height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2), width/8.0, height/11.01556637222976);
    rect(width/8.0, (height/8)+((height/9.955903643445904)*6)+ ((height/11.01556637222976)*2), width/8.0, height/11.01556637222976);
    rect(width/8.0*2, (height/8)+((height/9.955903643445904)*6)+ ((height/11.01556637222976)*2), width/8.0, height/11.01556637222976);
    rect(width/8.0*3, (height/8)+((height/9.955903643445904)*6)+ ((height/11.01556637222976)*2), width/8.0, height/11.01556637222976);

    text("A", (0 +width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("B", (width/8.0) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("C", (width/8.0*2) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2)) +((height/11.01556637222976)/2.0)   -heightOffset);
    text("X", (width/8.0*3) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2)) +((height/11.01556637222976)/2.0)   -heightOffset);


    if (group1.hasValue(1) ) {
      fill(yellow);
      rect(0, (height/8)+((height/9.955903643445904)*6), width/8.0, height/11.01556637222976);
      fill(blue);
      rect(0+boxOffset, (height/8)+((height/9.955903643445904)*6)+boxOffset, (width/8.0)-boxOffset*2, (height/11.01556637222976)-boxOffset*2);
      fill(yellow);
      text("A", (0 +width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6)) +((height/11.01556637222976)/2.0)   -heightOffset);
    }
    if (group1.hasValue(2) ) {
      fill(yellow);
      rect(width/8.0, (height/8)+((height/9.955903643445904)*6), width/8.0, height/11.01556637222976);
      fill(blue);
      rect(width/8.0 +boxOffset, (height/8)+((height/9.955903643445904)*6)+boxOffset, width/8.0-boxOffset*2, height/11.01556637222976-boxOffset*2);

      fill(yellow);
      text("B", (width/8.0) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6)) +((height/11.01556637222976)/2.0)   -heightOffset);
    }
    if (group1.hasValue(3) ) {
      fill(yellow);
      rect(width/8.0*2, (height/8)+((height/9.955903643445904)*6), width/8.0, height/11.01556637222976);

      fill(blue);
      rect(width/8.0*2+boxOffset, (height/8)+((height/9.955903643445904)*6)+boxOffset, width/8.0-boxOffset*2, height/11.01556637222976-boxOffset*2);

      fill(yellow);
      text("C", (width/8.0*2) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6)) +((height/11.01556637222976)/2.0)   -heightOffset);
    }
    if (group1.hasValue(0) ) {
      fill(yellow);
      rect(width/8.0*3, (height/8)+((height/9.955903643445904)*6), width/8.0, height/11.01556637222976);

      fill(blue);
      rect(width/8.0*3+boxOffset, (height/8)+((height/9.955903643445904)*6)+boxOffset, width/8.0-boxOffset*2, height/11.01556637222976-boxOffset*2);

      fill(yellow);
      text("X", (width/8.0*3) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6)) +((height/11.01556637222976)/2.0)   -heightOffset);
    }

    if (group2.hasValue(1) ) {
      fill(yellow);
      rect(0, (height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976), width/8.0, height/11.01556637222976);
      fill(blue);
      text("A", (0 +width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976)) +((height/11.01556637222976)/2.0)   -heightOffset);
    }
    if (group2.hasValue(2) ) {
      fill(yellow);
      rect(width/8.0, (height/8)+((height/9.955903643445904)*6)+ (height/11.01556637222976), width/8.0, height/11.01556637222976);
      fill(blue);
      text("B", (width/8.0) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976)) +((height/11.01556637222976)/2.0)   -heightOffset);
    }
    if (group2.hasValue(3) ) {
      fill(yellow);
      rect(width/8.0*2, (height/8)+((height/9.955903643445904)*6)+ (height/11.01556637222976), width/8.0, height/11.01556637222976);
      fill(blue);
      text("C", (width/8.0*2) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976)) +((height/11.01556637222976)/2.0)   -heightOffset);
    }
    if (group2.hasValue(0) ) {
      fill(yellow);
      rect(width/8.0*3, (height/8)+((height/9.955903643445904)*6)+ (height/11.01556637222976), width/8.0, height/11.01556637222976);
      fill(blue);
      text("X", (width/8.0*3) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + (height/11.01556637222976)) +((height/11.01556637222976)/2.0)   -heightOffset);
    }

    if (group3.hasValue(1) ) {
      fill(yellow);
      rect(0, (height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2), width/8.0, height/11.01556637222976);
      fill(blue);
      rect(0+boxOffset, (height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2)+boxOffset, width/8.0-boxOffset*2, height/11.01556637222976-boxOffset*2);
      fill(yellow);
      text("A", (0 +width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2)) +((height/11.01556637222976)/2.0)   -heightOffset);
    }
    if (group3.hasValue(2) ) {
      fill(yellow);
      rect(width/8.0, (height/8)+((height/9.955903643445904)*6)+ ((height/11.01556637222976)*2), width/8.0, height/11.01556637222976);
      fill(blue);
      rect(width/8.0+boxOffset, (height/8)+((height/9.955903643445904)*6)+ ((height/11.01556637222976)*2)+boxOffset, width/8.0-boxOffset*2, height/11.01556637222976-boxOffset*2);

      fill(yellow);
      text("B", (width/8.0) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2)) +((height/11.01556637222976)/2.0)   -heightOffset);
    }
    if (group3.hasValue(3) ) {
      fill(yellow);
      rect(width/8.0*2, (height/8)+((height/9.955903643445904)*6)+ ((height/11.01556637222976)*2), width/8.0, height/11.01556637222976);
      fill(blue);
      rect(width/8.0*2+boxOffset, (height/8)+((height/9.955903643445904)*6)+ ((height/11.01556637222976)*2)+boxOffset, width/8.0-boxOffset*2, height/11.01556637222976-boxOffset*2);

      fill(yellow);
      text("C", (width/8.0*2) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2)) +((height/11.01556637222976)/2.0)   -heightOffset);
    }
    if (group3.hasValue(0) ) {
      fill(yellow);
      rect(width/8.0*3, (height/8)+((height/9.955903643445904)*6)+ ((height/11.01556637222976)*2), width/8.0, height/11.01556637222976);
      fill(blue);
      rect(width/8.0*3+boxOffset, (height/8)+((height/9.955903643445904)*6)+ ((height/11.01556637222976)*2)+boxOffset, width/8.0-boxOffset*2, height/11.01556637222976-boxOffset*2);
      fill(yellow);
      text("X", (width/8.0*3) +(width/8.0)/2.0, ((height/8)+((height/9.955903643445904)*6) + ((height/11.01556637222976)*2)) +((height/11.01556637222976)/2.0)   -heightOffset);
    }



    noStroke();
    fill(yellow);
    rect((width/2.0), 0, (width/2.0)/2.0, height/8.0);
    fill(blue);
    text(listtostring(1), (width/2.0)+(((width/2.0)/2.0)/2.0), ((height/8.0)/2.0) -heightOffset);
    fill(yellow);
    noFill();

    textSize(size*0.92);
    rect((width/2.0) +(width/2.0)/2.0, 0, (width/2.0)/2.0, height/8.0);

    rect((width/2.0), height/8.0, (width/2.0)/2.0, height/8.0);
    rect((width/2.0) +(width/2.0)/2.0, height/8.0, (width/2.0)/2.0, height/8.0);
    rect((width/2.0), (height/8.0)*2, (width/2.0)/2.0, height/8.0);
    rect((width/2.0) +(width/2.0)/2.0, (height/8.0)*2, (width/2.0)/2.0, height/8.0);
    rect((width/2.0), (height/8.0)*3, (width/2.0)/2.0, height/8.0);
    rect((width/2.0) +(width/2.0)/2.0, (height/8.0)*3, (width/2.0)/2.0, height/8.0);
    rect((width/2.0), (height/8.0)*4, (width/2.0)/2.0, height/8.0);
    rect((width/2.0) +(width/2.0)/2.0, (height/8.0)*4, (width/2.0)/2.0, height/8.0);
    rect((width/2.0), (height/8.0)*5, (width/2.0)/2.0, height/8.0);
    rect((width/2.0) +(width/2.0)/2.0, (height/8.0)*5, (width/2.0)/2.0, height/8.0);
    rect((width/2.0), (height/8.0)*6, (width/2.0)/2.0, height/8.0);
    rect((width/2.0) +(width/2.0)/2.0, (height/8.0)*6, (width/2.0)/2.0, height/8.0);
    rect((width/2.0), (height/8.0)*7, (width/2.0)/2.0, height/8.0);

    text(listtostring(2), ((width/2.0) +(width/2.0)/2.0)+(((width/2.0)/2.0)/2.0), ((height/8.0)/2.0) -heightOffset2);
    text(listtostring(3), (width/2.0)+(((width/2.0)/2.0)/2.0), (height/8.0)+((height/8.0)/2.0) -heightOffset2);
    text(listtostring(4), ((width/2.0) +(width/2.0)/2.0)+(((width/2.0)/2.0)/2.0), (height/8.0)+((height/8.0)/2.0) -heightOffset2);
    text(listtostring(5), (width/2.0)+(((width/2.0)/2.0)/2.0), (height/8.0)*2+((height/8.0)/2.0) -heightOffset2);
    text(listtostring(6), ((width/2.0) +(width/2.0)/2.0)+(((width/2.0)/2.0)/2.0), (height/8.0)*2+((height/8.0)/2.0) -heightOffset2);
    text(listtostring(7), (width/2.0)+(((width/2.0)/2.0)/2.0), (height/8.0)*3+((height/8.0)/2.0) -heightOffset2);
    text(listtostring(8), ((width/2.0) +(width/2.0)/2.0)+(((width/2.0)/2.0)/2.0), (height/8.0)*3+((height/8.0)/2.0) -heightOffset2);
    text(listtostring(9), (width/2.0)+(((width/2.0)/2.0)/2.0), (height/8.0)*4+((height/8.0)/2.0) -heightOffset2);
    text(listtostring(10), ((width/2.0) +(width/2.0)/2.0)+(((width/2.0)/2.0)/2.0), (height/8.0)*4+((height/8.0)/2.0) -heightOffset2);
    text(listtostring(11), (width/2.0)+(((width/2.0)/2.0)/2.0), (height/8.0)*5+((height/8.0)/2.0) -heightOffset2);
    text(listtostring(12), ((width/2.0) +(width/2.0)/2.0)+(((width/2.0)/2.0)/2.0), (height/8.0)*5+((height/8.0)/2.0) -heightOffset2);
    text(listtostring(13), (width/2.0)+(((width/2.0)/2.0)/2.0), (height/8.0)*6+((height/8.0)/2.0) -heightOffset2);
    text(listtostring(14), ((width/2.0) +(width/2.0)/2.0)+(((width/2.0)/2.0)/2.0), (height/8.0)*6+((height/8.0)/2.0) -heightOffset2);
    text(listtostring(15), (width/2.0)+(((width/2.0)/2.0)/2.0), (height/8.0)*7+((height/8.0)/2.0) -heightOffset2);


    textSize(size);
    fill(yellow);
    textAlign(RIGHT, CENTER);

    rect((width/2.0) +(width/2.0)/2.0, (height/8.0)*7, (width/2.0)/2.0, height/8.0);
    fill(blue);
    text(count+"/1024", width - width/33.2, height-(((height/14.2))));
  };
}
