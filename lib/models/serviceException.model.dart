class ServiceException {
  final String code;
  final String message;

  ServiceException({this.code, this.message});

  @override
  String toString() {
    return "code: $code, message: $message";
  }
}
