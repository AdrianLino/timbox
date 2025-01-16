import '../../repository/post_repository.dart';

class UpdatePostUseCase{
  final PostRepository _postRepository;

  UpdatePostUseCase(this._postRepository);


  launch({required int id,required String title,required String body}) {
    return _postRepository.updatePost(id, title, body);
  }

}