// class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
//   final AddPostUseCase addPostUseCase;
//
//   AddPostBloc({required this.addPostUseCase})
//       : super(AddPostState(
//             post: PostEntity(userId: 0, id: 0, title: '', body: ''))) {
//     on<AddPostButtonPressed>(_onPostAddedEvent);
//   }
//
//   // void _onPostAddedEvent(
//   //   AddPostButtonPressed event,
//   //   Emitter<AddPostState> emit,
//   // ) {
//   //   addPostUseCase.execute(event.newPost);
//   // }
//   Future<void> _onPostAddedEvent(
//     AddPostButtonPressed event,
//     Emitter<AddPostState> emit,
//   ) async {
//     addPostUseCase.execute(event.newPost);
//     // List<PostEntity> updatedPosts = List.from(state.posts);
//     // updatedPosts.add(event.newPost);
//     // emit(state.copyWith(posts: updatedPosts, status: AddPostStatus.success));
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/get_all_posts/bloc/post_bloc.dart';
import 'package:flutter_details/src/features/post/root/domain/use_cases/create_post_use_case.dart';

import 'add_post_event.dart';
import 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final AddPostUseCase addPostUseCase;
  // final BuildContext context;
  final BuildContext postBlocContext;

  AddPostBloc({required this.addPostUseCase, required this.postBlocContext})
      : super(const AddPostState()) {
    on<AddPostButtonPressed>(_onPostAddedEvent);
  }

  void _onPostAddedEvent(
    AddPostButtonPressed event,
    Emitter<AddPostState> emit,
  ) async {
    try {
      print("hiiiii");
      emit(state.copyWith(status: AddPostStatus.initial));
      await addPostUseCase.execute(event.newPost);
      emit(state.copyWith(status: AddPostStatus.success)); //new
      BlocProvider.of<PostBloc>(postBlocContext)
          .add(PostAddedEvent(newPost: event.newPost));
    } catch (error) {
      print("failed");
      emit(state.copyWith(
        status: AddPostStatus.failure,
        errorMessage: 'Failed to add post.',
      ));
    }
  }
}

//   Future<void> _onPostAddedEvent(
//     AddPostButtonPressed event,
//     Emitter<AddPostState> emit,
//   ) async {
//     emit(state.copyWith(status: AddPostStatus.initial));
//     try {
//       final response = await addPostUseCase.execute(event.newPost);
//
//       response.fold(
//         (l) => emit(
//           state.copyWith(
//             status: AddPostStatus.failure,
//             errorMessage: l,
//           ),
//         ),
//         (r) => emit(
//           state.copyWith(
//             status: AddPostStatus.success,
//             post: r,
//           ),
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: AddPostStatus.failure,
//           errorMessage: e.toString(),
//         ),
//       );
//     }
//   }
// }
