import 'package:flutter/foundation.dart' hide Category;
import 'package:thu_vien_sach/models/category.model.dart';
import 'package:thu_vien_sach/services/category_service.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _categoryService;
  List<Category> _categories = [];

  CategoryProvider(this._categoryService);

  Future<void> init() async {
    await _getCategories();

    notifyListeners();
  }

  Future<void> _getCategories() async {
    _categories = await _categoryService.getCategories();

    notifyListeners();
  }

  List<Category> get categories => _categories;
}
