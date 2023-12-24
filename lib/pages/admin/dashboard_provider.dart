import 'package:flutter/foundation.dart' hide Category;
import 'package:thu_vien_sach/models/banner.dart';
import 'package:thu_vien_sach/models/book.model.dart';
import 'package:thu_vien_sach/models/category.model.dart';
import 'package:thu_vien_sach/models/user.dart';
import 'package:thu_vien_sach/services/banner_service.dart';
import 'package:thu_vien_sach/services/book_service.dart';
import 'package:thu_vien_sach/services/category_service.dart';
import 'package:thu_vien_sach/services/user_service.dart';

class DashBoardProvider extends ChangeNotifier {
  final BookService _bookService;
  final CategoryService _categoryService;
  final UserService _userService;
  final BannerService _bannerService;

  final List<Category> _categories = [];
  final List<Book> _books = [];
  final List<User> _users = [];
  final List<Banner> _banners = [];

  bool _isLoading = true;

  DashBoardProvider(this._bookService, this._categoryService, this._userService,
      this._bannerService);

  Future<void> init() async {
    _books.clear();
    _categories.clear();
    _users.clear();
    _banners.clear();

    await _getBooks();
    await _getCategories();
    await _getUsers();
    await _getBanners();

    _isLoading = false;

    notifyListeners();
  }

  Future<void> _getBooks() async {
    _books.addAll(await _bookService.getAllBook()
      ..sort((a, b) => b.title!.compareTo(a.title!)));
  }

  Future<void> _getCategories() async {
    _categories.addAll(await _categoryService.getCategories());
  }

  Future<void> _getUsers() async {
    _users.addAll(await _userService.getAllUser());
  }

  Future<void> _getBanners() async {
    _banners.addAll(await _bannerService.getAllBanner());
  }

  List<Category> get categories => _categories;
  List<Book> get books => _books;
  List<User> get users => _users;
  List<Banner> get banners => _banners;
  bool get isLoading => _isLoading;

  void deleteBook(String s) {
    _bookService.deleteBook(s);
    _books.removeWhere((book) => book.id == s);
    notifyListeners();
  }

  Future<String> uploadImage(String file) async {
    return await _bookService.uploadImage(file);
  }

  Future<String> uploadFile(String file) async {
    return await _bookService.uploadPdf(file);
  }

  deleteCategory(String s) {
    _categoryService.deleteCategory(s);
    _categories.removeWhere((category) => category.id == s);
    notifyListeners();
  }

  Future<Book?> createBook(Book book) async {
    final newBook = _bookService.addBook(book);
    _books.add(book);
    notifyListeners();
    return newBook;
  }

  updateBook(Book book) {
    _bookService.updateBook(book);
    notifyListeners();
  }

  updateCategory(Category category) async {
    final newCategory = await _categoryService.updateCategory(category);
    final index =
        _categories.indexWhere((element) => element.id == category.id);
    _categories[index] = newCategory;
    notifyListeners();
  }

  createCategory(Category category) async {
    final newCategory = await _categoryService.addCategory(category);
    _categories.add(newCategory);
    notifyListeners();
  }

  deleteBanner(String id) async {
    await _bannerService.deleteBanner(id);
    _banners.removeWhere((banner) => banner.id == id);
    notifyListeners();
  }

  Future<void> createBanner(Banner banner) async {
    final newBanner = await _bannerService.createBanner(banner);
    _banners.add(newBanner);
    notifyListeners();
  }

  Future<void> updateBanner(Banner banner) async {
    final newBanner = await _bannerService.updateBanner(banner);
    final index = _banners.indexWhere((element) => element.id == banner.id);
    _banners[index] = newBanner;
    notifyListeners();
  }

  Future<String> uploadBanner(String image) async {
    return await _bannerService.uploadBanner(image);
  }

  Future<void> deleteUser(User user) async {
    await _userService.deleteUser(user.id!);
    _users.removeWhere((element) => element.id == user.id);
    notifyListeners();
  }

  Future<void> updateRole(User user, String? value) async {
    final newUser = await _userService.updateRole(user, value);
    final index = _users.indexWhere((element) => element.id == user.id);
    _users[index] = newUser;
    notifyListeners();
  }
}
