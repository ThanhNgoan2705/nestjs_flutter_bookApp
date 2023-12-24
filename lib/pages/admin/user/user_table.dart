import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/models/user.dart';
import 'package:thu_vien_sach/pages/admin/dashboard_provider.dart';

class UserTable extends StatelessWidget {
  const UserTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý người dùng')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Tên người dùng')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Quyền')),
              DataColumn(label: Text('Chức năng')),
            ],
            rows: [
              for (User user in context.watch<DashBoardProvider>().users)
                DataRow(cells: [
                  DataCell(SizedBox(
                      width: 100,
                      child: Text(user.id.toString(),
                          overflow: TextOverflow.ellipsis))),
                  DataCell(SizedBox(
                      width: 150,
                      child: Text(user.username ?? '',
                          overflow: TextOverflow.ellipsis))),
                  DataCell(SizedBox(
                      width: 100,
                      child: Text(user.email ?? '',
                          overflow: TextOverflow.ellipsis))),
                  DataCell(SizedBox(
                      width: 100,
                      child: Text(user.role ?? '',
                          overflow: TextOverflow.ellipsis))),
                  DataCell(Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // update role

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Cập nhật quyền'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RadioListTile(
                                        title: const Text('Admin'),
                                        value: 'admin',
                                        groupValue: user.role,
                                        onChanged: (value) {
                                          context
                                              .read<DashBoardProvider>()
                                              .updateRole(user, value);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      RadioListTile(
                                        title: const Text('User'),
                                        value: 'user',
                                        groupValue: user.role,
                                        onChanged: (value) {
                                          context
                                              .read<DashBoardProvider>()
                                              .updateRole(user, value);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
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
                                      'Bạn có chắc chắn muốn xóa người dùng này?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Hủy'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<DashBoardProvider>()
                                            .deleteUser(user);
                                        Navigator.pop(context);
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
                ])
            ],
          ),
        ),
      ),
    );
  }
}
