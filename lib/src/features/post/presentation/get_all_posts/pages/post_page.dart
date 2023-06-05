import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/core/colors.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_state.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/pages/add_post_page.dart';
import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_event.dart';
import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_state.dart';
import 'package:flutter_details/src/features/post/presentation/edit_posts/bloc/edit_post_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/edit_posts/bloc/edit_post_state.dart';
import 'package:flutter_details/src/features/post/presentation/get_all_posts/bloc/post_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/get_all_posts/widgets/post_card.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late PostBloc _postBloc;
  late AddPostBloc _addPostBloc;
  late EditPostBloc _editPostBloc;
  late DeletePostBloc _deletePostBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = context.read<PostBloc>();
    _addPostBloc = context.read<AddPostBloc>();
    _editPostBloc = context.read<EditPostBloc>();
    _deletePostBloc = context.read<DeletePostBloc>();
    _postBloc.add(PostFetchedEvent());
  }

  @override
  void dispose() {
    _postBloc.close();
    _addPostBloc.close();
    _editPostBloc.close();
    _deletePostBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary_color,
        title: const Text('Post'),
        centerTitle: true,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return BlocListener<AddPostBloc, AddPostState>(
            listener: (context, addPostState) {
              if (addPostState.status == AddPostStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(addPostState.errorMessage),
                  ),
                );
              }
            },
            child: BlocListener<EditPostBloc, EditPostState>(
              listener: (context, editPostState) {
                if (editPostState.status == EditPostStatus.success) {
                  // Handle post edited successfully, you can perform any necessary actions here
                } else if (editPostState.status == EditPostStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(editPostState.errorMessage),
                    ),
                  );
                }
              },
              child: BlocListener<DeletePostBloc, DeletePostState>(
                listener: (context, deletePostState) {
                  if (deletePostState.status == DeletePostStatus.initial) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Stack(
                        children: [
                          Positioned.fill(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Palette.primary_color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (deletePostState.status ==
                      DeletePostStatus.success) {
                    Navigator.pop(context);
                    context
                        .read<PostBloc>()
                        .add(PostDeletedEvent(postId: deletePostState.postId));
                    // Handle post deleted successfully, you can perform any necessary actions here
                  } else if (deletePostState.status ==
                      DeletePostStatus.failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(deletePostState.errorMessage),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildPostsList(state),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPostPage(),
            ),
          );
        },
        backgroundColor: Palette.primary_color,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPostsList(PostState state) {
    if (state.status == PostStatus.initial) {
      return const Center(
          child: CircularProgressIndicator(
        color: Palette.primary_color,
      ));
    } else if (state.status == PostStatus.failure) {
      return Text(state.errorMessage);
    } else if (state.status == PostStatus.success) {
      return Builder(
        builder: (context) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return Dismissible(
                key: Key(post.id.toString()),
                background: Container(
                  color: Palette.primary_color,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  // Trigger the DeletePostEvent with the post ID
                  _deletePostBloc.add(PostDeleteRequested(post.id));
                },
                child: PostCard(
                  index: index + 1,
                  postEntity: post,
                  deletePostBloc: _deletePostBloc,
                ),
              );
            },
          );
        },
      );
    } else {
      return Container();
    }
  }
}

//This is without delete

// class PostPage extends StatefulWidget {
//   const PostPage({Key? key}) : super(key: key);
//
//   @override
//   State<PostPage> createState() => _PostPageState();
// }
//
// class _PostPageState extends State<PostPage> {
//   late PostBloc _postBloc;
//   late AddPostBloc _addPostBloc;
//   late EditPostBloc _editPostBloc;
//
//   @override
//   void initState() {
//     super.initState();
//     _postBloc = context.read<PostBloc>();
//     _addPostBloc = context.read<AddPostBloc>();
//     _editPostBloc = context.read<EditPostBloc>();
//     _postBloc.add(PostFetchedEvent());
//   }
//
//   @override
//   void dispose() {
//     _postBloc.close();
//     _addPostBloc.close();
//     _editPostBloc.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Post'),
//       ),
//       body: BlocBuilder<PostBloc, PostState>(
//         builder: (context, state) {
//           return BlocListener<AddPostBloc, AddPostState>(
//             listener: (context, addPostState) {
//               if (addPostState.status == AddPostStatus.failure) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(addPostState.errorMessage),
//                   ),
//                 );
//               }
//             },
//             child: BlocListener<EditPostBloc, EditPostState>(
//               listener: (context, editPostState) {
//                 if (editPostState.status == EditPostStatus.success) {
//                   // Handle post edited successfully, you can perform any necessary actions here
//                 } else if (editPostState.status == EditPostStatus.failure) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(editPostState.errorMessage),
//                     ),
//                   );
//                 }
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: _buildPostsList(state),
//               ),
//             ),
//           );
//         },
//       ),
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const AddPostPage(),
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildPostsList(PostState state) {
//     switch (state.status) {
//       case PostStatus.initial:
//         return const Center(child: CircularProgressIndicator());
//
//       case PostStatus.success:
//         return state.posts.isNotEmpty
//             ? ListView.builder(
//                 itemCount: state.posts.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   PostEntity postEntity = state.posts[index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   EditPostPage(post: postEntity)));
//                     },
//                     child: PostCard(
//                       index: index + 1,
//                       postEntity: postEntity,
//                     ),
//                   );
//                 },
//               )
//             : const Center(
//                 child: Text('No data found in server'),
//               );
//
//       case PostStatus.failure:
//         return Center(child: Text(state.errorMessage));
//
//       default:
//         return Container();
//     }
//   }
// }
//
//
//

//this is only delete

// class PostPage extends StatefulWidget {
//   const PostPage({Key? key}) : super(key: key);
//
//   @override
//   State<PostPage> createState() => _PostPageState();
// }
//
// class _PostPageState extends State<PostPage> {
//   late PostBloc _postBloc;
//   late AddPostBloc _addPostBloc;
//   late EditPostBloc _editPostBloc;
//   late DeletePostBloc _deletePostBloc;
//
//   @override
//   void initState() {
//     super.initState();
//     _postBloc = context.read<PostBloc>();
//     _addPostBloc = context.read<AddPostBloc>();
//     _editPostBloc = context.read<EditPostBloc>();
//     _deletePostBloc = context.read<DeletePostBloc>();
//     _postBloc.add(PostFetchedEvent());
//   }
//
//   @override
//   void dispose() {
//     _postBloc.close();
//     _addPostBloc.close();
//     _editPostBloc.close();
//     _deletePostBloc.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Post'),
//       ),
//       body: BlocBuilder<PostBloc, PostState>(
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: _buildPostsList(state),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const AddPostPage(),
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   Widget _buildPostsList(PostState state) {
//     if (state.status == PostStatus.initial) {
//       return const CircularProgressIndicator();
//     } else if (state.status == PostStatus.failure) {
//       return Text(state.errorMessage);
//     } else if (state.status == PostStatus.success) {
//       return ListView.builder(
//         itemCount: state.posts.length,
//         itemBuilder: (context, index) {
//           final post = state.posts[index];
//           return Dismissible(
//             key: Key(post.id.toString()),
//             background: Container(
//               color: Colors.red,
//               alignment: Alignment.centerRight,
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: const Icon(
//                 Icons.delete,
//                 color: Colors.white,
//               ),
//             ),
//             onDismissed: (direction) {
//               // Trigger the DeletePostEvent with the post ID
//               _deletePostBloc.add(PostDeleteRequested(postId: post.id));
//             },
//             child: ListTile(
//               title: Text(post.title),
//               subtitle: Text(post.body),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => EditPostPage(post: post)));
//               },
//             ),
//           );
//         },
//       );
//     } else {
//       return Container();
//     }
//   }
// }
