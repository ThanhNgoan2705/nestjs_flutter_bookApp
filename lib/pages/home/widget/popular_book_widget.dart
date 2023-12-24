import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/home/home_provider.dart';
import 'package:thu_vien_sach/pages/home/widget/book_widget.dart';

class PopularBookWidget extends StatelessWidget {
  const PopularBookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return SizedBox(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        children: [
          for (var book in homeProvider.popularBooks) BookWidget(book: book),
        ],
      ),
    );
  }
}
