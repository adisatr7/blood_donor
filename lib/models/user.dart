import 'package:blood_donor/constants/province.dart';

class User {
  final int id;
  final String nik;
  final String name;
  final String password;
  final String birthPlace;
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
  final String province;

  User({
    this.id = 0,
    required this.nik,
    required this.name,
    required this.password,
    required this.birthPlace,
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
    this.province = '',
  }) {
    if (!RegExp(r'^[0-9]{16}$').hasMatch(nik)) {
      throw ArgumentError('Invalid NIK format');
    }

    if (birthDate.isAfter(DateTime.now())) {
      throw ArgumentError('Birth date cannot be in the future');
    }

    if (weightKg < 0) {
      throw ArgumentError('Weight cannot be negative');
    }

    if (heightCm < 0) {
      throw ArgumentError('Height cannot be negative');
    }

    if (!Province.isValid(province)) {
      throw ArgumentError('Invalid province name');
    }
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map['id'] == null) {
      throw ArgumentError('ID cannot be null');
    }
    if (map['nik'] == null) {
      throw ArgumentError('NIK cannot be null');
    }
    if (map['name'] == null) {
      throw ArgumentError('Name cannot be null');
    }
    if (map['password'] == null) {
      throw ArgumentError('Password cannot be null');
    }
    if (map['birthPlace'] == null) {
      throw ArgumentError('Birth place cannot be null');
    }
    if (map['birthDate'] == null) {
      throw ArgumentError('Birth date cannot be null');
    }

    if (!Province.isValid(map['province'])) {
      throw ArgumentError('Invalid province name');
    }

    return User(
      id: map['id'] as int,
      nik: map['nik'] as String,
      name: map['name'] as String,
      password: map['password'] as String,
      birthPlace: map['birthPlace'] as String,
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
      province: map['province'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nik': nik,
      'name': name,
      'password': password,
      'birthPlace': birthPlace,
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
