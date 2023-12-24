import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/home/home_provider.dart';
import 'package:thu_vien_sach/pages/home/widget/book_widget.dart';

class NewsBookWidget extends StatelessWidget {
  const NewsBookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return SizedBox(
      height: 280,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        children: [
          for (var book in homeProvider.newsBooks) BookWidget(book: book),
        ],
      ),
    );
  }
}
