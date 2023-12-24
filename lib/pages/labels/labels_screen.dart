import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/find/search_book_delegare.dart';
import 'package:thu_vien_sach/providers/category_provider.dart';

class LabelScreen extends StatelessWidget {
  const LabelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thể loại"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/search');\
              showSearch(context: context, delegate: SearchBookDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView(children: [
        Wrap(
          children: [
            for (var label in categoryProvider.categories)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/label',
                      arguments: label,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(label.name ?? ''),
                ),
              ),
          ],
        )
      ]),
    );
  }
}
