import '../../repository/post_repository.dart';

class AddPostUseCase {
  final PostRepository _postRepository;

  AddPostUseCase(this._postRepository);

  launch({required String title,required String body}) {
    return _postRepository.addPost(title, body);
  }

}