// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thu_vien_sach/pages/home/widget/book_widget.dart';
import 'package:thu_vien_sach/pages/library/library_provider.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteBooks = context.watch<LibraryProvider>().favoriteBooks;
    if (favoriteBooks.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text('Bạn chưa thích sách nào'),
        ),
      );
    }

    return SizedBox(
      height: 300,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          for (var book in favoriteBooks) BookWidget(book: book),
        ],
      ),
    );
  }
}
