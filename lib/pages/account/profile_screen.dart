import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/auth/auth_provider.dart';
import 'package:thu_vien_sach/utils/constant.dart';
import 'package:thu_vien_sach/utils/google_check.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  String? _avatar;

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _avatar = result.files.single.path;
      });
    }
  }

  @override
  void initState() {
    final userModel = context.read<AuthProvider>();
    _usernameController.text = userModel.user?.username ?? '';
    _emailController.text = userModel.user?.email ?? '';
    _phoneController.text = userModel.user?.phone ?? '';
    _avatar = userModel.user?.image;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa thông tin'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (_avatar != null)
                  SizedBox(
                    height: 96,
                    width: 96,
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(provider.user?.image != null
                          ? provider.user!.image!.isGoogle
                              ? provider.user!.image!
                              : '${Constant.api}/${provider.user!.image}'
                          : '${Constant.api}/avatar/logo.jpg'),
                    ),
                  ),
                if (_avatar == null)
                  SizedBox(
                    height: 100,
                    child: Text(
                      'Chưa có ảnh đại diện',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _openFileExplorer,
                  child: const Text('Đổi ảnh đại diện'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Tên đăng nhập',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Số điện thoại',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final mess = await provider.updateProfile(
                      _usernameController.text,
                      _emailController.text,
                      _phoneController.text,
                      _avatar,
                    );
                    if (context.mounted && mess == null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Cập nhật thành công'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                        barrierDismissible: true,
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(mess ?? 'Cập nhật thất bại'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Cập nhật'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
