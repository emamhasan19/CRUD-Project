import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/features/post/root/domain/use_cases/update_post_use_case.dart';

import 'edit_post_event.dart';
import 'edit_post_state.dart';

class EditPostBloc extends Bloc<EditPostEvent, EditPostState> {
  final EditPostUseCase editPostUseCase;

  EditPostBloc({required this.editPostUseCase}) : super(const EditPostState()) {
    on<EditPostButtonPressed>(_onPostEditedEvent);
  }

  void _onPostEditedEvent(
    EditPostButtonPressed event,
    Emitter<EditPostState> emit,
  ) async {
    try {
      emit(state.copyWith(status: EditPostStatus.initial));
      await editPostUseCase.execute(event.updatedPost);
      emit(state.copyWith(
          status: EditPostStatus.success, post: event.updatedPost));
    } catch (error) {
      emit(state.copyWith(
        status: EditPostStatus.failure,
        errorMessage: 'Failed to add post.',
      ));
    }
  }
}
