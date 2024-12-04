class Post {
  final String username;
  final String profileImageUrl;
  final String postImageUrl;
  final String caption;
  final int likes;

  Post({
    required this.username,
    required this.profileImageUrl,
    required this.postImageUrl,
    required this.caption,
    required this.likes,
  });
}