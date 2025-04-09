import 'package:blood_donor/enums/province.dart';

class User {
  final int id;
  final String nik;
  final String name;
  final String email;
  final String password;
  final DateTime birthDate;
  final String gender;
  final String job;
  final int weightKg;
  final int heightCm;
  final String bloodType;

  final String address;
  final int rt;
  final int rw;
  final String village;
  final String district;
  final String city;
  final Province? province;

  User({
    this.id = 0,
    required this.nik,
    required this.name,
    required this.email,
    required this.password,
    required this.birthDate,
    this.gender = '',
    this.job = '',
    this.weightKg = 0,
    this.heightCm = 0,
    this.bloodType = '',
    this.address = '',
    this.rt = 0,
    this.rw = 0,
    this.village = '',
    this.district = '',
    this.city = '',
    this.province,
  }) {
    if (!RegExp(r'^[0-9]{16}$').hasMatch(nik)) {
      throw ArgumentError('Invalid NIK format');
    }

    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      throw ArgumentError('Invalid email format');
    }

    if (birthDate.isAfter(DateTime.now())) {
      throw ArgumentError('Birth date cannot be in the future');
    }
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      nik: map['nik'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      birthDate: map['birthDate'] as DateTime,
      gender: map['gender'] as String,
      job: map['job'] as String,
      weightKg: map['weightKg'] as int,
      heightCm: map['heightCm'] as int,
      bloodType: map['bloodType'] as String,
      address: map['address'] as String,
      rt: map['rt'] as int,
      rw: map['rw'] as int,
      village: map['village'] as String,
      district: map['district'] as String,
      city: map['city'] as String,
      province: map['province'] as Province,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nik': nik,
      'name': name,
      'email': email,
      'password': password,
      'birthDate': birthDate,
      'gender': gender,
      'job': job,
      'weightKg': weightKg,
      'heightCm': heightCm,
      'bloodType': bloodType,
      'address': address,
      'rt': rt,
      'rw': rw,
      'village': village,
      'district': district,
      'city': city,
      'province': province,
    };
  }
}