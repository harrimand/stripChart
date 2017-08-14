/*
Demonstrate usage of Graph class
Author:  Darrell Harriman
Contact:  harrimand@gmail.com
*/
Graph Gr1;  //Create Graph Object
boolean pause = false;
boolean plotLine = false;
boolean gridLines = false;
boolean source = false;
boolean Axis = false;
int degAngle = 0;  //For test data

void setup()
{
  size(800, 600);  // Window size (width, height)
  background(0);  //  Window background color
  Gr1 = new Graph(100, 200, 600, 304); //Initialize new Graph (x, y, width, height)
  Gr1.label("Graph Data");  // Graph Label Text below graph
  Gr1.bufferSize(360);  // Graph Data buffer (int size
  Gr1.yRange(0, 1023);  // Graph data values (int Minimum, int Maximum)
  Gr1.xAxis(Axis);  //  Show X Axis (boolean)
  Gr1.grid(10, 12);  // Grid Lines (int Divisions_Wide, int Divisions_high)
  Gr1.connectPoints(plotLine);  // Connect points with lines (boolean)
  Gr1.showGrid(gridLines);  //  Show Grid Lines (boolean)
  
  textAlign(CENTER);
  textSize(18);
  text("Graph Demo", width/2, 40);
  printKeys();
}

void draw()
{
  if(source) Gr1.newData(simData1());  //Add new element of data to buffer.
  else Gr1.newData(simData2());
  Gr1.plot(); //Update graph with current data.
  delay(4);  //Control simulation speed.  Smaller is faster.
}

int simData1()
{
  //Generate Random Data between min and max of yRange
  return int(random(0, 1023));
}

int simData2()
{
    //Generate pseudo square wave by adding odd harmonics of sin wave.
    // sin(n) + sin(3*n)/3 + sin(5*n)/5...
    float p1 = sin(radians(degAngle));
    p1 += sin(radians(3 * degAngle))/3;
    p1 += sin(radians(5 * degAngle))/5;
    p1 += sin(radians(7 * degAngle))/7;
    degAngle = (degAngle + 2) % 360;
    //if(degAngle > 45 && degAngle < 135) return 1024;  //'Out Of Range' data test   
    return int(512 * p1 + 511); 
}

void printKeys()
{
  println("keyboard functions:");
  println("b = blue background | g = green background | w = white background");
  println("R = red plot | G = green plot | W = white plot");
  println("r = red border | y = yellow border");
  println("p = toggle draw lines between points");
  println("x = toggle draw centered x Axis line");
  println("l = toggle draw grid lines");
  println("s = data source [ random / pseudo square wave ]");
  println("Space Bar = Pause / Resume");
}  

//Optional Keyboard functions to control appearance, select source and pause/resume
void keyPressed()
{
  switch(key)
  {
    case ' ':
      pause = !pause;
      if(pause) noLoop();
      else loop();
      break;
    case 'b':
      Gr1.bgColor(0, 0, 64);  //  b = Blue Background
      break;      
    case 'g':
      Gr1.bgColor(0, 48, 0);  //  g = Green Background
      break;
    case 'l':
      gridLines = !gridLines;
      Gr1.showGrid(gridLines);
      break;
    case 'p':                 //  p = Connect points with lines.
      plotLine = !plotLine;
      Gr1.connectPoints(plotLine);
      break;
    case 'r':
      Gr1.borderColor(255, 0, 0);  //  r = Red Border
      break;
    case 's':                      // s = Toggle Source
      source = !source;
      break;
    case 'w':
      Gr1.bgColor(224, 224, 224);  //  w = White Background
      break;
    case 'x':                     //  x = Toggle Display X axis
      Axis = !Axis;
      Gr1.xAxis(Axis);
      break;
    case 'y':
      Gr1.borderColor(255, 255, 0);  // y = Yellow Border
      break;
    case 'G':
      Gr1.plotColor(0, 255, 0);  // G = Green Plot
      break;
    case 'R':
      Gr1.plotColor(255, 0, 0);  // R = Red Plot
      break;
    case 'W':
      Gr1.plotColor(255, 255, 255);  // W = White Plot
      break;
    default:
      break;
  }
}
    
    
    
    
    


