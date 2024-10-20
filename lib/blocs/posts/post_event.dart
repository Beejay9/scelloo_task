part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class FetchPosts extends PostEvent {}

class AddPost extends PostEvent {
  final Map<String, String> body;
  final List<Post> posts;
  const AddPost({
    required this.body,
    required this.posts,
  });
}

class DeletePost extends PostEvent {
  final int postId;
  final List<Post> posts;

  const DeletePost({required this.postId, required this.posts});
}
