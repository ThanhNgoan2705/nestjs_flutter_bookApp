import 'package:flutter/material.dart' hide Banner;
import 'package:thu_vien_sach/models/banner.dart';
import 'package:thu_vien_sach/models/book.model.dart';
import 'package:thu_vien_sach/models/category.model.dart';
import 'package:thu_vien_sach/services/banner_service.dart';
import 'package:thu_vien_sach/services/book_service.dart';
import 'package:thu_vien_sach/services/category_service.dart';

class HomeProvider extends ChangeNotifier {
  final BookService _bookService;
  final CategoryService _categoryService;
  final BannerService _bannerService;

  bool _isLoading = true;
  List<Book> _newsBooks = [];
  List<Book> _popularBooks = [];
  List<Category> _labels = [];
  List<Banner> _banners = [];

  HomeProvider(this._bookService, this._categoryService, this._bannerService);

  Future<void> init() async {
    await _getNewsBooks();
    await _getPopularBooks();
    await _getCategories();
    await _getBanners();

    _isLoading = false;

    notifyListeners();
  }

  Future<void> _getNewsBooks() async {
    _newsBooks = await _bookService.getNewsBook();
  }

  Future<void> _getPopularBooks() async {
    _popularBooks = await _bookService.getPopularBook();
  }

  Future<void> _getCategories() async {
    _labels = await _categoryService.getCategories();
  }

  Future<void> _getBanners() async {
    _banners = await _bannerService.getAllBanner();
  }

  bool get isLoading => _isLoading;
  List<Category> get labels => _labels;
  List<Book> get newsBooks => _newsBooks;
  List<Book> get popularBooks => _popularBooks;
  List<Banner> get banners => _banners;
}
