import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';
import 'package:flutter_details/src/features/post/root/domain/use_cases/get_all_posts_use_case.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPosts getAllPosts;

  PostBloc({required this.getAllPosts}) : super(const PostState()) {
    on<PostFetchedEvent>(_onPostFetchedEvent);
    on<PostAddedEvent>(_onPostAddedEvent);
    on<PostEditedEvent>(_onPostEditedEvent);
    on<PostDeletedEvent>(_onPostDeletedEvent);
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
      final newPost = event.newPost;
      final updatedPosts = List<PostEntity>.from(state.posts);
      // updatedPosts.insert(0, newPost);
      updatedPosts.add(newPost);

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

  Future<void> _onPostEditedEvent(
    PostEditedEvent event,
    Emitter<PostState> emit,
  ) async {
    try {
      final PostEntity newPost = event.newPost;
      print("coming");
      // print(newPost.body);
      // print(newPost.title);
      // print(newPost.id);
      final updatedPosts = List<PostEntity>.from(state.posts);
      // print(updatedPosts[newPost.id-1]);
      // print(updatedPosts[newPost.id - 1].id);
      // print(updatedPosts[newPost.id - 1].title);
      // print(updatedPosts[newPost.id - 1].body);
      // updatedPosts.insert(0, newPost);
      // state.posts[newPost.id] = newPost;
      updatedPosts[newPost.id - 1] = newPost;

      // print(updatedPosts[newPost.id - 1].id);
      // print(updatedPosts[newPost.id - 1].title);
      // print(updatedPosts[newPost.id - 1].body);

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

  Future<void> _onPostDeletedEvent(
    PostDeletedEvent event,
    Emitter<PostState> emit,
  ) async {
    try {
      print("deletedtry");
      final postId = event.postId;
      final updatedPosts = List<PostEntity>.from(state.posts);

      // Find the index of the post to be deleted
      final index = updatedPosts.indexWhere((post) => post.id == postId);

      if (index != -1) {
        // Remove the post from the list
        updatedPosts.removeAt(index);

        emit(
          state.copyWith(
            status: PostStatus.success,
            posts: updatedPosts,
          ),
        );
      } else {
        // If the post was not found, emit a failure state
        emit(
          state.copyWith(
            status: PostStatus.failure,
            errorMessage: 'Post not found.',
          ),
        );
      }
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
