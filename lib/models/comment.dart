class Comment {
  int? id;
  String? name;
  String? content;
  String? email;
  int? postId;

  Comment({
    required this.id,
    required this.name,
    required this.content,
    required this.email,
    required this.postId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'],
        name: json['name'],
        content: json['body'],
        email: json['email'],
        postId: json['postId']
      );
}