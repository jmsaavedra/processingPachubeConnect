
class Datastream {

  String name;
  float value;
  String timeUpdated;

  Datastream() {
  }

  void setTitle(String streamName) {
    name = streamName;
  }
  void setVal(float streamVal) {
    value = streamVal;
  }
  void setTimeUpdated(String time) {
    timeUpdated = time;
  }

  String getTitle() {
    return name;
  }
  float getVal() {
    return value;
  }
  String getTimeUpdated() {
    return timeUpdated;
  }
}
