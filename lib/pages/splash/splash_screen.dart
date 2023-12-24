import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/auth/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    Future.delayed(const Duration(seconds: 1), () async {
      final user = await authProvider.tryAutoLogin();

      if (context.mounted && user != null) {
        Navigator.of(context).pushReplacementNamed('/main');
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
    return Scaffold(
        body: Center(
      child: Image.asset("assets/images/logo.jpg"),
    ));
  }
}
