import '../../repository/post_repository.dart';

class FetchPostUseCase {
  final PostRepository _postRepository;

  FetchPostUseCase(this._postRepository);


  launch() async {
    return await _postRepository.fetchPosts();
  }
}