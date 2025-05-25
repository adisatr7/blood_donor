class LoginRequest {
  String? nik;
  String? password;

  LoginRequest({this.nik, this.password});

  LoginRequest.fromMap(Map<String, dynamic> map) {
    nik = map['nik'];
    password = map['password'];
  }

  Map<String, dynamic> toMap() {
    return {'nik': nik, 'password': password};
  }
}
