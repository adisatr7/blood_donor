class BaseResponse {
  final bool success;
  final String? error;

  BaseResponse({required this.success, this.error});

  factory BaseResponse.fromMap(Map<String, dynamic> map) {
    return BaseResponse(
      success: map['success'] ?? false,
      error: map['error'],
    );
  }

  Map<String, dynamic> toMap() => {'success': success, 'error': error};
}
