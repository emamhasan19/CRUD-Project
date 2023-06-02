import 'package:dartz/dartz.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';
import 'package:http/http.dart';

abstract class PostRemoteDataSource {
  Future<Response> getAllPosts();

  Future<Unit> deletePost(int postId);

  Future<Response> updatePosts(PostEntity post, int id);

  Future<Response> addPosts(PostEntity postEntity);
}
