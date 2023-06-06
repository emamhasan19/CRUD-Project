// searchbar in body and without using searchBloc

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
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';

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
  // late SearchBloc _searchBloc;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _postBloc = context.read<PostBloc>();
    _addPostBloc = context.read<AddPostBloc>();
    _editPostBloc = context.read<EditPostBloc>();
    _deletePostBloc = context.read<DeletePostBloc>();
    // _searchBloc = context.read<SearchBloc>();
    _postBloc.add(PostFetchedEvent());
  }

  @override
  void dispose() {
    _postBloc.close();
    _addPostBloc.close();
    _editPostBloc.close();
    _deletePostBloc.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary_color,
        title: const Text("TO-DO LIST"),
        centerTitle: true,
        // centerTitle: true,
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
                child: _buildPostsList(state),
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
        ),
      );
    } else if (state.status == PostStatus.failure) {
      return Text(state.errorMessage);
    } else if (state.status == PostStatus.success) {
      final List<PostEntity> posts = state.posts;
      // List<PostEntity> filteredPosts = _getFilteredPosts(posts);
      List<PostEntity> filteredPosts = _searchQuery.trim().isEmpty
          ? posts
          : posts.where((post) {
              final postTitle = post.title.toLowerCase();
              final postBody = post.body.toLowerCase();
              return postTitle.contains(_searchQuery.toLowerCase()) ||
                  postBody.contains(_searchQuery.toLowerCase());
            }).toList();

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search posts...',
                      border: const OutlineInputBorder(),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Palette.primary_color,
                      ),
                      suffixIcon: _searchQuery.trim().isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Palette.primary_color,
                              ),
                              onPressed: () {
                                setState(() {
                                  _searchQuery = '';
                                  _searchController.clear();
                                });
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
                return Dismissible(
                  key: Key(post.id.toString()),
                  background: Container(
                    color: Palette.primary_color,
                    alignment: Alignment.centerRight,
                    child: const Center(
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    BlocProvider.of<DeletePostBloc>(context)
                        .add(PostDeleteRequested(post.id));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: PostCard(
                      index: index + 1,
                      postEntity: post,
                      deletePostBloc: _deletePostBloc,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}

//using searchbar in appbar and searchBloc
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_details/src/core/colors.dart';
// import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_bloc.dart';
// import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_state.dart';
// import 'package:flutter_details/src/features/post/presentation/add_posts/pages/add_post_page.dart';
// import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_bloc.dart';
// import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_event.dart';
// import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_state.dart';
// import 'package:flutter_details/src/features/post/presentation/edit_posts/bloc/edit_post_bloc.dart';
// import 'package:flutter_details/src/features/post/presentation/edit_posts/bloc/edit_post_state.dart';
// import 'package:flutter_details/src/features/post/presentation/get_all_posts/bloc/post_bloc.dart';
// import 'package:flutter_details/src/features/post/presentation/get_all_posts/widgets/post_card.dart';
// import 'package:flutter_details/src/features/post/presentation/search_posts/bloc/search_post_bloc.dart';
// import 'package:flutter_details/src/features/post/presentation/search_posts/bloc/search_post_state.dart';
// import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';
//
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
//   late SearchBloc _searchBloc;
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//   bool _searchVisible = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _postBloc = context.read<PostBloc>();
//     _addPostBloc = context.read<AddPostBloc>();
//     _editPostBloc = context.read<EditPostBloc>();
//     _deletePostBloc = context.read<DeletePostBloc>();
//     _searchBloc = context.read<SearchBloc>();
//     _postBloc.add(PostFetchedEvent());
//   }
//
//   @override
//   void dispose() {
//     _postBloc.close();
//     _addPostBloc.close();
//     _editPostBloc.close();
//     _deletePostBloc.close();
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Palette.primary_color,
//         title: _searchVisible
//             ? TextField(
//                 controller: _searchController,
//                 onChanged: (value) {
//                   setState(() {
//                     _searchQuery = value;
//                   });
//                 },
//                 decoration: const InputDecoration(
//                   hintText: 'Search posts...',
//                   border: InputBorder.none,
//                   hintStyle: TextStyle(color: Palette.secondary_color),
//                 ),
//                 style: const TextStyle(color: Palette.secondary_color),
//               )
//             : const Text("TO-DO LIST"),
//         // centerTitle: true,
//         actions: [
//           IconButton(
//             icon: _searchVisible
//                 ? const Icon(Icons.clear)
//                 : const Icon(Icons.search),
//             onPressed: () {
//               setState(() {
//                 if (_searchVisible) {
//                   _searchQuery = '';
//                   _searchController.clear();
//                 }
//                 _searchVisible = !_searchVisible;
//               });
//             },
//           ),
//         ],
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
//               child: BlocListener<DeletePostBloc, DeletePostState>(
//                 listener: (context, deletePostState) {
//                   if (deletePostState.status == DeletePostStatus.initial) {
//                     showDialog(
//                       context: context,
//                       barrierDismissible: false,
//                       builder: (context) => const Stack(
//                         children: [
//                           Positioned.fill(
//                             child: Center(
//                               child: CircularProgressIndicator(
//                                 color: Palette.primary_color,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else if (deletePostState.status ==
//                       DeletePostStatus.success) {
//                     Navigator.pop(context);
//                     context
//                         .read<PostBloc>()
//                         .add(PostDeletedEvent(postId: deletePostState.postId));
//                     // Handle post deleted successfully, you can perform any necessary actions here
//                   } else if (deletePostState.status ==
//                       DeletePostStatus.failure) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(deletePostState.errorMessage),
//                       ),
//                     );
//                   }
//                 },
//                 child: _buildPostsList(state),
//               ),
//             ),
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
//         backgroundColor: Palette.primary_color,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   Widget _buildPostsList(PostState state) {
//     if (state.status == PostStatus.initial) {
//       return const Center(
//         child: CircularProgressIndicator(
//           color: Palette.primary_color,
//         ),
//       );
//     } else if (state.status == PostStatus.failure) {
//       return Text(state.errorMessage);
//     } else if (state.status == PostStatus.success) {
//       return Builder(
//         builder: (context) {
//           final List<PostEntity> postsToShow =
//               _searchBloc.state.status == SearchStatus.success
//                   ? _searchBloc.state.searchResults
//                   : state.posts;
//
//           final List<PostEntity> filteredPosts = postsToShow.where((post) {
//             final postTitle = post.title.toLowerCase();
//             final postBody = post.body.toLowerCase();
//             final searchQuery = _searchQuery.toLowerCase();
//             return postTitle.contains(searchQuery) ||
//                 postBody.contains(searchQuery);
//           }).toList();
//
//           return ListView.builder(
//             itemCount: filteredPosts.length,
//             itemBuilder: (context, index) {
//               final post = filteredPosts[index];
//               return Dismissible(
//                 key: Key(post.id.toString()),
//                 background: Container(
//                   color: Palette.primary_color,
//                   alignment: Alignment.centerRight,
//                   // padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: const Icon(
//                     Icons.delete,
//                     color: Colors.white,
//                   ),
//                 ),
//                 onDismissed: (direction) {
//                   BlocProvider.of<DeletePostBloc>(context)
//                       .add(PostDeleteRequested(post.id));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                   child: PostCard(
//                     index: index + 1,
//                     postEntity: post,
//                     deletePostBloc: _deletePostBloc,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       );
//     } else {
//       return Container();
//     }
//   }
// }

//without searchbar

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_details/src/core/colors.dart';
// import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_bloc.dart';
// import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_state.dart';
// import 'package:flutter_details/src/features/post/presentation/add_posts/pages/add_post_page.dart';
// import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_bloc.dart';
// import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_event.dart';
// import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_state.dart';
// import 'package:flutter_details/src/features/post/presentation/edit_posts/bloc/edit_post_bloc.dart';
// import 'package:flutter_details/src/features/post/presentation/edit_posts/bloc/edit_post_state.dart';
// import 'package:flutter_details/src/features/post/presentation/get_all_posts/bloc/post_bloc.dart';
// import 'package:flutter_details/src/features/post/presentation/get_all_posts/widgets/post_card.dart';
// import 'package:flutter_details/src/features/post/presentation/search_posts/pages/search_page.dart';
//
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
//         backgroundColor: Palette.primary_color,
//         title: const Text('Post'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const SearchPage()),
//               );
//             },
//           ),
//         ],
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
//               child: BlocListener<DeletePostBloc, DeletePostState>(
//                 listener: (context, deletePostState) {
//                   if (deletePostState.status == DeletePostStatus.initial) {
//                     showDialog(
//                       context: context,
//                       barrierDismissible: false,
//                       builder: (context) => const Stack(
//                         children: [
//                           Positioned.fill(
//                             child: Center(
//                               child: CircularProgressIndicator(
//                                 color: Palette.primary_color,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else if (deletePostState.status ==
//                       DeletePostStatus.success) {
//                     Navigator.pop(context);
//                     context
//                         .read<PostBloc>()
//                         .add(PostDeletedEvent(postId: deletePostState.postId));
//                     // Handle post deleted successfully, you can perform any necessary actions here
//                   } else if (deletePostState.status ==
//                       DeletePostStatus.failure) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(deletePostState.errorMessage),
//                       ),
//                     );
//                   }
//                 },
//                 child: _buildPostsList(state),
//               ),
//             ),
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
//         backgroundColor: Palette.primary_color,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   Widget _buildPostsList(PostState state) {
//     if (state.status == PostStatus.initial) {
//       return const Center(
//           child: CircularProgressIndicator(
//         color: Palette.primary_color,
//       ));
//     } else if (state.status == PostStatus.failure) {
//       return Text(state.errorMessage);
//     } else if (state.status == PostStatus.success) {
//       return Builder(
//         builder: (context) {
//           return ListView.builder(
//             itemCount: state.posts.length,
//             itemBuilder: (context, index) {
//               final post = state.posts[index];
//               return Dismissible(
//                 key: Key(post.id.toString()),
//                 background: Container(
//                   color: Palette.primary_color,
//                   alignment: Alignment.centerRight,
//                   // padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: const Icon(
//                     Icons.delete,
//                     color: Colors.white,
//                   ),
//                 ),
//                 onDismissed: (direction) {
//                   // Trigger the DeletePostEvent with the post ID
//                   // _deletePostBloc.add(PostDeleteRequested(post.id));
//                   BlocProvider.of<DeletePostBloc>(context)
//                       .add(PostDeleteRequested(post.id));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                   child: PostCard(
//                     index: index + 1,
//                     postEntity: post,
//                     deletePostBloc: _deletePostBloc,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       );
//     } else {
//       return Container();
//     }
//   }
// }
