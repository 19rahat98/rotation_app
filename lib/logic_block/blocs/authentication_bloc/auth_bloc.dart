import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:rotation_app/config/util_preferences.dart';
import 'package:rotation_app/logic_block/api/http_request.dart';
import 'package:rotation_app/logic_block/blocs/authentication_bloc/bloc.dart';
import 'package:rotation_app/logic_block/models/user_model.dart';
import 'package:rotation_app/logic_block/repository/login_repository.dart';

class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthBloc() : super(InitialAuthenticationState());
  final UserRepository userRepository = UserRepository();

  @override
  Stream<AuthenticationState> mapEventToState(event) async* {
    if (event is OnAuthCheck) {
      ///Notify state AuthenticationBeginCheck
      yield AuthenticationBeginCheck();
      final hasUser = userRepository.getUserToken();

      if (hasUser != null) {

        ///Set token network
        httpManager.baseOptions.headers["Authorization"] =
            "Bearer " + hasUser;

        yield AuthenticationSuccess();

      } else {
        ///Notify loading to UI
        yield AuthenticationFail();
      }
    }

    if (event is OnSaveUser) {
      ///Save to Storage user via repository
      final savePreferences = await userRepository.saveUser(userToken: event.userToken);

      ///Check result save user
      if (savePreferences) {
        ///Set token network
        httpManager.baseOptions.headers["Authorization"] =
            "Bearer " + event.userToken;

        ///Notify loading to UI
        yield AuthenticationSuccess();
      } else {
        final String message = "Cannot save user data to storage phone";
        throw Exception(message);
      }
    }

    if (event is OnClear) {
      ///Delete user
      final deletePreferences = await userRepository.deleteUser();

      ///Clear token httpManager
      httpManager.baseOptions.headers = {};

      ///Check result delete user
      if (deletePreferences) {
        yield AuthenticationFail();
      } else {
        final String message = "Cannot delete user data to storage phone";
        throw Exception(message);
      }
    }
  }
}
