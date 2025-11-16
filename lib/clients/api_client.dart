import 'package:crud_api/core/responses/validation_response.dart';
import 'package:crud_api/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crud_api/core/exceptions/validation_exception.dart';

class ApiClient {
  final String _url = 'http://127.0.0.1:8000/api/v1/';
  final Map<String, String> _headers = {'Accept': 'application/json'};

  Future<http.Response> _sendPostRequest(String path, Object? body) async {
    print('sendPostRequest request to ${Uri.parse(_url + path)}');
    print('sendPostRequest body ${body.toString()}');
    return await http.post(
      Uri.parse(_url + path),
      body: body,
      headers: _headers,
    );
  }

  Future<UserModel> signIn(String email, String password) async {

    final response = await _sendPostRequest('auth/sign-in', {
      'email': email,
      'password': password,
    });

    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

    switch (response.statusCode) {
      case 200:
        return UserModel.fromJson(jsonResponse);
      case 422:
        throw ValidationException.fromJson(jsonResponse);
      default:
        throw Exception(response.reasonPhrase);
    }
  }
  Future<UserModel> signUp(String name, String email, String password, String passwordConfirmation) async {

    final response = await _sendPostRequest('auth/sign-up', {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });

    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

    switch (response.statusCode) {
      case 200:
        return UserModel.fromJson(jsonResponse);
      case 422:
        throw ValidationException.fromJson(jsonResponse);
      default:
        throw Exception();
    }
  }
}
