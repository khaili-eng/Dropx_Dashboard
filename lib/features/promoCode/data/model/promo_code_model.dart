class PromoCodeModel {
  final int? id;
  final String? code;

  PromoCodeModel({this.id, this.code});

  PromoCodeModel copyWith({int? id, String? code}) {
    return PromoCodeModel(
      id: id ?? this.id,
      code: code ?? this.code,
    );
  }

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) {
    return PromoCodeModel(
      id: json['id'],
      code: json['code'],
    );
  }
}