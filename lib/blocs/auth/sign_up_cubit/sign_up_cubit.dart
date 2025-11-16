

import 'package:crud_api/blocs/form/cubit_form_state.dart';
import 'package:crud_api/clients/api_client.dart';
import 'package:crud_api/core/exceptions/validation_exception.dart';
import 'package:crud_api/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignUpCubit extends Cubit<CubitFormState> {
  SignUpCubit() : super(FormInitialState());

  void submit(String name, String email, String password, String passwordConfirmation) async {
    if (state is FormLoadingState) {
      print('skip double click');
      return;
    }
    emit(FormLoadingState());
    try {
      UserModel userModel = await ApiClient().signUp(name, email, password, passwordConfirmation);
      print('SignUpSuccess state');
      emit(FormSuccessState(model: userModel));
    } on ValidationException catch (e) {
      print('SignUpValidationError state');
      emit(FormValidationState(validationResponse: e.response));
    } on Exception catch (e) {
      print('SignUpFailed state');
      emit(FormFailedState());
    }
  }
}
