import 'package:thu_vien_sach/models/user.dart';

class Comment {
  final String? id;
  final String? content;
  final String? bookId;
  final String? userId;
  final User? user;
  final DateTime? dateAdded;

  Comment({
    this.id,
    this.content,
    this.bookId,
    this.userId,
    this.user,
    this.dateAdded,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      bookId: json['bookId'],
      userId: json['userId'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      dateAdded: DateTime.parse(json['dateAdded']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'bookId': bookId,
      'userId': userId,
      'user': user?.toJson(),
      'dateAdded': dateAdded?.toIso8601String(),
    };
  }
}
