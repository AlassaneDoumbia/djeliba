import 'package:djeliba/helpers/constants.dart';
import 'package:djeliba/models/delivery.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardItem extends StatelessWidget {
  final String index;
  final String path;
  final String status;
  final Delivery delivery;
  const CardItem({
    Key? key,
    required this.index,
    required this.path,
    required this.status,
    required this.delivery,
  }) : super(key: key);
  // context.go('/home');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap:  () => Navigator.of(context)
            .pushNamed('/details', arguments: delivery.userId),
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding/2),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding/2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
            width: 2,
            color: Colors.black,
          ),
        ),

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Nº ${index.substring(index.length-6, index.length)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kDefaultTitleFontSize,
                  ),
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '$path',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kDefaultTitleFontSize,
                  ),
                ),
                const Spacer(flex: 1,),
                Checkbox(value: null, tristate: true, onChanged: (bool? value) {  },),
                // Wrap(
                //     runSpacing: 8,
                //     spacing: 8,
                //     children: [ActionChip(
                //       label: Text("$status"),
                //       labelStyle: const TextStyle(
                //           fontWeight: FontWeight.bold, color: Colors.white),
                //       backgroundColor: Colors.blue,
                //       onPressed: () => print("Perform some action here"),
                //     )]
                // )
              ],
            ),
          ],
        ),
      ),

    );

  }
}
