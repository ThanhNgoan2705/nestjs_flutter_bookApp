import 'package:flutter/material.dart';
import 'package:thu_vien_sach/models/user.dart';
import 'package:thu_vien_sach/services/auth_service.dart';
import 'package:thu_vien_sach/services/local_service.dart';
import 'package:thu_vien_sach/utils/exception.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  final LocalService _localService;
  User? _user;

  AuthProvider(this._authService, this._localService);

  Future<User?> login(
      {required String username, required String password}) async {
    final user = await _authService.login(username, password);
    _user = user;

    if (user != null) {
      _localService.saveId(user.id ?? "");

      return user;
    }
    return null;
  }

  Future<User?> loginGoogle() async {
    final user = await _authService.loginGoogle();
    _user = user;
    if (user != null) {
      _localService.saveId(user.id ?? "");
      return user;
    }
    notifyListeners();
    return null;
  }

  Future<User?> register(String username, String password) async {
    final user = await _authService.register(username, password);

    _user = user;

    if (user != null) {
      _localService.saveId(user.id ?? "");
    }
    return user;
  }

  void logout() {
    _localService.removeId();
  }

  Future<void> getUser() async {
    final token = _localService.getId();
    if (token == null) {
      return;
    }

    final user = await _authService.getUser(token);
    _user = user;
  }

  User? get user => _user;

  bool get isLogin => _user != null;

  Future<User?> tryAutoLogin() async {
    final token = _localService.getId();
    if (token == null) {
      return null;
    }
    final user = await _authService.getUser(token);
    _user = user;
    return user;
  }

  Future<String?> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    final token = _localService.getId();
    if (token == null) {
      return "Bạn chưa đăng nhập";
    }
    final result = await _authService.changePassword(
        token, oldPassword, newPassword, confirmPassword);
    return result;
  }

  Future<String?> updateProfile(
      String username, String email, String phone, String? localAvatar) async {
    final token = _localService.getId();
    if (token == null) {
      return "Bạn chưa đăng nhập";
    }

    try {
      if (localAvatar != null) {
        final url = await _authService.uploadAvatar(localAvatar);
        if (url != null) {
          localAvatar = url;
        }
      } else {
        localAvatar = _user?.image;
      }

      final result = await _authService.updateProfile(
          token, username, email, phone, localAvatar!);
      _user = result;
      notifyListeners();
      return null;
    } catch (e) {
      return e is AuthException ? e.message : e.toString();
    }
  }
}
