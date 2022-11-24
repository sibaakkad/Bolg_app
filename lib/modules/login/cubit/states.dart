import 'package:news_app/models/reset_password_model.dart';

import '../../../models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class ResetPasswordLoadingState extends LoginStates {}

class ResetPasswordSuccessState extends LoginStates {
  final ResetPasswordModel resetPasswordModel;

  ResetPasswordSuccessState(this.resetPasswordModel);
}

class ResetPasswordErrorState extends LoginStates {
  final String error;

  ResetPasswordErrorState(this.error);
}

class ChangePasswordVisibilityState extends LoginStates {}
