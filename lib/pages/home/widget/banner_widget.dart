import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/home/home_provider.dart';
import 'package:thu_vien_sach/utils/constant.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: CarouselSlider(
          items: [
            for (var banner in homeProvider.banners)
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Image(
                  image: NetworkImage(Constant.api + banner.image!),
                  fit: BoxFit.cover,
                ),
              ),
          ],
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.7,
            aspectRatio: 1.0,
            initialPage: 2,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
          ),
        ),
      ),
    );
  }
}
