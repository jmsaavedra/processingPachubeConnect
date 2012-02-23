
void getData() {
  println(">>> SEND GET <<<\n");

  c.write("GET /v2/feeds/" + feedID + ".csv HTTP/1.1\n"); // returns CSV
  c.write("Host: api.pachube.com\n"); // Be polite and say who we are
  c.write("X-PachubeApiKey: " + ApiKey + "\n");
  c.write("\r\n");
}

void checkForResponse() {
  if (c.available() > 0) { // If there's incoming data from the client...
    println(">>> RECEIVED RESPONSE: ");
    data = c.readString(); // ...then grab it
    println(data);
    println("-----end data-----");
    parseData(data);
  }
}

void parseData(String data) {

  datastreams.clear(); //clear all previous values

  String[] serverResponse = split(data, "\n\r\n"); //pull data csv from server response ("\newline\carriagereturn\newline")
  println("\nserverResponseParagraphs= " + serverResponse.length);
  
  if (serverResponse.length > 1) { //we have received ALL data (including datastreams CSVs)
    String[] rawDataLines = split(serverResponse[1], "\n");
    println("\nrawDataLines.length= " + rawDataLines.length); //how many datastreams are there

    for (int k=0; k < rawDataLines.length; k++) {  //each rawDataLine is an entire datastream
      // println("adding stream number: " + k);
      datastreams.add(new Datastream());           //create a new datastream in the arrayList
      String[] thisDatastream= split(rawDataLines[k], ","); //split each rawDataline by commas

      for (int j=0; j < thisDatastream.length; j++) { //each CSV goes "[0]title, [1]date updated, [2]value" 
        //println("rawDataLineNumber: " + k + " CSV: " + thisDatastream[j]);
        Datastream datastream = (Datastream) datastreams.get(k);
        if (j==0) datastream.setTitle(thisDatastream[j]);
        if (j==1) datastream.setTimeUpdated(thisDatastream[j]);
        if (j==2) datastream.setVal(float(thisDatastream[j]));
      }
    }
    assignValues();
  }
}

