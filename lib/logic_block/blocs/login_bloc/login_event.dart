abstract class LoginEvent {}

class OnLoginByPhoneNumber extends LoginEvent {
  final String phoneNumber;

  OnLoginByPhoneNumber({this.phoneNumber});
}

class OnLogin extends LoginEvent{
  final String code;

  OnLogin({this.code});
}

class OnLogout extends LoginEvent {
  OnLogout();
}
