import 'package:dio/dio.dart';
import 'package:thu_vien_sach/models/comment.dart';
import 'package:thu_vien_sach/utils/constant.dart';

class CommentService {
  final Dio _dio = Dio();
  Future<List<Comment>> getCommentOfBook(String bookId) async {
    final response = await _dio.get('${Constant.api}/comments/book/$bookId');

    final List<dynamic> data = response.data;
    return data.map((e) => Comment.fromJson(e)).toList();
  }

  Future<Comment> addComment(Comment comment) async {
    final response =
        await _dio.post('${Constant.api}/comments', data: comment.toJson());
    if (response.data['message'] != null) {
      throw Exception('Failed to add comment ${response.statusCode}');
    }
    return Comment.fromJson(response.data);
  }

  Future<Comment> updateComment(Comment comment) async {
    final response = await _dio.put('${Constant.api}/comments/${comment.id}',
        data: comment.toJson());
    if (response.data['message'] != null) {
      throw Exception('Failed to update comment ${response.statusCode}');
    }
    return Comment.fromJson(response.data);
  }

  Future<void> deleteComment(String commentId) {
    final response = _dio.delete('${Constant.api}/comments/$commentId');
    return response.then((value) {
      if (value.statusCode == 200) {
        return;
      }
      throw Exception('Failed to delete comment ${value.statusCode}');
    });
  }
}
