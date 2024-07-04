import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({Key? key, required this.title}) : super(key: key);
  final String title;
  final String image = 'https://cdn2.myminifactory.com/assets/object-assets/5f435a90d22ba/images/720X720-viper-avatar.jpg';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              '${'welcome'.tr()} $title 👋',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'motivationTxt'.tr(),
              style: const TextStyle(
                fontWeight:  FontWeight.w400,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        const SizedBox(width: 18.0),
        const CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
            'https://cdn2.myminifactory.com/assets/object-assets/5f435a90d22ba/images/720X720-viper-avatar.jpg',
          ),
        )
      ],
    );
  }
}