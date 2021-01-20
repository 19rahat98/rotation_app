import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rotation_app/logic_block/blocs/bloc.dart';
import 'package:rotation_app/logic_block/models/result_api_model.dart';
import 'package:rotation_app/logic_block/models/user_model.dart';
import 'package:rotation_app/logic_block/repository/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState());
  final UserRepository userRepository = UserRepository();

  @override
  Stream<LoginState> mapEventToState(event) async* {
    ///Event for login
    if (event is OnLoginByPhoneNumber) {
      ///Notify loading to UI
      yield LoginLoading();

      ///Fetch API via repository
      final ResponseApi result = await userRepository.sendCodeLogin(phoneNumber: event.phoneNumber, type: "test");
      final ResultApiModel decodeData = ResultApiModel.fromJson(result.data);

      if(result.code == 200){
        yield LoginSuccess();
      }
      if(result.code == 400){
        print(decodeData.slug);
        if(decodeData.slug == "employee_dismissed"){
          print('yield EmployeeDismissed');
          yield EmployeeDismissed();
        }
        if(decodeData.slug == "employee_not_found"){
          print('yield EmployeeNotFound');
          yield EmployeeNotFound();
        }
      }
      if(result.code == 429){
        yield TooManyRequest(decodeData.message);
      }
      else {
        ///Notify loading to UI
        yield LoginFail(result.code.toString());
      }
    }

    ///Event for logout
    if (event is OnLogout) {
      yield LogoutLoading();
      try {
        ///Begin start AuthBloc Event OnProcessLogout
        AuthBloc().add(OnClear());

        ///Notify loading to UI
        yield LogoutSuccess();
      } catch (error) {
        ///Notify loading to UI
        yield LogoutFail(error.toString());
      }
    }
  }
}
