import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/models/book.model.dart';
import 'package:thu_vien_sach/providers/book_provider.dart';
import 'package:thu_vien_sach/utils/constant.dart';

class SearchBookDelegate extends SearchDelegate {
  SearchBookDelegate() : super(searchFieldLabel: 'Tìm kiếm');
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Add back button in the app bar
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  FutureBuilder<List<Book>> buildResults(BuildContext context) {
    final bookProvider = context.watch<BookProvider>();

    return FutureBuilder(
      future: bookProvider.searchBook(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Lỗi'),
          );
        }
        if (snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Không tìm thấy kết quả'),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final book = snapshot.data![index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.network(Constant.api + book.image!),
                title: Text(book.title ?? ''),
                subtitle: Text(book.author ?? ''),
                onTap: () {
                  Navigator.pushNamed(context, '/book', arguments: book);
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Display suggestions when the user types in the search field

    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.search),
          title: Text('Tìm với từ khoá $query'),
          onTap: () {
            query.isEmpty ? null : close(context, query);
          },
        )
      ],
    );
  }
}
