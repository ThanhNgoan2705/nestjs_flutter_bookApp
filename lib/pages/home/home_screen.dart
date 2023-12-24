import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/find/search_book_delegare.dart';
import 'package:thu_vien_sach/pages/home/home_provider.dart';
import 'package:thu_vien_sach/pages/home/widget/banner_widget.dart';
import 'package:thu_vien_sach/pages/home/widget/lable_widget.dart';
import 'package:thu_vien_sach/pages/home/widget/news_book_widget.dart';
import 'package:thu_vien_sach/pages/home/widget/popular_book_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thư viện sách'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/search');\
              showSearch(context: context, delegate: SearchBookDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Consumer<HomeProvider>(builder: (context, provider, child) {
        if (provider.isLoading) {
          provider.init();
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: const [
            BannerWidget(),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Sách mới nhất',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            NewsBookWidget(),
            SizedBox(height: 8),
            LabelsWidget(),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Sách nổi bật',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            PopularBookWidget(),
          ],
        );
      }),
    );
  }
}
