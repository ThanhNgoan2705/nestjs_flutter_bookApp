import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/admin/dashboard_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.read<DashBoardProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: FutureBuilder<void>(
          future: dashboardProvider.init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final listen = context.watch<DashBoardProvider>();
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Card(
                        child: ListTile(
                          title: const Text('Số lượng sách'),
                          trailing: Text('${listen.books.length}'),
                          onTap: () {
                            Navigator.pushNamed(context, '/admin-books');
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Số lượng người dùng'),
                          trailing: Text('${listen.users.length}'),
                          onTap: () {
                            Navigator.pushNamed(context, '/admin-users');
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Số luọng danh mục'),
                          trailing: Text('${listen.categories.length}'),
                          onTap: () {
                            Navigator.pushNamed(context, '/admin-categories');
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Số lượng banner'),
                          trailing: Text('${listen.banners.length}'),
                          onTap: () {
                            Navigator.pushNamed(context, '/admin-banners');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/main');
                      },
                      child: const Text('Trở lại trang chủ'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/login');
                      },
                      child: const Text('Đăng xuất'),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
