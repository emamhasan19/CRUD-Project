// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'details_page_event.dart';
part 'details_page_state.dart';

class DetailsPageBloc extends Bloc<DetailsPageEvent, DetailsPageState> {
  DetailsPageBloc() : super(DetailsInitial()) {
    on<ShowDetailsEvent>((event, emit) {
      try {
        // Show loading state
        emit(DetailsLoading());
        // Show loaded state
        emit(DetailsLoaded());
      } catch (error) {
        // Handle error state
        emit(DetailsError('Failed to fetch posts: $error'));
      }
    });
  }
}
