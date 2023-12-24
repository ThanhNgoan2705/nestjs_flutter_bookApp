import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/models/banner.dart';
import 'package:thu_vien_sach/pages/admin/dashboard_provider.dart';
import 'package:thu_vien_sach/utils/constant.dart';

class BannerDetailScreen extends StatefulWidget {
  final Banner? banner;
  const BannerDetailScreen({Key? key, this.banner}) : super(key: key);

  @override
  State<BannerDetailScreen> createState() => _BannerDetailScreenState();
}

class _BannerDetailScreenState extends State<BannerDetailScreen> {
  late String _image;

  @override
  void initState() {
    _image = widget.banner?.image ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashBoardProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo banner'),
        actions: [
          IconButton(
              onPressed: () {
                Banner newBanner = Banner(
                  id: widget.banner?.id,
                  image: _image,
                );
                if (widget.banner == null) {
                  provider.createBanner(newBanner);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tạo banner thành công'),
                    ),
                  );
                } else {
                  provider.updateBanner(newBanner);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cập nhật banner thành công'),
                    ),
                  );
                }
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: widget.banner?.id ?? '',
                  decoration: const InputDecoration(
                    labelText: 'ID banner',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 16),
                if (_image != '')
                  Image.network(
                    '${Constant.api}/$_image',
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                if (_image == '') const Text('Chưa có hình ảnh'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(type: FileType.image);
                    if (result != null) {
                      final file = result.files.single.path!;

                      final uploadImage = await provider.uploadBanner(file);

                      setState(() {
                        _image = uploadImage;
                      });
                    }
                  },
                  child: const Text('Chọn hình ảnh'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
