abstract class AppException implements Exception {
  final String message;
  AppException(this.message);
}

class NoResponseBody implements AppException {
  @override
  String get message => 'No response body';
}

class RequestError implements AppException {
  final String _message;
  RequestError(this._message);
  @override
  String get message => _message;
}

class UserAlreadyExistException implements AppException {
  @override
  String get message => 'User already exists in Database';
}

class UserDoesNotExistException implements AppException {
  @override
  String get message => 'User does not exists. Sign up first.';
}
class UnauthorizedException implements AppException {
  @override
  String get message => 'Unauthorized';
}

class CustomException implements AppException {
  final String? _message;
  CustomException([this._message]);
  @override
  String get message => _message ?? "Something went wrong!";
}

class ApiException implements AppException {
  final String? errorCode;
  ApiException([this.errorCode]);
  @override
  String get message {

    switch (errorCode) {
      case 'USER_NOT_FOUND':
        return 'Given user is not found.';
      default:
        return 'Unknown error occured';
    }
  }
}
