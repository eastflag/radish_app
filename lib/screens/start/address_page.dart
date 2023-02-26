import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radish_app/model/AddressPointModel.dart';
import 'package:radish_app/screens/start/address_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:radish_app/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/shared_pref_keys.dart';
import '../../model/AddressModel.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressController = TextEditingController();

  AddressModel? _addressModel;
  List<AddressPointModel> _addressPointModelList = [];

  bool _isGettingLocation = false;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              onFieldSubmitted: (text) async {
                _addressPointModelList.clear();

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
                  _addressModel = null;
                  _addressPointModelList.clear();
                  setState(() {
                    _isGettingLocation = true;
                  });

                  bool serviceEnabled;
                  LocationPermission permission;

                  // Test if location services are enabled.
                  serviceEnabled = await Geolocator.isLocationServiceEnabled();
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

                  List<AddressPointModel> addressList = await AddressService().findAddressByCoordinate(log: position.longitude, lat: position.latitude);
                  // List<AddressPointModel> addressList = await AddressService().findAddressByCoordinate(log: 126.977041, lat: 37.579617);

                  _addressPointModelList.addAll(addressList);

                  setState(() {
                    _isGettingLocation = false;
                  });
                },
                icon: _isGettingLocation ? CircularProgressIndicator(color: Colors.white) : Icon(CupertinoIcons.compass, color: Colors.white),
                label: Text(_isGettingLocation ? "위치 찾는중 ..." : "현재 위치로 찾기", style: Theme.of(context).textTheme.button),
                style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor)),
            if (_addressModel != null) Expanded(
              child: ListView.builder(
                  itemCount: (_addressModel?.result?.items == null ? 0 : _addressModel?.result?.items?.length),
                  itemBuilder: (context, index) {
                    if (_addressModel == null || _addressModel?.result == null || _addressModel!.result!.items == null
                    || _addressModel!.result!.items![index].address == null) {
                      return Container();
                    }

                    return ListTile(
                      leading: Image.asset('assets/images/carrot.jpg'),
                      title: Text(_addressModel?.result?.items?[index].address?.road ?? ""),
                      subtitle: Text(_addressModel?.result?.items?[index].address?.parcel ?? ""),
                      trailing: Icon(Icons.more),
                      onTap: () {
                        _saveAddressAndGoToNextPage(_addressModel?.result?.items?[index].address?.road ?? ""
                          , num.parse(_addressModel!.result!.items![index].point!.y ?? "0")
                          , num.parse(_addressModel!.result!.items![index].point!.x ?? "0")
                        );
                      }
                    );
                  }),
            ),
            if (_addressPointModelList.isNotEmpty) Expanded(
              child: ListView.builder(
                  itemCount: _addressPointModelList.length,
                  itemBuilder: (context, index) {
                    if (_addressPointModelList[index].result == null || _addressPointModelList[index].result!.isEmpty) {
                      return Container();
                    }

                    return ListTile(
                      title: Text(_addressPointModelList[index].result?[0].text ?? ""),
                      subtitle: Text(_addressPointModelList[index].result?[0].zipcode ?? ""),
                      onTap: () {
                        _saveAddressAndGoToNextPage(_addressModel?.result?.items?[index].address?.road ?? ""
                            , num.parse(_addressModel!.result!.items![index].point!.y ?? "0")
                            , num.parse(_addressModel!.result!.items![index].point!.x ?? "0")
                        );
                      }
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  _saveAddressAndGoToNextPage(String address, num lat, num lon) async {
    await _saveAddressOnSharedPreference(address, lat, lon);
    context.read<PageController>().animateToPage(2, duration: Duration(microseconds: 700), curve: Curves.easeInOut);
  }

  _saveAddressOnSharedPreference(String address, num lat, num lon) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(SHARED_ADDRESS, address);
    await preferences.setDouble(SHARED_LAT, lat.toDouble());
    await preferences.setDouble(SHARED_LON, lon.toDouble());
  }
}
