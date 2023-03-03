import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:radish_app/constants/common_size.dart';

class MultiImageSelect extends StatelessWidget {
  const MultiImageSelect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size _size = MediaQuery.of(context).size;
        var imgSize = _size.width / 3;

        return SizedBox(
          width: _size.width,
          height: _size.width / 3,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: EdgeInsets.all(common_sm_padding),
                child: Container(
                  width: _size.width / 3,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey, width: 2)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_rounded, color: Colors.grey),
                      Text(
                        '0/10',
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                ),
              ),
              ...List.generate(
                  100,
                  (index) => Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: common_sm_padding, bottom: common_sm_padding, right: common_sm_padding),
                            child: CachedNetworkImage(
                              imageUrl: 'https://picsum.photos/100',
                              width: imgSize,
                              height: imgSize,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              width: 40,
                              height: 40,
                              child: IconButton(onPressed: () {}, icon: Icon(Icons.remove_circle, color: Colors.red[400])))
                        ],
                      ))
            ],
          ),
        );
      },
    );
  }
}
