import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/search_posts/bloc/search_post_event.dart';
import 'package:flutter_details/src/features/post/presentation/search_posts/bloc/search_post_state.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<PostEntity> postList;

  SearchBloc(this.postList) : super(SearchState.initial()) {
    on<SearchQueryChanged>(_onSearchEvent);
  }

  Future<void> _onSearchEvent(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: SearchStatus.loading));

    try {
      final List<PostEntity> searchResults = postList.where((post) {
        return post.title.toLowerCase().contains(event.query.toLowerCase()) ||
            post.body.toLowerCase().contains(event.query.toLowerCase());
      }).toList();
      // print(searchResults);

      emit(
        state.copyWith(
          status: SearchStatus.success,
          searchResults: searchResults,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          errorMessage: 'Failed to perform search.',
        ),
      );
    }
  }
}
