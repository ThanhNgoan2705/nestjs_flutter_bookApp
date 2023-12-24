import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_vien_sach/pages/home/home_provider.dart';

class LabelsWidget extends StatelessWidget {
  const LabelsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            'Thể loại',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 60,
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            children: [
              for (var label in homeProvider.labels)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/label',
                            arguments: label);
                      },
                      child: Text(label.name ?? '')),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
