import 'package:equatable/equatable.dart';

enum DeletePostStatus { initial, loading, success, failure }

class DeletePostState extends Equatable {
  final DeletePostStatus status;
  final String errorMessage;
  final int postId;

  const DeletePostState({
    required this.status,
    required this.errorMessage,
    required this.postId,
  });

  factory DeletePostState.initial() {
    return const DeletePostState(
      status: DeletePostStatus.initial,
      errorMessage: '',
      postId: 0,
    );
  }

  DeletePostState copyWith({
    DeletePostStatus? status,
    String? errorMessage,
    int? postId,
  }) {
    return DeletePostState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      postId: postId ?? this.postId,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, postId];
}
