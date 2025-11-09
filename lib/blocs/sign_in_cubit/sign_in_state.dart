import 'package:crud_api/core/responses/validation_response.dart';
import 'package:crud_api/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {

}

class SignInInitial extends SignInState {
  @override
  List<Object?> get props => [];

}

class SignInLoading extends SignInState {
  @override
  List<Object?> get props => [];
}

class SignInSuccess extends SignInState {
  final UserModel userModel;
  SignInSuccess({required this.userModel});
  @override
  List<Object?> get props => [userModel];
}

class SignInValidationError extends SignInState {
  final ValidationResponse validationResponse;
  SignInValidationError({required this.validationResponse});
  String? getError(String key) {
    return validationResponse.getError(key);
  }
  @override
  List<Object?> get props => [validationResponse];
}

class SignInFailed extends SignInState {
  List<Object?> get props => [];
}
