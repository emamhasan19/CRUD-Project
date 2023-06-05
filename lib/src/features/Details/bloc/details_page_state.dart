part of 'details_page_bloc.dart';

@immutable
abstract class DetailsPageState {}

class DetailsInitial extends DetailsPageState {}

class DetailsLoading extends DetailsPageState {}

class DetailsLoaded extends DetailsPageState {
  // final PostModel post;
  //
  // DetailsLoaded(this.post);
  //
  // List<Object?> get props => [post];
}

class DetailsError extends DetailsPageState {
  final String errorMessage;

  DetailsError(this.errorMessage);

  List<Object?> get props => [errorMessage];
}
