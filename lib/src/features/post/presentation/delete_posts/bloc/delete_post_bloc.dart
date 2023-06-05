import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_event.dart';
import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_state.dart';
import 'package:flutter_details/src/features/post/root/domain/use_cases/delete_post_use_case.dart';

class DeletePostBloc extends Bloc<DeletePostEvent, DeletePostState> {
  final DeletePostUseCase deletePostUseCase;

  DeletePostBloc({required this.deletePostUseCase})
      : super(DeletePostState.initial()) {
    on<PostDeleteRequested>(_onPostDeletedEvent);
  }

  // void _onPostDeletedEvent(
  //   PostDeleteRequested event,
  //   Emitter<DeletePostState> emit,
  // ) async {
  //   try {
  //     emit(state.copyWith(status: DeletePostStatus.initial));
  //     await deletePostUseCase.execute(event.postId);
  //     emit(state.copyWith(status: DeletePostStatus.success));
  //   } catch (error) {
  //     emit(state.copyWith(
  //       status: DeletePostStatus.failure,
  //       errorMessage: 'Failed to add post.',
  //     ));
  //   }
  // }
  void _onPostDeletedEvent(
    PostDeleteRequested event,
    Emitter<DeletePostState> emit,
  ) async {
    try {
      emit(state.copyWith(status: DeletePostStatus.initial));
      await deletePostUseCase.execute(event.postId);
      emit(state.copyWith(
          status: DeletePostStatus.success, postId: event.postId));
    } catch (error) {
      emit(state.copyWith(
        status: DeletePostStatus.failure,
        errorMessage: 'Failed to delete post.', // Update the error message here
      ));
    }
  }
}
