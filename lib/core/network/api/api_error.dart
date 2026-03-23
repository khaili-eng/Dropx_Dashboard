class ApiError {
  final String message;
  final int? statusCode;
  final Map<String, List<String>>? errors;

  ApiError({
    required this.message,
    this.statusCode,
    this.errors,
  });
  //from json
  factory ApiError.fromJson(Map<String, dynamic> json, int statusCode) {
    return ApiError(
      message: json['message'] ?? 'Unknown error',
      statusCode: statusCode,
      errors: json['errors'] != null
          ? Map<String, List<String>>.from(
        json['errors'].map(
              (key, value) => MapEntry(
            key,
            List<String>.from(value),
          ),
        ),
      )
          : null,
    );
  }
  String? getFieldError(String field) {
    if (errors != null && errors![field] != null) {
      return errors![field]!.first;
    }
    return null;
  }

  @override
  String toString() {
    return message;
  }
}