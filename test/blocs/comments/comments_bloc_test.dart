import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scelloo_task/blocs/comments/comments_bloc.dart';
import 'package:scelloo_task/models/comment.dart';
import 'package:scelloo_task/repositories/comment_repository.dart';

class MockCommentsRepository extends Mock implements CommentRepository {}

void main() {
  group(
    'tests for comments',
    () {
      final mockCommentsRepository = MockCommentsRepository();

      final comments = [
        Comment(
          id: 1,
          name: 'Test name',
          content: 'This is the first comment in the list of comments',
          email: 'email1@gmail.com',
          postId: 1,
        ),
        Comment(
          id: 2,
          name: 'Test name 2',
          content: 'This is the second comment in the list of comments',
          email: 'email2@gmail.com',
          postId: 1,
        ),
        Comment(
          id: 3,
          name: 'Test name 3',
          content: 'This is the third comment in the list of comments',
          email: 'email3@gmail.com',
          postId: 1,
        ),
      ];

      blocTest<CommentsBloc, CommentsState>(
        'this is to test the successful fetching of comments on a post',
        build: () => CommentsBloc(mockCommentsRepository),
        setUp: () {
          when(() => mockCommentsRepository.fetchComments(1)).thenAnswer(
            (_) => Future.value(comments),
          );
        },
        act: (bloc) => bloc.add(
          FetchComments(postId: 1),
        ),
        expect: () =>
            <CommentsState>[CommentsLoading(), CommentsSuccess(comments)],
      );

      blocTest<CommentsBloc, CommentsState>(
        'this is to test when there is an exception when fetching comments on a post',
        build: () => CommentsBloc(mockCommentsRepository),
        setUp: () {
          when(() => mockCommentsRepository.fetchComments(1)).thenAnswer(
            (_) => throw Exception(),
          );
        },
        act: (bloc) => bloc.add(
          FetchComments(postId: 1),
        ),
        expect: () => <CommentsState>[CommentsLoading(), CommentsFailure()],
      );
    },
  );
}
