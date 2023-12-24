class Category {
  final String? id;
  final String? name;
  final DateTime? dateAdded;

  Category({
    this.id,
    this.name,
    this.dateAdded,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      dateAdded: DateTime.parse(json['dateAdded']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateAdded': dateAdded?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Category{id: $id, name: $name, dateAdded: $dateAdded}';
  }

  Category copyWith({
    String? id,
    String? name,
    DateTime? dateAdded,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }
}
