import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scelloo_task/models/post.dart';

class PostRepository {
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final posts = List.from(data).map((post) => Post.fromJson(post)).toList();
      debugPrint('respose is ${posts.first.content}');
      return posts;
    } else {
      throw Exception();
    }
  }

  Future<List<Post>> addPost(Map<String, String> body, List<Post> posts) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'title': body['title'],
        'body': body['content'],
        'userId': 1,
        'postId': DateTime.now().millisecondsSinceEpoch,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint('post has been added successsfully');
      debugPrint('post response is ${jsonDecode(response.body)}');
      final json = jsonDecode(response.body);
      final newPost = Post.fromJson(json);
      posts.insert(0, newPost);
      return posts;
    } else {
      debugPrint('post adding failed');
      throw Exception();
    }
  }

  Future<List<Post>> deletePost(int postId, List<Post> posts) async {
    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      posts.removeWhere(
        (post) => post.newPostId == null
            ? post.id == postId
            : post.newPostId == postId,
      );
      debugPrint('Post has been successfully deleted');
      //  posts.remo
      return posts;
    } else {
      throw Exception();
    }
  }
}
