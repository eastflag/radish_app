import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:radish_app/constants/common_size.dart';

import 'multi_image_select.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
            onPressed: () {
              context.beamBack();
            },
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor
            ),
            child: Text(
              '뒤로',
              style: Theme.of(context).textTheme.bodyText2,
            )
        ),
        title: Text('중고상품 업로드'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                context.beamBack();
              },
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).appBarTheme.backgroundColor
              ),
              child: Text('완료', style: Theme.of(context).textTheme.bodyText2)
          )
        ],
      ),
      body: ListView(
        children: [
          MultiImageSelect(),
          Divider(
            height: 1,
            color: Colors.grey,
            thickness: 1,
            indent: common_bg_padding,
            endIndent: common_bg_padding,
          )
        ],
      ),
    );
  }
}

