import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/models/category.model.dart';
import 'package:thu_vien_sach/pages/admin/dashboard_provider.dart';

class CategoryTable extends StatefulWidget {
  const CategoryTable({Key? key}) : super(key: key);

  @override
  State<CategoryTable> createState() => _CategoryTableState();
}

class _CategoryTableState extends State<CategoryTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh mục'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/admin-category-detail');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Tên danh mục')),
              DataColumn(label: Text('Chức năng')),
            ],
            rows: [
              for (Category category
                  in context.watch<DashBoardProvider>().categories)
                DataRow(cells: [
                  DataCell(SizedBox(
                      width: 100,
                      child: Text(category.id.toString(),
                          overflow: TextOverflow.ellipsis))),
                  DataCell(SizedBox(
                    width: 150,
                    child: Text(category.name ?? '',
                        overflow: TextOverflow.ellipsis),
                  )),
                  DataCell(Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/admin-category-detail',
                              arguments: category);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          // confirm delete
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Xác nhận'),
                                  content: const Text(
                                      'Bạn có chắc chắn muốn xóa danh mục này?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Hủy'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await context
                                            .read<DashBoardProvider>()
                                            .deleteCategory(category.id!);
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text('Xóa'),
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  )),
                ]),
            ],
          ),
        ),
      ),
    );
  }
}
