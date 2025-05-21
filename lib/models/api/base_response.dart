class BaseResponse {
  final bool success;
  final String? error;

  BaseResponse({required this.success, this.error});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      success: json['success'] ?? false,
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() => {'success': success, 'error': error};
}
