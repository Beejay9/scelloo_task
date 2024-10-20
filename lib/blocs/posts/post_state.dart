part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState();
  
  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

final class PostFailure extends PostState {}

final class PostLoading extends PostState {}

final class PostSuccess extends PostState {
  final List<Post> posts;

  const PostSuccess(this.posts);

  @override
  List<Object> get props => [posts];
}

