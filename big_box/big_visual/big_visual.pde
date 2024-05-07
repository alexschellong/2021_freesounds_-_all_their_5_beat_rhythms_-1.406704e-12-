import netP5.*;
import oscP5.*;
import java.util.*;
import processing.io.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int GPIOpinButton0 = 17;
int GPIOpinButton1 = 23;
int GPIOpinButton2 = 24;
int GPIOpinButton3 = 26;

String[] num1 = {"5", "41", "32", "311", "2111", "221"};
int[] num2 = {0, 0, 0, 0, 0, 0};
int[] num3 = {1, 2, 3, 0, 2};



boolean dotintext = false;
boolean left = false;

public int randstroke(int H) {
  int[] randomlist = {-2, 2};
  H = H + randomlist[int(random(0, 1))];

  if (H > 360) {
    H = 0;
  };
  if (H < 0) {
    H = 360;
  };

  return H;
};


public String listtostring( IntList listosc) {

  String numbers =  "[ " + listosc.get(0) +", "+ listosc.get(1)  +", "+ listosc.get(2) +", "+ listosc.get(3)+", "+ listosc.get(4) +" ]" ;
  numbers = numbers.replace('0', 'X');
  numbers = numbers.replace('1', 'A');
  numbers = numbers.replace('2', 'B');
  numbers =  numbers.replace('3', 'C');
  return numbers;
  //return "[ " + listosc.get(0) +", "+ listosc.get(1)  +", "+ listosc.get(2) +", "+ listosc.get(3)+", "+ listosc.get(4) +" ]" ;
};



public String listtostring2( int[] listosc) {

  String b =  listosc[0] +"\n"+ listosc[1]  +"\n"+ listosc[2] +"\n"+ listosc[3]+"\n"+ listosc[4]+"\n"+ listosc[5];
  return b;
};

public String intlisttostring2( IntList array) {
  String x = "";
  for (int i = 0; i < array.size(); i++) {
    x = x + array.get(i);
  }
  return x;
}

public String intlisttostring( IntList array) {
  String x = "";
  if (array.size() == 1) {
    x =  x + new String(new char[array.get(0)]).replace("\0", "     ") + array.get(0) +new String(new char[3- array.get(0)]).replace("\0", "     ") ;
  } else {
    for (int i = 0; i < array.size(); i++) {
      if (i == 0) {
        x =x + new String(new char[array.get(i)]).replace("\0", "     ") + array.get(i) + "    " +new String(new char[((array.get(i+1)+1)-(array.get(i)+1))-1]).replace("\0", "     ");
      } else if (array.size()- 1== i) {
        x = x+ array.get(i) +new String(new char[3- array.get(i)]).replace("\0", "     ") ;
      } else {
        x = x+ array.get(i) +"    "+ new String(new char[((array.get(i+1)+1)-(array.get(i)+1))-1]).replace("\0", "     ");
      }
    };
  }
  x = x.replace('0', 'X');
  x = x.replace('1', 'A');
  x = x.replace('2', 'B');
  x=  x.replace('3', 'C');
  return x;
};

int count = 0;

public IntList group1 = new IntList(0, 1, 2, 3);
public IntList group2 = new IntList();
public IntList group3= new IntList();

boolean valueIsInArray(int v, int[] arr) {
  for (int i = 0; i < arr.length; i++) {
    if (v == arr[i]) {
      return true;
    }
  }
  return false;
}


public void numfunc(IntList x) {

  group2.clear();

  for (int u = 0; u < newpermutation.size(); u++) {
    if (group2.hasValue(newpermutation.get(u)) == false) {
      group2.append(newpermutation.get(u));
    };
  };
  group2.sort();


  if (oldpermutation.size() != 0) {
    for (int u = 0; u < 4; u++) {
      if (group3.hasValue(oldpermutation.get(u)) == false) {
        group3.append(oldpermutation.get(u));
      };
    };
  }

  group3.sort();



  if (group3.size() == 4) {
    group3.clear();
    group1 = new IntList(0, 1, 2, 3);
  };

  int size = group1.size();

  for (int u = 0; u < size; u++) {
    if (newpermutation.hasValue(group1.get(abs(u - (size - 1)))) == true) {
      group1.remove(abs(u - (size - 1)));
    };
  };


  int[] one = x.array();
  oldpermutation = new IntList(one);
};

//for adding  &&& in smaller font
public void textfunc(String[] text, float xi, float yi, float leading, float textsize  ) {
  textSize(textsize);

  textAlign(CENTER);
  textLeading(leading);
  for (int i = 0; i < text.length; i++) {
    if (i == 0) {
      text(text[i], xi, yi);
    } else {
      float m;
      String s =  "";
      if (text[i].length() > 1) {
        for (int j = 0; j < text[i].length(); j++) {

          text(new String(new char[i]).replace("\0", "\n") + text[i].charAt(j), xi + textWidth(s), yi);
          s = s + text[i].charAt(j);

          if (j < text[i].length() - 1) {
            m =  textWidth(s);
            textSize(textsize/2);
            textAlign(CENTER);
            textLeading(leading);
            text(new String(new char[i]).replace("\0", "\n") + "&", xi + m, yi);
            textSize(textsize);
            textAlign(CENTER);
            textLeading(leading);
            s = s + "&";
          };
        }
        //text(new String(new char[i]).replace("\0", "\n") + s, xi, yi);
      }
    }
  };
};
// Size of each cell in the grid, ratio of window size to video size
// 80 * 8 = 640
// 60 * 8 = 480

public float fittedText(String text, PFont font, float fitX)
{
  textFont(font);
  return font.getSize()*fitX/textWidth(text);
}


//public StringBuilder userpermutation = new StringBuilder("[ 0, 0, 1, 2, 0 ]");
public StringBuilder userpermutation = new StringBuilder("[ A, B, C, X, X]");

float size;

//PImage img;

PFont fontbig;
PFont fontsmall;

// Number of columns and rows in our system
float cols, rows;
float heightScale, widthScale, heightScale2;

String OscSchedule[] = new String[2000];

int SchNum = -1;

public void permutationchangeWrite( int a, int b, int c, int d, int e ) {
  SchNum++;
  OscSchedule[SchNum] = str(0) + str(a) + str(b) + str(c) + str(d) + str(e);
};


void metapatterncountWrite(int a) {
  SchNum++;
  OscSchedule[SchNum]=str(1) + str(a);
};

void locWrite(int a) {
  SchNum++;
  OscSchedule[SchNum] = str(2) + str(a);
};

void permutationchange(String input) {
  newpermutation.set(0, Integer.parseInt(input.substring(0, 1)));
  newpermutation.set(1, Integer.parseInt(input.substring(1, 2)));
  newpermutation.set(2, Integer.parseInt(input.substring(2, 3)));
  newpermutation.set(3, Integer.parseInt(input.substring(3, 4)));
  newpermutation.set(4, Integer.parseInt(input.substring(4, 5)));
  //set(width/2 - (int(textWidth("[ 3, 1, 0, 1, 0 ]"))/2),height/80,pg2);
  //   println(newpermutation);
  numfunc(newpermutation);
};


void local(String input) {
  int s = Integer.parseInt(input);
  receivedValues.append(s);
  if (receivedValues.size() == 1) {
    textSize(size);
    if ((receivedValues.get(0)*heightScale2 > (height/2.0 - (textWidth(userpermutation.toString())/2.0))-height/32.0)
      && (receivedValues.get(0)*heightScale2 <(height/2.0 + (textWidth(userpermutation.toString())/2.0))-height/32.0)) {
      dotintext = true;
      if (receivedValues.get(0)*heightScale2 < height/2.0 ) {
        left = true;
      }
    };
  };
};


void metapatterncount(String input) {
  int x = Integer.parseInt(input);
  metapatterncount[x] = metapatterncount[x] + 1;
  textAlign(CENTER, CENTER);
  textLeading(size * 1.95);
  fill(0);
  text( listtostring2(metapatterncount), ((width-((width /2.0)+ height/34.0) /2.0) + width/30.0 ), height/2);
  count = count + 1;
  if (count == 1024) {
    metapatterncount = new int[] {0, 0, 0, 0, 0, 0};
    group1 = new IntList(0, 1, 2, 3);
    group2 = new IntList();
    group3= new IntList();
    count = 0;
    left = false;
    dotintext = false;
    //  println(userpermutation.toString());
    delay(2000);
  };
};


void OscRoute(String input) {
  String inputTest = input.substring(0, 1);
  input = input.substring(1, input.length());
  if (inputTest.equals("0")==true) {
    permutationchange(input);
  };

  if (inputTest.equals("1")==true) {
    metapatterncount(input);
  };

  if (inputTest.equals("2")==true) {
    local(input);
  };
}
public IntList receivedValues = new IntList();



boolean timer = false;

float timer_count = 0;
boolean delayBool = false;





void setup() {

  //pins
  GPIO.pinMode(GPIOpinButton0, GPIO.INPUT_PULLUP);
  GPIO.pinMode(GPIOpinButton1, GPIO.INPUT_PULLUP);
  GPIO.pinMode(GPIOpinButton2, GPIO.INPUT_PULLUP);
  GPIO.pinMode(GPIOpinButton3, GPIO.INPUT_PULLUP);


  //osc stuff
  oscP5 = new OscP5(this, 1510);
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);

  oscP5.plug(this, "locWrite", "/loc");
  oscP5.plug(this, "permutationchangeWrite", "/permutationchange");
  oscP5.plug(this, "metapatterncountWrite", "/metapatterncount");


  //////////////////

  // background(255,255,255);
  frameRate(60);

  //size(800,480);
  fullScreen();

  fontsmall = createFont("myriad.ttf"
    , 30, true);
  fontbig = createFont("myriad.ttf"
    , 60, true);

  //  img = loadImage("interface (2020_09_05 19_53_31 UTC).jpg");

  //Initialize columns and rows
  heightScale2 = height/1024.0;
  heightScale = (height - (height/32.0)*2.0)/1024.0;
  widthScale = (width - (height/32.0)*2.0)/1024.0;
  cols = (width - (height/32.0)*2.0)/widthScale;
  rows = (height - (height/32.0)*2.0)/heightScale;

  //imageMode(CORNER);
  //image(img, 0, 0, width, height);
  fill(0);
  size = fittedText("[ 1, 2, 3, 0, 2 ]", fontbig, width/6.25);







  textSize(size);
  // pg1=get(height/80,height/2 - (int(textWidth("[ 3, 1, 0, 1, 0 ]"))/2),50,int(textWidth("[ 3, 1, 0, 1, 0 ]")));
  //pg2=get(width/2 - (int(textWidth("[ 3, 1, 0, 1, 0 ]"))/2), height/80,int(textWidth("[ 3, 1, 0, 1, 0 ]")),50);

  //text




  colorMode(HSB, 360, 100, 100);
}


int r1 = int(random(0, 255));
int g1 =100;
int b1 = 100;

//copy under changeable text
//public PImage pg1;
//public PImage pg2;

public IntList newpermutation= new IntList(3, 1, 0, 1, 0 );
public IntList oldpermutation= new IntList();
public int[] metapatterncount = {0, 0, 0, 0, 0, 0};
//osc

public  OscMessage firstpermutation = new OscMessage("/firstpermutation");
public  OscMessage reset = new OscMessage("/reset");

int iter = 2;

void draw() {

  if (delayBool == true) {

    delay(5000);
    delayBool = false;
    // println("waiting");
  }

  for (int i=0; i<=SchNum; i++) {
    OscRoute(OscSchedule[i]);
  }
  SchNum=-1;


  if (timer == true) {
    timer_count = timer_count + 1.0/frameRate;
  };

  if (timer_count > 10.0) {
    timer = false;
    timer_count = 0;
    metapatterncount = new int[] {0, 0, 0, 0, 0, 0};
    group1 = new IntList(0, 1, 2, 3);
    group2 = new IntList();
    group3= new IntList();
    count = 0;
    left = false;
    dotintext = false;
    //println(userpermutation.toString());

    background(0);
    noFill();
    stroke(r1, g1, b1);
    strokeWeight(1.5);
    strokeJoin(ROUND);
    rect(height/34.0, height/34.0, width - (height/34.0)*2, height - (height/34.0)*2);


    textAlign(LEFT, TOP);
    textSize(size/2);
    text("0", width/164.0, height/30.0);
    text("[X,X,X,X,X]", width/50.6, height - (height/35.5));
    //text("[3,3,3,3,3]",(width/50.6), height - (height/55));
    textAlign(RIGHT, BOTTOM);
    text("[C,C,C,C,C]", width - (width/50.6), height/35.5);
    pushMatrix();
    translate(width - width/400.0, height  - height/27.5);
    textAlign(RIGHT, TOP);
    rotate(radians(90));
    text("1024", 0, 0);
    popMatrix();
    textSize(size);
    textAlign(CENTER, CENTER);
    pushMatrix();
    translate(height/36.2, height/2.0);
    rotate(radians(-90));
    text(userpermutation.toString(), 0, 0 );
    popMatrix();



    reset = new OscMessage("/reset");

    reset.add(true);

    oscP5.send(reset, myRemoteLocation);
    delayBool = true;
  } else {


    while (count == 0) {
      OscSchedule = new String[2000];
      receivedValues = new IntList();
      // println("here");
      firstpermutation = new OscMessage("/firstpermutation");
      //  println(userpermutation.toString());
      String x = userpermutation.toString();
      x = x.replace('X', '0');
      x = x.replace('A', '1');
      x = x.replace('B', '2');
      x=  x.replace('C', '3');
      IntList i = new IntList(Integer.parseInt(x.substring(2, 3)), Integer.parseInt(x.substring(5, 6)), Integer.parseInt(x.substring(8, 9)), Integer.parseInt(x.substring(11, 12)), Integer.parseInt(x.substring(14, 15)));
      firstpermutation.add(i.array());
      oscP5.send(firstpermutation, myRemoteLocation);
      numfunc(i);
      count = count + 1;
    };

    background(0);

    //pins
    if (GPIO.digitalRead(GPIOpinButton0) == GPIO.LOW) {
      timer = true;
      if (iter > 14) {
        iter = 2;
      };
      userpermutation.setCharAt(iter, char(65));
      iter = iter+ 3;
      //  background(0);
      //    textSize(size);
      //textAlign(CENTER, CENTER);
      //pushMatrix();
      //translate(height/36.2, height/2.0);
      //rotate(radians(-90));
      // text(userpermutation.toString(), 0, 0 );
      //popMatrix();
      while (GPIO.digitalRead(GPIOpinButton0) == GPIO.LOW) {
      };
    };
    if (GPIO.digitalRead(GPIOpinButton1) == GPIO.LOW) {
      timer = true;
      if (iter > 14) {
        iter = 2;
      };
      userpermutation.setCharAt(iter, char(66));
      iter = iter+ 3;
      //  background(0);
      //    textSize(size);
      //textAlign(CENTER, CENTER);
      //pushMatrix();
      //translate(height/36.2, height/2.0);
      //rotate(radians(-90));
      // text(userpermutation.toString(), 0, 0 );
      //popMatrix();
      while (GPIO.digitalRead(GPIOpinButton1) == GPIO.LOW) {
      };
    };
    if (GPIO.digitalRead(GPIOpinButton2) == GPIO.LOW) {
      timer = true;
      if (iter > 14) {
        iter = 2;
      };
      userpermutation.setCharAt(iter, char(67));
      iter = iter+ 3;
      //  background(0);
      //    textSize(size);
      //textAlign(CENTER, CENTER);
      //pushMatrix();
      //translate(height/36.2, height/2.0);
      //rotate(radians(-90));
      // text(userpermutation.toString(), 0, 0 );
      //popMatrix();
      while (GPIO.digitalRead(GPIOpinButton2) == GPIO.LOW) {
      };
    };
    if (GPIO.digitalRead(GPIOpinButton3) == GPIO.LOW) {
      timer = true;
      if (iter > 14) {
        iter = 2;
      };
      userpermutation.setCharAt(iter, char(88));
      iter = iter+ 3;
      //  background(0);
      //    textSize(size);
      //textAlign(CENTER, CENTER);
      //pushMatrix();
      //translate(height/36.2, height/2.0);
      //rotate(radians(-90));
      // text(userpermutation.toString(), 0, 0 );
      //popMatrix();
      while (GPIO.digitalRead(GPIOpinButton3) == GPIO.LOW) {
      };
    };

    if (receivedValues.size() > 1) {
      strokeWeight(1.5);
      noFill();
      pushMatrix();
      translate(0, height/32.0);
      stroke(r1, g1, b1);
      beginShape();
      vertex(0, (1024 - receivedValues.get(0))*heightScale);
      vertex(height/34.0, (1024 - receivedValues.get(0))*heightScale);
      vertex(height/50.0, (1024 - receivedValues.get(0))*heightScale + height/120.0);
      vertex(height/34.0, (1024 - receivedValues.get(0))*heightScale);
      vertex(height/50.0, (1024 - receivedValues.get(0))*heightScale - height/120.0);
      endShape();
      popMatrix();
    };

    noFill();
    stroke(r1, g1, b1);
    strokeWeight(1.5);
    strokeJoin(ROUND);
    rect(height/34.0, height/34.0, width - (height/34.0)*2, height - (height/34.0)*2);

    fill(r1, g1, b1);
    noStroke();
    pushMatrix();
    translate(height/32.0, height/32.0);
    if (receivedValues.size() < 2) {
      //println(receivedValues)
      ;
    };
    //dont know how to append array to array of arrays or append two numbers to a array
    for (int i = 0; i < receivedValues.size(); i++) {
      float x = i*widthScale;
      float y = (1024 - receivedValues.get(i))*heightScale;

      rect(x, y, widthScale + 1, heightScale + 1);
    };
    popMatrix();
    fill(255);
    textSize(size);
    textAlign(CENTER, CENTER);
    if (dotintext == false) {
      textSize(size);
      pushMatrix();
      translate(height/36.2, height/2.0);
      rotate(radians(-90));
      text(userpermutation.toString(), 0, 0 );
      popMatrix();
    } else {
      if (left == true) {
        pushMatrix();
        translate(height/36.2, height/34.0 + (receivedValues.get(0)*heightScale2 - (textWidth(userpermutation.toString()))/1.5));
        rotate(radians(-90));
        text(userpermutation.toString(), 0, 0);
        popMatrix();
      } else {
        pushMatrix();
        translate(height/36.2, height/34.0 + (receivedValues.get(0)*heightScale2   + (textWidth(userpermutation.toString()))/1.5));
        rotate(radians(-90));
        text(userpermutation.toString(), 0, 0 );
        popMatrix();
      }
    }



    //&&&&&
    textfunc(num1, (width-((width /2)+ height/34.0) /2.0) - width/5.88, (height/2.0 ) - (height/4.08), size*1.958, size);
    textAlign(RIGHT, CENTER);
    textLeading(size*1.95);
    text("4\n60\n120\n240\n240\n360", (width-((width /2.0)+ height/34.0) /2.0) + width/5.88, height/2.0);

    textAlign(CENTER, CENTER);
    textLeading(size * 1.95);
    text(listtostring2(metapatterncount), ((width-((width /2.0)+ height/34.0) /2.0) + width/30.0 ), height/2.0);

    textAlign(CENTER, CENTER);
    text(listtostring(newpermutation), width/2.0, height/36.2);

    //showing not used/being used/ used numbers

    textAlign(CENTER, CENTER);
    text(intlisttostring(group1), (((width /2.0)+ height/34.0) /2.0), (height/2.0 )- (height/3.76));
    text(intlisttostring(group2), ((width /2.0)+ height/34.0) /2.0, height/2.0);
    text(intlisttostring(group3), ((width /2.0)+ height/34.0) /2.0, (height/2.0) + (height/3.76));   //showing not used/being used/ used nu

    //text sides
    textAlign(LEFT, TOP);
    textSize(size/2);
    text("0", width/164.0, height/30.0);
    text("[X,X,X,X,X]", width/50.6, height - (height/35.5));
    //text("[3,3,3,3,3]",(width/50.6), height - (height/55));
    textAlign(RIGHT, BOTTOM);
    text("[C,C,C,C,C]", width - (width/50.6), height/35.5);
    pushMatrix();
    translate(width - width/400.0, height  - height/27.5);
    textAlign(RIGHT, TOP);
    rotate(radians(90));
    text("1024", 0, 0);
    popMatrix();





    //chart color

    r1 = randstroke(r1);
  }
  //println(randstrokechart);
}
