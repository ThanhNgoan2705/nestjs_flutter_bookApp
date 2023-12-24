import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/admin/dashboard_provider.dart';

class BookTable extends StatelessWidget {
  const BookTable({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.watch<DashBoardProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý sách'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Tên sách')),
              DataColumn(label: Text('Tác giả')),
              DataColumn(label: Text('Thể loại')),
              DataColumn(label: Text('Luợt xem')),
              DataColumn(label: Text('Chức năng')),
            ],
            rows: [
              for (var book in dashboardProvider.books)
                DataRow(cells: [
                  DataCell(SizedBox(
                      width: 100,
                      child: Text(book.id.toString(),
                          overflow: TextOverflow.ellipsis))),
                  DataCell(SizedBox(
                      width: 150,
                      child: Text(book.title ?? '',
                          overflow: TextOverflow.ellipsis))),
                  DataCell(SizedBox(
                      width: 100,
                      child: Text(book.author ?? '',
                          overflow: TextOverflow.ellipsis))),
                  DataCell(SizedBox(
                      width: 100,
                      child: Text(book.category ?? '',
                          overflow: TextOverflow.ellipsis))),
                  DataCell(SizedBox(
                      width: 50,
                      child: Text('${book.views}',
                          overflow: TextOverflow.ellipsis))),
                  DataCell(Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/admin-book-detail',
                              arguments: book);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          // comfirm delete
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Xác nhận'),
                                content:
                                    const Text('Bạn có chắc chắn muốn xóa?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Hủy')),
                                  TextButton(
                                      onPressed: () {
                                        dashboardProvider.deleteBook(book.id!);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Xóa')),
                                ],
                              );
                            },
                          );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/admin-book-detail');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
