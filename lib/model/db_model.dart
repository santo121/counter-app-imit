//######################################## SensorFields ##################################################

class SensorFields {
  static final List<String> values = [
    /// Add all fields
    sensorId, sensorType, sensorSlno, sensorCode
  ];

  static const String sensorId = 'sensorId';
  static const String sensorType = 'sensorType';
  static const String sensorSlno = 'sensorSlno';
  static const String sensorCode = 'sensorCode';
}

class SensorModel {
  String sensorId;
  String sensorType;
  String sensorSlno;
  String sensorCode;
  SensorModel(
      {required this.sensorId,
      required this.sensorType,
      required this.sensorSlno,
      required this.sensorCode});

  Map<String, Object?> toJson() => {
        SensorFields.sensorId: sensorId,
        SensorFields.sensorType: sensorType,
        SensorFields.sensorSlno: sensorSlno,
        SensorFields.sensorCode: sensorCode
      };

  static SensorModel fromJson(Map<String, Object?> json) => SensorModel(
        sensorCode: json[SensorFields.sensorCode].toString(),
        sensorId: json[SensorFields.sensorId].toString(),
        sensorSlno: json[SensorFields.sensorSlno].toString(),
        sensorType: json[SensorFields.sensorType].toString(),
      );
}

//######################################## SensorFields ##################################################




//######################################## LaneOccupancyFields ##################################################
class LaneOccupancyFields {
  static final List<String> values = [
    occuId,
    occuVehicle,
    occuLaneSlno,
    occuStartDt,
    occuWorkMode,
    occuEndDt
  ];

  static const String occuId = 'occuId';
  static const String occuVehicle = 'occuVehicle';
  static const String occuLaneSlno = 'occuLaneSlno';
  static const String occuStartDt = 'occuStartDt';
  static const String occuWorkMode = 'occuWorkMode';
  static const String occuEndDt = 'occuEndDt';
}

class LaneOccupancy {
  String occuId;
  String occuVehicle;
  String occuLaneSlno;
  String occuStartDt;
  String occuWorkMode;
  String occuEndDt;

  LaneOccupancy(
      {required this.occuId,
      required this.occuEndDt,
      required this.occuLaneSlno,
      required this.occuStartDt,
      required this.occuVehicle,
      required this.occuWorkMode});

  Map<String, Object?> toJson() => {
        LaneOccupancyFields.occuId: occuId,
        LaneOccupancyFields.occuVehicle: occuVehicle,
        LaneOccupancyFields.occuLaneSlno: occuLaneSlno,
        LaneOccupancyFields.occuStartDt: occuStartDt,
        LaneOccupancyFields.occuWorkMode: occuWorkMode,
        LaneOccupancyFields.occuEndDt: occuEndDt,
      };

  static LaneOccupancy fromJson(Map<String, Object?> json) => LaneOccupancy(
      occuId: json[LaneOccupancyFields.occuId].toString(),
      occuEndDt: json[LaneOccupancyFields.occuEndDt].toString(),
      occuLaneSlno: json[LaneOccupancyFields.occuLaneSlno].toString(),
      occuStartDt: json[LaneOccupancyFields.occuStartDt].toString(),
      occuVehicle: json[LaneOccupancyFields.occuVehicle].toString(),
      occuWorkMode: json[LaneOccupancyFields.occuWorkMode].toString());
}
//########################################## LaneOccupancyFields ################################################





//########################################## RfTags ################################################

class RfTagsFields {
  static final List<String> values = [
    tagId,
    tagCode,
    tagName,
    tagStatus,
  ];

  static const String tagId = 'tagId';
  static const String tagCode = 'tagCode';
  static const String tagName = 'tagName';
  static const String tagStatus = 'tagStatus';
}

class RfTags {
  String tagId;
  String tagCode;
  String tagName;
  String tagStatus;

  RfTags(
      {required this.tagCode,
      required this.tagId,
      required this.tagName,
      required this.tagStatus});

  Map<String, Object?> toJson() => {
        RfTagsFields.tagCode: tagCode,
        RfTagsFields.tagId: tagId,
        RfTagsFields.tagName: tagName,
        RfTagsFields.tagStatus: tagStatus,
      };

  static RfTags fromJson(Map<String, Object?> json) => RfTags(
      tagCode: json[RfTagsFields.tagCode].toString(),
      tagId: json[RfTagsFields.tagId].toString(),
      tagName: json[RfTagsFields.tagName].toString(),
      tagStatus: json[RfTagsFields.tagStatus].toString());
}

//########################################## RfTags ################################################




//########################################## ReadingsFields ########################################

class ReadingsFields {
  static final List<String> values = [
    readId,
    readOccupancy,
    readWorkerMode,
    readPickDt,
    readPickSensor,
    readPicksType,
    readPickTagId,
    readDropDt,
    readDropSensor,
    readDropsType,
    readDropTagId,
    readCounter
  ];

  static const String readId = 'readId';
  static const String readOccupancy = 'readOccupancy';
  static const String readWorkerMode = 'readWorkerMode';
  static const String readPickDt = 'readPickDt';
  static const String readPickSensor = 'readPickSensor';
  static const String readPicksType = 'readPicksType';
  static const String readPickTagId = 'readPickTagId';
  static const String readDropDt = 'readDropDt';
  static const String readDropSensor = 'readDropSensor';
  static const String readDropsType = 'readDropsType';
  static const String readDropTagId = 'readDropTagId';
  static const String readCounter = 'readCounter';
}

class Readings {
  String readId;
  String readOccupancy;
  String readWorkerMode;
  String readPickDt;
  String readPickSensor;
  String readPicksType;
  String readPickTagId;
  String readDropDt;
  String readDropSensor;
  String readDropsType;
  String readDropTagId;
  String readCounter;

  Readings(
      {required this.readCounter,
      required this.readDropDt,
      required this.readDropSensor,
      required this.readDropTagId,
      required this.readDropsType,
      required this.readId,
      required this.readOccupancy,
      required this.readPickDt,
      required this.readPickSensor,
      required this.readPickTagId,
      required this.readPicksType,
      required this.readWorkerMode});

  Map<String, Object?> toJson() => {
        ReadingsFields.readId: readId,
        ReadingsFields.readOccupancy: readOccupancy,
        ReadingsFields.readWorkerMode: readWorkerMode,
        ReadingsFields.readPickDt: readPickDt,
        ReadingsFields.readPickSensor: readPickSensor,
        ReadingsFields.readPicksType: readPicksType,
        ReadingsFields.readPickTagId: readPickTagId,
        ReadingsFields.readDropDt: readDropDt,
        ReadingsFields.readDropSensor: readDropSensor,
        ReadingsFields.readDropsType: readDropsType,
        ReadingsFields.readDropTagId: readDropTagId,
        ReadingsFields.readCounter: readCounter,
      };

  static Readings fromJson(Map<String, Object?> json) => Readings(
      readCounter: ReadingsFields.readCounter,
      readDropDt: ReadingsFields.readDropDt,
      readDropSensor: ReadingsFields.readDropSensor,
      readDropsType: ReadingsFields.readDropsType,
      readDropTagId: ReadingsFields.readDropTagId,
      readId: ReadingsFields.readId,
      readOccupancy: ReadingsFields.readOccupancy,
      readPickDt: ReadingsFields.readPickDt,
      readPickSensor: ReadingsFields.readPickSensor,
      readPicksType: ReadingsFields.readPicksType,
      readPickTagId: ReadingsFields.readPickTagId,
      readWorkerMode: ReadingsFields.readWorkerMode);
}
//########################################## ReadingsFields ################################################