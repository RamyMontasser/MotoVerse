import 'package:file_picker/file_picker.dart';

abstract class ObdRepo {
  Stream<Map<String, dynamic>> startObdSimulation(PlatformFile file);
}
