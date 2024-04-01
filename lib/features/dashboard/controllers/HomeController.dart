import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:processed/features/completed/models/completed_inspection_model.dart';
import 'package:processed/features/dashboard/controllers/HomeController.dart';
import 'package:processed/features/dashboard/views/home.dart';
import 'package:processed/features/inspection/controllers/InspectionController.dart';
import 'package:processed/features/inspection/models/ItemModel.dart';
import 'package:processed/utils/http/http_client.dart';
import 'package:processed/utils/local_storage/db_helper.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/image_strings.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  static HomeController get instance => Get.find();
  RxBool isSaveEnabled = false.obs;
  RxList allPendingTasks = [].obs;
  RxList allCompletedInspections = [].obs;
  DatabaseHelper databaseHelper = DatabaseHelper();
  Map<String, RxList<dynamic>> referencesMap = {
    "Purchase Receipt": [].obs,
    "Purchase Invoice": [].obs,
    "Subcontracting Receipt": [].obs,
    "Delivery Note": [].obs,
    "Sales Invoice": [].obs,
    "Stock Entry": [].obs,
    "Job Card": [].obs,
  };

  RxList<Uint8List> allCompletedReportBytes = <Uint8List>[].obs;

  // Define a list of maps containing image URLs and titles
  List<Map<String, String>> imageTitles = [
    {
      'imageUrl': TImages.onboardingImage1,
      'title': 'Effortless Inspection Journey',
    },
    {
      'imageUrl': TImages.onboardingImage1,
      'title': 'Template Galore',
    },
    {
      'imageUrl': TImages.onboardingImage1,
      'title': 'Unplugged Inspections: Drafts Offline',
    },
    {
      'imageUrl': TImages.onboardingImage1,
      'title': 'Shareable Insights',
    },
    {
      'imageUrl': TImages.onboardingImage1,
      'title': 'Capture with Digital Proofs',
    },
  ];

  RxList allItemCodes = [].obs;
  RxList allItemNames = [].obs;

  Map<String, String> itemTemplateMap = {};

  RxList allInspectionTemplateNames = [].obs;

  var isDocument = true.obs;
  // static RxBool isNewForm = true.obs;

  var carouselIndex = 0.obs;

  var company = ''.obs;

  var subject = ''.obs;

  var startsOn = ''.obs;

  var endsOn = ''.obs;

  var eventId = ''.obs;

  var referenceDocument = ''.obs;

  RxInt systemIntegration = 0.obs;

  RxInt dl = 0.obs;

  var documentName = ''.obs;

  var isNewForm = true.obs;

  var isDraft = true.obs;

  void updateCarouselIndex(int index) {
    carouselIndex.value = index;
    update();
  }

  void getPendingTasks() async {
    print(GetStorage().read('user_email'));
    var res = await THttpHelper.get(
        'api/resource/Planner?fields=["*"]&filters=[["owner","=","${GetStorage().read('user_email').toString()}"]]');

    allPendingTasks.value = res.elementAt(1)['data'];
    update();

    print(allPendingTasks.length);

    await updatePendingList();

    update();
  }

  updatePendingList() async {
    List<Map<String, dynamic>> tasksToRemove = [];

    for (var task in allPendingTasks) {
      if (task['repeat_this_event'] == 1 && task['ends_on'] != null) {
        var endDate = DateTime.parse(task['ends_on']);
        var currentDate = DateTime.now();

        if (currentDate.isAfter(endDate)) {
          // Add task to the list of tasks to remove
          tasksToRemove.add(task);
        }
      } else if (task['repeat_this_event'] == 0) {
        // check if inspection form filled
        var docstatus = await databaseHelper.isEventIdExists(task['name']);

        if (docstatus) {
          print('Inspection form filled for ${task['name']}');
          print('Removing from list...');
          // Add task to the list of tasks to remove
          tasksToRemove.add(task);
        }
      }
    }

    // Remove tasks from the original list
    for (var task in tasksToRemove) {
      allPendingTasks.remove(task);
    }

    // Call update after all removals
    update();
  }

// if planner repeat on - >end date analysis  -> if passed ->remove;

// if repeat off -> inspection form filled -> remove

// repeat_this_event

  void fetchReportFile() async {
    try {
      final response = await THttpHelper.post(
          'api/method/get_inspection_form_pdf',
          {"docname": "MAT-QA-2024-00042"});

      if (response.elementAt(0) == 200) {
        final bytes = response.elementAt(1);

        print(bytes);

        allCompletedReportBytes.value =
            response.elementAt(1)['message']['filecontent'].asUint8List();

        print('File written');

        print('File data fetched');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void fillDetails() {
    for (int i = 0; i < allPendingTasks.length; i++) {
      company.value = allPendingTasks[i]['company'];
      subject.value = allPendingTasks[i]['subject'];
      startsOn.value = allPendingTasks[i]['starts_on'];
      endsOn.value = allPendingTasks[i]['ends_on'];
      eventId.value = allPendingTasks[i]['name'];
      referenceDocument.value = allPendingTasks[i]['ref_doc'];
      systemIntegration.value = allPendingTasks[i]['system_integrated'];
      dl.value = allPendingTasks[i]['document_level'];
      documentName.value = allPendingTasks[i]['document_name'];
    }
  }

  Future<List> getAllCompletedInspections() async {
    try {
      final response = await THttpHelper.get(
          'api/resource/Inspection Form?fields=["*"]&filters=[["inspected_by","=","${GetStorage().read('user_email').toString()}"], ["docstatus" , "=", "1"] ]');

      if (response.elementAt(0) == 200) {
        // print(response.elementAt(1)['data']);
        allCompletedInspections.value = response.elementAt(1)['data'];

        print(allCompletedInspections.length);

        return allCompletedInspections;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  // true or false if event id exists in completed inspections

  Future<void> initializeReferences() async {
    try {
      for (String referenceType in referencesMap.keys) {
        await getReferenceNames(referenceType, referencesMap[referenceType]!);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getReferenceNames(
      String referenceType, RxList<dynamic> referenceNames) async {
    try {
      final String endPoint =
          '${THttpHelper.baseUrl}/api/resource/$referenceType';

      var response = await http.get(headers: {
        'Authorization': 'token ${THttpHelper.apiKey}:${THttpHelper.apiSecret}'
      }, Uri.parse(endPoint));

      if (response.statusCode == 200) {
        print('Referene names data for $referenceType is -  ${response.body}');

        List<dynamic> dataList = json.decode(response.body)["data"];

        List<String> nameList =
            dataList.map((map) => map['name'].toString()).toList();

        referenceNames.value = nameList;

        print('Reference Type Selected - \n$referenceType');

        print(
            'All Reference Names for $referenceType fetched\n  - \n$referenceNames');
      }
    } catch (e) {
      print(e);
    }

    // update all values using allpendingtasks

    // update all values
  }

  Future<void> createItemTemplateMapping() async {
    try {
      final response = await THttpHelper.get(
          'api/resource/Item?limit_page_length=None&fields=["*"]');

      if (response.isNotEmpty && response.elementAt(0) == 200) {
        final responseData = response.elementAt(1)['data'];

        if (responseData != null) {
          for (var curData in responseData) {
            final itemName = curData['item_name'];
            final templateName =
                curData['custom_inspection_parameter_template'];

            final isItemExist =
                await databaseHelper.doesItemExistByName(itemName);

            if (!isItemExist) {
              final itemModel = ItemModel(
                itemName: itemName,
                templateName: templateName,
              );

              await databaseHelper.insertItem(itemModel);
            }
          }
        }
      } else {
        print('Error: Unexpected response: $response');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void updateCompletedInspectionList() async {
    allCompletedInspections.value = await getAllCompletedInspections();

    for (var i = 0; i < allCompletedInspections.length; i++) {
      var completedModel = CompletedInspection(
        userId: GetStorage().read('user_email'),
        inspectionName: allCompletedInspections[i]['name'],
        companyName: allCompletedInspections[i]['company'],
        reportDateCompleted: allCompletedInspections[i]['report_date'],
        eventId: allCompletedInspections[i]['event_id'] ?? '',
      );

      // insert into database;

      databaseHelper.insertCompletedInspection(completedModel);
    }

    allCompletedInspections.value = await databaseHelper
        .getAllCompletedInspections(GetStorage().read('user_email'));
  }

  @override
  void onInit() async {
    // Load data

    await getAllCompletedInspections();
    await initializeReferences();

    await databaseHelper.saveReferencesToDatabase(referencesMap);

    for (var i = 0; i < allCompletedInspections.length; i++) {
      var completedModel = CompletedInspection(
        userId: GetStorage().read('user_email'),
        inspectionName: allCompletedInspections[i]['name'],
        companyName: allCompletedInspections[i]['company'],
        reportDateCompleted: allCompletedInspections[i]['report_date'],
        eventId: allCompletedInspections[i]['event_id'] ?? '',
        inspectionTemplateName:
            allCompletedInspections[i]['inspection_template'] ?? '',
        completedItemName: allCompletedInspections[i]['item_name'] ?? '',

        // completedReportUrl:
        //     allCompletedInspections[i]['completed_report_url'] ?? '',
      );

      // for (var i = 0; i < allCompletedInspections.length; i++) {
      //   try {
      //     var reportData = await THttpHelper.post(
      //         'api/method/get_inspection_form_pdf',
      //         {"docname": allCompletedInspections[i]['name']});

      //     if (reportData.elementAt(0) == 200) {
      //       final bytes = reportData.elementAt(1);

      //       allCompletedReportBytes.value =
      //           reportData.elementAt(1)['message']['filecontent'].asUint8List();

      //       print(bytes);
      //       print('File data fetched');
      //     }
      //   } catch (e) {
      //     print(e.toString());
      //   }
      // }

      // insert into database;

      print('Inserting Completed task $i  nto database - $completedModel');
      print('\n');

      databaseHelper.insertCompletedInspection(completedModel);
    }

    // sort the completed inspections by date

    allCompletedInspections.sort((a, b) {
      return DateTime.parse(b['report_date'])
          .compareTo(DateTime.parse(a['report_date']));
    });

    getPendingTasks();

    await createItemTemplateMapping();
    print('Item Template Mapping Created!');

    isLoading.value = false;

    super.onInit();
  }
}
