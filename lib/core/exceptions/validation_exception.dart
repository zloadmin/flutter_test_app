import 'package:crud_api/core/responses/validation_response.dart';

class ValidationException implements Exception {
  ValidationResponse response;

  ValidationException({required this.response});
  ValidationException.fromJson(Map<String, dynamic> json) : response = ValidationResponse.fromJson(json);
}
