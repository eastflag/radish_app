import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 100,
            child: Row(
              children: [
                ExtendedImage.network('https://picsum.photos/100'),
                Column(
                  children: [
                    Text("title"),
                    Text("subtitle"),
                    Text("subtitle"),
                    Expanded(child: Container()),
                    Row()
                  ],
                )
              ],
            ),
          );
        });
  }
}
