import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:processed/features/completed/models/completed_inspection_model.dart';
import 'package:processed/utils/http/http_client.dart';
import 'package:processed/utils/local_storage/db_helper.dart';

class CompletedController extends GetxController {
  // RxBool isLoading = true.obs;

  static CompletedController get instance => Get.find();

  RxList all = [].obs;
  Rx<Uint8List> currentReportPdf = Uint8List(0).obs;

  DatabaseHelper databaseHelper = DatabaseHelper();

  getFileContent(String inspectionName) async {
    try {
      final response =
          await THttpHelper.post('api/method/get_inspection_form_pdf', {
        'docname': inspectionName,
      });

      if (response.elementAt(0) == 200) {
        print(response.elementAt(1)['message']['filecontent']);

        List<int> intList =
            (response.elementAt(1)['message']['filecontent'] as List<dynamic>)
                .map<int>((element) => element as int)
                .toList();

        Uint8List uint8List = Uint8List.fromList(intList);

        // Assuming currentReportPdf.value accepts Uint8List
        // currentReportPdf.value = uint8List;

        currentReportPdf.value = uint8List;

        print('Uint8List: $uint8List');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Future<void> writeToFile(Uint8List data) async {
  //   currentReportPdf.value = writeAsBytesSync(data);
  // }

  @override
  void onInit() async {
    all.value = await databaseHelper
        .getAllCompletedInspections(GetStorage().read('user_email'));

    // sort the list by date

    print('Unsorted List: $all');

    print('\n');

    // convert it to list of maps<String, dynamic>

    List<Map<String, dynamic>> list = [];

    for (var item in all) {
      list.add(item.toMap());
    }

    // now sort the list by date

    list.sort((a, b) {
      return b['reportDateCompleted'].compareTo(a['reportDateCompleted']);
    });

    // convert it back to list of CompletedInspection objects

    all.value = list.map((e) => CompletedInspection.fromMap(e)).toList();

    print('Sorted List: ${all.toString()}');

    update();

    super.onInit();
  }
}
