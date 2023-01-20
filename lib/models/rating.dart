class Rating {
  late final String userId;
  late final String id;
  late final num rating;

  Rating({required this.userId, required this.id, required this.rating});

  Rating.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['_id'];
    rating = json['rating'];
  }
}
