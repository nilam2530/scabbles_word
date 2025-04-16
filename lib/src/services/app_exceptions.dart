class AppException implements Exception {
  String title;
  String body;

  AppException({required this.title, required this.body});

  String toErrorMes() {
    return "$title : $body";
  }
}

class FetchDataException extends AppException {
  FetchDataException({required super.body})
      : super(title: "Error During Communication");
}

class BadRequestException extends AppException {
  BadRequestException({required super.body}) : super(title: "Invalid Request");
}

class UnauthorisedException extends AppException {
  UnauthorisedException({required super.body}) : super(title: "Unauthorised");
}

class InvalidInputException extends AppException {
  InvalidInputException({required super.body}) : super(title: "Invalid Input");
}
