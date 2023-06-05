import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';
import 'package:http/http.dart';

abstract class PostRemoteDataSource {
  Future<Response> getAllPosts();

  Future<Response> deletePost(int postId);

  Future<Response> updatePosts(PostEntity post);

  Future<Response> addPosts(PostEntity postEntity);
}
