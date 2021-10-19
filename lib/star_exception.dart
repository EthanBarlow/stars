
  enum StarExceptionCode {
    forbidden,
    rateLimitReached,
  }  

class StarException implements Exception {
  final StarExceptionCode code;
  String? message;

  StarException({required this.code, this.message});
}