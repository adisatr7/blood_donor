import 'package:blood_donor/models/api/base_response.dart';

class SignupResponse extends BaseResponse {
  final int userId;

  SignupResponse({required this.userId, required super.success, super.error});

  factory SignupResponse.fromMap(Map<String, dynamic> map) {
    return SignupResponse(
      success: map['success'] as bool,
      userId: map['userId'] as int,
      error: map['error'] as String?,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {'userId': userId, 'success': success, 'error': error};
  }
}
