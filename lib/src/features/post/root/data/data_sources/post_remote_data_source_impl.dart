import 'dart:convert';

import 'package:flutter_details/src/features/post/root/data/data_sources/post_remote_data_source.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PostRemoteDataSourceImp implements PostRemoteDataSource {
  var client = http.Client();

  @override
  Future<Response> getAllPosts() async {
    var client = http.Client();
    var response = await client.get(
      Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_limit=5',
      ),
    );
    return response;
  }

  @override
  Future<Response> addPosts(PostEntity post) async {
    var client = http.Client();

    final response = await client.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=5'),
      body: jsonEncode(
        post.toJson(),
      ),
    );
    return response;
  }

  @override
  Future<Response> deletePost(int postId) async {
    var client = http.Client();

    final response = await client.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'),
    );

    return response;
  }

  @override
  Future<Response> updatePosts(PostEntity updatedPost, int id) async {
    var client = http.Client();

    final url = 'https://jsonplaceholder.typicode.com/posts/$id';
    final response = await client.put(
      Uri.parse(url),
      body: jsonEncode(updatedPost.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}
