import 'dart:convert';

import 'package:dartz/dartz.dart';
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
    // print(response.body);
    // print("Post body is: ${post.body}");
    // print("Post title is: ${post.title}");
    return response;
  }

  @override
  Future<Unit> deletePost(int postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Response> updatePosts(PostEntity updatedPost, int id) async {
    // print("updated title: ${updatedPost.title}");
    // print("updated body: ${updatedPost.body}");
    // print("updated postId: ${updatedPost.id}");

    var client = http.Client();

    final url = 'https://jsonplaceholder.typicode.com/posts/$id';
    // print(url);
    final response = await client.put(
      Uri.parse(url),
      body:
          jsonEncode(updatedPost.toJson()), // Convert the updated post to JSON
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}
