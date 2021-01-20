import 'package:rotation_app/logic_block/models/user_model.dart';

abstract class AuthenticationEvent {}

class OnAuthCheck extends AuthenticationEvent {}

class OnSaveUser extends AuthenticationEvent {
  final String userToken;

  OnSaveUser(this.userToken);
}

class OnClear extends AuthenticationEvent {}
