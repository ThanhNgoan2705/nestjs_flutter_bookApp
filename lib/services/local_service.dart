import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  final SharedPreferences _sharedPreferences;
  LocalService(this._sharedPreferences);

  Future<void> saveId(String id) async {
    await _sharedPreferences.setString('id', id);
  }

  String? getId() {
    return _sharedPreferences.getString('id');
  }

  Future<void> removeId() async {
    await _sharedPreferences.remove('id');
  }
}
