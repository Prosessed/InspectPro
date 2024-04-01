class CompletedInspection {
  String? userId;
  int? completedId;
  String? inspectionName;
  String? companyName;
  String? reportDateCompleted;
  String? documentName;
  String? eventId;
  String? inspectionTemplateName;
  String? completedItemName;
  String? completedReportUrl;

  CompletedInspection(
      {this.completedId,
      this.inspectionName,
      this.companyName,
      this.reportDateCompleted,
      this.eventId,
      this.inspectionTemplateName,
      this.completedItemName,
      this.completedReportUrl,
      this.userId});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'completedId': completedId,
      'inspectionName': inspectionName,
      'companyName': companyName,
      'reportDateCompleted': reportDateCompleted,
      'eventId': eventId,
      'inspectionTemplateName': inspectionTemplateName,
      'completedItemName': completedItemName,
      'completedReportUrl': completedReportUrl,
    };
  }

  CompletedInspection.fromMap(Map<String, dynamic> map) {
    userId = map['userId'];
    completedId = map['completedId'];
    inspectionName = map['inspectionName'];
    companyName = map['companyName'];
    reportDateCompleted = map['reportDateCompleted'];
    eventId = map['eventId'];
    inspectionTemplateName = map['inspectionTemplateName'];
    completedItemName = map['completedItemName'];
    completedReportUrl = map['completedReportUrl'];
  }
}
