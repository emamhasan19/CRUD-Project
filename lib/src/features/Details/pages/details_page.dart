import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/core/colors.dart';
import 'package:flutter_details/src/features/Details/bloc/details_page_bloc.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';

class DetailsPage extends StatefulWidget {
  final PostEntity post;
  const DetailsPage({super.key, required this.post});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    context.read<DetailsPageBloc>().add(ShowDetailsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final postBloc = BlocProvider.of<PostBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary_color,
        title: const Text(
          'Post Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Palette.secondary_color,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<DetailsPageBloc, DetailsPageState>(
        listener: (context, state) {
          if (state is DetailsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        builder: (context, state) {
          // final post = widget.post;
          if (state is DetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailsLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Card(
                    elevation: 4,
                    color: Palette.secondary_color,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              widget.post.title,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Palette.primary_color,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Card(
                    elevation: 4,
                    color: Palette.primary_color,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                widget.post.body,
                                style: const TextStyle(
                                    fontSize: 20, color: Palette.white_color),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Text("Something went wrong");
          }
        },
      ),
    );
  }
}
