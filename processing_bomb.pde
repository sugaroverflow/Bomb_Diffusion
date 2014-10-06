import processing.serial.*;
import ddf.minim.*;
import java.util.*;



Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port
Minim minim;
AudioPlayer file;
AudioPlayer boom;
AudioPlayer defuse;
AudioPlayer win;
AudioPlayer tick;
AudioPlayer cure;

int def = 0;
int bom = 0;

void setup() 
{
  size(700, 700);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  
  minim = new Minim(this);
  file = minim.loadFile("in.mp3");
  file.play();
  file.rewind();
  
  boom = minim.loadFile("boom2.wav");
  defuse = minim.loadFile("defuse.mp3");
  win = minim.loadFile("win.mp3");
  cure = minim.loadFile("cure.mp3");
  tick = minim.loadFile("tick.mp3");
  tick.loop();

}

void draw() {
  
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();         // read it and store it in val
  }
  
  int p = randInt(0,10);
  //when defused is done playing
  //if the bomb was defused- plant it again
  if (!defuse.isPlaying()) {
    if (def == 1) {
       print("The bomb has been planted");
       file.play();
       file.rewind();
       tick.loop();
       image(ready, 0, 0);
       ready.play();
    }
    def = 0;
  }
  
  //boom is done playing
  //if the bomb did explode - the terrorists win
  if (!boom.isPlaying()) {
    if (bom == 1) {
       win.play();
       print("the terrorists win");
       text("The terrorists win", 100, 100);
       fill(255);
       win.rewind();
       tick.loop();
    }
    bom = 0;
  }
  //red crap and not defused
  if (val == 1 && def == 0) {
    fill(0);
    //bomb explodes
    if (p > 7) {
      tick.pause();
      bom = 1;
      boom.play();
      boom.rewind();
    }
    //bomb got defused
    else if (bom == 0) {
      tick.pause();
      def = 1;
      defuse.play();
      defuse.rewind();
    }
  } 
  //green crap and not defused
  else if (val == 2 && def == 0) {
    fill(100);
    //bomb explodes
    if (p > 7) {
      tick.pause();
      bom = 1;
      boom.play();
      boom.rewind();
    }
    //&got defused
    else if (bom == 0) {
      tick.pause();
      def = 1;
      defuse.play();
      defuse.rewind();
    }
  }
  
  else if (val == 3){
    //this is the cure!
    tick.pause();
    cure.play();
    cure.rewind();
  }
  
  else {
  rect(0, 0, 700, 700);
  }
}

public static int randInt(int min, int max) {

    Random rand = new Random();
    int randomNum = rand.nextInt((max - min) + 1) + min;
    return randomNum;
}
