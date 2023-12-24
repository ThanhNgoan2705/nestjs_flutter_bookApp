class Banner {
  final String? id;
  final String? image;
  final DateTime? dateAdded;

  Banner({
    this.id,
    this.image,
    this.dateAdded,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'],
      image: json['image'],
      dateAdded: DateTime.parse(json['dateAdded']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'dateAdded': dateAdded?.toIso8601String(),
    };
  }
}
