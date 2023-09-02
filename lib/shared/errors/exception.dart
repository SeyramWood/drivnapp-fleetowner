class CustomException implements Exception {
  final String message;
  final int statusCode;

  CustomException(this.message, {this.statusCode = 500});

  @override
  String toString() {
    return 'CustomException: $message (Status Code: $statusCode)';
  }
}