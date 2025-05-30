class EditPasswordRequest {
  String oldPassword;
  String newPassword;
  String confirmPassword;

  EditPasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmNewPassword': confirmPassword,
    };
  }
}
