import 'package:flutter/material.dart' hide Banner;
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/models/banner.dart';
import 'package:thu_vien_sach/pages/admin/dashboard_provider.dart';
import 'package:thu_vien_sach/utils/constant.dart';

class BannnerTable extends StatefulWidget {
  const BannnerTable({Key? key}) : super(key: key);

  @override
  State<BannnerTable> createState() => _BannnerTableState();
}

class _BannnerTableState extends State<BannnerTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banner'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/admin-banner-detail');
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
            dataRowHeight: 100,
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Hình ảnh')),
              DataColumn(label: Text('Chức năng')),
            ],
            rows: [
              for (Banner banner in context.watch<DashBoardProvider>().banners)
                DataRow(cells: [
                  DataCell(SizedBox(
                      width: 100,
                      child: Text(banner.id.toString(),
                          overflow: TextOverflow.ellipsis))),
                  DataCell(SizedBox(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network('${Constant.api}/${banner.image}',
                          width: 100, height: 100),
                    ),
                  )),
                  DataCell(Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/admin-banner-detail',
                              arguments: banner);
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
                                      'Bạn có chắc chắn muốn xóa banner này?'),
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
                                            .deleteBanner(banner.id!);
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
