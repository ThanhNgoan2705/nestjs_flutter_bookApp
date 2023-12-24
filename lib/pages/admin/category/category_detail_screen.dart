import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/models/category.model.dart';
import 'package:thu_vien_sach/pages/admin/dashboard_provider.dart';

class CategoryDetailScreen extends StatelessWidget {
  final Category? category;
  CategoryDetailScreen({Key? key, this.category}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashBoardProvider>();
    _nameController.text = category?.name ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(category?.name ?? 'Tạo danh mục'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tên danh mục',
                  border: OutlineInputBorder(),
                ),
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Category newCategory = Category(
                    id: category?.id,
                    name: _nameController.text,
                  );

                  if (category == null) {
                    provider.createCategory(newCategory);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tạo danh mục thành công'),
                      ),
                    );
                  } else {
                    provider.updateCategory(newCategory);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cập nhật danh mục thành công'),
                      ),
                    );
                  }
                  Navigator.pop(context);
                },
                child: const Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
