import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_state.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/pages/add_post_page.dart';
import 'package:flutter_details/src/features/post/presentation/edit_posts/pages/edit_post_page.dart';
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

  @override
  void initState() {
    super.initState();
    _postBloc = context.read<PostBloc>();
    _addPostBloc = context.read<AddPostBloc>();
    _postBloc.add(PostFetchedEvent());
  }

  @override
  void dispose() {
    _postBloc.close();
    _addPostBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildPostsList(state),
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
        child: const Icon(Icons.add),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const AddPostPage(),
      //       ),
      //     ).then((newPost) {
      //       print(newPost);
      //       if (newPost != null) {
      //         // Trigger the PostAddedEvent with the new post
      //         context.read<PostBloc>().add(PostAddedEvent(newPost: newPost));
      //       }
      //     });
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Widget _buildPostsList(PostState state) {
    switch (state.status) {
      case PostStatus.initial:
        return const Center(child: CircularProgressIndicator());

      case PostStatus.success:
        return state.posts.isNotEmpty
            ? ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (BuildContext context, int index) {
                  PostEntity postEntity = state.posts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditPostPage(post: postEntity)));
                    },
                    child: PostCard(
                      index: index + 1,
                      postEntity: postEntity,
                    ),
                  );
                },
              )
            : const Center(
                child: Text('No data found in server'),
              );

      case PostStatus.failure:
        return Center(child: Text(state.errorMessage));

      default:
        return Container();
    }
  }
}
