import 'package:flutter/foundation.dart';
import 'package:thu_vien_sach/models/book.model.dart';
import 'package:thu_vien_sach/services/book_service.dart';

class BookProvider extends ChangeNotifier {
  final BookService _bookService;

  BookProvider(this._bookService);

  Future<List<Book>> getAllBook() {
    return _bookService.getAllBook();
  }

  Future<List<Book>> searchBook(String query) {
    return _bookService.searchBook(query);
  }

  Future<List<Book>> getBooksByLabel(String category) {
    return _bookService.getBookByCategory(category);
  }
}
