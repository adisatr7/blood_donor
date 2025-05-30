import 'package:blood_donor/models/api/base_response.dart';

class LoginResponse extends BaseResponse {
  final String token;

  LoginResponse({required super.success, required this.token, super.error});

  factory LoginResponse.fromMap(Map<String, dynamic> map) => LoginResponse(
    success: map['success'] as bool,
    token: map['token'] as String,
    error: map['error'] as String?,
  );

  @override
  Map<String, dynamic> toMap() => {
    'token': token,
    'success': success,
    'error': error,
  };
}
