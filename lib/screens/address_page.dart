import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                prefixIconConstraints: BoxConstraints(minWidth: 24, minHeight: 24),
                hintText: '도로명으로 검색하세요',
                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                hintStyle: TextStyle(color: Theme.of(context).hintColor)),
          ),
          TextButton.icon(
              onPressed: () => {},
              icon: Icon(CupertinoIcons.compass, color: Colors.white),
              label: Text("현재 위치로 찾기", style: Theme.of(context).textTheme.button),
              style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor)),
          Expanded(
            child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ExtendedImage.asset('assets/images/carrot.jpg'),
                    title: Text('title $index'),
                    subtitle: Text('subtitle: $index'),
                    trailing: Icon(Icons.more),
                  );
                }),
          )
        ],
      ),
    );
  }
}
