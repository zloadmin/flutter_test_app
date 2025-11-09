import 'package:crud_api/core/responses/validation_response.dart';
import 'package:crud_api/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {

}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];

}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  final UserModel userModel;
  LoginSuccess({required this.userModel});
  @override
  List<Object?> get props => [userModel];
}

class LoginValidationError extends LoginState {
  final ValidationResponse validationResponse;
  LoginValidationError({required this.validationResponse});
  String? getError(String key) {
    return validationResponse.getError(key);
  }
  @override
  List<Object?> get props => [validationResponse];
}

class LoginFailed extends LoginState {
  List<Object?> get props => [];
}
