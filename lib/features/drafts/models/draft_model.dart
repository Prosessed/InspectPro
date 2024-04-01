class DraftModel {
  // all basic details
  int? draftId;
  String? userId;
  String? eventId;
  String? reportDate;
  String? inspectionType;
  String? referenceType;
  int? isSystemIntegrated;
  int? isDocumentLevel;
  String? referenceName;
  String? inspectionTemplate;
  String? itemCode;
  String? serialNo;
  String? batchNo;
  int? sampleSize;
  String? documentName;

  // all reading values
  int? moisturePercentage;
  int? sortexPercentage;
  int? brokenPercentage;
  int? doesExportQuality;
  int? noOfLayers;
  int? countryNutrition;
  int? lengthOfGrain;
  int? allowancePercentage;
  String? color;
  String? certificate;

//   {
//    "draftId":null,
//    "eventId":01695dce0b,
//    "reportDate":2024-03-20,
//    "inspectionType":"Outgoing",
//    "referenceType":"Delivery Note",
//    "isSystemIntegrated":1,
//    "isDocumentLevel":1,
//    "referenceName":MAT-DN-2024-00002,
//    "inspectionTemplate":"Basmati Rice",
//    "itemCode":"Select Item Code",
//    "serialNo":,
//    "batchNo":,
//    "sampleSize":0,
//    "documentName":,
//    "moisturePercentage":12,
//    "sortexPercentage":124,
//    "brokenPercentage":33,
//    "doesExportQuality":0,
//    "noOfLayers":0,
//    "countryNutrition":0,
//    "lengthOfGrain":,
//    "allowancePercentage":,
//    "color":"Select Rice Colour",
//    "certificate":,
//    "lengthImageFilePath":,
//    "riceColourImagePath":,
//    "sortexPercentageImagePath":,
//    "exportQualityImagePath":,
//    "labelContentPath":,
//    "moistureContentImagePath":,
//    "brokenContentImagePath":,
//    "complicanceContentImagePath":
// }

  // all uploaded images

  String? lengthImageFilePath;
  String? riceColourImagePath;
  String? sortexPercentageImagePath;
  String? exportQualityImagePath;
  String? labelContentPath;
  String? moistureContentImagePath;
  String? brokenContentImagePath;
  String? complicanceContentImagePath;
  String? noOfLayersImagePath;

  // all images

  DraftModel(
      {this.userId,
      this.draftId,
      this.eventId,
      this.reportDate,
      this.inspectionType,
      this.referenceType,
      this.isSystemIntegrated,
      this.isDocumentLevel,
      this.referenceName,
      this.inspectionTemplate,
      this.itemCode,
      this.serialNo,
      this.batchNo,
      this.sampleSize,
      this.documentName,
      this.moisturePercentage,
      this.sortexPercentage,
      this.brokenPercentage,
      this.doesExportQuality,
      this.noOfLayers,
      this.countryNutrition,
      this.lengthOfGrain,
      this.allowancePercentage,
      this.color,
      this.certificate,
      this.lengthImageFilePath,
      this.riceColourImagePath,
      this.sortexPercentageImagePath,
      this.exportQualityImagePath,
      this.labelContentPath,
      this.moistureContentImagePath,
      this.brokenContentImagePath,
      this.complicanceContentImagePath,
      this.noOfLayersImagePath});

  DraftModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    draftId = json['draftId'];
    eventId = json['eventId'];
    reportDate = json['reportDate'];
    inspectionType = json['inspectionType'];
    referenceType = json['referenceType'];
    isSystemIntegrated = json['isSystemIntegrated'];
    isDocumentLevel = json['isDocumentLevel'];
    referenceName = json['referenceName'];
    inspectionTemplate = json['inspectionTemplate'];
    itemCode = json['itemCode'];
    serialNo = json['serialNo'];
    batchNo = json['batchNo'];
    sampleSize = json['sampleSize'];
    documentName = json['documentName'];
    moisturePercentage = json['moisturePercentage'];
    sortexPercentage = json['sortexPercentage'];
    brokenPercentage = json['brokenPercentage'];
    doesExportQuality = json['doesExportQuality'];
    noOfLayers = json['noOfLayers'];
    countryNutrition = json['countryNutrition'];
    lengthOfGrain = json['lengthOfGrain'];
    allowancePercentage = json['allowancePercentage'];
    color = json['color'];
    certificate = json['certificate'];
    lengthImageFilePath = json['lengthImageFilePath'];
    riceColourImagePath = json['riceColourImagePath'];
    sortexPercentageImagePath = json['sortexPercentageImagePath'];
    exportQualityImagePath = json['exportQualityImagePath'];
    labelContentPath = json['labelContentPath'];
    moistureContentImagePath = json['moistureContentImagePath'];
    brokenContentImagePath = json['brokenContentImagePath'];
    complicanceContentImagePath = json['complicanceContentImagePath'];
    noOfLayersImagePath = json['noOfLayersImagePath'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['draftId'] = draftId;
    data['eventId'] = eventId;
    data['reportDate'] = reportDate;
    data['inspectionType'] = inspectionType;
    data['referenceType'] = referenceType;
    data['isSystemIntegrated'] = isSystemIntegrated;
    data['isDocumentLevel'] = isDocumentLevel;
    data['referenceName'] = referenceName;
    data['inspectionTemplate'] = inspectionTemplate;
    data['itemCode'] = itemCode;
    data['serialNo'] = serialNo;
    data['batchNo'] = batchNo;
    data['sampleSize'] = sampleSize;
    data['documentName'] = documentName;
    data['moisturePercentage'] = moisturePercentage;
    data['sortexPercentage'] = sortexPercentage;
    data['brokenPercentage'] = brokenPercentage;
    data['doesExportQuality'] = doesExportQuality;
    data['noOfLayers'] = noOfLayers;
    data['countryNutrition'] = countryNutrition;
    data['lengthOfGrain'] = lengthOfGrain;
    data['allowancePercentage'] = allowancePercentage;
    data['color'] = color;
    data['certificate'] = certificate;
    data['lengthImageFilePath'] = lengthImageFilePath;
    data['riceColourImagePath'] = riceColourImagePath;
    data['sortexPercentageImagePath'] = sortexPercentageImagePath;
    data['exportQualityImagePath'] = exportQualityImagePath;
    data['labelContentPath'] = labelContentPath;
    data['moistureContentImagePath'] = moistureContentImagePath;
    data['brokenContentImagePath'] = brokenContentImagePath;
    data['complicanceContentImagePath'] = complicanceContentImagePath;
    data['noOfLayersImagePath'] = noOfLayersImagePath;
    return data;
  }
}
