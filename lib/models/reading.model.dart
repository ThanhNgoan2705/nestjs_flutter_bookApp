import 'package:thu_vien_sach/models/book.model.dart';

class Reading {
  final String id;
  final String bookId;
  final String userId;
  final int page;
  final Book? book;
  final DateTime dateAdded;

  Reading({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.page,
    required this.book,
    required this.dateAdded,
  });

  factory Reading.fromJson(Map<String, dynamic> json) {
    return Reading(
      id: json['id'],
      bookId: json['bookId'],
      userId: json['userId'],
      page: json['page'],
      book: json['book'] != null ? Book.fromJson(json['book']) : null,
      dateAdded: DateTime.parse(json['dateAdded']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookId': bookId,
      'userId': userId,
      'page': page,
      'book': book?.toJson(),
      'dateAdded': dateAdded.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Reading{id: $id, bookId: $bookId, userId: $userId, page: $page, book: $book, dateAdded: $dateAdded}';
  }

  Reading copyWith({
    String? id,
    String? bookId,
    String? userId,
    int? page,
    Book? book,
    DateTime? dateAdded,
  }) {
    return Reading(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      userId: userId ?? this.userId,
      page: page ?? this.page,
      book: book ?? this.book,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }
}
