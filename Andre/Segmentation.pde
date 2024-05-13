PImage imgOriginal, gray, edges, groundTruth, processedImage, blackBackgroundImage;
ImageProcessor processor;

void setup() {
  size(1000, 638);
  processor = new ImageProcessor();
  
  imgOriginal = loadImage("SegmentationImages/Image.jpg");
  groundTruth = loadImage("SegmentationImages/SegmentationClass.png");
  gray = processor.convertToGrayScale(imgOriginal);
  
  gray = processor.applyGaussianBlur(gray, 1.5);
  gray = processor.applyThreshold(gray, 121);
  
  edges = createImage(gray.width, gray.height, RGB);
  edges = processor.filterSobel(gray, edges);
  edges = processor.dilate(edges);
  
  processedImage = processor.floodFill(edges, 234, 158, color(128,0,0), color(0));
  blackBackgroundImage = processor.maskBackgroundToBlack(imgOriginal);
  //processor.calcularMetricas(processedImage, groundTruth);
  
  noLoop();
}

void draw() {
  background(255);
  displayImages();
}

void displayImages() {
  image(imgOriginal, 0, 0);
  image(groundTruth, 500, 0);
  processor.changeBorderToYellow(processedImage);
  image(processedImage, 0, 319);
  image(blackBackgroundImage, 500, 319);
  save("SegmentationResult.png");
}
