public float fittedText(String text, PFont font, float fitX)
{
  textFont(font);
  return font.getSize()*fitX/textWidth(text);
}

public void numfunc(IntList x) {

  group2.clear();
  // println(newpermutation);
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

void OscRoute(String input) {
  String inputTest = input.substring(0, 1);
  input = input.substring(1, input.length());
  if (inputTest.equals("0")==true) {
    permutationchange(input);
  };

  if (inputTest.equals("1")==true) {
    metapatterncount(input);
  };
}







public void permutationchangeWrite( int a, int b, int c, int d, int e ) {
  SchNum++;
  OscSchedule[SchNum] = str(0) + str(a) + str(b) + str(c) + str(d) + str(e);
  println(str(a) + str(b) + str(c) + str(d) + str(e));
};


void metapatterncountWrite(int a) {
  println(a);
  SchNum++;
  OscSchedule[SchNum]=str(1) + str(a);
};



void metapatterncount(String input) {
  int x = Integer.parseInt(input);
  metapatterncount[x] = metapatterncount[x] + 1;
  //textAlign(CENTER, CENTER);
  switchnum = x;



  //text(metapatterncount[0],width/2.965 ,((height/8.0)+(height/9.955903643445904)/2.0) -heightOffset);
  //     text(metapatterncount[1], width/2.965,(height/8)+((height/9.955903643445904))+((height/9.955903643445904)/2.0) -heightOffset);
  //        text(metapatterncount[2],width/2.965  ,(height/8)+((height/9.955903643445904)*2)+((height/9.955903643445904)/2.0) -heightOffset);
  //        text(metapatterncount[3], width/2.965 ,(height/8)+((height/9.955903643445904)*3)+((height/9.955903643445904)/2.0) -heightOffset);
  //             text(metapatterncount[4],width/2.965 ,(height/8)+((height/9.955903643445904)*4)+((height/9.955903643445904)/2.0) -heightOffset);
  //                  text(metapatterncount[5],width/2.965 ,(height/8)+((height/9.955903643445904)*5)+((height/9.955903643445904)/2.0) -heightOffset);
  //
  count = count + 1;
  if (count == 1024) {
    count_bool = true;
    oldpermutation= new IntList();
    metapatterncount = new int[] {0, 0, 0, 0, 0, 0};
    group1 = new IntList(0, 1, 2, 3);
    group2 = new IntList();
    group3= new IntList();
    count = 0;
    //println(userpermutation.toString());
    delay(2000);
  };
};


void permutationchange(String input) {
  newpermutation.set(0, Integer.parseInt(input.substring(0, 1)));
  newpermutation.set(1, Integer.parseInt(input.substring(1, 2)));
  newpermutation.set(2, Integer.parseInt(input.substring(2, 3)));
  newpermutation.set(3, Integer.parseInt(input.substring(3, 4)));
  newpermutation.set(4, Integer.parseInt(input.substring(4, 5)));
  if (plist.length() == 280) {
    plist = plist.substring(140, 280);
  }
  plist =  str(newpermutation.get(0)) + str(newpermutation.get(1)) + str(newpermutation.get(2)) + str(newpermutation.get(3)) + str(newpermutation.get(4)) + plist;
  //set(width/2 - (int(textWidth("[ 3, 1, 0, 1, 0 ]"))/2),height/80,pg2);
  //println(newpermutation);
  numfunc(newpermutation);
};


public String listtostring(int number) {

  if (plist.length() / 5 >= number) {
    int start = (number - 1) * 5;
    String numbers = "[" + plist.charAt(start) +", "+ plist.charAt(start+1) +", "+ plist.charAt(start+2) +", "+ plist.charAt(start+3)+", "+ plist.charAt(start+4) +"]" ;
    numbers = numbers.replace('0', 'X');
    numbers = numbers.replace('1', 'A');
    numbers = numbers.replace('2', 'B');
    numbers =  numbers.replace('3', 'C');
    return numbers;
    //return "[ " + plist.charAt(start) +", "+ plist.charAt(start+1) +", "+ plist.charAt(start+2) +", "+ plist.charAt(start+3)+", "+ plist.charAt(start+4) +" ]" ;
  } else {
    return "";
  }
};
