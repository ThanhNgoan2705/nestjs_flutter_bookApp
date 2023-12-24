import 'package:dio/dio.dart';
import 'package:thu_vien_sach/models/book.model.dart';
import 'package:thu_vien_sach/models/reading.model.dart';
import 'package:thu_vien_sach/utils/constant.dart';

class BookService {
  final Dio _dio = Dio();
  Future<List<Book>> getAllBook() {
    final resp = _dio.get('${Constant.api}/books');
    return resp.then((value) {
      if (value.statusCode == 200) {
        return (value.data as List)
            .map((e) => Book.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw Exception('Failed to load books ${value.statusCode}');
    });
  }

  Future<Book> getBookById(String id) {
    final resp = _dio.get('${Constant.api}/books/$id');
    return resp.then((value) {
      if (value.statusCode == 200) {
        return Book.fromJson(value.data);
      }
      throw Exception('Failed to load book ${value.statusCode}');
    });
  }

  Future<Book?> addBook(Book book) {
    final resp = _dio.post('${Constant.api}/books', data: book.toJson());
    return resp.then((value) {
      if (value.statusCode == 201) {
        return Book.fromJson(value.data);
      }
      return null;
    });
  }

  Future<Book> updateBook(Book book) {
    final resp =
        _dio.put('${Constant.api}/books/${book.id}', data: book.toJson());
    return resp.then((value) {
      if (value.statusCode == 200) {
        return Book.fromJson(value.data);
      }
      throw Exception('Failed to update book ${value.statusCode}');
    });
  }

  Future<void> deleteBook(String id) {
    final resp = _dio.delete('${Constant.api}/books/$id');
    return resp.then((value) {
      if (value.statusCode == 200) {
        return;
      }
      throw Exception('Failed to delete book ${value.statusCode}');
    });
  }

  Future<List<Book>> searchBook(String query) async {
    final resp = await _dio.get('${Constant.api}/books/search/$query');
    if (resp.statusCode == 200) {
      return (resp.data as List)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Failed to search books ${resp.statusCode}');
  }

  Future<List<Book>> getBookByCategory(String category) {
    final resp = _dio.get('${Constant.api}/books/category/$category');
    return resp.then((value) {
      if (value.statusCode == 200) {
        return (value.data as List)
            .map((e) => Book.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw Exception('Failed to load books ${value.statusCode}');
    });
  }

  Future<List<Book>> getNewsBook() async {
    final resp = await _dio.get('${Constant.api}/books/news');

    if (resp.statusCode == 200) {
      return (resp.data as List)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Failed to load books ${resp.statusCode}');
  }

  Future<List<Book>> getPopularBook() {
    final resp = _dio.get('${Constant.api}/books/popular');
    return resp.then((value) {
      if (value.statusCode == 200) {
        return (value.data as List)
            .map((e) => Book.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw Exception('Failed to load books ${value.statusCode}');
    });
  }

  Future<List<Book>> getFavoriteBooks(String id) async {
    final resp = await _dio.get('${Constant.api}/favorite/$id');

    if (resp.statusCode == 200) {
      return (resp.data as List)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Failed to load books ${resp.statusCode}');
  }

  Future<void> addFavoriteBook(String userId, String bookId) async {
    final resp = await _dio.post('${Constant.api}/favorite/$userId/$bookId');

    if (resp.statusCode == 201) {
      return;
    }
    throw Exception('Failed to add favorite book ${resp.statusCode}');
  }

  Future<void> removeFavoriteBook(
    String userId,
    String bookId,
  ) async {
    final resp = await _dio.delete('${Constant.api}/favorite/$userId/$bookId');
    if (resp.statusCode == 200) {
      return;
    }
    throw Exception('Failed to remove favorite book ${resp.statusCode}');
  }

  Future<Reading> updateReading(String userId, String bookId, int pageIndex) {
    final resp = _dio.post('${Constant.api}/readings/', data: {
      'userId': userId,
      'bookId': bookId,
      'page': pageIndex,
    });

    return resp.then((value) {
      if (value.statusCode == 201) {
        return Reading.fromJson(value.data);
      }
      throw Exception('Failed to add reading book ${value.statusCode}');
    });
  }

  Future<List<Reading>> getReadingBooks(String id) {
    final resp = _dio.get('${Constant.api}/readings/$id');

    return resp.then((value) {
      if (value.statusCode == 200) {
        return (value.data as List)
            .map((e) => Reading.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw Exception('Failed to load reading books ${value.statusCode}');
    });
  }

  Future<String> uploadImage(String file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file),
    });

    final resp = _dio.post('${Constant.api}/upload/image', data: formData);

    return resp.then((value) {
      if (value.statusCode == 201) {
        return value.data['filename'];
      }
      throw Exception('Failed to upload image ${value.statusCode}');
    });
  }

  Future<String> uploadPdf(String file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file),
    });

    final resp = _dio.post('${Constant.api}/upload/pdf', data: formData);

    return resp.then((value) {
      if (value.statusCode == 201) {
        return value.data['filename'];
      }
      throw Exception('Failed to upload pdf ${value.statusCode}');
    });
  }
}
