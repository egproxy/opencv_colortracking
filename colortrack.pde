import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

Capture video;
OpenCV opencv;
ArrayList<Contour> contours;

// <1a> Set the range of Hue values for our filter
static final int rangeLow = 140;
static final int rangeHigh = 160;

// <1b> Set the number of points the object should have
static final int PT_THRESHOLD = 260;


void setup() {
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, video.width, video.height);
  size(opencv.width, opencv.height, P2D);
  contours = new ArrayList<Contour>();
  
  video.start();
}

void draw() {
  image(video, 0, 0);  

  // <2> Load the new frame of our movie in to OpenCV
  opencv.loadImage(video);
  // <3> Tell OpenCV to work in HSV color space.
  opencv.useColor(HSB);
  // <4> Copy the Hue channel of our image into 
  //     the gray channel, which we process.
  opencv.setGray(opencv.getH().clone());
  // <5> Filter the image based on the range of 
  //     hue values that match the object we want to track.
  opencv.inRange(rangeLow, rangeHigh);
  // <6> Display the processed image for reference.
  image(opencv.getOutput(), 3*width/4, 3*height/4, width/4, height/4);
  // <7> Find contours in our range image.
  //     Passing 'true' sorts them by descending area.
  contours = opencv.findContours(true,true);
  // <8> Check to make sure we've found any contours
  
  ArrayList<Contour> dotsFound = new ArrayList<Contour>();
  int objsFound = 0;
  //OpenCV sorts objects detected by size
  for( Contour investigate : contours ) {
    if( investigate.numPoints() >= PT_THRESHOLD ) {
      // <10> Find the bounding box of the contour,
      //      and hence our object.
      Rectangle r = investigate.getBoundingBox();
      
      // <11> Draw the bounding box of our object
      noFill();
      strokeWeight(2);
      stroke(255, 0, 0);
      rect(r.x, r.y, r.width, r.height);
      
      // <12> Increment number of objects found in frame
      objsFound++;
    } else {
      break;
    }
  }
  
  println("Objects Found: " + objsFound);
}

void captureEvent(Capture c) {
  c.read();
}
