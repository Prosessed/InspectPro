import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:processed/common/widgets/thank_you.dart';
import 'package:processed/features/completed/models/completed_inspection_model.dart';
import 'package:processed/features/dashboard/controllers/homecontroller.dart';
import 'package:processed/features/dashboard/views/home.dart';
import 'package:processed/features/drafts/controllers/draft_controller.dart';
import 'package:processed/features/drafts/models/draft_model.dart';
import 'package:processed/features/planners/controllers/plannercontroller.dart';
import 'package:processed/navigation_menu.dart';
import 'package:processed/utils/constants/text_strings.dart';
import 'package:processed/utils/helpers/helper_functions.dart';
import 'package:processed/utils/http/http_client.dart';
import 'package:processed/utils/local_storage/db_helper.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class InspectionController extends GetxController {
  // *** -------------------  Inspection Form Observables ------------------- ***
  // Rx<DateTime> reportDate = DateTime.now().obs;
  // Rx<String> inspectionFor = 'Inspection For'.obs;
  Rx<String> name = 'Name'.obs;
  Rx<String> productValue = 'Select Item Name'.obs;
  Rx<String> referenceTypeValue = 'Select Reference Type*'.obs;
  Rx<String> referenceNameValue = 'Select Reference Name*'.obs;
  // Rx<String> inspectionTypeValue = 'Inspection Type*'.obs;
  Rx<String> inspectionTemplateValue = 'Select Inspection Template*'.obs;
  var filePath = ''.obs;
  final riceColor = "Select Colour".obs;
  RxString lengthImageFilePath = ''.obs;
  RxString riceColourImagePath = ''.obs;
  RxString sortexPercentageImagePath = ''.obs;
  RxString exportQualityImagePath = ''.obs;
  RxString labelContentPath = ''.obs;
  RxString moistureContentImagePath = ''.obs;
  RxString brokenContentImagePath = ''.obs;
  RxString complicanceContentImagePath = ''.obs;
  RxString noOfLayersImagePath = ''.obs;
  RxBool isExportQuality = false.obs;
  RxBool isNutritionalContent = false.obs;
  RxBool isDocument = true.obs;
  RxBool isSystemIntegrated = false.obs;
  RxBool isLoading = false.obs;
  RxBool isNoPlanner = false.obs;
  static RxBool isDraft = true.obs;

  Rx<Uint8List> signature = Uint8List(0).obs;

  RxBool isGallerySelected = true.obs;

  var carouselIndex = 0.obs;
  RxString eventId = ''.obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;

  // *** -------------------  Inspection Form Lists ------------------- ***

  List<String> inspectionTypeList = [
    'Inspection Type',
    'Incoming',
    'Outgoing',
    'Inprocess'
  ];

  late Position myLocation;

  List<String> riceColorOptions = ['Golden', 'White', 'Pearl White', 'Creamy'];

  var referenceNames = <String>[].obs;
  var itemCodeValues = <String>[].obs;
  var inspectionTemplateList = <String>[].obs;

  static Rx<DraftModel> draftModel = DraftModel().obs;

  // *** -------------------  Inspection Form Controllers ------------------- ***

  final inspectionForController = TextEditingController();
  final reportDateController = TextEditingController();
  final batchNoController = TextEditingController();
  final sampleSizeController = TextEditingController();
  final serialNoController = TextEditingController();
  final riceLengthController = TextEditingController();
  final moistureController = TextEditingController();
  final sortexController = TextEditingController();
  final brokenPercentageController = TextEditingController();
  final noOfLayersController = TextEditingController();
  final allowancePercentageController = TextEditingController();
  final documentNameController = TextEditingController();
  final certificatesController = TextEditingController();
  final complianceController = TextEditingController();
  static InspectionController get instance => Get.find();

  final RxList<DraftModel> currentDrafts = <DraftModel>[].obs;

  void setselected(String value) {
    riceColor.value = value;
  }

  void updateCarouselIndex(int index) {
    carouselIndex.value = index;
    update();
  }

  // File? newImage;

  XFile? image;

  final picker = ImagePicker();

  pickImageFromGallery(RxString generalisedFile) async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print('Image picked from gallery');

      try {
        final bytes = await pickedImage.readAsBytes();
        final kb = bytes.length / 1024;
        final mb = kb / 1024;

        if (kDebugMode) {
          print('Original image size: $mb MB');
        }

        // Compressing the image
        final compressedImage = await compressImage(pickedImage);

        generalisedFile.value =
            compressedImage.path; // Update the value with compressed image path
        print('Updated generalisedFile value: ${generalisedFile.value}');
      } catch (e) {
        print('Error compressing image: $e');
      }
    } else {
      print('No image picked from gallery');
    }
  }

  pickImageFromCamera(RxString generalisedFile) async {
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      print('Image picked from gallery');

      try {
        final bytes = await pickedImage.readAsBytes();
        final kb = bytes.length / 1024;
        final mb = kb / 1024;

        if (kDebugMode) {
          print('Original image size: $mb MB');
        }

        // Compressing the image
        final compressedImage = await compressImage(pickedImage);

        generalisedFile.value =
            compressedImage.path; // Update the value with compressed image path
        print('Updated generalisedFile value: ${generalisedFile.value}');
      } catch (e) {
        print('Error compressing image: $e');
      }
    } else {
      print('No image picked from gallery');
    }
  }

  Future<XFile> compressImage(XFile pickedImage) async {
    final dir = await path_provider.getTemporaryDirectory();
    final random = Random().nextInt(100000); // Generate a random number
    final targetPath =
        '${dir.absolute.path}/image_$random.jpg'; // Unique file name
    final result = await FlutterImageCompress.compressAndGetFile(
      pickedImage.path,
      targetPath,
      format: CompressFormat.jpeg, // Use the appropriate format
      minHeight: 300,
      minWidth: 300,
      quality: 90,
    );

    final data = await result!.readAsBytes();
    final newKb = data.length / 1024;
    final newMb = newKb / 1024;

    if (kDebugMode) {
      print('Compressed image size: $newMb MB');
    }

    return result;
  }

  List<String> referenceTypeList = [
    'Select Reference Type',
    'Purchase Receipt',
    'Purchase Invoice',
    'Subcontracting Receipt',
    'Delivery Note',
    'Sales Invoice',
    'Stock Entry',
    'Job Card'
  ];

  void selectReferenceType(String val) {
    referenceTypeValue.value = val;
  }

  /// currently basmati

  Future<void> selectReportDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2024), lastDate: DateTime(2025));

    if (pickedDate != null && pickedDate != reportDateController.text) {
      reportDateController.text = pickedDate.toString();
      controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  // get list of reference names based on the reference type selected from local storage

  Future<void> getReferencesListBasedOnReferenceType(String type) async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();

      final response = await databaseHelper.getReferencesByType(type);

      print('Reference Names for $type - $response');

      List<String> finalData = List<String>.from(response)
          .map((item) => item.replaceAll('[', '').replaceAll(']', ''))
          .toList();

      referenceNames.value = finalData;
    } catch (e) {
      print(e.toString());
    }
  }

  getlocation() async {
    bool serviceEnabled = false;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      //do stuff here
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //stuff
        THelperFunctions.showSnackBar('Location Services Disabled',
            'Please enable location services to continue', Colors.red);

        Get.to(() => const NavigationMenu());
      }
    }
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.checkPermission();

      Get.to(() => const NavigationMenu());
      THelperFunctions.showSnackBar('Location Services Disabled',
          'Please enable location services to continue', Colors.red);
    }
    myLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // THelperFunctions.showSnackBar(
    //     'Great!', 'Thank you providing your location!', Colors.green);
    //position stream?
  }

  Future<String> getDownloadUrl(imagePickedPath) async {
    final response = await uploadFile(File(imagePickedPath.value.toString()));

    Map<String, dynamic> jsonres = jsonDecode(response);

    String fileUrl = jsonres['message']['file_url'];

    print('File URL for $imagePickedPath: $fileUrl');

    return fileUrl;
  }

  Future<String> uploadFile(File file) async {
    try {
      // Create the request headers
      Map<String, String> headers = {
        HttpHeaders.authorizationHeader:
            'token ${THttpHelper.apiKey}:${THttpHelper.apiSecret}',
      };

      // Create the multipart request
      var request = http.MultipartRequest('POST',
          Uri.parse('https://app.prosessed.com/api/method/upload_file'));

      // Attach the file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
        ),
      );

      // Add the headers to the request
      request.headers.addAll(headers);

      // Send the request
      var response = await request.send();

      //get body of response

      var responseData = await response.stream.bytesToString();

      // Check the response status code
      if (response.statusCode == 200) {
        print('File uploaded successfully.');
        print(responseData);
        return responseData;
      } else {
        print('File upload failed with status code: ${response.statusCode}');
        print('Response: ${await response.stream.bytesToString()}');
      }
    } catch (e) {
      print('Error: $e');
    }

    return '';
  }

  Future<void> getParameters(String inspectionTemplateName) async {
    try {
      final response = await THttpHelper.get(
          'api/resource/Inspection Template/$inspectionTemplateName');

      if (response.elementAt(0) == 200) {
        print(
            'Parameters for $inspectionTemplateName are - ${response.elementAt(1)}');
      }
    } catch (e) {
      THelperFunctions.showSnackBar(
          '', 'Please select an Template to continue', Colors.red);
    }
  }

  // get all item names

  Future<List<String>> getAllItems() async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();

      List<String> itemNames = await databaseHelper.getAllItemNames();

      itemCodeValues.value = itemNames;
    } catch (e) {
      print(e.toString());
    }

    return itemCodeValues;
  }

  // getTemplateNamesBasedOnItemName

  Future<List<String>> getAllTemplates() async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();

      List<String> templateNames =
          await databaseHelper.getAllInspectionTemplateNames();

      inspectionTemplateList.value = templateNames;
    } catch (e) {
      print(e.toString());
    }

    return inspectionTemplateList;
  }

  // get template names based on item name

  Future<String> getTemplateByItemName(String itemName) async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();

      final response = await databaseHelper.getTemplateByItemName(itemName);

      inspectionTemplateValue.value = response!;
    } catch (e) {
      print(e.toString());
    }

    return inspectionTemplateValue.value;
  }

  // *** -------------------  Inspection Form Post Request ------------------- ***

  void createInspectionForm() async {
    try {
      isLoading.value = true;

      print('Report Date ${reportDateController.text}');
      print('Reference Type ${referenceTypeValue.value}');
      print('Is System Integrated ${isSystemIntegrated.value}');
      print('Is Document Level ${isDocument.value}');
      print('Document Name ${documentNameController.text}');
      print('Item Code ${productValue.value}');
      print('Batch No ${batchNoController.text}');
      print('Serial No ${serialNoController.text}');
      print('Sample Si ze ${sampleSizeController.text}');
      print('Inspection Template ${inspectionTemplateValue.value}');
      print('Moiusture ${moistureController.text}');
      print('Sortex ${sortexController.text}');
      print('Broken Percentage ${brokenPercentageController.text}');
      print('isExportQuality ${isExportQuality.value}');
      print('No of Layers ${noOfLayersController.text}');
      print('isNutritionalContent ${isNutritionalContent.value}');
      print('Rice Length ${riceLengthController.text}');
      print('Allowance Percentage ${allowancePercentageController.text}');
      print('Rice Color ${riceColor.value}');
      print('Complicance Content ${certificatesController.text}');

      final response = await THttpHelper.post('api/resource/Inspection Form', {
        "event_id": HomeController.instance.isDraft.value
            ? eventId.value
            : HomeController.instance.isNewForm.value
                ? null
                : PlannerController.instance.arguments[4].toString(),

        // "document_name": HomeController.instance.isDraft.value
        //     ? documentNameController.text
        //     : HomeController.instance.isNewForm.value
        //         ? isSystemIntegrated.value == true
        //             ? null
        //             : documentNameController.text
        //         : PlannerController.instance.arguments[8],

        "document_name": HomeController.instance.isDraft.value ||
                HomeController.instance.isNewForm.value
            ? documentNameController.text
            : PlannerController.instance.arguments[8],

        "reference_type": referenceTypeValue.value,

        "reference_name": HomeController.instance.isNewForm.value ||
                HomeController.instance.isDraft.value
            ? referenceNameValue.value == 'Select Reference Name*'
                ? ''
                : referenceNameValue.value
            : PlannerController.instance.arguments[9],

        "item_code": isDocument.value == true
            ? null
            : productValue.value == 'Select Item Name'
                ? ''
                : productValue.value,

        "batch_no": isDocument.value == true
            ? null
            : batchNoController.text == ''
                ? ''
                : batchNoController.text,
        "sample_size": isDocument.value == true
            ? null
            : sampleSizeController.text == ''
                ? ''
                : sampleSizeController.text,
        "serial_no": isDocument.value == true
            ? null
            : serialNoController.text == ''
                ? ''
                : serialNoController.text,
        "report_date": DateFormat("yyyy-MM-dd")
            .parse(reportDateController.text)
            .toString(),

        // "report_date": reportDateController.text,
        // "inspection_type": inspectionTypeValue.value == 'Inspection Type*'
        //     ? ''
        //     : inspectionTypeValue.value,
        "inspection_template":
            inspectionTemplateValue.value == 'Select Inspection Template*'
                ? ''
                : inspectionTemplateValue.value,
        "document_level": HomeController.instance.isNewForm.value ||
                HomeController.instance.isDraft.value
            ? isDocument.value.toString() == "true"
                ? 1
                : 0
            : PlannerController.instance.arguments[6],

        // "system_integrated": HomeController.instance.isNewForm.value ||
        //         HomeController.instance.isDraft.value
        //     ? isSystemIntegrated.value.toString() == "true"
        //         ? 1
        //         : 0
        //     : PlannerController.instance.arguments[7],

        "system_integrated": HomeController.instance.isNewForm.value ||
                HomeController.instance.isDraft.value
            ? 0
            : PlannerController.instance.arguments[7],

        "inspected_by": GetStorage().read('user_email').toString(),

        "location":
            "{\"type\":\"FeatureCollection\",\"features\":[{\"type\":\"Feature\",\"properties\":{},\"geometry\":{\"type\":\"Point\",\"coordinates\":[${long.value}, ${lat.value}]}}]}",

        "sign": 'data:image/png;base64,${base64Encode(signature.value)}',
        "readings": [
          {
            "specification": TTexts.doesExportQuality,
            "reading_value":
                isExportQuality.value.toString() == "true" ? "Yes" : "No",
            "custom_image_1": exportQualityImagePath.isNotEmpty
                ? 'https://app.prosessed.com${await getDownloadUrl(exportQualityImagePath)}'
                : null
          },
          {
            "specification": TTexts.countryNutrition,
            "reading_value":
                isNutritionalContent.value.toString() == "true" ? "Yes" : "No",
            "custom_image_1": labelContentPath.isNotEmpty
                ? 'https://app.prosessed.com${await getDownloadUrl(labelContentPath)}'
                : null
          },
          {
            "specification": TTexts.lengthOfGrain,
            "reading_value": riceLengthController.text.isEmpty
                ? ''
                : riceLengthController.text,
            "custom_image_1": lengthImageFilePath.isNotEmpty
                ? 'https://app.prosessed.com${await getDownloadUrl(lengthImageFilePath)}'
                : null
          },
          {
            "specification": TTexts.moisturePercentage,
            "reading_value":
                moistureController.text.isEmpty ? '' : moistureController.text,
            "custom_image_1": moistureContentImagePath.isNotEmpty
                ? 'https://app.prosessed.com${await getDownloadUrl(moistureContentImagePath)}'
                : null
          },
          {
            "specification": TTexts.sortexPercentage,
            "reading_value":
                sortexController.text.isEmpty ? '' : sortexController.text,
            "custom_image_1": sortexPercentageImagePath.isNotEmpty
                ? 'https://app.prosessed.com${await getDownloadUrl(sortexPercentageImagePath)}'
                : null
          },
          {
            "specification": TTexts.brokenPercentage,
            "reading_value": brokenPercentageController.text.isEmpty
                ? ''
                : brokenPercentageController.text,
            "custom_image_1": brokenContentImagePath.isNotEmpty
                ? 'https://app.prosessed.com${await getDownloadUrl(brokenContentImagePath)}'
                : null
          },
          {
            "specification": TTexts.noOfLayers,
            "reading_value": noOfLayersController.text.isEmpty
                ? ''
                : noOfLayersController.text,
            "custom_image_1": noOfLayersImagePath.isNotEmpty
                ? 'https://app.prosessed.com${await getDownloadUrl(noOfLayersImagePath)}'
                : null
          },
          {
            "specification": TTexts.allowancePercentage,
            "reading_value": allowancePercentageController.text == ''
                ? ''
                : allowancePercentageController.text,
          },
          {
            "specification": TTexts.color,
            "reading_value":
                riceColor.value == 'Select Colour' ? '' : riceColor.value,
            "custom_image_1": riceColourImagePath.isNotEmpty
                ? 'https://app.prosessed.com${await getDownloadUrl(riceColourImagePath)}'
                : null
          },
          {
            "specification": TTexts.certifcates,
            "reading_value": certificatesController.text == ''
                ? ''
                : certificatesController.text,
            "custom_image_1": complicanceContentImagePath.isNotEmpty
                ? 'https://app.prosessed.com${await getDownloadUrl(complicanceContentImagePath)}'
                : null
          }
        ],
        "docstatus": 1,
      });

      if (response.elementAt(0) == 200) {
        print(response.elementAt(1));
        isLoading.value = false;

        resetValues();

        // insert into database;

        Get.to(() => const ThankyouScreen(
              message: 'Great Inspection Form Created !',
              title: 'Hurrah !',
            ));
      } else {
        THelperFunctions.showSnackBar(
            'Oops!', 'Failed to Create Inspection Try Again !', Colors.red);
        Get.off(() => const NavigationMenu());
      }
    } catch (e) {
      THelperFunctions.showSnackBar(
          'Oops!', 'Failed to Create Inspection Try Again !', Colors.red);
      Get.off(() => const NavigationMenu());
      print(e.toString());
    }
  }

  void createDraft() {
    if (reportDateController.text.isEmpty ||
        // inspectionTypeValue.value == 'Inspection Type*' ||
        referenceTypeValue.value == 'Select Reference Type*' ||
        documentNameController.text == '' ||
        inspectionTemplateValue.value == 'Select Inspection Template*') {
      THelperFunctions.showSnackBar(
          'Please fill all the mandatory fields', '', Colors.red);
      return;
    }

    DraftController.to.createDraft(DraftModel(
      eventId: HomeController.instance.isNewForm.value
          ? ''
          : PlannerController.instance.toString(),
      userId: GetStorage().read('user_email').toString(),
      reportDate: reportDateController.text,
      // inspectionType: inspectionTypeValue.value.toString(),
      referenceType: referenceTypeValue.value.toString(),
      isSystemIntegrated: isSystemIntegrated.value == true ? 1 : 0,
      isDocumentLevel: isDocument.value == true ? 1 : 0,
      referenceName: referenceNameValue.value.toString(),
      inspectionTemplate: inspectionTemplateValue.value.toString(),
      itemCode: productValue.value.toString(),
      serialNo: serialNoController.text.toString(),
      batchNo: batchNoController.text.toString(),
      sampleSize: sampleSizeController.text.isEmpty
          ? 0
          : int.parse(sampleSizeController.text),
      documentName: documentNameController.text.toString(),
      moisturePercentage: moistureController.text.isEmpty
          ? 0
          : int.parse(moistureController.text),
      sortexPercentage:
          sortexController.text.isEmpty ? 0 : int.parse(sortexController.text),
      brokenPercentage: brokenPercentageController.text.isEmpty
          ? 0
          : int.parse(brokenPercentageController.text),
      doesExportQuality: isExportQuality.value == true ? 1 : 0,
      noOfLayers: noOfLayersController.value.text.isEmpty
          ? 0
          : int.parse(noOfLayersController.value.text),
      countryNutrition: isNutritionalContent.value == true ? 1 : 0,
      lengthOfGrain: riceLengthController.text.isEmpty
          ? 0
          : int.parse(riceLengthController.text),
      allowancePercentage: allowancePercentageController.text.isEmpty
          ? 0
          : int.parse(allowancePercentageController.text),
      color: riceColor.value.toString(),
      certificate: certificatesController.text.toString(),

      // lengthImageFilePath: lengthImageFilePath.value.toString(),
      // riceColourImagePath: riceColourImagePath.value.toString(),
      // sortexPercentageImagePath: sortexPercentageImagePath.value.toString(),
      // exportQualityImagePath: exportQualityImagePath.value.toString(),
      // labelContentPath: labelContentPath.value.toString(),
      // moistureContentImagePath: moistureContentImagePath.value.toString(),
      // brokenContentImagePath: brokenContentImagePath.value.toString(),
      // complicanceContentImagePath:
      //     complicanceContentImagePath.value.toString()));
    ));
    Get.until((route) => Get.currentRoute == '/NavigationMenu');
  }

  @override
  void onInit() async {
    print('Report Date Controller value - ${reportDateController.text}');

    await getAllItems();
    await getAllTemplates();

    Get.put(DraftController());

    if (HomeController.instance.isDraft.value) {
      int draftId = DraftController.to.currentSelectedDraft.value;

      // Wait for the future to complete and get the actual DraftModel object
      DraftModel draftModel =
          await DraftController.to.getCurrentDraftById(draftId);

      // Set the draftModel to the current draftModel

      draftModel = draftModel;

      reportDateController.text = draftModel.reportDate!;
      print(draftModel.reportDate);
      // inspectionTypeValue.value =
      //     draftModel.inspectionType ?? 'Inspection Type';
      referenceTypeValue.value =
          draftModel.referenceType ?? 'Select Reference Type*';

      referenceNameValue.value =
          draftModel.referenceName ?? 'Select Reference Name*';

      referenceNames.value = await DatabaseHelper()
              .getReferencesByType(referenceTypeValue.value.toString())
          as List<String>;

      inspectionTemplateValue.value =
          draftModel.inspectionTemplate ?? 'Select Inspection Template*';
      isSystemIntegrated.value =
          draftModel.isSystemIntegrated == 1 ? true : false;
      isDocument.value = draftModel.isDocumentLevel == 1 ? true : false;

      moistureController.text = draftModel.moisturePercentage == 0
          ? ''
          : draftModel.moisturePercentage.toString();

      sortexController.text = draftModel.sortexPercentage == 0
          ? ''
          : draftModel.sortexPercentage.toString();
      brokenPercentageController.text = draftModel.brokenPercentage == 0
          ? ''
          : draftModel.brokenPercentage.toString();
      isExportQuality.value = draftModel.doesExportQuality == 1 ? true : false;
      noOfLayersController.text =
          draftModel.noOfLayers == 0 ? '' : draftModel.noOfLayers.toString();
      isNutritionalContent.value =
          draftModel.countryNutrition == 1 ? true : false;
      riceLengthController.text = draftModel.lengthOfGrain == 0
          ? ''
          : draftModel.lengthOfGrain.toString();
      allowancePercentageController.text = draftModel.allowancePercentage == 0
          ? ''
          : draftModel.allowancePercentage.toString();
      certificatesController.text = draftModel.certificate ?? '';
      riceColor.value = draftModel.color ?? 'Select Colour';

      documentNameController.text = draftModel.documentName ?? '';

      // Set the image paths

      // lengthImageFilePath.value = draftModel.lengthImageFilePath ?? '';

      // riceColourImagePath.value = draftModel.riceColourImagePath ?? '';

      // sortexPercentageImagePath.value =
      //     draftModel.sortexPercentageImagePath ?? '';

      // exportQualityImagePath.value = draftModel.exportQualityImagePath ?? '';

      // labelContentPath.value = draftModel.labelContentPath ?? '';

      // moistureContentImagePath.value =
      //     draftModel.moistureContentImagePath ?? '';

      // brokenContentImagePath.value = draftModel.brokenContentImagePath ?? '';

      // complicanceContentImagePath.value =
      //     draftModel.complicanceContentImagePath ?? '';

      noOfLayersController.text =
          draftModel.noOfLayers == 0 ? '' : draftModel.noOfLayers.toString();

      certificatesController.text = draftModel.certificate ?? '';

      // noOfLayersImagePath.value = draftModel.noOfLayersImagePath ?? '';

      lat.value = myLocation.latitude;
      long.value = myLocation.longitude;

      print('Draft ID - $draftId');
      print('Draft Model - ${draftModel.toMap()}');
      print('\n\n');
    }

    await getlocation();

    lat.value = myLocation.latitude;
    long.value = myLocation.longitude;

    print(myLocation.latitude);
    print(myLocation.longitude);

    super.onInit();
  }

  // reset controllers and values

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    // dispose all

    // all imagespath

    resetValues();
  }

  void resetValues() {
    reportDateController.text = DateTime.now().toString();
    name.value = 'Name';
    productValue.value = 'Select Item Name';
    referenceTypeValue.value = 'Select Reference Type*';
    referenceNameValue.value = 'Select Reference Name*';
    // inspectionTypeValue.value = 'Inspection Type';
    inspectionTemplateValue.value = 'Select Inspection Template*';
    // inspectionTemplateName.value = '';
    filePath.value = '';
    riceColor.value = 'Select Colour';
    lengthImageFilePath.value = '';
    riceColourImagePath.value = '';
    sortexPercentageImagePath.value = '';
    exportQualityImagePath.value = '';
    labelContentPath.value = '';
    moistureContentImagePath.value = '';
    brokenContentImagePath.value = '';
    complicanceContentImagePath.value = '';
    noOfLayersImagePath.value = '';
    isExportQuality.value = false;
    isNutritionalContent.value = false;
    isDocument.value = true;
    isSystemIntegrated.value = true;
    isLoading.value = false;

    inspectionForController.clear();
    reportDateController.clear();
    batchNoController.clear();
    sampleSizeController.clear();
    serialNoController.clear();
    riceLengthController.clear();
    moistureController.clear();
    sortexController.clear();
    brokenPercentageController.clear();
    noOfLayersController.clear();
    allowancePercentageController.clear();
    documentNameController.clear();
    certificatesController.clear();
    complianceController.clear();

    referenceNames.clear();
    itemCodeValues.clear();

    inspectionTemplateList.clear();

    update();

    print('Values Reset');
  }
}
