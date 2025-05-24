import 'package:blood_donor/models/api/base_response.dart';

class SignupResponse extends BaseResponse {
  final int userId;

  SignupResponse({required this.userId, required super.success, super.error});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      success: json['success'] as bool,
      userId: json['userId'] as int,
      error: json['error'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'success': success, 'error': error};
  }
}
