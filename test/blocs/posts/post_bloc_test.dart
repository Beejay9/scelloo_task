import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scelloo_task/blocs/comments/comments_bloc.dart';
import 'package:scelloo_task/blocs/posts/post_bloc.dart';
import 'package:scelloo_task/models/comment.dart';
import 'package:scelloo_task/models/post.dart';
import 'package:scelloo_task/repositories/post_repository.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  group(
    'tests for fetching posts',
    () {
      final mockPostRepository = MockPostRepository();

      final posts = [
        Post(
          id: 1,
          title: 'Post title',
          content: 'Post content',
          userId: 1,
        ),
      ];
      blocTest<PostBloc, PostState>(
        'this is to test for successful fetching of all posts',
        build: () => PostBloc(mockPostRepository),
        setUp: () {
          when(() => mockPostRepository.fetchPosts())
              .thenAnswer((_) => Future.value(posts));
        },
        act: (bloc) => bloc.add(FetchPosts()),
        expect: () => <PostState>[PostLoading(), PostSuccess(posts)],
      );

      blocTest<PostBloc, PostState>(
        'this is to test exceptions when fetching all posts',
        build: () => PostBloc(mockPostRepository),
        setUp: () {
          when(() => mockPostRepository.fetchPosts()).thenAnswer(
            (_) => throw Exception(),
          );
        },
        act: (bloc) => bloc.add(FetchPosts()),
        expect: () => <PostState>[PostLoading(), PostFailure()],
      );
    },
  );

  group(
    'tests for adding posts',
    () {
      final mockPostRepository = MockPostRepository();

      final posts = [
        Post(
          id: 1,
          title: 'Post title',
          content: 'Post content',
          userId: 1,
        ),
      ];
      blocTest<PostBloc, PostState>(
        'this is to test for successful adding of post',
        build: () => PostBloc(mockPostRepository),
        setUp: () {
          when(() => mockPostRepository.addPost({
                'title': 'this is the title',
                'content': 'this is the content',
              }, posts)).thenAnswer(
            (_) => Future.value(posts),
          );
        },
        act: (bloc) => bloc.add(
          AddPost(
            body: const {
              'title': 'this is the title',
              'content': 'this is the content',
            },
            posts: posts,
          ),
        ),
        expect: () => <PostState>[
          PostLoading(),
          PostSuccess(posts),
        ],
      );

      blocTest<PostBloc, PostState>(
        'this is to test exceptions when adding post',
        build: () => PostBloc(mockPostRepository),
        setUp: () {
          when(() => mockPostRepository.addPost({
                'title': 'this is the title',
                'content': 'this is the content',
              }, posts)).thenAnswer(
            (_) => throw Exception(),
          );
        },
        act: (bloc) => bloc.add(AddPost(body: const {
          'title': 'this is the title',
          'content': 'this is the content',
        }, posts: posts)),
        expect: () => <PostState>[PostLoading(), PostFailure()],
      );
    },
  );

  group(
    'tests for deleting posts',
    () {
      final mockPostRepository = MockPostRepository();

      final posts = [
        Post(
          id: 1,
          title: 'Post title',
          content: 'Post content',
          userId: 1,
        ),
      ];
      blocTest<PostBloc, PostState>(
        'this is to test for successful deleting of a post',
        build: () => PostBloc(mockPostRepository),
        setUp: () {
          when(() => mockPostRepository.deletePost(1, posts))
              .thenAnswer((_) => Future.value(posts));
        },
        act: (bloc) => bloc.add(DeletePost(postId: 1, posts: posts)),
        expect: () => <PostState>[PostLoading(), PostSuccess(posts)],
      );

      blocTest<PostBloc, PostState>(
        'this is to test exceptions when deleting a post',
        build: () => PostBloc(mockPostRepository),
        setUp: () {
          when(() => mockPostRepository.deletePost(1, posts)).thenAnswer(
            (_) => throw Exception(),
          );
        },
        act: (bloc) => bloc.add(DeletePost(postId: 1, posts: posts)),
        expect: () => <PostState>[PostLoading(), PostFailure()],
      );
    },
  );
}
