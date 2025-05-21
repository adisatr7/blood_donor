class LoginRequest {
  String? nik;
  String? password;

  LoginRequest({this.nik, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    nik = json['nik'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {'nik': nik, 'password': password};
  }
}
