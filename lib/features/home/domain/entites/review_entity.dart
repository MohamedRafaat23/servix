class ReviewEntity {
  final String id;
  final String userName;
  final String userImage;
  final String date;
  final String comment;
  final int rating;

  const ReviewEntity({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.date,
    required this.comment,
    required this.rating,
  });
}
