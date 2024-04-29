import 'package:flutter/material.dart';
import 'package:mmm_project/core/services/api_services.dart';
import 'package:mmm_project/model/post_model.dart';

class PostProvider extends ChangeNotifier {
  Future<List<PostModel>> getPosts() async {
    return await ApiServices.getPosts();
  }
}
