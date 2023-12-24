import 'dart:io';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thu_vien_sach/models/user.dart';
import 'package:thu_vien_sach/utils/constant.dart';
import 'package:thu_vien_sach/utils/exception.dart';

class AuthService {
  final Dio _dio = Dio();
  final _googleSignIn = GoogleSignIn();
  Future<User?> login(String email, String password) async {
    final resp = await _dio.post('${Constant.api}/auth/login', data: {
      'username': email,
      'password': password,
    });
    print(resp.data);

    if (resp.data['message'] != null) {
      throw AuthException(
          resp.data['message'] ?? 'Failed to register ${resp.statusCode}');
    }
    return User.fromJson(resp.data);
  }

  Future<User?> register(String username, String password) async {
    final resp = await _dio.post('${Constant.api}/auth/register', data: {
      'username': username,
      'password': password,
    });

    if (resp.data['message'] != null) {
      throw AuthException(
          resp.data['message'] ?? 'Failed to register ${resp.statusCode}');
    }
    return User.fromJson(resp.data);
  }

  Future<User?> getUser(String id) async {
    final resp = await _dio.get(
      '${Constant.api}/auth/$id',
    );

    if (resp.data['message'] != null) {
      throw AuthException(
          resp.data['message'] ?? 'Failed to register ${resp.statusCode}');
    }

    final user = User.fromJson(resp.data);

    return user;
  }

  Future<String?> changePassword(String token, String oldPassword,
      String newPassword, String confirmPassword) async {
    final resp = await _dio.post('${Constant.api}/user/password', data: {
      'id': token,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    });

    if (resp.data['message'] != null) {
      return resp.data['message'];
    }
    return null;
  }

  Future<String?> uploadAvatar(String localAvatar) async {
    File file = File(localAvatar);
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    final resp =
        await _dio.post('${Constant.api}/upload/avatar', data: formData);

    final filename = resp.data['filename'];
    if (filename != null) {
      return filename;
    }
    throw AuthException('không thể upload ảnh');
  }

  Future<User?> updateProfile(String token, String username, String email,
      String phone, String image) async {
    final resp = await _dio.put('${Constant.api}/user', data: {
      'id': token,
      'username': username,
      'email': email,
      'phone': phone,
      'image': image,
    });

    if (resp.data['message'] != null) {
      throw AuthException(
          resp.data['message'] ?? 'Failed to register ${resp.statusCode}');
    }
    return User.fromJson(resp.data);
  }

  Future<User?> loginGoogle() async {
    final user = await _googleSignIn.signIn();
    if (user == null) {
      return null;
    }

    return _dio.post('${Constant.api}/auth/google', data: {
      'id': user.id,
      'email': user.email,
      'username': user.displayName,
      'image': user.photoUrl,
    }).then((value) {
      if (value.data['message'] != null) {
        throw AuthException(
            value.data['message'] ?? 'Failed to register ${value.statusCode}');
      }
      _googleSignIn.signOut();
      return User.fromJson(value.data);
    });
  }
}
