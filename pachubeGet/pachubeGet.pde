import processing.net.*;

Client c;
String data;

//parsonscollab API key:  JI129Qd1q0Mb2napu8kosXSTQkPtMX5iIFfdV5clhcc
String ApiKey = "7HsgaVRMCZ5FOSGypykT72YyKvKSAKxQbXdIanBxeEFBYz0g";
String feedID = "48306";

void setup() {
  size(500, 500);
  background(50);
  fill(200);
  c = new Client(this, "api.pachube.com", 80); // Connect to server on port 80
  getData(); //call the get data function once right off the bat
}

void draw() {

  checkForResponse(); //always be listening for a response from the server!
}

void keyPressed() {
  getData();
}

void getData() {
  println(">>> SEND GET <<<\n");

  // Use the HTTP "GET" command to ask for a Web page
  c.write("GET /v2/feeds/" + feedID + ".xml HTTP/1.1\n");  //returns XML
  // c.write("GET /v2/feeds/" + feedID + ".csv HTTP/1.1\n"); // returns CSV
  // c.write("GET /v2/feeds/" + feedID + ".json HTTP/1.1\n"); // returns JSON

  c.write("Host: api.pachube.com\n"); // Be polite and say who we are
  c.write("X-PachubeApiKey: " + ApiKey + "\n");
  c.write("\r\n");
}

void checkForResponse() {
  if (c.available() > 0) { // If there's incoming data from the client...
    println(">>> RECEIVED RESPONSE: ");
    data = c.readString(); // ...then grab it 
    println(data); //and print it
  }
}

