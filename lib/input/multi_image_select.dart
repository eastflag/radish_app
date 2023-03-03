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

        return SizedBox(
          width: _size.width,
          height: _size.width / 3,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: EdgeInsets.all(common_sm_padding),
                child: Container(
                  width: _size.width/3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey, width: 2)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_rounded, color: Colors.grey),
                      Text('0/10', style: Theme.of(context).textTheme.subtitle2,)
                    ],
                  ),
                ),
              ),
              Container(
                width: _size.width/5,
                decoration: BoxDecoration(
                    color: Colors.red
                ),
              ),
              Container(
                width: _size.width/4,
                decoration: BoxDecoration(
                    color: Colors.blue
                ),
              ),
              Container(
                width: _size.width/6,
                decoration: BoxDecoration(
                    color: Colors.amber
                ),
              ),
              Container(
                width: _size.width/5,
                decoration: BoxDecoration(
                    color: Colors.cyan
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
