import 'package:flutter/material.dart';
import 'package:restful_api/api.dart';
import 'package:restful_api/model/user.dart';
import 'package:restful_api/utils/validator.dart';

API api = API();
addUserDialog(context) async {
  String name, phone, email;
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
              TextField(
                decoration: InputDecoration(hintText: "email"),
                onChanged: (String value) {
                  email = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "phone"),
                keyboardType: TextInputType.phone,
                onChanged: (String value) {
                  phone = value;
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
  await _uploadUser(name, email, phone, context);
}

_uploadUser(String name, String email, String phone, context) async {
  if (Validator.nameValidator(name) &&
      Validator.emailValidator(email) &&
      Validator.phoneValidator(phone)) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(" upload"),
    ));
    await api.addUser(User(name: name, email: email, phone: phone));
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("invalid input"),
    ));
  }
}
