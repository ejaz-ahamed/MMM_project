import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mmm_project/model/comment_model.dart';
import 'package:mmm_project/model/post_model.dart';

class ApiServices {
  static final dio =
      Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));

  static Future<List<PostModel>> getPosts(int page) async {
    final postPath = '/posts?_page=$page&_limit=20';
    try {
      final response = await dio.get(postPath);
      if (response.statusCode == 200) {
        final posts = (response.data as List)
            .map((json) => PostModel.fromJson(json))
            .toList();
        return posts;
      } else {
        throw Exception('Cannot fetch posts .Try again');
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<PostModel> getPostDetails(int postId) async {
    try {
      final response = await dio.get('/posts/$postId');
      return PostModel.fromJson(response.data);
    } on DioException catch (e) {
      throw e.message ?? "Something went wrong, please try again.";
    }
  }

  static Future<List<CommentModel>> getComments(int postId) async {
    try {
      final response = await dio.get('/posts/$postId/comments');
      final comments =
          (response.data as List).map((e) => CommentModel.fromJson(e)).toList();
      return comments;
    } on DioException catch (e) {
      throw e.message ?? "Something went wrong, please try again.";
    }
  }
}
