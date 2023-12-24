// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/models/book.model.dart';

import 'package:thu_vien_sach/models/category.model.dart';
import 'package:thu_vien_sach/pages/home/widget/book_widget.dart';
import 'package:thu_vien_sach/providers/book_provider.dart';

class BookLabelScreen extends StatelessWidget {
  final Category label;
  const BookLabelScreen({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookProvider = context.watch<BookProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(label.name ?? ''),
      ),
      body: FutureBuilder<List<Book>>(
        future: bookProvider.getBooksByLabel(label.id ?? ''),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 200 / 300,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  children: [
                    for (var book in snapshot.data!) BookWidget(book: book),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
