import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restful_api/api.dart';
import 'package:restful_api/model/company.dart';

API _api = API();
addCompanyDialog(context) async {
  String name;
  File imageFile;
  double lat = 22.2, long = 22.2;
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (contexxt) {
        TextEditingController();
        return Dialog(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "name"),
                onChanged: (String value) {
                  name = value;
                },
              ),
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    GoogleMap(
                      onMapCreated: (googleMapController) {},
                      onCameraMove: (CameraPosition cameraPosition) {
                        lat = cameraPosition.target.latitude;
                        long = cameraPosition.target.longitude;
                      },
                      initialCameraPosition:
                          CameraPosition(target: LatLng(22.2, 22.2)),
                    ),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.green,
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text("choose image"),
                onPressed: () async {
                  imageFile = await ImagePicker.pickImage(
                    source: ImageSource.gallery,
                  );
                },
              ),
              RaisedButton(
                child: Text("save"),
                onPressed: () async {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      });
  await _addCompany(imageFile, name, lat, long, context);
}

_addCompany(
    File imageFile, String name, double lat, double long, context) async {
  if (imageFile != null && name != null && name.length > 0) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("uploading"),
    ));
    Address address = (await Geocoder.local
            .findAddressesFromCoordinates(Coordinates(lat, long)))
        .first;
    await _api.addCompany(Company(
        name: name,
        logo: base64Encode(imageFile.readAsBytesSync()),
        lat: lat,
        address: address.addressLine,
        long: long));
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("error"),
    ));
  }
}
