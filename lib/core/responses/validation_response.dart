import 'package:equatable/equatable.dart';

class ValidationResponse extends Equatable {
  final String message;
  final Map<String, List<String>> errors;

  factory ValidationResponse.fromJson(Map<String, dynamic> json) {
    Map<String, List<String>> errorsList = {};
    (json['errors']).forEach((key, value) {
      errorsList[key] = List<String>.from(value as List);
    });
    return ValidationResponse(
      message: json['message'] as String,
      errors: errorsList,
    );
  }

  const ValidationResponse({required this.message, required this.errors});

  String? getError(String key) {
    return errors.containsKey(key) ? errors[key]?.first : null;
  }

  @override
  List<Object?> get props => [message, errors];
}
