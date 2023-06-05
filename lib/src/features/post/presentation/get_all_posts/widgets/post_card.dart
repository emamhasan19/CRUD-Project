import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/core/colors.dart';
import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_event.dart';
import 'package:flutter_details/src/features/post/presentation/edit_posts/pages/edit_post_page.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.index,
    required this.postEntity,
    required this.deletePostBloc,
  }) : super(key: key);

  final int index;
  final PostEntity postEntity;
  final DeletePostBloc deletePostBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      child: Card(
        color: index % 2 == 0 ? Palette.primary_color : Palette.secondary_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              color: index % 2 == 0
                  ? Palette.secondary_color
                  : Palette.primary_color,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 40,
            width: 40,
            child: Center(
              child: Text(
                "$index",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: index % 2 == 0
                      ? Palette.primary_color
                      : Palette.secondary_color,
                ),
              ),
            ),
          ),
          title: Text(
            (postEntity.title),
            style: TextStyle(
              fontSize: 20,
              color: index % 2 == 0
                  ? Palette.secondary_color
                  : Palette.primary_color,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
          subtitle: Text(
            postEntity.body,
            style: TextStyle(
              fontSize: 16,
              color: index % 2 == 0
                  ? Palette.secondary_color
                  : Palette.primary_color,
            ),
            maxLines: 1,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPostPage(post: postEntity),
                    ),
                  );
                },
                child: Icon(
                  Icons.edit_note,
                  size: 35,
                  color: index % 2 == 0
                      ? Palette.secondary_color
                      : Palette.primary_color,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  // Show a confirmation dialog here
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        'Confirm Delete',
                        style: TextStyle(color: Palette.primary_color),
                      ),
                      content: const Text(
                          'Are you sure you want to delete this post?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Dismiss the dialog
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Palette.primary_color),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();

                            // Trigger the DeletePostEvent with the post ID
                            BlocProvider.of<DeletePostBloc>(context)
                                .add(PostDeleteRequested(postEntity.id));

                            // deletePostBloc
                            //     .add(PostDeleteRequested(postEntity.id));
                            // Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Palette.primary_color),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Icon(
                  Icons.delete_sharp,
                  size: 30,
                  color: index % 2 == 0
                      ? Palette.secondary_color
                      : Palette.primary_color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
