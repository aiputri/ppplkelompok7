import 'dart:convert';
import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class JSONDecoder {
  // SOLUSI: Inisialisasi properti untuk menghindari error 'late'
  late final Map<String, dynamic> jsonObject;
  late final List<dynamic> jsonList;
  bool _isJsonObject = false; // Tambahkan flag untuk tahu tipe data asli

  JSONDecoder(dynamic json) {
    if (json is Map<String, dynamic>) {
      jsonObject = json;
      _isJsonObject = true; // Tandai sebagai objek JSON
    } else if (json is String) {
      dynamic object = jsonDecode(json);
      if (object is Map<String, dynamic>) {
        jsonObject = object;
        _isJsonObject = true;
      } else if (object is List) { // Disederhanakan untuk menangani semua jenis list
        jsonList = object;
        jsonObject = {}; // Inisialisasi jsonObject dengan map kosong untuk menghindari error
      } else {
        // Jika format tidak dikenali, inisialisasi dengan nilai default
        jsonObject = {};
        jsonList = [];
      }
    } else if (json is List) { // Disederhanakan untuk menangani semua jenis list
      jsonList = json;
      jsonObject = {}; // Inisialisasi jsonObject dengan map kosong
    } else {
      // Jika tipe data input tidak dikenali sama sekali
      jsonObject = {};
      jsonList = [];
    }
  }

  // Cek apakah data yang di-decode adalah objek JSON, bukan list
  void _assertIsObject() {
    if (!_isJsonObject) {
      throw Exception("Metode ini hanya bisa dipanggil pada JSON Object, bukan JSON List.");
    }
  }

  int get getId => getInt('id');

  int getInt(String key, [int defaultValue = 0]) {
    _assertIsObject();
    return getIntOrNull(key) ?? defaultValue;
  }

  // SOLUSI: Mengganti nama `has` menjadi `containsKey` agar lebih standar dan jelas
  bool containsKey(String key) {
    _assertIsObject();
    return jsonObject.containsKey(key);
  }

  int? getIntOrNull(String key) {
    _assertIsObject();
    if (containsKey(key) && jsonObject[key] != null) {
      return int.tryParse(jsonObject[key].toString());
    }
    return null;
  }

  double getDouble(String key, [double defaultValue = 0]) {
    _assertIsObject();
    if (containsKey(key) && jsonObject[key] != null) {
      return double.tryParse(jsonObject[key].toString()) ?? defaultValue;
    }
    return defaultValue;
  }

  double? getDoubleOrNull(String key) {
    _assertIsObject();
    if (containsKey(key) && jsonObject[key] != null) {
      return double.tryParse(jsonObject[key].toString());
    }
    return null;
  }

  String getString(String key, {String defaultValue = "", bool utf8 = false}) {
    _assertIsObject();
    String? value;
    if (containsKey(key)) {
      value = validateString(jsonObject[key]) ?? defaultValue;
      if (utf8) {
        return _utf8Decode(value);
      }
    }
    return value ?? defaultValue;
  }

  String _utf8Decode(String string) {
    try {
      return utf8.decode(string.codeUnits);
    } catch (e) {
      return string;
    }
  }

  bool getBool(String key, [bool defaultValue = false]) {
    _assertIsObject();
    if (containsKey(key)) {
      String? value = validateString(jsonObject[key]);
      if (value == null) return defaultValue;
      return value.toLowerCase() == 'true' || value == '1'; // Juga menangani '1' sebagai true
    }
    return defaultValue;
  }

  String? getStringOrNull(String key) {
    _assertIsObject();
    if (containsKey(key)) {
      return validateString(jsonObject[key]);
    }
    return null;
  }

  T getEnum<T extends Enum>(String key, List<T> options, T defaultValue) {
    _assertIsObject();
    return getEnumOrNull(key, options) ?? defaultValue;
  }

  T? getEnumOrNull<T extends Enum>(
    String key,
    List<T> options,
  ) {
    _assertIsObject();
    String? value = getStringOrNull(key);
    if (value == null) return null;
    for (T t in options) {
      if (t.name.toLowerCase() == value.toLowerCase()) { // Dibuat case-insensitive
        return t;
      }
    }
    return null;
  }

  DateTime getDateTime(String key, {DateTime? defaultValue, bool local = true}) {
    _assertIsObject();
    DateTime? parsedDate;
    if (containsKey(key)) {
      parsedDate = DateTime.tryParse(jsonObject[key].toString());
    }
    // Jika gagal parse, gunakan defaultValue atau DateTime.now()
    final dt = parsedDate ?? defaultValue ?? DateTime.now();
    return local ? dt.toLocal() : dt;
  }

  LatLng getLatLng({String latitudeKey = 'latitude', String longitudeKey = 'longitude'}) {
    _assertIsObject();
    double latitude = getDouble(latitudeKey);
    double longitude = getDouble(longitudeKey);
    return LatLng(latitude, longitude);
  }

  LatLng? getLatLngOrNull({String latitudeKey = 'latitude', String longitudeKey = 'longitude'}) {
    _assertIsObject();
    double? latitude = getDoubleOrNull(latitudeKey);
    double? longitude = getDoubleOrNull(longitudeKey);
    if (latitude != null && longitude != null) {
      return LatLng(latitude, longitude);
    }
    return null;
  }

  DateTime? getDateTimeOrNull(String key, {bool local = true}) {
    _assertIsObject();
    if (containsKey(key)) {
      String? validatedDate = validateString(jsonObject[key]);
      if (validatedDate != null) {
        final dt = DateTime.tryParse(validatedDate);
        return dt != null ? (local ? dt.toLocal() : dt) : null;
      }
    }
    return null;
  }

  String? validateString(Object? value) {
    if (value != null && value.toString().toLowerCase() != 'null') {
      return value.toString();
    }
    return null;
  }

  List<T> getObjectList<T>(String key, [List<T> defaultValue = const []]) {
    _assertIsObject();
    if (containsKey(key)) {
      if (jsonObject[key] is List<dynamic>) {
        try {
          return List<T>.from(jsonObject[key]);
        } catch (e) {
          // Gagal casting, kembalikan default
        }
      }
    }
    return defaultValue;
  }

  List<T>? getObjectListOrNull<T>(String key) {
    _assertIsObject();
    if (containsKey(key) && jsonObject[key] != null) {
      if (jsonObject[key] is List<dynamic>) {
        try {
          return List<T>.from(jsonObject[key]);
        } catch (e) {
          log(e.toString());
        }
      } else if (jsonObject[key] is String) {
        try {
          return List<T>.from(jsonDecode(jsonObject[key]));
        } catch (e) {
          log(e.toString());
        }
      }
    }
    return null;
  }
  
  // SOLUSI: Tipe data parameter diubah menjadi `String` agar lebih aman
  List<Map<String, dynamic>>? getMapListOrNull(String key) {
    _assertIsObject();
    if (containsKey(key) && jsonObject[key] is List) {
      try {
        return List<Map<String, dynamic>>.from(jsonObject[key]);
      } catch (e) {
        // Gagal cast, kembalikan null
      }
    }
    return null;
  }
  
  // SOLUSI: Tipe data parameter diubah menjadi `String` agar lebih aman
  Map<String, dynamic>? getMapOrNull(String key) {
    _assertIsObject();
    if (containsKey(key) && jsonObject[key] is Map<String, dynamic>) {
      return jsonObject[key];
    }
    return null;
  }

  Map<String, dynamic>? getMapObjectOrNull(String key) {
    _assertIsObject();
    if (containsKey(key) && jsonObject[key] != null) {
      if (jsonObject[key] is Map<String, dynamic>) {
        return jsonObject[key];
      } else if (jsonObject[key] is String) {
        try {
          dynamic data = json.decode(jsonObject[key]);
          if (data is Map<String, dynamic>) {
            return data;
          }
        } catch (e) {
          // Gagal decode
        }
      }
    }

    return null;
  }

  static String objectToString(Map<String, dynamic> object) {
    return json.encode(object);
  }

  dynamic getDynamic(String key) {
    _assertIsObject();
    return jsonObject[key];
  }
  
  // SOLUSI: Fungsi hasKey diimplementasikan
  bool hasKey(String s) {
    // Ini adalah duplikat dari containsKey, jadi sebaiknya panggil itu saja
    return containsKey(s);
  }
}