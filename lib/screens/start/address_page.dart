import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radish_app/screens/start/address_service.dart';
import 'package:geolocator/geolocator.dart';

import '../../model/AddressModel.dart';
import 'intro_page.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressController = TextEditingController();

  AddressModel? _addressModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            onFieldSubmitted: (text) async {
              _addressModel = await AddressService().SearchAddressByStr(text);
              setState(() {

              });
            },
            controller: _addressController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                prefixIconConstraints: BoxConstraints(minWidth: 24, minHeight: 24),
                hintText: '도로명으로 검색하세요',
                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                hintStyle: TextStyle(color: Theme.of(context).hintColor)),
          ),
          TextButton.icon(
              onPressed: () async {
                bool serviceEnabled;
                LocationPermission permission;

                // Test if location services are enabled.
                /*serviceEnabled = await Geolocator.isLocationServiceEnabled();
                if (!serviceEnabled) {
                  // Location services are not enabled don't continue
                  // accessing the position and request users of the
                  // App to enable the location services.
                  return Future.error('Location services are disabled.');
                }

                permission = await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                  if (permission == LocationPermission.denied) {
                    // Permissions are denied, next time you could try
                    // requesting permissions again (this is also where
                    // Android's shouldShowRequestPermissionRationale
                    // returned true. According to Android guidelines
                    // your App should show an explanatory UI now.
                    return Future.error('Location permissions are denied');
                  }
                }

                if (permission == LocationPermission.deniedForever) {
                  // Permissions are denied forever, handle appropriately.
                  return Future.error(
                      'Location permissions are permanently denied, we cannot request permissions.');
                }

                // When we reach here, permissions are granted and we can
                // continue accessing the position of the device.
                Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                logger.d('${position.altitude}, ${position.longitude}');

                AddressService().findAddressByCoordinate(log: position.altitude, lat: position.longitude);*/

                AddressService().findAddressByCoordinate(log: 37.579617, lat: 126.977041);
              },
              icon: Icon(CupertinoIcons.compass, color: Colors.white),
              label: Text("현재 위치로 찾기", style: Theme.of(context).textTheme.button),
              style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor)),
          Expanded(
            child: ListView.builder(
                itemCount: (_addressModel?.result?.items == null ? 0 : _addressModel?.result?.items?.length),
                itemBuilder: (context, index) {
                  if (_addressModel == null || _addressModel?.result == null || _addressModel!.result!.items == null
                  || _addressModel!.result!.items![index].address == null) {
                    return Container();
                  }

                  return ListTile(
                    leading: ExtendedImage.asset('assets/images/carrot.jpg'),
                    title: Text(_addressModel?.result?.items?[index].address?.road ?? ""),
                    subtitle: Text(_addressModel?.result?.items?[index].address?.parcel ?? ""),
                    trailing: Icon(Icons.more),
                  );
                }),
          )
        ],
      ),
    );
  }
}
