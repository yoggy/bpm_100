//
//  bpm_100.pde
//
float bpm = 100;
float max_t = 60.0f / (float)bpm;

float range_min_x = -1.0;
float range_max_x =  1.0;
float range_min_y = 0.0; // bottom
float range_max_y = 1.0; // top

float func(float x) {
  return 1.0 - x * x;
}

//////////////////////////////////////////////////////

float current_t = 0;

void setup() {
  size(600, 600);
  PFont pfont = createFont("Impact", 36);
  textFont(pfont);
}

// screen -> normal coordinates
float conv_s2n_x(float v) {
  // [0, width] -> [min - max]
  float s = range_min_x;
  float w = range_max_x - range_min_x;
  return v / (float)width * w + s;
}

// normal -> screen coordinates
float conv_n2s_x(float v) {
  // [min, max] - [0, width]
  float s = range_min_x;
  float w = range_max_x - range_min_x;
  return (v - s) / w * width;
}

// screen -> normal coordinates
float conv_s2n_y(float v) {
  // [0, height] -> [max, min]
  float s = range_min_y;
  float w = range_max_y - range_min_y;
  return (1.0 - (v / (float)height)) * w + s;
}

// normal -> screen coordinates
float conv_n2s_y(float v) {
  // [max, min] - [0, height]
  float s = range_min_y;
  float w = range_max_y - range_min_y;
  return (1.0 - (v - s) / w) * height;  
}

void draw() {
  background(0, 0, 0);
  
  noFill();
  strokeWeight(2);
  stroke(#ffffff);
  for (int x = 0; x < width; ++x) {
    float x0 = x;
    float x1 = x+1;
    float y0 = conv_n2s_y(func(conv_s2n_x(x0)));
    float y1 = conv_n2s_y(func(conv_s2n_x(x1)));

    line(x0, y0, x1, y1);    
  }
 
  noFill();
  strokeWeight(1);
  stroke(#008800);
  for (int x = 0; x < width; x += width / 6) {
    line(x, 0, x, height);
  }
  
  float y_3 = conv_n2s_y(func(0.333333));
  noFill();
  strokeWeight(1);
  stroke(#ff0000);
  line(0, y_3, width, y_3);
  
  fill(#ffff00);
  noStroke();
  float current_x = current_t / max_t * (range_max_x - range_min_x) + range_min_x;
  float current_y = func(current_x);
  ellipse(conv_n2s_x(current_x), conv_n2s_y(current_y), 50, 50);
  
  current_t += 1 / 60.0f;
  if (current_t > max_t) {
    current_t = 0.0f;
  }

  fill(#ffffff);
  text("bpm=" + bpm + ", t=" + max_t, 10, 36);
}
