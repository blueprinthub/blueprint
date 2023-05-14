import 'package:authentication_repository/src/constants/constants.dart';
import 'package:authentication_repository/src/exceptions/exceptions.dart';

class UserNotFoundException extends SignInException
    implements ResetPasswordException {
  UserNotFoundException([String? message])
      : super(message ?? ErrorMessages.userNotFound);
}