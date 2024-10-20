import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scelloo_task/models/comment.dart';

class CommentRepository {
  Future<List<Comment>> fetchComments(int postId) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId/comments'),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body) as List;
      debugPrint('bal bal is $data');
      if (data.isNotEmpty) {
        final comments = List.from(data)
            .map(
              (comment) => Comment.fromJson(comment),
            )
            .toList();
        debugPrint('respose is ${comments.first.name}');
        return comments;
      }
      return [];
    } else {
      throw Exception();
    }
  }
}
