class Post {
  int? id;
  String? title;
  String? content;
  int? userId;
  int? newPostId;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    this.newPostId,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        title: json['title'],
        content: json['body'],
        userId: json['userId'],
        newPostId: json['postId']
      );
}
