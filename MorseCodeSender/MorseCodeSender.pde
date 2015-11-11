
int [][] morseTable = 
{
  {0,1,-1,-1,-1,-1},   // a
  {1,0,0,0,-1,-1},     // b
  {1,0,1,0,-1,-1},    // c
  {0,-1,-1,-1,-1,-1},  // e
  {0,0,1,0,-1,-1},    // f
  {1,1,0,-1,-1,-1},    // g
};

int i = 0;
int signal = 4; // what we send

int signalspace = 200;
int shortsignal = 200;
int longsignal = 800;
int cmdspace = 3000;

int l = 0;
int c = 0;

void setup()
{
  frameRate(999);
  size(600,400);
}

void draw() // its a loop!
{
  delay(l);
  if (++i==6*2) i=0;
  int s = i/2;
  int v = morseTable[signal][s];
  if ( s*2 == i)
  {
    l = signalspace;
    c = 0;
  } else if (v!=-1) {
    l = v==1?longsignal:shortsignal;
    c = 255;
  } else {
    l = cmdspace;
    c = 0;
    i = 0;
    println( "new command" );
  }
  background(c);
}
