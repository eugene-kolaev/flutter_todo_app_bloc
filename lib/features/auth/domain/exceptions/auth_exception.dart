sealed class AuthException implements Exception {
  final String message;

  const AuthException(this.message);
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException() : super('Неверный email или пароль');
}

class EmailAlreadyInUseException extends AuthException {
  const EmailAlreadyInUseException() : super('Этот email уже используется');
}

class WeakPasswordException extends AuthException {
  const WeakPasswordException()
    : super('Пароль слишком простой. Минимум 6 символов');
}

class InvalidEmailException extends AuthException {
  const InvalidEmailException() : super('Некорректный email');
}

class UserNotFoundException extends AuthException {
  const UserNotFoundException() : super('Пользователь не найден');
}

class TooManyRequestsException extends AuthException {
  const TooManyRequestsException()
    : super('Слишком много неуспешных попыток. Попробуйте позже');
}

class OperationCancelledException extends AuthException {
  const OperationCancelledException() : super('Операция отменена');
}

class UnknownAuthException extends AuthException {
  const UnknownAuthException(super.message);
}
