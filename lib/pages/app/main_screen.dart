import 'package:flutter/material.dart';
import 'package:thu_vien_sach/pages/account/account_screen.dart';
import 'package:thu_vien_sach/pages/home/home_screen.dart';
import 'package:thu_vien_sach/pages/labels/labels_screen.dart';
import 'package:thu_vien_sach/pages/library/library_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: const [
          HomeScreen(),
          LabelScreen(),
          LibrayScreen(),
          AccountScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Danh mục',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Thư viện',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}
