import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_details/src/features/post/root/data/data_sources/post_remote_data_source.dart';
import 'package:flutter_details/src/features/post/root/data/data_sources/post_remote_data_source_impl.dart';
import 'package:flutter_details/src/features/post/root/data/models/post_model.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';
import 'package:flutter_details/src/features/post/root/domain/repositories/post_repositories.dart';
import 'package:http/http.dart';

class PostRepositoryIml implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource = PostRemoteDataSourceImp();

  @override
  Future<Either<String, List<PostEntity>>> getAllPosts() async {
    try {
      final Response response = await postRemoteDataSource.getAllPosts();

      final data = jsonDecode(response.body);

      List<PostEntity> models = data
          .map<PostModel>((element) => PostModel.fromJson(element))
          .toList();

      return Right(models);
    } catch (e) {
      return Left((e.toString()));
    }
  }

  @override
  Future<Either<String, PostEntity>> addPosts(PostEntity post) async {
    try {
      final Response response = await postRemoteDataSource.addPosts(post);
      if (response.statusCode == 201) {
        return Right(post);
      } else {
        throw ("Failed to add post due to ${response.statusCode} error!");
      }
    } catch (e) {
      return Left((e.toString()));
    }
  }

  @override
  Future<Either<String, bool>> deletePosts(int postId) async {
    try {
      final Response response = await postRemoteDataSource.deletePost(postId);
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        throw ("Failed to delete post due to ${response.statusCode} error!");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, PostEntity>> editPosts(PostEntity post) async {
    try {
      final Response response =
          await postRemoteDataSource.updatePosts(post, post.id);

      if (response.statusCode == 200) {
        return Right(post);
      } else {
        throw ("this is error");
      }
    } catch (e) {
      return Left((e.toString()));
    }
  }
}
