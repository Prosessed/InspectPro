class ItemModel {
  final String itemName;
  final String? templateName;

  ItemModel({
    required this.itemName,
    required this.templateName,
  });

  Map<String, dynamic> toMap() {
    return {
      'item_name': itemName,
      'template_name': templateName,
      // Convert list to string for simplicity
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      itemName: map['item_name'],
      templateName: map['template_name'],
    );
  }
}
