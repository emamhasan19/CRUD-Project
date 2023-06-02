// part of 'add_post_bloc.dart';
//
// abstract class AddPostState extends Equatable {
//   const AddPostState();
// }
//
// class AddPostInitial extends AddPostState {
//   @override
//   List<Object> get props => [];
// }

// abstract class AddPostState extends Equatable {
//   const AddPostState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class AddPostInitial extends AddPostState {}
//
// class AddPostLoading extends AddPostState {}
//
// class AddPostSuccess extends AddPostState {}
//
// class AddPostFailure extends AddPostState {
//   final String error;
//
//   const AddPostFailure({required this.error});
//
//   @override
//   List<Object?> get props => [error];
// }

// import 'package:equatable/equatable.dart';
//
// abstract class AddPostState extends Equatable {
//   const AddPostState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class AddPostInitial extends AddPostState {}
//
// class AddPostLoading extends AddPostState {}
//
// class AddPostSuccess extends AddPostState {}
//
// class AddPostFailure extends AddPostState {
//   final String errorMessage;
//
//   const AddPostFailure(this.errorMessage);
//
//   @override
//   List<Object> get props => [errorMessage];
// }

import 'package:equatable/equatable.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';

enum AddPostStatus { initial, success, failure }

class AddPostState extends Equatable {
  final AddPostStatus status;
  final PostEntity? post;
  final String errorMessage;

  const AddPostState(
      {this.status = AddPostStatus.initial, this.post, this.errorMessage = ""});

  AddPostState copyWith({
    AddPostStatus? status,
    PostEntity? post,
    String? errorMessage,
  }) {
    return AddPostState(
      status: status ?? this.status,
      post: post ?? this.post,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, post, errorMessage];
}
