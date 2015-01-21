import processing.video.*;
Movie video;

float r, g, b;
int movieHeight = 240;  // this should be the video file height
int movieLength; // this is determined by the duration of the file loaded
int framesPerSecond = 2; // this should be the video file frame rate

// I'm not sure if this works right
// float framesPerSecond = 1.44; 

void setup() {
  video = new Movie(this, "test.mp4");
  video.play();
  
  background(0);
  frameRate(framesPerSecond);
  
  movieLength = int(video.duration());
  size(movieLength*framesPerSecond, movieHeight);
}

void draw() {
  if (video.available()) {
    video.read(); 
  }
  
  loadPixels();
  video.loadPixels();
  
  // loop through the pixel array
  for (int y = 0; y < video.height; y++) {
    r = 0;
    g = 0; 
    b = 0;
    
    // find the rgb values across each row of pixels for the current frame
    for (int x = 0; x < video.width; x++) {
      int location = y*video.width + x;
      r += red(video.pixels[location]);
      g += green(video.pixels[location]);
      b += blue(video.pixels[location]);
    }
    
    // find the average of the rgb values
    r = r/video.width;
    g = g/video.width;
    b = b/video.width;
    
    // turn average rgb values into a color value
    color c = color(r, g, b);
    
    // paint that value back into a single pixel
    // advance the pixel location using frameCount
    int location = y*width + frameCount;
    if (location < pixels.length) {
      pixels[location] = c;
    }
  }
  updatePixels();
  
  // if we have reached the end of the movie, save the image and exit
  if (frameCount == width) {
   saveFrame("output.png");
   exit();
  }
}
