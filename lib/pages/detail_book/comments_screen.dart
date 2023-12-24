import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/models/book.model.dart';
import 'package:thu_vien_sach/pages/detail_book/comment_provider.dart';
import 'package:thu_vien_sach/utils/constant.dart';

class CommentScreen extends StatelessWidget {
  final Book book;
  final TextEditingController _controller = TextEditingController();
  CommentScreen({super.key, required this.book});
  @override
  Widget build(BuildContext context) {
    final provider = context.read<CommnetProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bình luận'),
      ),
      body: FutureBuilder<void>(
          future: provider.getComments(book.id ?? ''),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: context.watch<CommnetProvider>().comments.isEmpty
                      ? const Center(
                          child: Text('Chưa có nhận xét gì'),
                        )
                      : ListView(
                          children: [
                            for (var comment
                                in context.watch<CommnetProvider>().comments)
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      '${Constant.api}/${comment.user!.image}'),
                                ),
                                title: Text('${comment.user!.username}'),
                                subtitle: Text('${comment.content}'),
                                trailing: provider.isOwner(comment)
                                    ? IconButton(
                                        onPressed: () {
                                          provider.deleteComment(
                                              book.id!, comment.id!);
                                        },
                                        icon: const Icon(Icons.delete),
                                      )
                                    : null,
                              ),
                          ],
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 1,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Nhập bình luận',
                            border: InputBorder.none,
                          ),
                          controller: _controller,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          provider.addComment(book.id ?? '', _controller.text);
                          _controller.clear();
                        },
                        icon: const Icon(Icons.send),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
