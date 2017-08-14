/*
Graph class
Author:  Darrell Harriman
Contact:  harrimand@gmail.com
*/

class Graph{
  int xPos = 100, yPos = 100, w = 600, h = 400;
  int buffSize = 80, index = 0;
  int min = 0, max = 1023;
  int r = 0, g = 0, b = 0;
  int plotR = 255, plotG = 255, plotB = 255;
  int gridDivsW = 10, gridDivsH = 10;
  int data[];
  boolean connectDots = false;
  boolean xAx = false;
  boolean shGrid = false;
  boolean shYscale = true;
  PGraphics p1;  //Used to render graph background image with grid lines.
  //PGraphics scaleY; // 
  
  Graph(int x, int y, int wx, int hy)
  {
    xPos = x;
    yPos = y;
    w = wx;
    h = hy;
    pushStyle();
    stroke(0, 255, 0);
    strokeWeight(4);
    noFill();
    rectMode(CORNER);
    rect(xPos-4, yPos-4, w+8, h+8);
    fill(r, g, b);
    //fill(128);
    noStroke();
    rect(xPos, yPos, w, h);
    popStyle();
    p1 = createGraphics(w + 2, h + 3);
    this.grid(gridDivsW, gridDivsH);
    //scaleY = createGraphics(80, h+30);
    this.yScale();    
  }
  
  void label(String name)
  {
    pushStyle();
    textAlign(CENTER);
    text(name, xPos + w/2, yPos + h + 20);
    popStyle();
  }
  
  void bgColor(int red, int green, int blue)
  {
    r = red;
    g = green;
    b = blue;
    pushStyle();
    fill(r, g, b);
    rectMode(CORNER);
    noStroke();
    rect(xPos, yPos, w, h);
    popStyle();
    grid(gridDivsW, gridDivsH);  // Update grid background color.  
  }
  
  void borderColor(int red, int green, int blue)
  {
    pushStyle();
    stroke(red, green, blue);
    strokeWeight(4);
    noFill();
    rectMode(CORNER);
    rect(xPos-4, yPos-4, w+8, h+8);
    popStyle();
  }
  
  void plotColor(int red, int green, int blue)
  {
    plotR = red;
    plotG = green;
    plotB = blue;
  }
  
  void xAxis(boolean x)
  {
    xAx = x;
    strokeWeight(1);
    this.plot();
  } 
  
  void bufferSize(int size)
  {
    buffSize = size;
    data = new int[buffSize];
    data[0] = yPos + h/2;
  }
  
  void yRange(int Min, int Max)
  {
    min = Min;
    max = Max;
    for(int i = 0; i < buffSize; i ++)
      data[i] = int((2 * yPos + h)/2);
  }
  
  void connectPoints(boolean cP)
  {
    connectDots = cP;
    this.plot();
  }

  void grid(int divsw, int divsh)
  {
    gridDivsW = divsw;
    gridDivsH = divsh;
    p1.beginDraw();
    p1.background(r, g, b);
    p1.stroke(64);
    for(int rw = w/divsw; rw < w; rw += w/divsw)
      p1.line(rw, 0, rw, h);
    for(int rh = h/divsh; rh < h; rh += h/divsh)
      p1.line(0, rh, w, rh);
    p1.endDraw();
    this.yScale();
  }
  
  void showGrid(boolean showG)
  {
    shGrid = showG;
    this.plot();
  }
  
  void yScale()
  {
    println(gridDivsH);
    pushMatrix();
    translate(xPos, yPos);
    pushStyle();
    fill(0);
    noStroke();
    rect(-50, -15, 40, h + 30);
    fill(255);
    textSize(14);
    textAlign(RIGHT, CENTER);
    for(int y = 0; y < gridDivsH + 1 ; y ++)
    {
      int scY = max - y * (max - min)/gridDivsH;
      text(scY, -10, y * (h / gridDivsH)-3);
      print(y + " ");
    }
    println();
    popStyle();
    popMatrix();
  }
  
/*  
    if(shYscale)
      image(scaleY, xPos + 50, yPos - 30);
    else
    {
      fill(0);
      noStroke();
      rect(xPos - 50, yPos - 30, 60, h + 30);
    }  
*/
    
  void newData(int sample)
  {
    if(sample < min || sample > max)  // Data Out of Range ?
    {
      pushStyle();      
      textAlign(LEFT);
      fill(255, 0, 0);
      textSize(10);
      textLeading(10);
      text("RANGE\nERROR", xPos, yPos + h + 20);
      popStyle();
      return; //Ignore invalid data
    }
    pushStyle();
    rectMode(CORNER);
    fill(0);
    noStroke();
    rect(xPos, yPos + h + 10, 60, 40);  // Clear Range Error Message
    popStyle();
    int newD = int(map(sample, min, max, yPos + h, yPos));
    data[index] = newD;  // Overwrite oldest data with new data
    //print(data[index], " ");  //For Testing
    index = (index + 1) % buffSize; 
  }

  void plot()
  {
    pushStyle();    
    if(shGrid)   //  Load background image with grid lines.
      image(p1, xPos - 1, yPos -1);
    else
    {
    fill(r, g, b);
    rectMode(CORNER);
    noStroke();
    rect(xPos - 1, yPos-1, w+2, h+3);
    }
 
    int xP = 0;
    int x = int(map(xP, 0, buffSize, xPos, xPos + w));
    int y = data[index];
    //print(y, " ");  //For Testing
    int xLast = x;
    int yLast = y;
    stroke(plotR, plotG, plotB);    
    
    for(xP = 0; xP < buffSize; xP ++)
    {
      point(x, y);
      x = int(map(xP, 0, buffSize, xPos, xPos + w));
      y = data[(xP + index) % buffSize];
      //print(y, " ");
      if(connectDots)
      {
        line(xLast, yLast, x, y);
        xLast = x;
        yLast = y;
      }
    }
    if(xAx)
     line(xPos - 1, (2 * yPos + h)/2, xPos + w, (2 * yPos + h)/2);  
    popStyle();
  }
}
