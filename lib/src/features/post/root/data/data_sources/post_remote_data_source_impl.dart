import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_details/src/features/post/root/data/data_sources/post_remote_data_source.dart';
import 'package:flutter_details/src/features/post/root/data/models/post_model.dart';
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
        'https://jsonplaceholder.typicode.com/posts',
      ),
    );

    return response;
  }

  // @override
  // Future<List<PostEntity>> addPost(PostEntity postEntity) async {
  //   // List<PostEntity> posts = (await getAllPosts()) as List<PostEntity>;
  //   // posts.add(postEntity);
  //   //
  //   // return posts;
  //
  //   final response = await http.post(
  //     Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=5'),
  //     body: {
  //       'title': postEntity.title,
  //       'body': postEntity.body,
  //       'userId': '1',
  //       'id': '1'
  //     },
  //   );
  //
  //   if (response.statusCode == 201) {
  //     final data = jsonDecode(response.body);
  //
  //     List<PostEntity> models = data
  //         .map<PostModel>((element) => PostModel.fromJson(element))
  //         .toList();
  //     // Post added successfully
  //     return models;
  //   } else {
  //     throw Exception('Failed to add post');
  //   }
  // }

  @override
  Future<Response> addPosts(PostEntity post) async {
    // print("Post body is: ${post.body}");
    // print("Post title is: ${post.title}");
    var client = http.Client();

    final response = await client.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: jsonEncode(
          post.toJson(),
        )
        // headers: {'Content-Type': 'application/json'},
        );
    print(response.body);
    print("Post body is: ${post.body}");
    print("Post title is: ${post.title}");
    return response;
  }

  @override
  Future<Unit> deletePost(int postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost(PostModel postModel) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
