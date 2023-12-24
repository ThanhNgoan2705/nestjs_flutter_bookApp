import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/models/book.model.dart';
import 'package:thu_vien_sach/models/category.model.dart';
import 'package:thu_vien_sach/pages/admin/dashboard_provider.dart';
import 'package:thu_vien_sach/utils/constant.dart';

class AdminBookDetainScreen extends StatefulWidget {
  final Book? book;
  const AdminBookDetainScreen({Key? key, required this.book}) : super(key: key);

  @override
  State<AdminBookDetainScreen> createState() => _AdminBookDetainScreenState();
}

class _AdminBookDetainScreenState extends State<AdminBookDetainScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _authorController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();

  final TextEditingController _pageController = TextEditingController();

  final TextEditingController _fileController = TextEditingController();

  String _category = '';

  String _image = '';

  @override
  void initState() {
    _titleController.text = widget.book?.title ?? '';
    _authorController.text = widget.book?.author ?? '';
    _contentController.text = widget.book?.content ?? '';
    _category = widget.book == null || widget.book?.category == ''
        ? context.read<DashBoardProvider>().categories.first.id!
        : context
            .read<DashBoardProvider>()
            .categories
            .firstWhere((element) => element.id == widget.book!.category,
                orElse: () => Category(id: ''))
            .id!;
    _pageController.text = widget.book?.page.toString() ?? '0';
    _fileController.text = widget.book?.file ?? '';
    _image = widget.book?.image ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashBoardProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book?.title ?? 'Tạo sách'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // upload image
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (_image != '')
                    Image.network(
                      Constant.api + _image,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  if (_image == '')
                    const SizedBox(
                      height: 150,
                      child: Text('Chưa có ảnh'),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'png'],
                      );

                      if (result != null) {
                        final file = result.files.single.path;
                        if (file != null) {
                          final url = await provider.uploadImage(file);
                          _image = url;

                          setState(() {
                            _image = url;
                          });
                        }
                      }
                    },
                    child: const Text('Upload ảnh'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // upload file
              TextFormField(
                controller: _fileController,
                decoration: const InputDecoration(
                  labelText: 'File',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf'],
                  );

                  if (result != null) {
                    final file = result.files.single.path;
                    if (file != null) {
                      final url = await provider.uploadFile(file);

                      setState(() {
                        _fileController.text = url;
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Tên sách',
                  border: OutlineInputBorder(),
                ),
                controller: _titleController,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Tác giả',
                  border: OutlineInputBorder(),
                ),
                controller: _authorController,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                  value: _category,
                  items: [
                    for (Category category
                        in context.read<DashBoardProvider>().categories)
                      DropdownMenuItem(
                        value: category.id ?? '',
                        child: Text(category.name ?? ''),
                      ),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Thể loại',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _category = value ?? '';
                  }),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Số trang',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                controller: _pageController,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 500,
                child: SingleChildScrollView(
                  child: TextField(
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Nội dung',
                      border: OutlineInputBorder(),
                    ),
                    controller: _contentController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final book = Book(
              id: widget.book?.id,
              title: _titleController.text,
              author: _authorController.text,
              category: _category,
              content: _contentController.text,
              page: int.parse(_pageController.text),
              image: _image,
              file: _fileController.text,
            );
            Book? newBook = await provider.createBook(book);

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Lưu sách thành công'),
                ),
              );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Lưu sách không thành công'),
                ),
              );
            }
          },
          child: const Icon(Icons.save)),
    );
  }
}
