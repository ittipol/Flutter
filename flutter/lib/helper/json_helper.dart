import 'dart:convert';

class JsonHelper {
  static R jsonDeserialize<R,T>(String source, R Function(T) callBack) {
    dynamic obj = {};

    if(source.isNotEmpty) {
      obj = jsonDecode(source);
    }

    return callBack.call(obj);
  }
}