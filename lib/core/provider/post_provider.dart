import 'package:flutter/material.dart';
import 'package:mmm_project/core/services/api_services.dart';
import 'package:mmm_project/model/post_model.dart';

class PostProvider extends ChangeNotifier {
  final List<PostModel> _list = [];
  int page = 1;
  bool _isLast = false;

  bool get isLast {
    return _isLast;
  }

  List<PostModel> get posts {
    return _list;
  }

  Future<List<PostModel>> getPosts() async {
    final posts = await ApiServices.getPosts(1);
    _list.addAll(posts);
    notifyListeners();
    return _list;
  }

  Future<List<PostModel>> fetchMore() async {
    page++;
    final posts = await ApiServices.getPosts(page);
    if (posts.length < 20) {
      _isLast = true;
    }
    _list.addAll(posts);
    notifyListeners();
    return _list;
  }
}
