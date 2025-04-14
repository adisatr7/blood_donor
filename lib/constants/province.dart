class Province {
  static const String aceh = 'Nanggroe Aceh Darussalam';
  static const String sumateraUtara = 'Sumatera Utara';
  static const String sumateraSelatan = 'Sumatera Selatan';
  static const String sumateraBarat = 'Sumatera Barat';
  static const String bengkulu = 'Bengkulu';
  static const String riau = 'Riau';
  static const String kepulauanRiau = 'Kepulauan Riau';
  static const String jambi = 'Jambi';
  static const String lampung = 'Lampung';
  static const String bangkaBelitung = 'Bangka Belitung';
  static const String kalimantanBarat = 'Kalimantan Barat';
  static const String kalimantanTimur = 'Kalimantan Timur';
  static const String kalimantanSelatan = 'Kalimantan Selatan';
  static const String kalimantanTengah = 'Kalimantan Tengah';
  static const String kalimantanUtara = 'Kalimantan Utara';
  static const String banten = 'Banten';
  static const String dkiJakarta = 'DKI Jakarta';
  static const String jawaBarat = 'Jawa Barat';
  static const String jawaTengah = 'Jawa Tengah';
  static const String daerahIstimewaYogyakarta = 'Daerah Istimewa Yogyakarta';
  static const String jawaTimur = 'Jawa Timur';
  static const String bali = 'Bali';
  static const String nusaTenggaraTimur = 'Nusa Tenggara Timur';
  static const String nusaTenggaraBarat = 'Nusa Tenggara Barat';
  static const String gorontalo = 'Gorontalo';
  static const String sulawesiBarat = 'Sulawesi Barat';
  static const String sulawesiTengah = 'Sulawesi Tengah';
  static const String sulawesiUtara = 'Sulawesi Utara';
  static const String sulawesiTenggara = 'Sulawesi Tenggara';
  static const String sulawesiSelatan = 'Sulawesi Selatan';
  static const String malukuUtara = 'Maluku Utara';
  static const String maluku = 'Maluku';
  static const String papuaBarat = 'Papua Barat';
  static const String papua = 'Papua';
  static const String papuaTengah = 'Papua Tengah';
  static const String papuaPegunungan = 'Papua Pegunungan';
  static const String papuaSelatan = 'Papua Selatan';
  static const String papuaBaratDaya = 'Papua Barat Daya';

  static const List<String> list = [
    aceh,
    sumateraUtara,
    sumateraSelatan,
    sumateraBarat,
    bengkulu,
    riau,
    kepulauanRiau,
    jambi,
    lampung,
    bangkaBelitung,
    kalimantanBarat,
    kalimantanTimur,
    kalimantanSelatan,
    kalimantanTengah,
    kalimantanUtara,
    banten,
    dkiJakarta,
    jawaBarat,
    jawaTengah,
    daerahIstimewaYogyakarta,
    jawaTimur,
    bali,
    nusaTenggaraTimur,
    nusaTenggaraBarat,
    gorontalo,
    sulawesiBarat,
    sulawesiTengah,
    sulawesiUtara,
    sulawesiTenggara,
    sulawesiSelatan,
    malukuUtara,
    maluku,
    papuaBarat,
    papua,
    papuaTengah,
    papuaPegunungan,
    papuaSelatan,
    papuaBaratDaya,
  ];

  /// Check if the given province name is valid (case insensitive)
  static bool isValid(String province) {
    return list.any((p) => p.toLowerCase() == province.toLowerCase());
  }
}
