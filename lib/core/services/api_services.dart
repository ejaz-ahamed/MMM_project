import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mmm_project/model/post_model.dart';

class ApiServices {
  static final dio = Dio();

  static Future<List<PostModel>> getPosts() async {
    const baseUrl = 'https://jsonplaceholder.typicode.com/posts';
    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        final posts = response.data;
        return posts;
      } else {
        throw Exception('Cannot fetch posts .Try again');
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
