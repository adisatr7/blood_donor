import 'package:blood_donor/models/api/base_response.dart';

class LoginResponse extends BaseResponse {
  final String token;

  LoginResponse({required super.success, required this.token, super.error});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json['success'] as bool,
    token: json['token'] as String,
    error: json['error'] as String?,
  );

  @override
  Map<String, dynamic> toJson() => {
    'token': token,
    'success': success,
    'error': error,
  };
}
