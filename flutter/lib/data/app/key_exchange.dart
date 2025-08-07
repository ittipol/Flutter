class KeyExchange {  

  static String? _key;
  static String? _keyId;

  static bool get isKeyExist => _key?.isNotEmpty ?? false;
  static bool get isKeyIdExist => _keyId?.isNotEmpty ?? false;

  static String get key => _key ?? "";

  static set key(String value) {
    _key = value;
  }

  static void setKey(String value) {
    _key = value;
  }

  static String get keyId => _keyId ?? "";

  static set keyId(String value) {
    _keyId = value;
  }

  static void setKeyId(String value) {
    _keyId = value;
  }
}