import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restful_api/api.dart';
import 'package:restful_api/model/company.dart';

API _api = API();
updateCompanyDialog(index, context, Company company, String id) async {
  String name = company.name;
  double lat = company.lat;
  double long = company.long;
  String imageBase64 = company.logo;
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (contexxt) {
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
                      onCameraMove: (CameraPosition cameraPosition) {
                        lat = cameraPosition.target.latitude;

                        long = cameraPosition.target.longitude;
                      },
                      initialCameraPosition:
                          CameraPosition(target: LatLng(lat, long)),
                    ),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.green,
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text("change photo"),
                onPressed: () async {
                  var file =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  if (file != null) {
                    imageBase64 = base64Encode(file.readAsBytesSync());
                  }
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
  await _updateCompany(name, index, lat, long, imageBase64, id, context);
}

_updateCompany(
    String name, index, lat, long, String imageFile, id, context) async {
  if (name != null && name.trim().length > 0) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("updated"),
    ));
    Address address = (await Geocoder.local
            .findAddressesFromCoordinates(Coordinates(lat, long)))
        .first;
    await _api.updateCompany(
        Company(
            name: name,
            logo: imageFile,
            lat: lat,
            long: long,
            address: address.addressLine),
        id);
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("invalid input"),
    ));
  }
}
