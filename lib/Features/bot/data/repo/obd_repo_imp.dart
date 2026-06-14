import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:motoverse/Core/services/network_service.dart';
import 'package:motoverse/Features/bot/domain/repo/obd_repo.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/csv_simulator_helper.dart';

class ObdRepoImp implements ObdRepo {
  final NetworkService networkService;

  ObdRepoImp({required this.networkService});

  @override
  Stream<Map<String, dynamic>> startObdSimulation(PlatformFile file) {
    final controller = StreamController<Map<String, dynamic>>();

    controller.onListen = () async {
      final csvRows = await CsvSimulatorHelper.parsePlatformFile(file);
      int index = 1;

      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (index >= csvRows.length) {
          timer.cancel();
          controller.close();
          return;
        }

        final row = csvRows[index];

        controller.add({
          'carModel': '${row[1]} ${row[2]} ${row[3]}'.trim(),
          'rpm': row[12].toString(),
          'speed': row[19].toString(),
          'temp': row[8].toString(),
          'fuel': row[9].toString(),
          'load': row[10].toString(),
          'intake': row[17].toString(),
          'baro': row[7].toString(),
          'runtime': row[22].toString(),
          'faultCode': row.length > 25 ? row[25].toString().trim() : '',
        });
        index++;
      });
    };

    return controller.stream;
  }
}
