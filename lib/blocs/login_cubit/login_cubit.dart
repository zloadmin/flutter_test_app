import 'package:crud_api/blocs/login_cubit/login_state.dart';
import 'package:crud_api/clients/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/exceptions/validation_exception.dart';
import '../../models/user_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void submit(String email, String password) async {
    if (state is LoginLoading) {
      print('skip double click');
      return;
    }
    emit(LoginLoading());
    try {
      UserModel userModel = await ApiClient().signIn(email, password);
      print('LoginSuccess state');
      emit(LoginSuccess(userModel: userModel));
    } on ValidationException catch (e) {
      print('LoginValidationError state');
      emit(LoginValidationError(validationResponse: e.response));
    } on Exception catch (e) {
      print('LoginFailed state');
      emit(LoginFailed());
    }
  }
}
