import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:processed/features/completed/controllers/completed_controller.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class PdfController extends GetxController {
  Rx<Uint8List> reportBytes = Uint8List(0).obs;

  CompletedController completedController = Get.find<CompletedController>();

  void shareUint8List(Uint8List fileData, {String? text}) {
    final XFile file = XFile.fromData(fileData, mimeType: 'application/pdf');

    Share.shareXFiles(
      [file],
    );
  }

  @override
  void onInit() {
    // print('Report Url - ${completedController.currentReportUrl.value}');
    super.onInit();
  }
}
