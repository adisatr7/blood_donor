import 'dart:io';
import 'package:blood_donor/widgets/popups/app_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:blood_donor/constants/province.dart';

class User {
  final int id;
  String nik;
  String name;
  String? password;
  File? profilePicture;
  String birthPlace;
  DateTime birthDate;
  String gender; // 'Laki-laki' atau 'Perempuan'
  String job;
  double weightKg;
  double heightCm;
  String bloodType;
  String rhesus;

  String address;
  int noRt;
  int noRw;
  String village;
  String district;
  String city;
  String province;

  User({
    this.id = 0,
    required this.nik,
    required this.name,
    this.password,
    required this.birthPlace,
    required this.birthDate,
    this.profilePicture,
    this.gender = '',
    this.job = '',
    this.weightKg = 0,
    this.heightCm = 0,
    this.bloodType = '',
    this.rhesus = '',
    this.address = '',
    this.noRt = 0,
    this.noRw = 0,
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

    if (province.isNotEmpty && !Province.isValid(province)) {
      throw ArgumentError('Invalid province name');
    }
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int? ?? 0,
      nik: map['nik'] as String,
      name: map['name'] as String,
      birthPlace: map['birthPlace'] as String,
      birthDate: DateTime.parse(map['birthDate'] as String),
      profilePicture: _getProfilePicture(map['profilePicture']),
      gender: genderEnumToString(map['gender']),
      job: map['job'] as String? ?? '',
      weightKg: (map['weightKg'] as num?)?.toDouble() ?? 0,
      heightCm: (map['heightCm'] as num?)?.toDouble() ?? 0,
      bloodType: map['bloodType'] as String? ?? '',
      rhesus: rhesusEnumToString(map['rhesus']),
      address: map['address'] as String? ?? '',
      noRt: map['noRt'] as int? ?? 0,
      noRw: map['noRw'] as int? ?? 0,
      village: map['village'] as String? ?? '',
      district: map['district'] as String? ?? '',
      city: map['city'] as String? ?? '',
      province: map['province'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nik': nik,
      'name': name,
      'password': password,
      'birthPlace': birthPlace,
      'birthDate': birthDate.toIso8601String(),
      'gender': User.genderStringToEnum(gender),
      'job': job,
      'weightKg': weightKg,
      'heightCm': heightCm,
      'bloodType': bloodType,
      'rhesus': User.rhesusStringToEnum(rhesus),
      'address': address,
      'noRt': noRt,
      'noRw': noRw,
      'village': village,
      'district': district,
      'city': city,
      'province': province,
    };
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'nik': nik,
      'name': name,
      'password': password,
      'profilePicture':
          profilePicture != null && profilePicture!.path.isNotEmpty
              ? await MultipartFile.fromFile(profilePicture!.path)
              : null,
      'birthPlace': birthPlace,
      'birthDate': birthDate.toIso8601String(),
      'gender': gender,
      'job': job,
      'weightKg': weightKg,
      'heightCm': heightCm,
      'bloodType': bloodType,
      'rhesus': rhesus,
      'address': address,
      'noRt': noRt,
      'noRw': noRw,
      'village': village,
      'district': district,
      'city': city,
      'province': province,
    });
  }

  /// Method static untuk konversi gender string (Laki-laki/Perempuan) ke
  /// enumerasi yang digunakan di MySQL.
  /// - 'Laki-laki' = 'MALE'
  /// - 'Perempuan' = 'FEMALE'
  static String genderStringToEnum(String genderString) {
    switch (genderString) {
      case 'Laki-laki':
        return 'MALE';
      case 'Perempuan':
        return 'FEMALE';
      default:
        return 'ERROR';
    }
  }

  /// Method static untuk mengonversi gender enumerasi dari MySQL ke string
  /// yang digunakan oleh widget SelectInput di aplikasi.
  /// - 'MALE' = 'Laki-laki'
  /// - 'FEMALE' = 'Perempuan'
  static String genderEnumToString(genderEnum) {
    switch (genderEnum) {
      case 'MALE':
        return 'Laki-laki';
      case 'FEMALE':
        return 'Perempuan';
      default:
        return 'ERROR';
    }
  }

  /// Method static untuk konversi rhesus string (Positif/Negatif) ke
  /// enumerasi yang digunakan di MySQL.
  /// - 'Positif' = 'POSITIVE'
  /// - 'Negatif' = 'NEGATIVE'
  static String rhesusStringToEnum(rhesusString) {
    switch (rhesusString) {
      case 'Positif':
        return 'POSITIVE';
      case 'Negatif':
        return 'NEGATIVE';
      default:
        return 'ERROR';
    }
  }

  /// Method static untuk mengonversi rhesus enumerasi dari MySQL ke string
  /// yang digunakan oleh widget SelectInput di aplikasi.
  /// - 'POSITIVE' = 'Positif'
  /// - 'NEGATIVE' = 'Negatif'
  static String rhesusEnumToString(rhesusEnum) {
    switch (rhesusEnum) {
      case 'POSITIVE':
        return 'Positif';
      case 'NEGATIVE':
        return 'Negatif';
      default:
        return 'ERROR';
    }
  }

  /// Getter untuk mengambil golongan darah dan rhesus dalam satu string (cth: B+)
  String get mergedBloodType {
    if (bloodType.isEmpty || (rhesus != 'Positif' && rhesus != 'Negatif')) {
      throw ArgumentError('Invalid blood type or rhesus value');
    }

    String rhesusSymbol = (rhesus == 'Positif') ? '+' : '-';
    return '$bloodType$rhesusSymbol';
  }

  /// Method internal untuk mendapatkan file gambar profil dari URL atau path.
  static File? _getProfilePicture(String? profilePictureUrl) {
    // Jika URL atau path kosong, berikan nilai `null`
    if (profilePictureUrl == null || profilePictureUrl.isEmpty) {
      return null;
    }

    // Jika ada URL, tambahkan prefix API_URL dari .env
    final String uri =
        Uri.parse('${dotenv.env['API_URL']}$profilePictureUrl').toString();
    if (Uri.tryParse(uri)?.isAbsolute ?? false) {
      return File(uri);
    }

    // Jika URL tidak valid, tampilkan pesan error
    showAppDialog(
      title: 'Gagal Memuat Foto Profil',
      message: 'URL foto profil tidak benar: $uri',
    );
    return null;
  }
}
