import '../../repository/post_repository.dart';

class DeletePostUseCase {
  final PostRepository _postRepository;

  DeletePostUseCase(this._postRepository);

  launch({required int id}) {
    return _postRepository.deletePost(id);
  }

}