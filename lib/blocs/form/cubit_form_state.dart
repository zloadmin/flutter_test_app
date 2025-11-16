import 'package:crud_api/core/responses/validation_response.dart';
import 'package:crud_api/models/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class CubitFormState extends Equatable {
  String getFailedError() {
    return this is FormFailedState ? (this as FormFailedState).getErrorMessage() : '';
  }
  String? getError(String key) {
    if(this is FormValidationState) {
      return (this as FormValidationState).getFieldError(key);
    }
    return null;
  }
  bool isLoading() {
    return this is FormLoadingState;
  }
}

class FormInitialState extends CubitFormState {
  @override
  List<Object?> get props => [];
}

class FormLoadingState extends CubitFormState {
  @override
  List<Object?> get props => [];
}

class FormSuccessState extends CubitFormState {
  final Model model;

  FormSuccessState({required this.model});

  @override
  List<Object?> get props => [model];
}

class FormValidationState extends CubitFormState {
  final ValidationResponse validationResponse;

  FormValidationState({required this.validationResponse});

  String? getFieldError(String key) {
    return validationResponse.getError(key);
  }

  @override
  List<Object?> get props => [validationResponse];
}

class FormFailedState extends CubitFormState {
  final String errorMessage;

  FormFailedState({this.errorMessage = 'Server Error'});
  @override
  List<Object?> get props => [];

  String getErrorMessage() {
    return kDebugMode ? errorMessage : 'Server Error';
  }
}
