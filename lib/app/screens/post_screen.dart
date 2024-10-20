import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scelloo_task/app/constants/app_colors.dart';
import 'package:scelloo_task/app/widgets/add_post_sheet.dart';
import 'package:scelloo_task/app/widgets/comments_card.dart';
import 'package:scelloo_task/app/widgets/custom_texts.dart';
import 'package:scelloo_task/blocs/comments/comments_bloc.dart';
import 'package:scelloo_task/blocs/posts/post_bloc.dart';
import 'package:scelloo_task/models/post.dart';
import 'package:scelloo_task/repositories/comment_repository.dart';
import 'package:scelloo_task/repositories/post_repository.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({
    super.key,
    required this.post,
    required this.postColor,
    required this.posts,
  });

  final Post post;
  final Color postColor;
  final List<Post> posts;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String? editedTitle;
  String? editedContent;
  Post? post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.postColor,
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }
          Navigator.of(context).pop(post);
        },
        child: BlocProvider(
          create: (context) => PostBloc(PostRepository()),
          child: BlocBuilder<PostBloc, PostState>(
            builder: (_, state) {
              return SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    // vertical: 15,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(post);
                          },
                          child: const CircleAvatar(
                            backgroundColor: AppColor.sColor,
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        boldText(
                          editedTitle ?? '${widget.post.title}',
                          fontSize: 35,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 26, 26, 26),
                              child: Icon(
                                Icons.person,
                                color: AppColor.whiteTextColor,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                regularText(
                                  'Posted by',
                                  textColor: AppColor.subTextColor,
                                  fontSize: 12,
                                ),
                                mediumText(
                                  widget.post.userId == 1 ? 'You' : 'John Doe',
                                  fontSize: 14,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                            if (widget.post.userId == 1)
                              const Expanded(
                                child: SizedBox(),
                              ),
                            if (widget.post.userId == 1)
                              GestureDetector(
                                onTap: () async {
                                  final result = await showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                      ),
                                    ),
                                    builder: (context) => AddPostSheet(
                                      isEdit: true,
                                      post: post ?? widget.post,
                                    ),
                                  );

                                  if (result != null) {
                                    editedTitle = result['title'];
                                    editedContent = result['content'];
                                    post = Post(
                                      id: widget.post.id,
                                      title: editedTitle,
                                      content: editedContent,
                                      userId: widget.post.userId,
                                    );
                                    setState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        margin: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          bottom: 10,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 20,
                                        ),
                                        backgroundColor: Colors.green,
                                        content: mediumText(
                                          'Your operation was successful',
                                          textColor: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const Icon(Icons.edit),
                              )
                          ],
                        ),
                        mediumText(
                          editedContent ?? '${widget.post.content}',
                          maxLines: 12,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BlocProvider(
                          create: (context) =>
                              CommentsBloc(CommentRepository()),
                          child: BlocConsumer<CommentsBloc, CommentsState>(
                            listener: (context, state) {
                              if (state is CommentsSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      bottom: 10,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 20,
                                    ),
                                    backgroundColor: Colors.green,
                                    content: mediumText(
                                      'Your operation was successful',
                                      textColor: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              }

                              if (state is CommentsFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      bottom: 10,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 20,
                                    ),
                                    backgroundColor: Colors.red,
                                    content: mediumText(
                                      'Your operation failed. Please try again',
                                      textColor: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is CommentsInitial) {
                                return ElevatedButton(
                                  onPressed: () {
                                    context.read<CommentsBloc>().add(
                                          FetchComments(
                                            postId: widget.post.id!,
                                          ),
                                        );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: buttonText(
                                    'Fetch Comments',
                                    color: Colors.white,
                                  ),
                                );
                              }
                              if (state is CommentsFailure) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        mediumText(
                                          'Oops! Something went wrong',
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context.read<CommentsBloc>().add(
                                                  FetchComments(
                                                    postId: widget.post.id!,
                                                  ),
                                                );
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor:
                                                AppColor.whiteTextColor,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 26, 26, 26),
                                            padding: const EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                            ),
                                          ),
                                          child: buttonText('Retry',
                                              color: AppColor.whiteTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              if (state is CommentsLoading) {
                                return const Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (state is CommentsSuccess) {
                                if (state.comments.isEmpty) {
                                  return Align(
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: mediumText(
                                        'There are no comments on this post',
                                        fontSize: 18,
                                      ),
                                    ),
                                  );
                                }
                                return Column(
                                  children: state.comments
                                      .map(
                                        (comment) => CommentsCard(
                                          user: comment.email.toString(),
                                          comment: comment.content.toString(),
                                        ),
                                      )
                                      .toList(),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // )
          //   },
          // ),
        ),
      ),
    );
  }
}
