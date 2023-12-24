import 'package:dio/dio.dart';
import 'package:thu_vien_sach/models/category.model.dart';
import 'package:thu_vien_sach/utils/constant.dart';

class CategoryService {
  final Dio _dio = Dio();
  // Get all categories
  Future<List<Category>> getCategories() async {
    final resp = await _dio.get('${Constant.api}/category');
    if (resp.statusCode == 200) {
      return (resp.data as List).map((e) => Category.fromJson(e)).toList();
    }
    throw Exception('Failed to load categories ${resp.statusCode}');
  }

  // Get category by id
  Future<Category> getCategoryById(String id) async {
    final resp = await _dio.get('${Constant.api}/category/$id');
    if (resp.statusCode == 200) {
      return Category.fromJson(resp.data);
    }
    throw Exception('Failed to load category ${resp.statusCode}');
  }

  // Add category
  Future<Category> addCategory(Category category) async {
    final resp = await _dio.post('${Constant.api}/category', data: {
      'id': category.id,
      'name': category.name,
    });
    return Category.fromJson(resp.data);
  }

  // Update category
  Future<Category> updateCategory(Category category) async {
    final resp = await _dio.put('${Constant.api}/category/${category.id}',
        data: category.toJson());

    return Category.fromJson(resp.data);
  }

  // Delete category
  Future<void> deleteCategory(String id) async {
    final resp = await _dio.delete('${Constant.api}/category/$id');
    if (resp.statusCode == 200) {
      return;
    }
    throw Exception('Failed to delete category ${resp.statusCode}');
  }
}
