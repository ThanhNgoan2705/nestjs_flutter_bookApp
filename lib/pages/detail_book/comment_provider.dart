import 'package:flutter/material.dart';
import 'package:thu_vien_sach/models/comment.dart';
import 'package:thu_vien_sach/services/comment_service.dart';
import 'package:thu_vien_sach/services/local_service.dart';

class CommnetProvider extends ChangeNotifier {
  final CommentService _commentService;
  final LocalService _localService;

  List<Comment> _comments = [];

  CommnetProvider(this._commentService, this._localService);

  List<Comment> get comments => _comments;

  Future<void> getComments(String bookId) async {
    _comments = [];
    _comments = await _commentService.getCommentOfBook(bookId);
    notifyListeners();
  }

  Future<void> addComment(String bookId, String content) async {
    final userId = _localService.getId();
    final comment = Comment(
      bookId: bookId,
      userId: userId,
      content: content,
    );
    await _commentService.addComment(comment);

    await getComments(bookId);
  }

  //delete comment
  Future<void> deleteComment(String bookId, String commentId) async {
    await _commentService.deleteComment(commentId);
    await getComments(bookId);
  }

  bool isOwner(Comment comment) {
    final userId = _localService.getId();
    return comment.userId == userId;
  }
}
