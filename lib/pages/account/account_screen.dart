import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/auth/auth_provider.dart';
import 'package:thu_vien_sach/utils/constant.dart';
import 'package:thu_vien_sach/utils/google_check.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 32,
            ),
            const UserCard(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Chức năng',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Column(
                children: [
                  if (provider.user?.role == "admin")
                    ListTile(
                      leading: const Icon(Icons.dashboard),
                      title: const Text("Trang quản trị"),
                      onTap: () {
                        Navigator.pushNamed(context, '/dashboard');
                      },
                    ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Đổi mật khẩu"),
                    onTap: () {
                      Navigator.pushNamed(context, '/change-password');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.login_outlined),
                    title: const Text("Đăng xuất"),
                    onTap: () {
                      provider.logout();
                      Navigator.popAndPushNamed(context, '/login');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 96,
              width: 96,
              child: CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(provider.user?.image != null
                    ? provider.user!.image!.isGoogle
                        ? provider.user!.image!
                        : '${Constant.api}/${provider.user!.image}'
                    : '${Constant.api}/avatar/logo.jpg'),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              children: [
                Text(
                  provider.user?.username ?? "",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Email: ${provider.user?.email ?? "Không có"}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
          Flexible(
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(Icons.edit),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
