import 'package:timbox/src/domain/use_cases/post/update_post_usecase.dart';

import 'add_post_usecase.dart';
import 'delte_post_usecase.dart';
import 'fetchPost_usecase.dart';

class PostUseCases {

  FetchPostUseCase fetchPos;
  DeletePostUseCase deletePost;
  UpdatePostUseCase updatePost;
  AddPostUseCase addPost;


  PostUseCases({
    required this.fetchPos,
    required this.deletePost,
    required this.updatePost,
    required this.addPost
  });
}