// class AddPostUseCase {
//   final PostRepository postRepository = PostRepositoryIml();
//
//   Future<Either<String, List<PostEntity>>> call() async {
//     return await postRepository.addPosts(post);
//   }
// }

// class AddPostUseCase {
//   final PostRepository postRepository;
//
//   AddPostUseCase({required this.postRepository});
//
//   Future<void> execute(String title, String body) async {
//     final PostEntity post =
//         PostEntity(userId: 0, id: 0, title: title, body: body);
//     await postRepository.addPosts(post);
//   }
// }
import 'package:dartz/dartz.dart';
import 'package:flutter_details/src/features/post/root/data/repositories/post_repository_impl.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';
import 'package:flutter_details/src/features/post/root/domain/repositories/post_repositories.dart';

// class AddPostUseCase {
//   final PostRepository postRepository;
//
//   const AddPostUseCase(this.postRepository);
//
//   Future<void> execute(PostEntity post) async {
//     try {
//       await postRepository.addPosts(post);
//       // Post added successfully, you can emit a success state or perform any necessary actions
//     } catch (error) {
//       // Failed to add post, you can emit an error state or handle the error accordingly
//     }
//   }
// }

class AddPostUseCase {
  final PostRepository postRepository = PostRepositoryIml();

  Future<Either<String, PostEntity>> execute(PostEntity post) async {
    return await postRepository.addPosts(post);
    // Post added successfully, you can emit a success state or perform any necessary actions
  }
}
