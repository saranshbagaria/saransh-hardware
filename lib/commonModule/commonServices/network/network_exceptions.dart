class NetworkException implements Exception {
  final String? _message;
  final String _prefix;

  NetworkException([this._message, this._prefix = '']);

  String? getMessage() {
    return _message;
  }

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends NetworkException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends NetworkException {
  BadRequestException([String? message])
      : super(message, "Invalid Request. Try again. ");
}

class UnknownException extends NetworkException {
  UnknownException([String? message]) : super(message, "Unknown Exception. ");
}

class UnauthorisedException extends NetworkException {
  UnauthorisedException([String? message])
      : super(message, "Unauthorised request. Try again. ");
}

class InvalidInputException extends NetworkException {
  InvalidInputException([String? message])
      : super(message, "Invalid Input. Try again. ");
}