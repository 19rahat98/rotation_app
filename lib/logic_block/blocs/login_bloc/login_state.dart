import 'package:meta/meta.dart';

@immutable
abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoginLoading extends LoginState {}

class SendSmsCode extends LoginState{}

class LoginFail extends LoginState {
  final String code;

  LoginFail(this.code);
}

class EmployeeNotFound extends LoginState{}

class EmployeeDismissed extends LoginState{}

class TooManyRequest extends LoginState{
  final String message;

  TooManyRequest(this.message);
}

class LoginSuccess extends LoginState {}

class LogoutLoading extends LoginState {}

class LogoutFail extends LoginState {
  final String message;

  LogoutFail(this.message);
}

class LogoutSuccess extends LoginState {}
