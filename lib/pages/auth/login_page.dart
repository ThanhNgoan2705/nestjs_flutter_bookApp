import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/auth/auth_provider.dart';

import 'package:thu_vien_sach/utils/exception.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
        excludeHeaderSemantics: false,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Tên đăng nhập',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final success = await loginProvider.login(
                      username: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (success != null && context.mounted) {
                      Navigator.popAndPushNamed(context, '/main');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đăng nhập không thành công'),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e is AuthException
                            ? e.message
                            : 'Đăng nhập không thành công'),
                      ),
                    );
                  }
                },
                child: const Text('Đăng nhập'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final user = await loginProvider.loginGoogle();
                      if (context.mounted && user != null) {
                        Navigator.popAndPushNamed(context, '/main');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đăng nhập không thành công'),
                          ),
                        );
                      }
                    },
                    child: const Text('Đăng nhập với Google'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text('Đăng ký'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginHandler(BuildContext context) {}
}
