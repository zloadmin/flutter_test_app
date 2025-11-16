
import 'package:crud_api/blocs/form/cubit_form_state.dart';
import 'package:crud_api/clients/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud_api/core/exceptions/validation_exception.dart';
import 'package:crud_api/models/user_model.dart';

class SignInCubit extends Cubit<CubitFormState> {
  SignInCubit() : super(FormInitialState());

  void submit(String email, String password) async {
    if (state is FormLoadingState) {
      print('skip double click');
      return;
    }
    emit(FormLoadingState());
    try {
      UserModel userModel = await ApiClient().signIn(email, password);
      print('SignInSuccess state');
      emit(FormSuccessState(model: userModel));
    } on ValidationException catch (e) {
      print('SignInValidationError state');
      emit(FormValidationState(validationResponse: e.response));
    } on Exception catch (e) {
      print('SignInFailed state');
      emit(FormFailedState(errorMessage: e.toString()));
    }
  }
}
