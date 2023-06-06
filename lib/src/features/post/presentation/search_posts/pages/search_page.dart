// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_details/src/core/colors.dart';
// // import 'package:flutter_details/src/features/post/presentation/get_all_posts/bloc/post_bloc.dart';
// // import 'package:flutter_details/src/features/post/presentation/search_posts/bloc/search_post_bloc.dart';
// // import 'package:flutter_details/src/features/post/presentation/search_posts/bloc/search_post_event.dart';
// // import 'package:flutter_details/src/features/post/presentation/search_posts/bloc/search_post_state.dart';
// //
// // class SearchPage extends StatefulWidget {
// //   const SearchPage({Key? key}) : super(key: key);
// //
// //   @override
// //   _SearchPageState createState() => _SearchPageState();
// // }
// //
// // class _SearchPageState extends State<SearchPage> {
// //   late TextEditingController _searchController;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _searchController = TextEditingController();
// //   }
// //
// //   @override
// //   void dispose() {
// //     _searchController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     PostState postState = context.read<PostBloc>().state;
// //     return BlocProvider<SearchBloc>(
// //       create: (_) =>
// //           SearchBloc(postState.posts), // Provide an empty postList initially
// //       child: BlocBuilder<SearchBloc, SearchState>(
// //         builder: (context, state) {
// //           return Scaffold(
// //             appBar: AppBar(
// //               backgroundColor: Palette.primary_color,
// //               title: const Text('Search Page'),
// //               centerTitle: true,
// //             ),
// //             body: Column(
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Column(
// //                     children: [
// //                       TextField(
// //                         onChanged: (query) {
// //                           BlocProvider.of<SearchBloc>(context)
// //                               .add(SearchQueryChanged(query: query));
// //                         },
// //                         decoration: const InputDecoration(
// //                           labelText: 'Search',
// //                           prefixIcon: Icon(Icons.search),
// //                         ),
// //                       ),
// //                       ElevatedButton(
// //                         onPressed: () {
// //                           final query = _searchController.text;
// //                           BlocProvider.of<SearchBloc>(context)
// //                               .add(SearchQueryChanged(query: query));
// //                         },
// //                         child: const Text('Search'),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Expanded(
// //                   child: _buildSearchResults(state),
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget _buildSearchResults(SearchState state) {
// //     if (state.status == SearchStatus.loading) {
// //       return const Center(
// //         child: CircularProgressIndicator(),
// //       );
// //     } else if (state.status == SearchStatus.success) {
// //       return ListView.builder(
// //         itemCount: state.searchResults.length,
// //         itemBuilder: (context, index) {
// //           final post = state.searchResults[index];
// //           // Build your search results UI here
// //           return ListTile(
// //             title: Text(post.title),
// //             subtitle: Text(post.body),
// //             // Other UI components for each search result item
// //           );
// //         },
// //       );
// //     } else if (state.status == SearchStatus.failure) {
// //       return Center(
// //         child: Text(state.errorMessage),
// //       );
// //     } else {
// //       return const SizedBox.shrink();
// //     }
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_details/src/core/colors.dart';
// import 'package:flutter_details/src/features/post/presentation/search_posts/bloc/search_post_bloc.dart';
// import 'package:flutter_details/src/features/post/presentation/search_posts/bloc/search_post_event.dart';
// import 'package:flutter_details/src/features/post/presentation/search_posts/bloc/search_post_state.dart';
//
// class SearchPage extends StatelessWidget {
//   final TextEditingController? controller;
//
//   const SearchPage({Key? key, this.controller}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<SearchBloc>(
//       create: (_) => SearchBloc([]), // Provide an empty postList initially
//       child: BlocBuilder<SearchBloc, SearchState>(
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Palette.primary_color,
//               title: const Text('Search Page'),
//               centerTitle: true,
//             ),
//             body: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: controller,
//                         onChanged: (query) {
//                           BlocProvider.of<SearchBloc>(context)
//                               .add(SearchQueryChanged(query: query));
//                         },
//                         decoration: const InputDecoration(
//                           labelText: 'Search',
//                           prefixIcon: Icon(Icons.search),
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           final query = controller?.text ?? '';
//                           BlocProvider.of<SearchBloc>(context)
//                               .add(SearchQueryChanged(query: query));
//                         },
//                         child: const Text('Search'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: _buildSearchResults(state),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildSearchResults(SearchState state) {
//     if (state.status == SearchStatus.loading) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     } else if (state.status == SearchStatus.success) {
//       return ListView.builder(
//         itemCount: state.searchResults.length,
//         itemBuilder: (context, index) {
//           final post = state.searchResults[index];
//           // Build your search results UI here
//           return ListTile(
//             title: Text(post.title),
//             subtitle: Text(post.body),
//             // Other UI components for each search result item
//           );
//         },
//       );
//     } else if (state.status == SearchStatus.failure) {
//       return Center(
//         child: Text(state.errorMessage),
//       );
//     } else {
//       return const SizedBox.shrink();
//     }
//   }
// }
