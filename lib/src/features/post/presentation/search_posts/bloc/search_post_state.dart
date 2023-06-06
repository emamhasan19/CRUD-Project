import 'package:equatable/equatable.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  final SearchStatus status;
  final List<PostEntity> searchResults;
  final String errorMessage;

  const SearchState({
    required this.status,
    required this.searchResults,
    required this.errorMessage,
  });

  factory SearchState.initial() {
    return const SearchState(
      status: SearchStatus.initial,
      searchResults: [],
      errorMessage: '',
    );
  }

  SearchState copyWith({
    SearchStatus? status,
    List<PostEntity>? searchResults,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      searchResults: searchResults ?? this.searchResults,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, searchResults, errorMessage];
}
