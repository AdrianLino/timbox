import 'package:timbox/src/domain/models/PostData.dart';
import 'package:timbox/src/domain/repository/post_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:timbox/src/domain/utils/resource.dart';


class PostRepositoryImpl extends PostRepository{
  @override

   final baseUrl = 'https://jsonplaceholder.typicode.com/posts';


  Future<List<Post>> fetchPosts() async {
    final url = Uri.parse(baseUrl);
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData
            .take(10) // Limita a los primeros 10 elementos
            .map((item) => Post.fromJson(item))
            .toList();
      } else {
        throw Exception("Failed to load posts: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching posts: $e");
    }
  }


// Función para agregar un post
  Future<Resource> addPost(String title, String body) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'title': title,
        'body': body,
        'userId': 1, // Siempre se establece en 1
      }),
    );

    if (response.statusCode == 201) {
      return Success('Post agregado con éxito');
    } else {
      return Error('Error al agregar el post: ${response.statusCode}');
    }
  }

// Función para actualizar un post
  Future<Resource> updatePost(int id, String title, String body) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': id,
        'title': title,
        'body': body,
        'userId': 1, // Siempre se establece en 1
      }),
    );

    if (response.statusCode == 200) {
      return Success('Post actualizado con éxito');
    } else {
      return Error('Error al actualizar el post: ${response.statusCode}');
    }
  }

// Función para eliminar un post
  Future<Resource> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
    );

    if (response.statusCode == 200) {
      return Success('Post eliminado con éxito');
    } else {
      return Error('Error al eliminar el post: ${response.statusCode}');
    }
  }
}