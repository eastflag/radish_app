import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radish_app/constants/common_size.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            height: common_sm_padding * 3,
            thickness: 2,
            color: Colors.grey[200],
            indent: common_sm_padding,
            endIndent: common_sm_padding,
          );
        },
        padding: EdgeInsets.all(common_sm_padding),
        itemCount: 10,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 100,
            child: Row(
              children: [
                ExtendedImage.network('https://picsum.photos/100'),
                SizedBox(
                  width: common_bg_padding,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "그래픽 카드 RTX3060",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "1시간전",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(height: 10,),
                      Text("15,000원"),
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 15,
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.chat_bubble_2,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    "31",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Icon(
                                    CupertinoIcons.heart,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    "31",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
