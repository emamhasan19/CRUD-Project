import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';
import 'package:flutter_details/src/features/post/root/domain/use_cases/get_all_posts_use_case.dart';

part 'post_event.dart';
part 'post_state.dart';

// class PostBloc extends Bloc<PostEvent, PostState> {
//   PostBloc({required this.getAllPosts, required this.addPostBloc})
//       : super(const PostState()) {
//     on<PostFetchedEvent>(_onPostFetchedEvent);
//     addPostBloc.stream.listen((event) {
//       if (event is AddPostButtonPressed) {
// // Dispatch the event to add the new post to the post list
//         add(PostAddedEvent(newPost: event.post));
//       }
//     });
//   }
//   final AddPostBloc addPostBloc;
//
//   final GetAllPosts getAllPosts;
//
//   void onPostAddedEvent(PostAddedEvent event, Emitter<PostState> emit) {
//     final updatedPosts = List<PostEntity>.from(state.posts);
//     updatedPosts.add(event.newPost);
//
//     emit(state.copyWith(posts: updatedPosts));
//   }
//
//   Future<void> _onPostFetchedEvent(
//     PostFetchedEvent event,
//     Emitter<PostState> emit,
//   ) async {
//     emit(state.copyWith(status: PostStatus.initial));
//     try {
//       final response = await getAllPosts.call();
//
//       response.fold(
//         (l) => emit(
//           state.copyWith(
//             status: PostStatus.failure,
//             errorMessage: l,
//           ),
//         ),
//         (r) => emit(
//           state.copyWith(
//             status: PostStatus.success,
//             posts: r,
//           ),
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: PostStatus.failure,
//           errorMessage: e.toString(),
//         ),
//       );
//     }
//   }
// }

// class PostBloc extends Bloc<PostEvent, PostState> {
//   final GetAllPosts getAllPosts;
//
//   PostBloc({required this.getAllPosts}) : super(const PostState()) {
//     on<PostFetchedEvent>(_onPostFetchedEvent);
//   }
//
//   Future<void> _onPostFetchedEvent(
//     PostFetchedEvent event,
//     Emitter<PostState> emit,
//   ) async {
//     emit(state.copyWith(status: PostStatus.initial));
//     try {
//       final response = await getAllPosts.call();
//
//       response.fold(
//         (l) => emit(
//           state.copyWith(
//             status: PostStatus.failure,
//             errorMessage: l,
//           ),
//         ),
//         (r) => emit(
//           state.copyWith(
//             status: PostStatus.success,
//             posts: r,
//           ),
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: PostStatus.failure,
//           errorMessage: e.toString(),
//         ),
//       );
//     }
//   }
// }

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPosts getAllPosts;

  PostBloc({required this.getAllPosts}) : super(const PostState()) {
    on<PostFetchedEvent>(_onPostFetchedEvent);
    on<PostAddedEvent>(_onPostAddedEvent);
  }

  Future<void> _onPostFetchedEvent(
    PostFetchedEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(status: PostStatus.initial));
    try {
      final response = await getAllPosts.call();

      response.fold(
        (l) => emit(
          state.copyWith(
            status: PostStatus.failure,
            errorMessage: l,
          ),
        ),
        (r) => emit(
          state.copyWith(
            status: PostStatus.success,
            posts: r,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onPostAddedEvent(
    PostAddedEvent event,
    Emitter<PostState> emit,
  ) async {
    try {
      print("try1");
      // Perform the logic to add the post here
      // Example: Call an API to add the post and handle the response

      // Assuming the post is successfully added
      final newPost = event.newPost;
      final updatedPosts = List<PostEntity>.from(state.posts);
      updatedPosts.add(newPost);

      print("updatedPosts are: ${updatedPosts}");
      print(updatedPosts[updatedPosts.length - 1].body);
      print("try2");

      emit(
        state.copyWith(
          status: PostStatus.success,
          posts: updatedPosts,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
