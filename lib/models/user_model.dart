import 'package:crud_api/models/model.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Model {
  final int id;
  final String email;

  UserModel({required this.id, required this.email});

  // Factory constructor to create a User object from a JSON Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'] as int, email: json['email'] as String);
  }

  // // Method to convert a User object back to a JSON Map
  // Map<String, dynamic> toJson() {
  //   return {'id': id, 'name': name};
  // }

  @override
  List<Object?> get props => [id, email];
}
