import 'package:dio/dio.dart';

import 'package:thu_vien_sach/models/banner.dart';
import 'package:thu_vien_sach/utils/constant.dart';

class BannerService {
  final Dio _dio = Dio();

  Future<List<Banner>> getAllBanner() async {
    final resp = await _dio.get('${Constant.api}/banners');
    if (resp.statusCode == 200) {
      final List<dynamic> data = resp.data;
      return data.map((e) => Banner.fromJson(e)).toList();
    }
    throw Exception('Failed to load banners ${resp.statusCode}');
  }

  // create banner
  Future<Banner> createBanner(Banner banner) async {
    final resp =
        await _dio.post('${Constant.api}/banners', data: banner.toJson());
    if (resp.data['mess'] != null) {
      throw Exception('Failed to create banner ${resp.statusCode}');
    }
    return Banner.fromJson(resp.data);
  }

  // delete banner
  Future<void> deleteBanner(String id) async {
    final resp = await _dio.delete('${Constant.api}/banners/$id');
    if (resp.statusCode == 200) {
      return;
    }
    throw Exception('Failed to delete banner ${resp.statusCode}');
  }

  Future<String> uploadBanner(String image) async {
    final FormData formData =
        FormData.fromMap({'file': await MultipartFile.fromFile(image)});

    final resp =
        await _dio.post('${Constant.api}/upload/banner', data: formData);

    return resp.data['filename'];
  }

  Future<Banner> updateBanner(Banner banner) async {
    final resp = await _dio.put('${Constant.api}/banners/${banner.id}',
        data: banner.toJson());

    if (resp.data['mess'] != null) {
      throw Exception('Failed to create banner ${resp.statusCode}');
    }
    return Banner.fromJson(resp.data);
  }
}
