import '../models/PostData.dart';
import '../utils/resource.dart';

abstract class PostRepository {

  Future<List<Post>> fetchPosts();
  Future<Resource> addPost(String title, String body);
  Future<Resource> updatePost(int id, String title, String body);
  Future<Resource> deletePost(int id);

}