import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scelloo_task/models/post.dart';
import 'package:scelloo_task/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  PostBloc(this.postRepository) : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);

    on<AddPost>(_onAddPost);

    on<DeletePost>(_onDeletePost);
  }

  Future<void> _onFetchPosts(
    FetchPosts event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());
    try {
      final posts = await postRepository.fetchPosts();
      emit(PostSuccess(posts));
    } catch (e) {
      debugPrint('error is $e');
      emit(PostFailure());
    }
  }

  Future<void> _onAddPost(
    AddPost event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());
    try {
      final post = await postRepository.addPost(
        event.body,
        event.posts,
      );

      emit(PostSuccess(
        post,
      ));
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> _onDeletePost(
    DeletePost event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());
    try {
      final posts = await postRepository.deletePost(
        event.postId,
        event.posts,
      );
      emit(PostSuccess(
        posts,
      ));
    } catch (_) {
      emit(PostFailure());
    }
  }
}
