/*
 example to read and parse a feed
 uses HTTPClient and GET
 parses CSV
 
 http://jos.ph 
 Feb 2012
*/

import processing.net.*;

//parsonscollab API key:  JI129Qd1q0Mb2napu8kosXSTQkPtMX5iIFfdV5clhcc
String ApiKey = "95nFBkTypzz4C-0GoMAh9Wqwzo6SAKwyTldnWDNvZnQ0RT0g";
String feedID = "26118"; // http://pachube.com/feeds/26118

Client c;
String data;
ArrayList datastreams;

//timer variables
long currTime = 0;
long lastGET = 0;
int interval = 3; //check for new data every 3 seconds 

//my variables!
float temperatureValue = 0;
float lightValue = 0;
float humidityValue = 0;
float CO2Value = 0; 

float myX;
float myY;
float myRed;
float mySize;

void setup() {
  size(500, 500);
  background(50);
  c = new Client(this, "api.pachube.com", 80); // Connect to server on port 80
  datastreams = new ArrayList();
  getData(); //call the get data function once right off the bat
}

void draw() {
  checkForResponse(); //always be listening for a response from the server!
  currTime = millis();
  if (currTime > lastGET + interval*1000){ //check if we've hit the timer
    lastGET = currTime; //reset timer
    getData();  //get me some data
  }
  
  /* map my incoming values to values usable for my sketch! */
  myX = map(temperatureValue, 10, 30, 0, width); //incoming min: 10 max: 30 // becomes min: 0 max: width of app
  myY = map(lightValue, 32, 90, 0, height);
  myRed = map(humidityValue, 240, 279, 0, 255); //incoming min: 240 max: 279 // becomes min: 0 max: 255
  mySize = map(CO2Value, 679, 807, 10, 200);
  //println("myX= " + myX + "\tmyY= " + myY + "\tmyRed= " + myRed + "\tmySize= " + mySize); //debug!
  
  /* do stuff */
  background(50);
  fill(myRed, 100, 200);
  ellipse(myX, myY, mySize, mySize); //super fancy AND creative!
}

void assignValues() { //this gets called at the end of parseData() function (inside of pachubeConnect)

  for (int thisStream = 0; thisStream < datastreams.size(); thisStream++) { //this will go through all available datastreams
    Datastream datastream = (Datastream) datastreams.get(thisStream);
    println("\nstream number: " + thisStream);
    println("stream title: " + datastream.getTitle());
    println("stream lastUpdated: " + datastream.getTimeUpdated());
    println("stream value: " + datastream.getVal());

    /* here is where you pull out streams and assign them to whatever you want! */
    if (thisStream == 0) { //datastream 0
      temperatureValue = datastream.getVal();
    }
    if (thisStream == 1) { //datastream 1
      lightValue = datastream.getVal();
    }
    if (thisStream == 2) { //datastream 2
      humidityValue = datastream.getVal();
    }
    if (thisStream == 4) {
      CO2Value = datastream.getVal();
    }
  }
  println();
}


void keyPressed() {
  //manually get data by pressing 'd'
  if (key == 'd') getData();
}
