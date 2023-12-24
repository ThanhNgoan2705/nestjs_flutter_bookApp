import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/models/book.model.dart';
import 'package:thu_vien_sach/pages/library/library_provider.dart';
import 'package:thu_vien_sach/utils/constant.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title ?? ''),
      ),
      body: ListView(
        children: [
          if (book.image != null)
            Image.network(
              Constant.api + book.image!,
              height: 300,
              fit: BoxFit.cover,
            ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              book.title ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'By ${book.author}',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.book_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, '/reader', arguments: book);
                  },
                  label: const Text('Đọc'),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.comment),
            title: const Text('Nhận xét'),
            onTap: () {
              Navigator.pushNamed(context, '/comment', arguments: book);
            },
          ),
          const Divider(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              book.content ?? '',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      floatingActionButton: FavoriteButton(book),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  final Book book;

  const FavoriteButton(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LibraryProvider>();
    return FloatingActionButton(
      onPressed: () {
        provider.toggleFavorite(book);
        if (provider.isFavorite(book)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đã thêm vào yêu thích'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đã xóa khỏi yêu thích'),
            ),
          );
        }
      },
      child: Icon(
        provider.isFavorite(book) ? Icons.favorite : Icons.favorite_border,
      ),
    );
  }
}
