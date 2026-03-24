class CommissionModel {
  final String type;
  final int value;

  CommissionModel({required this.type, required this.value});

  factory CommissionModel.fromJson(Map<String, dynamic> json) {
    return CommissionModel(type: json['type'], value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {"type": type, "value": value};
  }
}
