import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/library/library_provider.dart';
import 'package:thu_vien_sach/pages/library/widgets/favorite_widget.dart';
import 'package:thu_vien_sach/pages/library/widgets/readings_widget.dart';

class LibrayScreen extends StatelessWidget {
  const LibrayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final libraryProvider = context.read<LibraryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thư viện"),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: libraryProvider.init(),
        builder: (context, snapshot) => libraryProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: const [
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Sách đang đọc',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ReadingsWidget(),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Sách yêu thích',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  FavoriteWidget()
                ],
              ),
      ),
    );
  }
}
