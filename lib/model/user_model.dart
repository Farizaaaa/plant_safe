import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  String email;

  @HiveField(1)
  String password;

  UserData({required this.email, required this.password});
}

class UserDataBox {
  static late Box<UserData> _box;
  static const String _boxName = "loginBox";

  static Future<void> openBox() async {
    _box = await Hive.openBox<UserData>(_boxName);
  }

  static Future<void> saveLoginData(String email, String password) async {
    final loginData = UserData(email: email, password: password);
    await _box.put("userLogin", loginData);
  }

  static Future<UserData?> getLoginData() async {
    return _box.get("userLogin");
  }

  static Future<void> clearLoginData() async {
    await _box.delete("userLogin");
  }
}
