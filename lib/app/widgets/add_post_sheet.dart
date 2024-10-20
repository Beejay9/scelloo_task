import 'package:flutter/material.dart';
import 'package:scelloo_task/app/constants/app_colors.dart';
import 'package:scelloo_task/app/widgets/custom_textfield.dart';
import 'package:scelloo_task/app/widgets/custom_texts.dart';
import 'package:scelloo_task/models/post.dart';

class AddPostSheet extends StatefulWidget {
  const AddPostSheet({
    super.key,
    // required this.posts,
    // required this.onTap,
    this.isEdit = false,
    this.post,
  });

  // List<Post> posts;
  // final void Function()? onTap;
  final bool isEdit;
  final Post? post;

  @override
  State<AddPostSheet> createState() => _AddPostSheetState();
}

class _AddPostSheetState extends State<AddPostSheet> {
  final formKey = GlobalKey<FormState>();

  final contentFocusNode = FocusNode();

  Map<String, String> body = {
    'title': '',
    'content': '',
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: Colors.black,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            boldText(
              widget.isEdit ? 'Edit Post' : 'Add Post',
              fontSize: 25,
              textColor: AppColor.whiteTextColor,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hintText: 'enter your title',
              onSaved: (value) => body['title'] = value.toString(),
              initialValue: widget.isEdit ? widget.post?.title : null,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(contentFocusNode);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hintText: 'enter your content',
              maxLines: 7,
              focusNode: contentFocusNode,
              onSaved: (value) => body['content'] = value.toString(),
              initialValue: widget.isEdit ? widget.post?.content : null,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a content';
                }
                return null;
              },
            ),
            const Expanded(
              child: SizedBox(
                  // height: 100,
                  ),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  Navigator.of(context).pop(body);
                  // widget.onTap;
                  //  await PostRepository().addPost(body);
                  // widget.posts.insert(
                  //   0,
                  //   Post(
                  //     id: 2,
                  //     title: body['title'],
                  //     content: body['content'],
                  //     userId: 2,
                  //   ),
                  // );
                  debugPrint('Post has been added');
                  //
                }
              },
              style: TextButton.styleFrom(
                  backgroundColor: AppColor.bisqueColor,
                  foregroundColor: AppColor.mainTextColor,
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  )),
              child: buttonText(
                widget.isEdit ? 'Edit' : 'Post',
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
