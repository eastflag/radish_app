import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                prefixIconConstraints: BoxConstraints(minWidth: 24, minHeight: 24),
                hintText: '도로명으로 검색하세요',
                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                hintStyle: TextStyle(color: Theme.of(context).hintColor)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton.icon(
                    onPressed: () => {},
                    icon: Icon(CupertinoIcons.compass, color: Colors.white),
                    label: Text("현재 위치로 찾기", style: Theme.of(context).textTheme.button),
                    style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor))
              ],
            ),
          )
        ],
      ),
    );
  }
}
