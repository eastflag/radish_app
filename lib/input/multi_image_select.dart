import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:radish_app/constants/common_size.dart';

class MultiImageSelect extends StatefulWidget {
  const MultiImageSelect({
    super.key,
  });

  @override
  State<MultiImageSelect> createState() => _MultiImageSelectState();
}

class _MultiImageSelectState extends State<MultiImageSelect> {
  List<XFile>? _images = [];

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
                child: InkWell(
                  onTap: () async{
                    final ImagePicker _picker = ImagePicker();
                    // final List<XFile>? images = await _picker.pickMultiImage();
                    List<XFile>? images = await _picker.pickMultiImage();
                    if (images != null && images.isNotEmpty) {
                      _images!.clear();
                      _images!.addAll(images);
                      setState(() {

                      });
                    }
                  },
                  child: Container(
                    width: imgSize,
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
              ),
              ...List.generate(_images!.length, (index) => Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: common_sm_padding, bottom: common_sm_padding, right: common_sm_padding),
                    child: FutureBuilder<Uint8List>(
                      future: _images![index].readAsBytes(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            // loadStateChanged: (state) {
                            //   switch (state.extendedImageLoadState) {
                            //     case LoadState.loading:
                            //       return Container(
                            //         padding: EdgeInsets.all(imgSize / 3),
                            //         height: imgSize,
                            //         width: imgSize,
                            //         child: CircularProgressIndicator()
                            //       );
                            //     case LoadState.completed:
                            //       return null;
                            //     case LoadState.failed:
                            //       return Icon(Icons.cancel);
                            //   }
                            // },
                          );
                        } else {
                          return Container(
                            height: imgSize,
                            width: imgSize,
                            child: CircularProgressIndicator())
                          ;
                        }
                      },
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
