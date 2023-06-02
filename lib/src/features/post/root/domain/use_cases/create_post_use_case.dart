import 'package:dartz/dartz.dart';
import 'package:flutter_details/src/features/post/root/data/repositories/post_repository_impl.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';
import 'package:flutter_details/src/features/post/root/domain/repositories/post_repositories.dart';

class AddPostUseCase {
  final PostRepository postRepository = PostRepositoryIml();

  Future<Either<String, PostEntity>> execute(PostEntity post) async {
    return await postRepository.addPosts(post);
    // Post added successfully, you can emit a success state or perform any necessary actions
  }
}
