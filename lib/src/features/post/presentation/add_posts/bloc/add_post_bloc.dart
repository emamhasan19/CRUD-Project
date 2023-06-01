// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
//
// part 'add_post_event.dart';
// part 'add_post_state.dart';
//
// class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
//   AddPostBloc() : super(AddPostInitial()) {
//     on<AddPostEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

// import 'package:bloc/bloc.dart';
// import 'package:your_app_name/features/homePage/domain/usecases/add_post_usecase.dart';
// import 'package:your_app_name/features/homePage/presentation/bloc/add_post_event.dart';
// import 'package:your_app_name/features/homePage/presentation/bloc/add_post_state.dart';
//
// class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
//   final AddPostUseCase addPostUseCase;
//
//   AddPostBloc({required this.addPostUseCase}) : super(AddPostInitial());
//
//   @override
//   Stream<AddPostState> mapEventToState(AddPostEvent event) async* {
//     if (event is AddPostButtonPressed) {
//       yield AddPostLoading();
//
//       try {
//         await addPostUseCase.execute(event.post);
//         yield AddPostSuccess();
//       } catch (error) {
//         yield AddPostFailure(error: 'Failed to add post: $error');
//       }
//     }
//   }
// }

// class PostBloc extends Bloc<PostEvent, PostState> {
//   PostBloc({required this.getAllPosts}) : super(const PostState()) {
//     on<PostFetchedEvent>(_onPostFetchedEvent);
//   }
//
//   final GetAllPosts getAllPosts;
//
//   Future<void> _onPostFetchedEvent(
//     PostFetchedEvent event,
//     Emitter<PostState> emit,
//   ) async {
//     emit(state.copyWith(status: AddPostStatus.initial));
//     try {
//       final response = await getAllPosts.call();
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
//             posts: r,
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

// class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
//   AddPostBloc({required this.getAllPosts}) : super(const AddPostState()) {
//     on<PostAddedEvent>(_onPostAddedEvent);
//   }
//
//   void _onPostAddedEvent(
//     PostAddedEvent event,
//     Emitter<AddPostState> emit,
//   ) {
//     List<PostEntity> updatedPosts = List.from(state.posts);
//     updatedPosts.add(event.newPost);
//     emit(state.copyWith(posts: updatedPosts));
//   }
// }
//
// import 'package:bloc/bloc.dart';
// import 'package:your_app_name/features/homePage/domain/usecases/add_post_usecase.dart';
// import 'package:your_app_name/features/homePage/presentation/bloc/add_post_event.dart';
// import 'package:your_app_name/features/homePage/presentation/bloc/add_post_state.dart';
//
// class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
//   final AddPostUseCase addPostUseCase;
//
//   AddPostBloc({required this.addPostUseCase}) : super(AddPostInitial());
//
//   @override
//   Stream<AddPostState> mapEventToState(AddPostEvent event) async* {
//     if (event is AddPostButtonPressed) {
//       yield AddPostLoading();
//
//       try {
//         await addPostUseCase.execute(event.post);
//         yield AddPostSuccess();
//       } catch (error) {
//         yield AddPostFailure(error: 'Failed to add post: $error');
//       }
//     }
//   }
// }

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_event.dart';
// import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_state.dart';
// import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';
// import 'package:flutter_details/src/features/post/root/domain/use_cases/create_post_use_case.dart';
//
// class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
//   final AddPostUseCase addPostUseCase;
//
//   AddPostBloc({required this.addPostUseCase}) : super(const AddPostState()) {
//     on<AddPostButtonPressed>(_onPostAddedEvent);
//   }
//
//   Future<void> _onPostAddedEvent(
//     AddPostButtonPressed event,
//     Emitter<AddPostState> emit,
//   ) async {
//     try {
//       final post =
//           await addPostUseCase.execute(event.newPost.title, event.newPost.body);
//       List<PostEntity> updatedPosts = List.from(state.posts);
//       updatedPosts.add(post);
//       // emit(state.copyWith(posts: updatedPosts));
//       emit(
//         state.copyWith(
//           status: AddPostStatus.success,
//           posts: updatedPosts,
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

// Stream<AddPostState> mapEventToState(AddPostEvent event) async* {
//   if (event is AddPostButtonPressed) {
//     yield AddPostLoading();
//
//     try {
//       await addPostUseCase.execute(event.title, event.body);
//       yield AddPostSuccess();
//     } catch (error) {
//       yield AddPostFailure(error.toString());
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_event.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_state.dart';
import 'package:flutter_details/src/features/post/root/domain/use_cases/create_post_use_case.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final AddPostUseCase addPostUseCase;

  AddPostBloc({required this.addPostUseCase}) : super(const AddPostState()) {
    on<AddPostButtonPressed>(_onPostAddedEvent);
  }

  // void _onPostAddedEvent(
  //   AddPostButtonPressed event,
  //   Emitter<AddPostState> emit,
  // ) {
  //   addPostUseCase.execute(event.newPost);
  // }
  Future<void> _onPostAddedEvent(
    AddPostButtonPressed event,
    Emitter<AddPostState> emit,
  ) async {
    addPostUseCase.execute(event.newPost);
    // List<PostEntity> updatedPosts = List.from(state.posts);
    // updatedPosts.add(event.newPost);
    // emit(state.copyWith(posts: updatedPosts, status: AddPostStatus.success));
  }
}
