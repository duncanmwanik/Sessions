// BLE UUIDs
import '../models/vibration_model.dart';

String serviceUuid = "4fafc201-1666-459e-8fcc-c5c9c331914b";
String characteristicUuidBattery = "beb54800-36e1-4688-b7f5-ea07361b26a8";
String characteristicUuidAlarm = "beb54811-36e1-4688-b7f5-ea07361b26a8";
String characteristicUuidCommand = "beb54822-36e1-4688-b7f5-ea07361b26a8";

List<VibrationPatternObject> vibrationPatternList = [
  const VibrationPatternObject(patternNumber: 0, patternImage: 'assets/images/pattern0.png'),
  const VibrationPatternObject(patternNumber: 1, patternImage: 'assets/images/pattern1.png'),
  const VibrationPatternObject(patternNumber: 2, patternImage: 'assets/images/pattern2.png'),
  const VibrationPatternObject(patternNumber: 3, patternImage: 'assets/images/pattern3.png'),
];
