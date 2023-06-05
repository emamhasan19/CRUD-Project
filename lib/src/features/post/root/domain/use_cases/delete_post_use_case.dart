import 'package:dartz/dartz.dart';
import 'package:flutter_details/src/features/post/root/data/repositories/post_repository_impl.dart';
import 'package:flutter_details/src/features/post/root/domain/repositories/post_repositories.dart';

class DeletePostUseCase {
  final PostRepository postRepository = PostRepositoryIml();

  Future<Either<String, bool>> execute(int postId) async {
    return await postRepository.deletePosts(postId);
  }
}
