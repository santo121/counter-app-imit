class JNSensorModel{
  String? sensorId;
  DateTime? time;
  String?tagId;
  String?mode;
  String?junctionBoxName;
  JNSensorModel({this.sensorId,this.tagId,this.time,this.junctionBoxName,this.mode});
}
class LNSensorModel{
  String? sensorId;
  DateTime? time;
  String?vehicleNumber;
  String?tagId;
  String?mode;
  LNSensorModel({this.sensorId,this.tagId,this.time,this.mode,this.vehicleNumber});
}