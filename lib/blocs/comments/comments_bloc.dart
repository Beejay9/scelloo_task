import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scelloo_task/models/comment.dart';
import 'package:scelloo_task/repositories/comment_repository.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentRepository commentRepository;
  CommentsBloc(this.commentRepository) : super(CommentsInitial()) {
    on<FetchComments>(_onFetchComments);
  }

  Future<void> _onFetchComments(
    FetchComments event,
    Emitter<CommentsState> emit,
  ) async {
    emit(CommentsLoading());
    try {
      final comments = await commentRepository.fetchComments(event.postId);
      emit(CommentsSuccess(comments));
    } catch (e) {
      debugPrint('error is $e');
      emit(CommentsFailure());
    }
  }
}
