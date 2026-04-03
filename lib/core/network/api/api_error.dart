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
    Map<String, List<String>>? extractedErrors;

    if (json['errors'] != null) {
      extractedErrors = Map<String, List<String>>.from(
        json['errors'].map(
              (key, value) => MapEntry(
            key,
            List<String>.from(value),
          ),
        ),
      );
    }

    return ApiError(
      message: json['message'] ?? 'Unknown error',
      statusCode: statusCode,
      errors: extractedErrors,
    );
  }
  String? getFieldError(String field) {
    if (errors != null && errors!.containsKey(field)) {
      return errors![field]!.isNotEmpty ? errors![field]!.first : null;
    }
    return null;
  }
  bool get isValidationError {
    return errors != null && errors!.isNotEmpty;
  }

  @override
  String toString() {
    return message;
  }
}