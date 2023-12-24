import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/home/widget/book_widget.dart';

import 'package:thu_vien_sach/pages/library/library_provider.dart';

class ReadingsWidget extends StatelessWidget {
  const ReadingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final readings = context.watch<LibraryProvider>().readingBooks;

    if (readings.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text('Bạn chưa đọc sách nào'),
        ),
      );
    }
    return SizedBox(
      height: 300,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          for (var reading in readings)
            Column(
              children: [
                BookWidget(book: reading.book!),
                Text(
                  '${reading.page}/${reading.book!.page}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
