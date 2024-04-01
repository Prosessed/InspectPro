class ReferenceModel {
  final String type;
  final List<dynamic> data;

  ReferenceModel({required this.type, required this.data});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'data': data.toString(), // Convert list to string for simplicity
    };
  }

  factory ReferenceModel.fromMap(Map<String, dynamic> map) {
    return ReferenceModel(
      type: map['type'],
      data: map['data'].toString().split(',').map((e) => e.trim()).toList(),
    );
  }
}
