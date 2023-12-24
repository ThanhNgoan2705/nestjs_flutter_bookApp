import 'package:dio/dio.dart';
import 'package:thu_vien_sach/models/user.dart';
import 'package:thu_vien_sach/utils/constant.dart';

class UserService {
  final Dio _dio = Dio();

  Future<List<User>> getAllUser() {
    return _dio.get('${Constant.api}/user').then((value) {
      final List<dynamic> data = value.data;

      final users = data.map((e) => User.fromJson(e)).toList();

      return users;
    });
  }

  Future<User> deleteUser(String s) {
    return _dio.delete('${Constant.api}/user/$s').then((value) {
      if (value.statusCode == 200) {
        return User.fromJson(value.data);
      }
      throw Exception('Failed to delete user ${value.statusCode}');
    });
  }

  Future<User> updateRole(User user, String? value) {
    return _dio.post('${Constant.api}/user/role', data: {
      'id': user.id,
      'role': value,
    }).then((value) {
      if (value.statusCode == 201) {
        return User.fromJson(value.data);
      }
      throw Exception('Failed to update user ${value.statusCode}');
    });
  }
}
