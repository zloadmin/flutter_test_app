import 'package:crud_api/blocs/sign_in_cubit/sign_in_state.dart';
import 'package:crud_api/clients/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/exceptions/validation_exception.dart';
import '../../models/user_model.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  void submit(String email, String password) async {
    if (state is SignInLoading) {
      print('skip double click');
      return;
    }
    emit(SignInLoading());
    try {
      UserModel userModel = await ApiClient().signIn(email, password);
      print('SignInSuccess state');
      emit(SignInSuccess(userModel: userModel));
    } on ValidationException catch (e) {
      print('SignInValidationError state');
      emit(SignInValidationError(validationResponse: e.response));
    } on Exception catch (e) {
      print('SignInFailed state');
      emit(SignInFailed());
    }
  }
}
