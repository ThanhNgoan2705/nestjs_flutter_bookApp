import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/auth/auth_provider.dart';

class PasswordScreen extends StatelessWidget {
  PasswordScreen({Key? key}) : super(key: key);

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Đổi mật khẩu')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _oldPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu cũ',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu mới',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Nhập lại mật khẩu mới',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final mess = await authProvider.changePassword(
                      _oldPasswordController.text,
                      _newPasswordController.text,
                      _confirmPasswordController.text,
                    );
                    if (mess == null && context.mounted) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Đổi mật khẩu thành công'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(mess!),
                        ),
                      );
                    }
                  },
                  child: const Text('Đổi mật khẩu'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
