import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

class CsvSimulatorHelper {
  static Future<List<List<dynamic>>> parsePlatformFile(
    PlatformFile file,
  ) async {
    String csvString = '';

    // 1. قراءة الملف حسب المنصة (ويب أو موبايل) وتحويله لـ String
    if (file.bytes != null) {
      // لو شغال ويب (Web)
      csvString = utf8.decode(file.bytes!);
    } else if (file.path != null) {
      // لو شغال موبايل (Android / iOS)
      final fileOnDevice = File(file.path!);
      csvString = await fileOnDevice.readAsString();
    }

    // 2. استخدام ميثود decode من كلاس Csv الجديد اللي أنت بعت السورس كود بتاعه
    return Csv().decode(csvString);
  }
}
