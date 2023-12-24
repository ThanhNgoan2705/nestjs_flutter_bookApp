import 'package:flutter/material.dart';
import 'package:thu_vien_sach/models/book.model.dart';
import 'package:thu_vien_sach/utils/constant.dart';

class BookWidget extends StatelessWidget {
  final Book book;

  const BookWidget({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/book', arguments: book);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  Constant.api + book.image!,
                  height: 200,
                  width: 160,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                book.title ?? '',
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                book.author ?? '',
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
