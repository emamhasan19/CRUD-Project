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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/features/post/root/domain/use_cases/create_post_use_case.dart';

import 'add_post_event.dart';
import 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final AddPostUseCase addPostUseCase;
  final BuildContext context;

  AddPostBloc({required this.addPostUseCase, required this.context})
      : super(const AddPostState()) {
    on<AddPostButtonPressed>(_onPostAddedEvent);
  }

  void _onPostAddedEvent(
    AddPostButtonPressed event,
    Emitter<AddPostState> emit,
  ) async {
    // await Future.delayed(const Duration(seconds: 1));
    try {
      emit(state.copyWith(status: AddPostStatus.loading));
      await addPostUseCase.execute(event.newPost);
      emit(state.copyWith(status: AddPostStatus.success, post: event.newPost));
    } catch (error) {
      emit(state.copyWith(
        status: AddPostStatus.failure,
        errorMessage: 'Failed to add post.',
      ));
    }
  }
}
