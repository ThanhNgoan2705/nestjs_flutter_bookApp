class Book {
  final String? id;
  final String? title;
  final String? author;
  final String? content;
  final String? image;
  final String? category;
  final int? page;
  final DateTime? dateAdded;
  final int? views;
  final String? file;

  Book({
    this.id,
    this.title,
    this.author,
    this.content,
    this.image,
    this.category,
    this.page,
    this.dateAdded,
    this.views,
    this.file,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      content: json['content'],
      image: json['image'],
      category: json['category'],
      page: json['page'],
      dateAdded: DateTime.parse(json['dateAdded']),
      views: json['views'],
      file: json['file'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'content': content,
      'image': image,
      'category': category,
      'page': page,
      'dateAdded': dateAdded?.toIso8601String(),
      'views': views,
      'file': file,
    };
  }
}
