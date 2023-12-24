import 'package:flutter/foundation.dart';
import 'package:thu_vien_sach/models/book.model.dart';
import 'package:thu_vien_sach/models/reading.model.dart';
import 'package:thu_vien_sach/services/book_service.dart';
import 'package:thu_vien_sach/services/local_service.dart';

class LibraryProvider extends ChangeNotifier {
  final BookService _bookService;
  final LocalService _localService;

  final List<Book> _favoriteBooks = [];

  final List<Reading> _readingBooks = [];

  bool isLoading = true;

  LibraryProvider(this._bookService, this._localService);

  Future<void> init() async {
    _favoriteBooks.clear();
    _readingBooks.clear();
    await _getFavoriteBooks();

    await _getReadingBooks();
    isLoading = false;
    notifyListeners();
  }

  Future<void> _getFavoriteBooks() async {
    final token = _localService.getId();

    if (token == null) {
      return;
    }

    final books = await _bookService.getFavoriteBooks(token);

    _favoriteBooks.addAll(books);
  }

  Future<void> _getReadingBooks() async {
    final token = _localService.getId();

    if (token == null) {
      return;
    }
    final reading = await _bookService.getReadingBooks(token);
    _readingBooks.addAll(reading);
  }

  Future<void> addFavoriteBook(Book book) async {
    final token = _localService.getId();

    if (token == null) {
      return;
    }
    _bookService.addFavoriteBook(token, book.id!);
    _favoriteBooks.add(book);
    notifyListeners();
  }

  Future<void> removeFavoriteBook(Book book) async {
    final id = _localService.getId();
    if (id == null) {
      return;
    }
    await _bookService.removeFavoriteBook(id, book.id!);
    _favoriteBooks.removeWhere((element) => element.id == book.id);

    notifyListeners();
  }

  Future<void> updateReading(Book book, int pageIndex) async {
    final userId = _localService.getId();

    if (userId == null) {
      return;
    }
    final reading =
        await _bookService.updateReading(userId, book.id!, pageIndex);
    _readingBooks.removeWhere((element) => element.bookId == book.id);

    final newReading = reading.copyWith(book: book);
    _readingBooks.add(newReading);

    notifyListeners();
  }

  List<Book> get favoriteBooks => _favoriteBooks;
  List<Reading> get readingBooks => _readingBooks;

  bool isFavorite(Book book) {
    return _favoriteBooks.any((element) => element.id == book.id);
  }

  void toggleFavorite(Book book) {
    if (isFavorite(book)) {
      removeFavoriteBook(book);
    } else {
      addFavoriteBook(book);
    }
  }
}
