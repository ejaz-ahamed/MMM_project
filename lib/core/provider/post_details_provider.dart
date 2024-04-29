import 'package:flutter/material.dart';
import 'package:mmm_project/core/services/api_services.dart';
import 'package:mmm_project/model/comment_model.dart';
import 'package:mmm_project/model/post_model.dart';

class PostDetailsProvider extends ChangeNotifier {
  PostModel? _post;
  PostModel? get post {
    return _post;
  }

  final List<CommentModel> _comments = [];
  List<CommentModel> get comments {
    return _comments;
  }

  void clearComments() {
    _comments.clear();
    notifyListeners();
  }

  Future<void> getPostDetails(int postId) async {
    try {
      final post = await ApiServices.getPostDetails(postId);
      _post = post;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getComments(int postId) async {
    try {
      final comments = await ApiServices.getComments(postId);
      _comments.addAll(comments);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _post = null;
    _comments.clear();
    notifyListeners();
  }
}
