import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../../../domain/models/PostData.dart';
import '../../../../domain/use_cases/post/post_usecases.dart';
import '../../../../domain/utils/resource.dart';

class ServiciosViewmodel extends ChangeNotifier {
  final PostUseCases _repository;
  List<Post> _posts = [];
  bool _isLoading = false;

  ServiciosViewmodel(this._repository) {
    fetchPosts();
  }

  List<Post> get posts => _posts;

  bool get isLoading => _isLoading;

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final allPosts = await _repository.fetchPos.launch();
      _posts = allPosts.take(10)
          .toList(); // Limita los registros a los primeros 10 aquí
    } catch (e) {
      print("Error fetching posts: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> editPosts(int id, String title, String body, context) async {
    _isLoading = true;
    notifyListeners();

    final allPosts = await _repository.updatePost.launch(
        id: id, title: title, body: body);
    if (allPosts is Success) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        toastification.show(
          context: context,
          title: Text("Exito"),
          description: Text('Post actualizado correctamente'),
          type: ToastificationType.success,
          autoCloseDuration: Duration(seconds: 2),
          animationDuration: Duration(milliseconds: 300),
        );
        _isLoading = false;
        notifyListeners();
      }
      );
    }
  }

    Future<void> deletePosts(int id, context) async {
      _isLoading = true;
      notifyListeners();

      final allPosts = await _repository.deletePost.launch(id: id);
      if (allPosts is Success) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          toastification.show(
            context: context,
            title: Text("Exito"),
            description: Text('Post eliminado correctamente'),
            type: ToastificationType.success,
            autoCloseDuration: Duration(seconds: 2),
            animationDuration: Duration(milliseconds: 300),
          );
          _isLoading = false;
          notifyListeners();
        }
        );
      }
    }

      Future<void> createPosts(context,  String title, String body) async {
        _isLoading = true;
        notifyListeners();
          final allPosts = await _repository.addPost.launch(
              title: title, body: body);
        if (allPosts is Success) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            toastification.show(
              context: context,
              title: Text("Exito"),
              description: Text('Post creado correctamente'),
              type: ToastificationType.success,
              autoCloseDuration: Duration(seconds: 2),
              animationDuration: Duration(milliseconds: 300),
            );
            _isLoading = false;
            notifyListeners();
          }
          );
        }

      }
    }


